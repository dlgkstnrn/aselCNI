
$(document).ready(function () {
  //닫기 버튼 클릭시 modal 입력 내용 클리어

    $('button[data-bs-dismiss="modal"]').on(
      "click", //닫기버튼 누르면
      function () {
        modalContentClear(); //아래
      }
    );
  //닫기 버튼 클릭시 modal 입력 내용 클리어
  function modalContentClear() {
    $("#order_no_modal").text("주문 번호 선택");
    $(".modal-content input").val("");
    $(".modal-content textarea").val("");
  }

  //날짜
  //시작 날짜와 종료 날짜 논리 일관성
    $("#startDate").on("input", function () {
      let startDate = $("#startDate").val();
      let endDate = $("#endDate").val();

      // 시작 날짜가 종료 날짜보다 뒤에 있는 경우
      if (startDate > endDate) {
        // 시작 날짜를 종료 날짜와 동일하게 설정
        $("#startDate").val(endDate);
      }
    });

    $("#endDate").on("input", function () {
      let startDate = $("#startDate").val();
      let endDate = $("#endDate").val();

      // 시작 날짜가 종료 날짜보다 뒤에 있는 경우
      if (startDate > endDate) {
        // 시작 날짜를 종료 날짜와 동일하게 설정
        $("#endDate").val(startDate);
      }
    });


  // 좌우 버튼 누를 때마다 날짜 7일 단위로 바뀜
    $("#dateRightBtn").click(function () {
      dateShift("right");
    });

    $("#dateLeftBtn").click(function () {
      dateShift("left");
    });

  // 날짜 조정 함수
  function dateShift(direction) {
    let startDateVal = $("#startDate").val();
    let endDateVal = $("#endDate").val();

    // Date 객체로 변환
    let startDate = new Date(startDateVal);
    let endDate = new Date(endDateVal);

    // 방향에 따라 날짜를 조정
    if (direction === "right") {
      startDate.setDate(startDate.getDate() + 7);
      endDate.setDate(endDate.getDate() + 7);
    } else if (direction === "left") {
      startDate.setDate(startDate.getDate() - 7);
      endDate.setDate(endDate.getDate() - 7);
    }

    // 새로운 날짜를 입력 필드에 설정
    $("#startDate").val(startDate.toISOString().slice(0, 10));
    $("#endDate").val(endDate.toISOString().slice(0, 10));
  }

  //dropdown 기능
    $("#order_no_modal").dropdown();
    /* 주문번호 부분이 드롭다운으로 내려오게 */

/*     $("#outitem_insert").dropdown();
     등록모달 */ 

 /*      $(".dropdown-menu a").on("click", function () {
        var selectedValue = $(this).attr("data-value");
        $("#outitem_insert").text(selectedValue);
      }); */


    //조회 테이블 행 클릭시 modal 수정창으로 이동
    $('tr[data-bs-toggle="modal"]').on("click", function () {
      let orderNo = $(this).find("td:nth-child(2)").text();
      $("#order_no_modal").val(orderNo);
    });


     //등록버튼 눌렀을 때..
    $("#outitem_insert_btn").click(function(){ 



      //주문번호와 그에 해당하는 제품명(item_nm), 수량(qty), 기업명(cust_nm)을 주문품목과 주문 테이블에서 가져옴
     
      $.ajax({
          url: 'ujmGetOrderNo',
          type: 'GET',
          dataType: 'json',
          success: function(response) {
            console.log(response);
              var selectBox = $('#selectOrderNo'); //주문번호 select 부분 id , 안에 option이 있음
              selectBox.empty();
              
              $.each(response, function(index, item) { //리스트의 각각의 객체를 item으로 명명 
                  selectBox.append('<option value="' + item.order_no + '">' + 
                  item.order_no + ': ' +
                  item.customer_name + ' - ' + item.items + '</option>');
              });
          },
          error: function(xhr, status, error) {
              console.error(error);
          }
      });



  });


  
 //주문번호 셀렉트박스 눌렀을 때 : 선택한 주문번호에 대한 정보들 컨트롤러로 가져오기 위함
 $("#selectOrderNo").click(function(){ 
  var selectOrderNo = $('#selectOrderNo').val();
  $('#insertOrderNo').val(selectOrderNo); //form에 넣을 주문번호


  //주문번호와 그에 해당하는 주문일자, 매입처이름, 주문상태, 주문납기일을 조인해 가져옴
  $.ajax({
      url: 'ujmGetOrderInfoFromOrderNo',
      type: 'GET',
      data: { order_no: selectOrderNo },
      success: function(orderInfo) {
        console.log(orderInfo); //orderInfo 객체 자체
  
        
        $('#orderInfo_order_dt').val(orderInfo.order_dt); //주문일자
        $('#orderInfo_order_dt').html(orderInfo.order_dt); 

        $('.orderInfo_cust_nm').val(orderInfo.cust_nm); //매입처, 표시부분과 input hidden 둘다
        $('#orderInfo_cust_nm').html(orderInfo.cust_nm); //매입처 표시 부분

        $('#orderInfo_order_status_chk').val(orderInfo.order_status_chk);  //주문상태

        if(orderInfo.order_status_chk==0) {
        $('#orderInfo_order_status_chk').html('미출고');
        } else if(orderInfo.order_status_chk==2) {
          $('#orderInfo_order_status_chk').html('일부 출고');
        }
        
        $('#orderInfo_order_end_dt').val(orderInfo.order_end_dt); //주문납기일
        $('#orderInfo_order_end_dt').html(orderInfo.order_end_dt);

      
      
      }, 
      error: function(xhr, status, error) {
          console.error(error);
      }
   });



  //주문번호와 그에 해당하는 제품명(item_nm), 수량(qty), 기업명(cust_nm)을 주문품목과 주문 테이블에서 가져옴
  $.ajax({
    url: 'ujmGetOrderItem',
    type: 'GET',
    data: { order_no: selectOrderNo },
    success: function(response) {
      console.log('주문품목조회'+response);  

      $('#outitem_item_list tbody').empty();
      
      $.each(response, function(index, item){ /* 각각의 주문품목 */
        $('#outitem_item_list tbody').append(
            '<tr>' +
            '<td><input type="checkbox" name="selectedItems" value="' + 
            item.item_cd + '" data-qty="' + item.qty + '"></td>' +
            '<td>' + item.item_nm + '</td>'+ 
            '<input type="hidden" class="insertItemCd form-control" name="item_cd" value="item.item_cd" >' +
            '<td>' + item.stock + '</td>' +
            '<td>' + item.qty + '</td>' +
            '<td> <input type="number" class="insertQty form-control" name="qty">' + '</td>' +
            '</tr>'
        );
    });
    }, 
    error: function(xhr, status, error) {
        console.error(error);
    }
 });





}); //selectBox

$('#insertOutitemBtn').click(function(e){ //출고등록 버튼(form) 누르면
  e.preventDefault(); // 기본 이벤트 동작 방지

  // 현재 날짜 생성
  var now = new Date();
  var year = now.getFullYear();
  var month = now.getMonth() + 1;
  var day = now.getDate();
  var currentDate = year + "-" + month + "-" + day; // ex 2024-04-07

  
  var outitemDt = $('#outitem_dt').val(); //출고일자 : 달력으로 선택
  var orderDt=  $('#orderInfo_order_dt').val() //주문일자 : 주문번호 선택시 자동으로 가져와 보여줌


  // 날짜 형식 문자열에서 '-' 제거한 숫자값 계산
  var currentDateValue = Number(currentDate.replace(/-/g, ''));
  var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
  var orderDtValue =  Number(orderDt.replace(/-/g, ''));

// 현재 날짜와 outitem_dt 비교
if (outitemDtValue >= currentDateValue && outitemDtValue>=orderDtValue) { //출고일자가 현재시간 및 주문일자보다 같거나 늦어야함
  //이 조건 만족할 경우에만 출고등록 진행....
  
  // 폼 데이터 수집
  var formData = {
      orderNo: $('#orderNo').val(),
      custmEmp: $('#custmEmp').val(),
      remark: $('#remark').val(),
      // 다른 입력란 데이터 추가
  };

  // 선택된 주문품목 -> 출고품목으로 : 출고품목 테이블에 insert
  var selectedItems = [];
  $('input[name="selectedItems"]:checked').each(function() {
      var itemCd = $(this).val();
      var qty = $(this).data('qty');
      selectedItems.push({ item_cd: itemCd, qty: qty });
  });

  // 데이터 조합
  var postData = {
      formData: formData,
      selectedItems: selectedItems
  };

  // 서버로 전송
  $.ajax({
      url: 'insertOutitem',
      type: 'POST',
      contentType: 'application/json',
      data: JSON.stringify(postData),
      success: function(response){
          // 성공적으로 처리된 경우
          alert('출고 등록 완료.');
      }
  });

} else {
  alert("출고 실패.");
      }
});




}); //끝


