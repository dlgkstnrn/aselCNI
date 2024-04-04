const offset = new Date().getTimezoneOffset() * 60000;
const now = new Date(Date.now() - offset).toISOString().substring(0, 10);
$('#start_date').val(now);
$('#end_date').val(now);


// 검색 시 서버에 전달할 객체
const data = {
    currentPage: '1',
    start_date: $('#start_date').val(),
    end_date: $('#end_date').val(),
    cust_nm: $('#cust_nm').val(),
    item_nm: $('#item_nm').val(),
    initem_no: $('initem_no').val()
}

// 입력값 변경 시 전달 객체 최신화 함수
const changeData = function (elem) {
    data[elem.id] = elem.value;
    data.currentPage = '1';
    console.log(data);
}

// 검색
const searchInitem = function () {
    // 검색 기능
    $.ajax({
        type: "GET",
        url: "/searchInitems",
        data,
        success: (res) => {
            console.log(res);

            if (res.initems.length == 0) {
                alert('조회가능한 정보가 없습니다.');
                return;
            }

            const tbody = $('#initemListTable');
            tbody.empty();
            res.initems.forEach((item, idx) => {
                tbody.append(
                    `
                    <tr onclick="console.log('${item.initem_no}')" style="cursor:pointer;">
                        <th scope="row">${idx + 1 + (res.page.currentPage - 1) * res.page.rowPage}</th>
                        <td>${item.initem_no}</td>
                        <td>${item.initem_dt}</td>
                        <td>${item.cust_nm}</td>
                        <td>${item.item_nm}</td>
                    </tr>
                    `
                )
            });


            /*
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
                        <td><input id="initemQty${idx}" onchange="checkItemQty(this,${ele['qty']})" type="number" value="${ele['qty']}" placeholder="입고수량" style="width: 75px"></td>
                        <td>${ele['purc_cost']}</td>
                      </tr>`
                )
            });
            */
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