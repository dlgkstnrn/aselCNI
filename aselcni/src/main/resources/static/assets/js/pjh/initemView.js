// 초기 날짜 입력 부
const offset = new Date().getTimezoneOffset() * 60000;
const now = new Date(Date.now() - offset).toISOString().substring(0, 10);
$('#start_date').val(now);
$('#end_date').val(now);


// 검색 시 서버에 전달할 객체
let data = {
    currentPage: '1',
    start_date: $('#start_date').val(),
    end_date: $('#end_date').val(),
    cust_nm: $('#cust_nm').val(),
    purc_no: $('#purc_no').val(),
    purc_emp_nm: $('#purc_emp_nm').val(),
    initem_no: $('#initem_no').val(),
    initem_emp_nm: $('#initem_emp_nm').val(),
    item_nm: $('#item_nm').val()
};
// 이전 검색 정보
let tempData = {};

/**
 * 조회 버튼 클릭 시 호출되는 함수
 * input에서 정보를 가져와 전역data에 담은 후
 * getTavleRow함수 호출
 */
const searchInitem = function () {
    tempData = { ...data };
    data.currentPage = '1';
    data.start_date = $('#start_date').val();
    data.end_date = $('#end_date').val();
    data.cust_nm = $('#cust_nm').val();
    data.purc_no = $('#purc_no').val();
    data.purc_emp_nm = $('#purc_emp_nm').val();
    data.initem_no = $('#initem_no').val();
    data.initem_emp_nm = $('#initem_emp_nm').val();
    data.item_nm = $('#item_nm').val();
    console.log(data);
    getTableRow();
}

/**
 * 전역 data(검색정보)를 서버에 보낸 후
 * 응답을 통해 테이블에 정보 업데이트하는 함수 
 */
const getTableRow = function () {
    // 검색 기능
    $.ajax({
        type: "GET",
        url: "/searchInitems",
        data,
        success: (res) => {
            console.log(res);

            if (res.initems.length == 0) {
                alert('조회가능한 정보가 없습니다.');
                data = tempData;
                $('#start_date').val(data.start_date);
                $('#end_date').val(data.end_date);
                $('#cust_nm').val(data.cust_nm);
                $('#purc_no').val(data.purc_no);
                $('#purc_emp_nm').val(data.purc_emp_nm);
                $('#initem_no').val(data.initem_no);
                $('#initem_emp_nm').val(data.initem_emp_nm);
                $('#item_nm').val(data.item_nm);
                return;
            }

            const tbody = $('#initemListTable');
            tbody.empty();
            $('.pageNum').remove();
            res.initems.forEach((item, idx) => {
                tbody.append(
                    `
                    <tr onclick="detailView('${item.initem_no}')" style="cursor:pointer;">
                        <th scope="row">${idx + 1 + (res.page.currentPage - 1) * res.page.rowPage}</th>
                        <td>${item.initem_no}</td>
                        <td>${item.initem_emp_nm}</td>
                        <td>${item.purc_no}</td>
                        <td>${item.purc_emp_nm}</td>
                        <td>${item.initem_dt}</td>
                        <td>${item.cust_nm}</td>
                        <td>${item.item_nm}</td>
                    </tr>
                    `
                )
            });
            for (let i = res.page.startPage; i <= res.page.endPage; i++) {
                $('#nextPageLi').before(
                    `
                    <li class="page-item pageNum "><button class="page-link ${res.page.currentPage - i == 0 ? 'fw-bold' : ''}" onclick="goPage('${i}')">${i}</button></li>
                    `
                );
            }
            document.getElementById('nextPageBtn').dataset.totalPage = res.page.totalPage;
        },
        beforeSend: () => {
            $('body').append(
                `
                <div id="ajaxLoadingImg" style="z-index:1091;" class="spinner-border text-primary position-absolute top-50 start-50" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                `
            )
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
		},
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }

    });
}

/**
 * 페이지 이동함수, param으로 넘겨준 페이지로 이동
 * @param {String} i 이동할 페이지 번호
 */
const goPage = function (i) {
    data.currentPage = i;
    getTableRow();
}

/**
 * 다음페이지 이동
 * @param {HTMLButtonElement} element next버튼
 * @returns 
 */
const nextPage = function (element) {
    if (data.currentPage >= element.dataset.totalPage) {
        alert('마지막 페이지 입니다.');
        return;
    }
    data.currentPage = data.currentPage * 1 + 1;
    getTableRow();
}
/**
 * 이전페이지 이동
 * @returns 
 */
