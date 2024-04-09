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
// 검색
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

// 테이블 리스트 ajax
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
                    <li class="page-item pageNum"><button class="page-link" onclick="goPage('${i}')">${i}</button></li>
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
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }

    });
}

// 페이지 이동함수
const goPage = function (i) {
    data.currentPage = i;
    getTableRow();
}

const nextPage = function (element) {
    if (data.currentPage >= element.dataset.totalPage) {
        alert('마지막 페이지 입니다.');
        return;
    }
    data.currentPage = data.currentPage * 1 + 1;
    getTableRow();
}

const prevPage = function () {
    if (data.currentPage == '1') {
        alert('첫 페이지 입니다.');
        return;
    }
    data.currentPage = '' + (data.currentPage * 1 - 1);
    getTableRow();
}


// 테이블 로우 클릭 시 상세보기 창
const detailView = function (initem_no) {
    $.ajax({
        type: "GET",
        url: "detailInitem",
        data: { initem_no },
        success: (res) => {
            console.log(res);
            $('#modal_initem_no').val(res.initem_no);
            $('#modal_initem_emp_nm').val(res.initem_emp_nm);
            $('#modal_purc_no').val(res.purc_no);
            $('#modal_purc_emp_nm').val(res.purc_emp_nm);
            $('#modal_initem_dt').val(res.initem_dt);
            $('#modal_cust_nm').val(res.cust_nm);
            $('#modal_cust_emp').val(res.cust_emp);
            $('#modal_wh_cd').empty();
            res.whs.forEach((wh) => {
                $('#modal_wh_cd').append(
                    `
					<option value="${wh.wh_cd}" ${wh.wh_cd == res.wh_cd ? 'selected' : ''}>${wh.wh_nm}</option>
					`
                );
            })
            $('#modal_remark').val(res.remark);

            $('#modal_itemTableBody').empty();
            res.inItems.forEach((ele, idx) => {
                if (!ele['qty'])
                    return;
                $('#modal_itemTableBody').append(
                    `<tr>
	                    <td id="initemNo${idx}">${ele['item_cd']}</td>
	                    <td>${ele['item_nm']}</td>
	                    <td>${ele['item_spec']}</td>
	                    <td>${ele['item_unit']}</td>
	                    <td><input id="initemQty${idx}" onchange="checkItemQty(this,${ele['qty']})" type="number" value="${ele['qty']}" min="1" placeholder="입고수량" style="width: 75px"></td>
	                    <td>${ele['item_cost']}</td>
	                    <td>${ele.qty * ele.item_cost}</td>
	                  </tr>`
                )
            })


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
        complete: () => {
            $('#ajaxLoadingImg').remove();
        }
    })
}