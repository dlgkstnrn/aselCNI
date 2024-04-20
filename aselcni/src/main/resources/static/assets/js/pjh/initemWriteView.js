const offset = new Date().getTimezoneOffset() * 60000;
$('#initem_dt').val(new Date(Date.now() - offset).toISOString().substring(0, 10));

/**
 * 
 */
const changeEndState = function (item) {
    if (item.checked) {
        item.value = 1;
    } else {
        item.value = 0;
    }
}

// 전역변수에 해당 정보 저장
let purcNo = '';
/**
 * 발주번호 선택 시 실행(선택된 발주번호 전역변수에 저장)
 * @param {HTMLSelectElement} item 
 */
const selectPurc = function (item) {
    console.log(item.value);
    purcNo = item.value;
}
// 발주번호 select 선택 및 모달 창 선택 클릭 시 호출
/**
 * 발주번호 select에서 더블클릭 및 모달 선택 클릭 시 호출하는 함수,
 * 선택된 발주번호의 정보를 메인화면에 넣어줌
 */
const pickPurcNo = function () {
    if (purcNo == '') {
        alert("발주번호를 선택해주세요");
        return;
    }
    // 입고등록창에 선택번호 정보 입력
    $('#purc_no').val(purcNo);
    $('#cust_nm').val(purcData[purcNo]['cust_nm']);

    // 서버에 통신하여 자재 목록 가져와 목록테이블에 넣기
    getItemList();

    $('#modalDialogScrollable').modal('hide');
}

/**
 * 발주번호에 해당하는 정보를 서버에서 가져와 테이블에 넣어주는 함수
 */
const getItemList = function () {
    console.log($('#purc_no').val());
    $.ajax({
        type: "GET",
        url: "purcItemList",
        data: {
            purc_no: $('#purc_no').val()
        },
        success: (res) => {
            console.log(res);
            if (res.length == 0) {
                alert('조회가능한 정보가 없습니다.');
                return;
            }
            $('#itemTableBody').empty();
            res.forEach((ele, idx) => {
                if (!ele['qty'])
                    return;
                $('#itemTableBody').append(
                    `<tr>
	                    <th scope="row"><input type="checkbox"></th>
	                    <td id="initemNo${idx}">${ele['item_cd']}</td>
	                    <td>${ele['item_nm']}</td>
	                    <td>${ele['item_spec']}</td>
	                    <td>${ele['item_unit']}</td>
	                    <td><input class="initemQty" id="initemQty${idx}" onchange="checkItemQty(this,${ele['qty']})" type="number" value="${ele['qty']}" data-cost="${ele.purc_cost}" min="1" placeholder="입고수량" style="width: 75px"></td>
	                    <td>${ele['purc_cost'].toLocaleString()}</td>
                        <td>${(ele['purc_cost'] * ele['qty']).toLocaleString()}</td>
	                  </tr>`
                )
            });
            calcTotalAmount();
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
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
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }
    })

}

/**
 * 입력된 수량의 소계와 합계를 변경하는 함수
 */
const calcTotalAmount = function () {
    $('#itemTableFoot').empty();
    let totalCost = 0;
    let totalAmount = 0;
    [...document.getElementsByClassName('initemQty')].forEach(item => {
        const qty = item.value * 1;
        const cost = item.dataset.cost * 1;
        const subTotal = qty * cost;
        item.parentNode.parentNode.lastElementChild.textContent = subTotal.toLocaleString();
        totalCost += subTotal;
        totalAmount += qty;
    });
    $('#itemTableFoot').append(`
        <tr>
            <th colspan="5">합계</th>
            <td id="totalQuantity">${totalAmount.toLocaleString()}</td>
            <td></td>
            <td id="totalAmount">${totalCost.toLocaleString()}</td>
        </tr>
    `);
}

// 조회된 발주번호 저장 변수
let purcData = {};
/**
 * 발주조회 창에서 조회 버튼 클릭 시 서버에서 정보를 받아 Select List에 넣는 함수
 */