const prevPage = function () {
    if (data.currentPage == '1') {
        alert('첫 페이지 입니다.');
        return;
    }
    data.currentPage = '' + (data.currentPage * 1 - 1);
    getTableRow();
}

// 서버에서 받아온 initem 상세 조회 값(전역)
let responseData = {};

/**
 * 테이블 로우 클릭 시 서버에서 해당하는 initem 정보를 조회
 * @param {string} initem_no 조회하는 initem의 key인 initem_no
 */
const detailView = function (initem_no) {
    $.ajax({
        type: "GET",
        url: "detailInitem",
        data: { initem_no },
        success: (res) => {
            console.log(res);
            responseData = res;
            detailUpdate();
            $('#detailModal').modal('show');
        },
        beforeSend: () => {
            $('body').append(
                `
                <div id="ajaxLoadingImg" style="z-index:1091;" class="spinner-border text-primary position-absolute top-50 start-50" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                `
            )
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
		},
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }
    })
}

//상세보기창 업데이트
/**
 * 상세보기 창에 서버에서 응답 받은 값을 입력해주는 함수
 * @param {Boolean} insertFlag 수정화면 : true, 조회화면 : false(default)
 */
const detailUpdate = function (insertFlag = false) {
    if (!insertFlag) {
        //조회화면
        $('#modal_initem_dt').attr('disabled', 'true');
        $('#modal_cust_emp').attr('disabled', 'true');
        $('#modal_remark').attr('disabled', 'true');
        $('#modal_wh_cd').attr('disabled', 'true');
        $('#cancleBtn').attr('hidden', 'true');
        $('#submitBtn').attr('hidden', 'true');
        $('#modifyBtn').removeAttr('hidden');
        $('#closeBtn').removeAttr('hidden');
        $('#modal_initem_end').attr('disabled', true);
        $('#modal_initem_emp_nm').val(responseData.initem_emp_nm);
    } else {
        //수정화면
        $('#modal_initem_dt').removeAttr('disabled');
        $('#modal_cust_emp').removeAttr('disabled');
        $('#modal_remark').removeAttr('disabled');
        $('#modal_wh_cd').removeAttr('disabled');
        $('#cancleBtn').removeAttr('hidden');
        $('#submitBtn').removeAttr('hidden');
        $('#modal_initem_end').removeAttr('disabled');
        $('#modifyBtn').attr('hidden', 'true');
        $('#closeBtn').attr('hidden', 'true');
        const emp_nm = document.getElementById('modal_initem_emp_nm');
        emp_nm.value = emp_nm.dataset.userNm
    }

    $('#modal_initem_no').val(responseData.initem_no);
    $('#modal_purc_no').val(responseData.purc_no);
    $('#modal_purc_emp_nm').val(responseData.purc_emp_nm);
    $('#modal_initem_dt').val(responseData.initem_dt);
    $('#modal_cust_nm').val(responseData.cust_nm);
    $('#modal_cust_emp').val(responseData.cust_emp);
    $('#modal_wh_cd').empty();
    responseData.whs.forEach((wh) => {
        $('#modal_wh_cd').append(
            `
            <option value="${wh.wh_cd}" ${wh.wh_cd == responseData.wh_cd ? 'selected' : ''}>${wh.wh_nm}</option>
            `
        );
    })
    $('#modal_remark').val(responseData.remark);
    if (responseData.initem_end == 2) {
        // $('#modal_initem_end').checked = true;
        document.getElementById('modal_initem_end').checked = true;
        // $('#modal_initem_end').attr('checked', true);
        $('#modal_initem_end').val(1);
    } else {
        // $('#modal_initem_end').checked = false;
        document.getElementById('modal_initem_end').checked = false;
        // $('#modal_initem_end').removeAttr('checked');
        $('#modal_initem_end').val(0);
    }

    $('#modal_itemTableBody').empty();
    responseData.inItems.forEach((ele, idx) => {
        if (!insertFlag && !ele['qty'])
            return;
        $('#modal_itemTableBody').append(
            `<tr>
                <td id="initemNo${idx}">${ele['item_cd']}</td>
                <td>${ele['item_nm']}</td>
                <td>${ele['item_spec']}</td>
                <td>${ele['item_unit']}</td>
                <td><input id="initemQty${idx}" class="itemList" 
                    data-qty="${ele.qty}" data-item-cd="${ele.item_cd}"
                    data-cost="${ele.item_cost}"
                    onchange="checkItemQty(this)" type="number" 
                    value="${ele['qty']}" min="${ele.required_stock >= 0 ? ele.required_stock < ele.qty ? ele.required_stock : ele.qty : 0}" 
                    max="${ele.qty + ele.add_max}" 
                    placeholder="입고수량" style="width: 75px" ${insertFlag ? '' : 'readonly'}></td>
                <td>${ele['item_cost'].toLocaleString()}</td>
                <td>${(ele.qty * ele.item_cost).toLocaleString()}</td>
                </tr>`
        )
        calcTotalAmount();
    })
}

