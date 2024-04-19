
$(document).ready(function() {
    // 검색 버튼 클릭 이벤트 연결
    $("#searchButton").click(function() {
        const searchParams = collectSearchParams();
        searchPurchases(searchParams);
    });

    // 모든 입력 필드에 대해 엔터 키 이벤트 처리
    $("#cust_nm, #purc_no, #item_nm, #start_date, #end_date").keypress(function(event) {
        if (event.which == 13) {  // 13은 엔터 키의 키 코드
            event.preventDefault(); // 폼 제출 방지
            const searchParams = collectSearchParams();
            searchPurchases(searchParams);
        }
    });

    // 오늘 날짜를 시작일자와 마감일자 입력란에 설정
    inputToday($("#start_date"));
    inputToday($("#end_date"));
});

// 검색 파라미터 수집 함수
function collectSearchParams() {
    return {
        currentPage: 1,
        start_date: $("#start_date").val(),
        end_date: $("#end_date").val(),
        cust_nm: $("#cust_nm").val(),
        purc_no: $("#purc_no").val(),
        item_nm: $("#item_nm").val()
    };
}

// 검색 실행 함수
function searchPurchases(searchParams) {
    $.ajax({
        type: "GET",
        url: "/searchPurchases",
        data: searchParams,
        success: function(response) {
            console.log("검색 결과:", response);
            updateTable(response.items);
            updatePagination(response.page);
        },
        error: function(xhr, status, error) {
            console.error("검색 실패:", error);
            alert("검색에 실패했습니다. 오류: " + error);
        }
    });
}

// 날짜 입력 필드에 오늘 날짜 설정 함수
function inputToday(inputField) {
    let today = new Date().toISOString().slice(0, 10);
    inputField.val(today);
}


function updateTable(items) {
    const tbody = $("#searchPurchase");
    tbody.empty();
    
    if (items.length === 0) {
    tbody.append('<tr><td colspan="10" class="text-center">조회결과가 없습니다.</td></tr>');
    return; // 항목이 없으면 메시지 출력 후 함수 종료
    }
    
    items.forEach((item, index) => {
        tbody.append(`
            <tr>
                <td><input type="checkbox" id="itemSelect${index + 1}" name="itemSelect"></td>
                <td>${index + 1}</td>
                <td>${item.purc_no}</td>
                <td>${item.cust_nm}</td>
                <td>${item.item_nm}</td>
                <td>${Number(item.qty).toLocaleString()}개</td>
                <td>${Number(item.item_cost).toLocaleString()}원</td>
                <td>${Number(item.purc_cost).toLocaleString()}원</td>
                <td>${item.purc_dt}</td>
                <td>
                    ${item.purc_status_chk === 0 ? '<span class="badge bg-success">발주진행</span>' :
                    item.purc_status_chk === 1 ? '<span class="badge bg-primary">입고진행</span>' :
                    '<span class="badge bg-warning">입고완료</span>'}
                </td>
            </tr>`
        );
    });
}
function updatePagination(page) {
    const pagination = $("#pagination");
    pagination.empty(); // 기존 페이징 컨트롤 삭제

    if (page.totalPage === 0) return; // 페이지가 없으면 종료

    let startPage = Math.max(1, page.currentPage - 2);
    let endPage = startPage + 4;

    if (endPage > page.totalPage) {
        endPage = page.totalPage;
        startPage = Math.max(1, endPage - 4); // 총 페이지 수가 5개 미만인 경우 시작 페이지 조정
    }

    // "이전" 페이지 링크
    if (startPage > 1) {
        pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(${startPage - 1}); event.preventDefault();">&laquo;</a></li>`);
    }

    // 페이지 번호 링크
    for (let i = startPage; i <= endPage; i++) {
        pagination.append(`<li class="page-item ${page.currentPage === i ? 'active' : ''}"><a class="page-link" href="#" onclick="changePage(${i}); event.preventDefault();">${i}</a></li>`);
    }

    // "다음" 페이지 링크
    if (endPage < page.totalPage) {
        pagination.append(`<li class="page-item"><a class="page-link" href="#" onclick="changePage(${endPage + 1}); event.preventDefault();">&raquo;</a></li>`);
    }
}


function changePage(pageNumber) {
    $("#searchButton").data("currentPage", pageNumber); // 현재 페이지 업데이트
    const searchParams = {
        currentPage: pageNumber,
        start_date: $("#start_date").val(),
        end_date: $("#end_date").val(),
        cust_nm: $("#cust_nm").val(),
        purc_no: $("#purc_no").val(),
        item_nm: $("#item_nm").val()
    };

    searchPurchases(searchParams);
}



/*
function inputToday(tagId){
	let todayLong= new Date();
	let today = todayLong.toISOString().slice(0,10);
	tagId.val(today);
	}
inputToday($("#start_date"))
inputToday($("#end_date"))

function searchInputEnter(){
	$("#searchInput").find("input").keypress(function(event) {
        if (event.which == 13) {  // 13은 엔터 키의 키 코드
            event.preventDefault(); // 폼 제출을 방지
            searchPurchases();
        }
    });
}


*/

