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
    console.log(data);
}

// 검색
const searchInitem = function () {
    // 검색 기능

}