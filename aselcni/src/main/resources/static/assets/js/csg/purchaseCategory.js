/*function submitFormWithSave() {
    // "저장" 버튼 클릭 시의 동작
    // 예를 들어, 폼 데이터를 서버의 특정 엔드포인트로 전송
    document.getElementById('purchaseItem2').action = 'purchaseSave';
    document.getElementById('purchaseItem2').submit();
}

function submitFormWithCancel() {
    // "취소" 버튼 클릭 시의 동작
    // 예를 들어, 사용자를 이전 페이지로 리다이렉트
    location.href='purchase';
    
}*/

// 검색 버튼 클릭 이벤트 핸들러
$("#searchButton").click(function() {
    const searchParams = {
        currentPage: 1,
        start_date: $("#start_date").val(),
        end_date: $("#end_date").val(),
        cust_nm: $("#cust_nm").val(),
        purc_no: $("#purc_no").val(),
        item_nm: $("#item_nm").val()
    };

    $.ajax({
        type: "GET", // 요청 방식을 GET로 변경
        url: "/searchPurchases", // 검색 요청을 처리할 서버의 URL
        data: searchParams, 
        
        success: function(response) {
            console.log("검색 결과:", response);
            const tbody = $("#searchPurchase"); 
            tbody.empty(); // 테이블의 내용을 비웁니다.
            response.forEach((item, index) => {
			    tbody.append(
			        `<tr>
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
			                ${item.purc_status_chk === 0 ? '<button class="btn btn-warning btn-sm">발주진행중</button>' :
			                item.purc_status_chk === 1 ? '<button class="btn btn-info btn-sm">입고진행중</button>' :
			                '<button class="btn btn-success btn-sm">입고완료</button>'}
			            </td>
			        </tr>`
			    );
			});

        },
        error: function(xhr, status, error) {
            console.error("검색 실패:", error);
        }
    });
});




