const offset = new Date().getTimezoneOffset() * 60000;
$('#initem_dt').val(new Date(Date.now() - offset).toISOString().substring(0, 10));

// 발주번호 선택 시
// 전역변수에 해당 정보 저장
let purcNo = '';
const selectPurc = function (item) {
    console.log(item.value);
    purcNo = item.value;
}
// 발주번호 select 선택 및 모달 창 선택 클릭 시 호출
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

// 서버와 통신하여 자제 목록 가져오는 함수
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
	                    <td><input id="initemQty${idx}" onchange="checkItemQty(this,${ele['qty']})" type="number" value="${ele['qty']}" placeholder="입고수량" style="width: 75px"></td>
	                    <td>${ele['purc_cost']}</td>
	                  </tr>`
                )
            });
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


// 조회 버튼 클릭 시 서버에서 발주번호들 받아와 select에 입력
let purcData = {};
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
                    `<option value="${ele['purc_no']}">${ele['purc_no'] + '/' + ele['cust_nm'] + '/' + ele['cust_emp'] + '/' + ele['purc_dt']}</option>`
                )
                purcData[ele['purc_no']] = ele;
            });

            purcSelect.focus();
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



// 입고품목 수량 수정 시 발주 수량보다 많은지 체크
const checkItemQty = function (item, num) {
    if (item.value > num) {
        alert('발주수량 보다 큰 값을 입력할 수 없습니다.\n발주수량:' + num);
        item.value = num;
    }
}

// 입고품목리스트에서 체크된 품목 지우기
const deleteRow = function () {
    $("#itemTableBody input[type='checkbox']:checked").each((idx, item) => {
        $(item).parent().parent().remove();
    })
}

// 입력된 정보 DB에 저장하기
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

// 필수 입력 사항이 다 입력되었으면 true리턴
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