/**
 * 폼에서 수정 된 내용 DB에 반영
 */
const updateInitem = function () {
    const data = {};
    data.initem_no = $('#modal_initem_no').val();
    data.purc_no = $('#modal_purc_no').val();
    data.initem_dt = $('#modal_initem_dt').val();
    data.cust_emp = $('#modal_cust_emp').val();
    data.wh_cd = $('#modal_wh_cd').val();
    data.remark = $('#modal_remark').val();
    data.initem_end = $('#modal_initem_end').val();

    const inItems = [];
    $('.itemList').each((idx, item) => {
        console.log(item.dataset)
        if (item.dataset.qty == item.value) {
            console.log('수량 변경없음');
            return;
        }
        const obj = {
            initem_no: data.initem_no,
            purc_no: $('#modal_purc_no').val(),
            item_cd: item.dataset.itemCd,
            qty: item.value
        }
        inItems.push(obj);
    })
    data.inItems = inItems;
    console.log(data);
    $.ajax({
        type: "POST",
        url: "updateInitem",
        contentType: "application/json",
        data: JSON.stringify(data),
        success: function (response) {
            if (response == 'success') {
                detailView(data.initem_no);
            } else {
                alert('수정실패');
            }
        },
        beforeSend: () => {
            $('body').append(
                `
                <div id="ajaxLoadingImg" style="z-index:1091;" class="spinner-border text-primary position-absolute top-50 start-50" role="status">
                    <span class="visually-hidden">Loading...</span>
                </div>
                `
            )
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
		},
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }
    });

}

/**
 * 입고 삭제 함수
 */
const detailDelete = function () {
    if (!confirm('해당 입고를 삭제하겠습니까?'))
        return;
    $.ajax({
        type: "DELETE",
        url: "deleteInitem",
        data: {
            initem_no: $('#modal_initem_no').val(),
            purc_no: $('#modal_purc_no').val()
        },
        success: function (response) {
            if (response == 'success') {
                alert('삭제성공');
                location.href = '';
            } else {
                alert('삭제실패');
            }
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
		}
    });
}


/**
 * 입력 수정 시 검증 함수
 * @param {HTMLInputElement} item 입고수량 입력 input
 */
const checkItemQty = function (item) {
    if (item.value * 1 < item.min * 1) {
        item.value = item.min;
    } else if (item.value * 1 > item.max * 1) {
        item.value = item.max;
    } else {
        calcTotalAmount();
        return;
    }
    calcTotalAmount();
    alert('사용 중인 재고는 변경할 수 없으며, 발주 수량보다 높은 값은 입력할 수 없음 \n수량 오류 최소:' + item.min + ', 최대: ' + item.max);
}


const changeEndState = function (item) {
    if (item.checked) {
        item.value = 1;
    } else {
        item.value = 0;
    }
}

/**
 * 입력된 수량의 소계와 합계를 변경하는 함수
 */
const calcTotalAmount = function () {
    $('#modal_itemTableFoot').empty();
    let totalCost = 0;
    let totalAmount = 0;
    [...document.getElementsByClassName('itemList')].forEach(item => {
        const qty = item.value * 1;
        const cost = item.dataset.cost * 1;
        const subTotal = qty * cost;
        item.parentNode.parentNode.lastElementChild.textContent = subTotal.toLocaleString();
        totalCost += subTotal;
        totalAmount += qty;
    });
    $('#modal_itemTableFoot').append(`
        <tr>
            <th colspan="4">합계</th>
            <td id="totalQuantity">${totalAmount.toLocaleString()}</td>
            <td></td>
            <td id="totalAmount">${totalCost.toLocaleString()}</td>
        </tr>
    `);
}