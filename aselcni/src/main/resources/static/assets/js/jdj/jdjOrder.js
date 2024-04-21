$(document).ready(function(){
	function getParameterByName(name) {
	    let url = new URL(window.location.href);
	    return url.searchParams.get(name);
	}
	var selCusts;
	var selUsers;
	var order_no;
	var seltDT;
	console.log("main");

	
	
	// 체크박스 선택 -> 배열 저장
	$(function() {
	    // 매입처 체크박스 처리
	    $('.custCheckbox').change(function() {
	        selCusts = $('.custCheckbox:checked').map(function() {
	            return $(this).val();
	        }).get();
	        console.log('고객사 선택 값: ', selCusts);
	        console.log("=-==> " + seltDT)
	    });
	
	    // 담당자 체크박스 처리
	    $('.userCheckbox').change(function() {
	        selUsers = $('.userCheckbox:checked').map(function() {
	            return $(this).val();
	        }).get();
	        console.log('담당자 선택 값: ', selUsers);
	    });
	});
	
	
	// 리셋 버튼 눌렀을때 
	$("#resetBtn").click(function() {
	    $("#input_order_no").val("");
	    $("#input_start_dt").val("");
	    $("#input_end_dt").val("");
	
	    $("#selectDT").text("기간 선택");
	    $(".custCheckbox").prop("checked", false);
	    $(".userCheckbox").prop("checked", false);
		
		selCusts = [];
		selUsers = [];
		order_no = "";
		seltDT = "";
	});


	// 선택한 착수일보다 무조건 이후만 선택가능
	$("#input_start_dt").change(function(){
		input_start_dt = $("#input_start_dt").val();			// 착수일
		$("#input_end_dt").attr('min', input_start_dt);
	})
	
	$("#serachBtn").click(async function(){  // async 키워드 추가
	    console.log("----- searchBtn -----")
	    order_no = $("#input_order_no").val();

		let pageValue = getParameterByName('page');
		if(pageValue == null){
			pageValue = 1;
		}
		//if(seltDT == null || seltDT == ""){
		//	alert("기간비었따")
		//}
		index = (pageValue * 10) - 9;
	        try{
			    let response = await $.ajax({
			        url: "/order",
			        type: "POST",
			        contentType: "application/json", 
			        data: JSON.stringify({  // 데이터를 JSON 형식으로 변환
			            order_no : order_no,
			            seltDT : seltDT,
			            selUsers : selUsers,
			            selCusts : selCusts,
			            input_start_dt : $("#input_start_dt").val(),
			            input_end_dt : $("#input_end_dt").val(),
			            currPage : pageValue
			        })
			    });
			   	
	            $("#table_body").empty(); // 기존 테이블 내용 제거
	            $("#paging").empty();
	            console.log("----", response)
				if(response.length == 0){
					alert("조회 결과가 없습니다");
					window.location.href = "/order";

				}
			    $.each(response, function(index, order) {
			        var newRow = "<tr>" +
			            "<th scope='row' class='text-center'>" + (index + 1) + "</th>" +
			            "<td><a href='/orderSpec?detailView=" + order.order_sec_no + "' class='text-center'>" + order.order_no + "</a></td>" +
			            "<td>" + order.cust_nm + "</td>" +
			            "<td class='datatable'>" + order.order_dt + "</td>" +
			            "<td class='datatable'>" + order.order_end_dt + "</td>" +
			            "<td>" + order.user_nm + "</td>" +
			            "<td class='blue'><span class='badge " + getStatusClass(order.order_status_chk) + "'>" + getStatusText(order.order_status_chk) + "</span></td>" +
			            "</tr>";
					
			        $("#table_body").append(newRow); // 새로운 행 추가
			        
			        // $("#input_order_no").val("");
				    // $("#input_start_dt").val("");
				    // $("#input_end_dt").val("");
				
				    // $("#selectDT").text("기간 선택");
				    // $(".custCheckbox").prop("checked", false);
				    // $(".userCheckbox").prop("checked", false);
					
					// selCusts = [];
					// selUsers = [];
					// order_no = "";
					// seltDT = "";
			    });
			    // var paging = "<p>거묘ㅐㄱ </p>"
			    $("#paging").append(paging);
	        }
	        catch (error){
	            console.error(error);
	        }
			
		function getStatusClass(status) {
		    switch(status) {
		        case 1: return "bg-secondary";
		        case 2: return "bg-primary";
		        case 3: return "bg-secondary";
		        default: return "bg-warning text-dark";
		    }
		}
			
		function getStatusText(status) {
		    switch(status) {
		        case 1: return "주문 취소";
		        case 2: return "진행중";
		        case 3: return "출고 완료";
		        default: return "주문 완료";
		    }
		}

		console.log("input_start_dt : ", $("#input_end_dt").val());
		console.log("input_end_dt : ", $("#input_end_dt").val());
		console.log("selectDT : ", seltDT);
		console.log(selCusts + " : checkedCustValues");
		console.log(selUsers + " : checkedUserValues");
		
	})

	
	$("#searchUserName").on('input', function(){
        var input = $(this).val().toLowerCase();
        $(".userDrop").each(function(){
            var label = $(this).find('.form-check-label').text().toLowerCase();
            if (label.includes(input)) {
	            console.log(label + " label");
	            $(this).css('display', 'block')
                
            } else {
	            $(this).css('display', 'none')
            }
        });
    });

	
	$(".dropdown-menu .dropdown-item").click(function(){
	  var selText = $(this).text();
	  seltDT = $(this).val();
	  $(this).parents('.input-group').find('.dropdown-toggle').html(selText+' <span class="caret"></span>');
	});

})
// 직원, 고객사 선택 후 검색버튼 눌ㄹ렀을때 