const searchPurc = function () {
    $.ajax({
        type: "GET",
        url: "searchPurc",
        data: {
            period: $('#period').val(),
            cust_nm: $('#custNm').val(),
            purc_no: $('#purCd').val()
        },
        success: (res) => {
            console.log(res);
            if (res.length == 0) {
                alert('조회가능한 정보가 없습니다.');
                return;
            }
            const purcSelect = $('#purcSelect');
            purcSelect.empty();
            purcData = {};
            res.forEach(ele => {
                purcSelect.append(
                    `<option ondblclick="pickPurcNo()" value="${ele['purc_no']}">${ele['purc_no'] + '/' + ele['cust_nm'] + '/' + ele['cust_emp'] + '/' + ele['purc_dt']}</option>`
                )
                purcData[ele['purc_no']] = ele;
            });

            purcSelect.focus();
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
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
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }
    })
}



/**
 * 입고품목 수량 입력 시 발주 수량(잔여량)보다 많은지 체크하는 함수
 * @param {HTMLInputElement} item 수량입력 input element
 * @param {Number} num 최대 수량
 */
const checkItemQty = function (item, num) {
    if (item.value > num) {
        alert('발주수량 보다 큰 값을 입력할 수 없습니다.\n발주수량:' + num);
        item.value = num;
    } else if(item.value == 0){
		alert('0개를 입력할 수 없습니다. \n삭제 기능을 이용해주세요');
        item.value = num;
	}
    calcTotalAmount();
}

/**
 * 입고품목리스트에서 체크된 항목 지우는 함수
 */
const deleteRow = function () {
    $("#itemTableBody input[type='checkbox']:checked").each((idx, item) => {
        $(item).parent().parent().remove();
    })
    calcTotalAmount();
}

/**
 * 입고 데이터 서버에 등록
 */
const regInitem = function () {
    // 테이블에 품목이 있는지 체크
    if ($('#itemTableBody tr').length == 0) {
        alert('저장가능한 품목이 없습니다.');
        return;
    }
    // 입력해야하는 정보 입력되었는지 체크
    if (!requieredInputCheck()) {
        return;
    }
    // 리스트에 담기
    const inItems = [];
    $('#itemTableBody tr').each((idx, item) => {
        const item_cd = item.children[1].innerText;
        const qty = item.children[5].children[0].value;
        const purc_no = $('#purc_no').val();
        inItems.push({ purc_no, item_cd, qty });
    })

    console.log(inItems);


    $.ajax({
        type: "POST",
        url: "/regInitem",
        contentType: "application/json",
        data: JSON.stringify({
            initem_dt: $('#initem_dt').val(),
            purc_no: $('#purc_no').val(),
            cust_emp: $('#cust_emp').val(),
            wh_cd: $('#wh_cd').val(),
            remark: $('#remark').val(),
            initem_end: $('#initem_end').val(),
            inItems
        }),
        success: (res) => {
            console.log(res);
            if (res.success == 'false') {
                alert(res.errMsg);
                switch (res.errCode) {
                    case 'login':
                        location.href = '/';
                        return;
                    case 'err':
                        location.href = '/initem';
                        return;
                    default:
                        location.href = '/initem';
                        return;
                }
            }

            location.href = '/initem';
        },
        error : (request, status, error) => {
			alert('잘못된 요청입니다.\n다시 확인해 주세요.');
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
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }
    })

}

/**
 * 필수 입력 항목 입력되어있는 체크하는 함수
 * @returns {Boolean} true: 필수 입력사항 모두 입력, false: 미입력
 */
const requieredInputCheck = function () {
    const initemDt = $('#initem_dt');
    if (initemDt.val() == '' || initemDt.val() == null) {
        initemDt.focus();
        return false;
    }

    const purcNo = $('#purc_no');
    if (purcNo.val() == '' || purcNo.val() == null) {
        purcNo.focus();
        return false;
    }

    const custNm = $('#cust_nm');
    if (custNm.val() == '' || custNm.val() == null) {
        custNm.focus();
        return false;
    }

    const custEmp = $('#cust_emp');
    if (custEmp.val() == '' || custEmp.val() == null) {
        custEmp.focus();
        return false;
    }

    const whCd = $('#wh_cd');
    if (whCd.val() == '' || whCd.val() == null) {
        whCd.focus();
        return false;
    }
    console.log('필수 사항 입력완료');
    return true;
}