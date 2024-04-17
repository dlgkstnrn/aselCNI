
$(document).ready(function () {
  //닫기 버튼 클릭시 modal 입력 내용 클리어
  function modalContentClear() {
    $(".modal-content input").val("");
    $(".modal-content textarea").val("");
    $('#insertOutitemBtn').prop('disabled', true);
    $('#updateOutitemSubmitBtn').hide();
    $('#updateOutitemBtn').show();
    $('#detail_outitem_item_list tbody').empty();
  }

    $('button[data-bs-dismiss="modal"]').on("click", //닫기버튼 누르면
      function () {
        modalContentClear(); 
      }
    );
  

  //검색
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







     //메인화면에서 등록버튼 눌렀을 때..
    $("#outitem_insert_btn").click(function(){ 
      
      //모달 초기화
      modalContentClear();

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
  
        $('#orderInfo_order_dt').val(orderInfo.order_dt);
        $('#orderInfo_order_dt').html(orderInfo.order_dt);   //주문일자

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
        
        $.each(response, function(index, item) { /* 각각의 주문품목 */
            var checkbox = $('<input>').attr({
                type: 'checkbox',
                name: 'selectedItems',
                value: item.item_cd,
                'data-qty': item.qty
            });

            var qtyValue;
            var maxQty;
            var minQty;

            var insertQtyInput = $('<input>').attr({
                type: 'number',
                class: 'insertQty form-control',
                name: 'insert_qty',
                min: 0, 
                max: item.stock, 
                value: 0 
            });

            
            insertQtyInput.on('change', function() {
                qtyValue = parseInt($(this).val()); // 입력된 값
                maxQty = parseInt($(this).attr('max')); //재고 
                minQty = parseInt($(this).attr('min')); //최소: 0

                console.log('qtyValue'+qtyValue);
                console.log('maxQty'+maxQty);
                console.log('minQty'+minQty);
                console.log('remain_qty'+item.remain_qty); //남은수량

                console.log(Boolean(qtyValue > maxQty));
                console.log(Boolean(qtyValue > item.remain_qty));
                console.log(Boolean(qtyValue < minQty));
                console.log(Boolean(isNaN(qtyValue)));

                // 체크박스의 상태 변화에 따라 버튼 상태 업데이트
                updateInsertOutitemBtnState();
            });

            function updateInsertOutitemBtnState() {
                var checkedCount = $('input[name="selectedItems"]:checked').length; //체크
                if (qtyValue > maxQty || qtyValue > item.remain_qty || qtyValue <= minQty 
                  || isNaN(qtyValue) || checkedCount == 0) { //출고버튼 비활성화 조건
                    $('#insertOutitemBtn').prop('disabled', true); 
                } else {
                    $('#insertOutitemBtn').prop('disabled', false);
                }
            }
            
            $('#outitem_item_list tbody').append(
                $('<tr>').append(
                    $('<td>').append(checkbox),
                    $('<td>').text(item.item_nm),
                    $('<td>').text(item.stock),
                    $('<td>').text(item.qty),
                    $('<td>').text(item.remain_qty),
                    $('<td>').append(insertQtyInput),
                )
            );
        }); // each
    },
    error: function(xhr, status, error) {
        console.error(error);
    }
  }); //주문번호 selectBox


}); //주문번호 selectBox

  $('#insertOutitemBtn').click(function(e){ //출고등록 버튼(form) 누르면
    e.preventDefault(); // 기본 이벤트 동작 방지

    var insert_cust_emp_value = document.getElementById('insert_cust_emp').value;
     // 입력값이 비어 있는지 확인
     if (insert_cust_emp_value === '') {
      // 입력란이 비어 있으면 경고 메시지를 표시하고 클릭 이벤트를 취소
      alert('거래처 담당자명을 입력해주세요.');
      return false; 
  }

    // 현재 날짜 생성
    var now = new Date();
    var year = now.getFullYear();
    var month = (now.getMonth() + 1).toString();
    if(month.length===1) {month="0"+month;} //1월-9월일 경우 01 - 09로 변경

    var day = now.getDate();
    var currentDate = year + "-" + month + "-" + day; // ex 2024-04-07
    console.log('currentDate:'+currentDate);
    
    var outitemDt = $('#insert_outitem_dt').val(); //출고일자 : 달력으로 선택
    var orderDt=  $('#orderInfo_order_dt').val() //주문일자 : 주문번호 선택시 자동으로 가져와 보여줌
    console.log('outitemDt:'+outitemDt);
    console.log('orderDt:'+orderDt);

    // 날짜 형식 문자열에서 '-' 제거한 숫자값 계산
    var currentDateValue = Number(currentDate.replace(/-/g, ''));
    var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
    var orderDtValue =  Number(orderDt.replace(/-/g, ''));


    //출고일자가 현재시간 및 주문일자보다 같거나 늦어야함
    if (outitemDtValue >= currentDateValue && outitemDtValue>=orderDtValue) { 
        //이 조건 만족할 경우에만 출고등록 진행....

        // form으로 제출할 outitem데이터들
        var insertOutitemData = {
            outitem_no : outitemDt, //일단 2024-04-07 그대로 보내고, OUT2404070001..으로의 변환은 자바에서, seq_no와 같이.
            order_no: $('#insertOrderNo').val(),
            outitem_dt: $('#insert_outitem_dt').val(),
            cust_emp: $('#insert_cust_emp').val(),
            remark: $('#insert_remark').val()
        };

        console.log(insertOutitemData);

        // 선택된 주문품목 -> 출고품목으로 : 출고품목 테이블에 insert
        var selectedItems = [];

        $('input[name="selectedItems"]:checked').each(function() {
            var itemCd = $(this).val();
            var qty = $(this).closest('tr').find('.insertQty').val(); // 해당 체크박스에 연결된 insertQtyInput의 입력값 가져오기
            if(qty!=0) {//수량이 0이면 출고품목 테이블에 보내지 않음
              selectedItems.push({ item_cd: itemCd, qty: qty }); 
            }
        });

        console.log(selectedItems);

        // 데이터 조합
        var insertData = {
            outitemData: insertOutitemData,
            selectedItems: selectedItems
        };

        console.log(insertData);

        // 조합한 insertData를 서버로 전송
        $.ajax({
            url: 'insertOutitem',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(insertData),
            success: function(response){
                alert('출고 등록 완료.');
                modalContentClear();
                $('#outitem_insert').modal('hide');
                location.reload();
            }
        });

    } else {
        alert("출고 날짜가 정상적으로 설정되지 않았습니다.");
    }
  });





/* 상세 조회 */

//수정/삭제에서도 쓸 변수들 선언
let outitemNo;
let orderNo;
let orderDt;
let outitemDt;
let detail_cust_emp;
let detail_remark;


    //메인화면 테이블 행 클릭시 modal 상세/수정창으로 이동
    $('tr[data-bs-toggle="modal"]').on("click", function () {

      modalContentClear(); //초기화
      

      outitemNo = $(this).find("td:nth-child(2)").text(); //출고번호
      $("#detail_outitem_no").html(outitemNo);

      orderNo = $(this).find("td:nth-child(3)").text(); //주문번호
      $("#detail_order_no").html(orderNo);

      orderDt = $(this).find("td:nth-child(6)").text(); //주문일자
      $("#detail_order_dt").html(orderDt);

      let orderEndDt = $(this).find("td:nth-child(7)").text(); //주문 마감일(납기일)
      $("#detail_order_end_dt").html(orderEndDt);

      outitemDt = $(this).find("td:nth-child(8)").text(); //출고일자
      $("#detail_outitem_dt").html(outitemDt);

      let custNm = $(this).find("td:nth-child(4)").text(); //매입처
      $("#detail_cust_nm").html(custNm);



/*       detail_remark = $(this).find(".invisibleRemark").text(); //비고
      $("#detail_remark").html(detail_remark); */



      let orderStatusChk = $(this).find("td:nth-child(10)").text(); //출고 상태
      $("#detail_order_status_chk").html(orderStatusChk);


      // 현재 날짜 생성
      var now = new Date();
      var year = now.getFullYear();
      var month = (now.getMonth() + 1).toString();
      if(month.length===1) {month="0"+month;} //1월-9월일 경우 01 - 09로 변경
  
      var day = now.getDate();
      var currentDate = year + "-" + month + "-" + day; // ex 2024-04-07
      console.log('currentDate:'+currentDate);

      var currentDateValue = Number(currentDate.replace(/-/g, ''));
      var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
      console.log('수정 전 outitemDtValue:'+outitemDtValue);

      if(currentDateValue >= outitemDtValue) { //이미 출고가 되었다면
        $('#updateOutitemBtn').prop('disabled', true); 
      } else {
        $('#updateOutitemBtn').prop('disabled', false); 
      }


      /* ajax로 그외 것, 출고한 품목들 가져오기 */
      $.ajax({
        url: 'ujmGetOutitemDetail',
        type: 'GET',
        data: { order_no: orderNo, outitem_no: outitemNo},
        success: function(response) {
          console.log(response);
 
          
          $.each(response, function(index, item) { /* 각각의 주문품목 */

          detail_cust_emp = item.cust_emp; //상대 담당자
          $("#detail_cust_emp").html(detail_cust_emp);
            
            $('#detail_outitem_item_list tbody').append(
                $('<tr>').append(
                    $('<td>').text(''),
                    $('<td>').text(item.item_nm),
                    $('<td>').text(item.stock), 
                    $('<td>').text(item.qty),
                    $('<td>').text(item.qty - item.order_qty),
                    $('<td>').text(item.outitem_qty),
                )
            );
          }); //each 주문품목
 
        }, //success 끝
        error: function(xhr, status, error) {
            console.error(error);
        }

      }); //상세조회 ajax
    }); //상세조회 modal클릭 끝




    // 수정하기 버튼 클릭시
    $("#updateOutitemBtn").on("click", function (e) {
      e.preventDefault(); // 기본 이벤트 동작 방지


      modalContentClear(); //초기화


      $("#updateOutitemSubmitBtn").show();
      $('#updateOutitemBtn').hide();

      //수정완료 버튼 활성화 여부에 사용
      let qtyChk=0; 
      let dtChk=0;

      //거래처 담당자를 수정 가능하게 input으로 변경
      var detail_cust_emp_value = document.getElementById('detail_cust_emp').innerText;
      document.getElementById("detail_cust_emp").innerHTML = '';

      var inputCustEmp = document.createElement('input');
          inputCustEmp.setAttribute('type', 'text');
          inputCustEmp.setAttribute('class', 'form-control');
          inputCustEmp.setAttribute('id', 'change_cust_emp');
          inputCustEmp.setAttribute('name', 'cust_emp');
          inputCustEmp.setAttribute('autocomplete', 'off');
          inputCustEmp.setAttribute('value', detail_cust_emp_value);
          inputCustEmp.setAttribute('style', 'width: 200px;');

      document.getElementById("detail_cust_emp").appendChild(inputCustEmp);

      //비고도 수정 가능하게 input으로 변경
      var detail_remark_value = document.getElementById('detail_remark').innerText;
      document.getElementById("detail_remark").innerHTML = '';

      var inputRemark = document.createElement('input');
          inputRemark.setAttribute('type', 'text');
          inputRemark.setAttribute('class', 'form-control');
          inputRemark.setAttribute('id', 'change_remark');
          inputRemark.setAttribute('name', 'remark');
          inputRemark.setAttribute('autocomplete', 'off');
          inputRemark.setAttribute('value', detail_remark_value);
          inputRemark.setAttribute('style', 'width: 200px;');

      document.getElementById("detail_remark").appendChild(inputRemark);

      

      
        /* ajax로 품목 부분 다시 가져오기(수정 위해) */
        $.ajax({
          url: 'ujmGetOutitemToUpdate',
          type: 'GET',
          data: { order_no: orderNo,
                  outitem_no: outitemNo 
                },
          success: function(response) {
            console.log('출고품목조회:'+response);  
    
            $('#detail_outitem_item_list tbody').empty(); //품목 넣기 전 이전 출고의 품목 제거
            
            $.each(response, function(index, item) { /* 각각의 주문품목 */
              var checkbox = $('<input>').attr({
                  type: 'checkbox',
                  name: 'selectedItems',
                  value: item.item_cd,
                  'data-qty': item.qty 
              });
              console.log('ujmGetOutitemToUpdate each:'+item.item_cd,);

              var qtyValue;
              var maxQty;
              var minQty;
      
              var updateQtyInput = $('<input>').attr({
                  type: 'number',
                  class: 'updateQty form-control',
                  name: 'update_qty',
                  min: 0, 
                  max: item.stock, 
                  value: item.old_qty
                }).on('change', function() {

                  if ($(this).val() === null) {
                    $(this).val() = 0;
                  }

                qtyValue = parseInt($(this).val()); // 입력된 값
                maxQty = parseInt($(this).attr('max')); //재고 
                minQty = parseInt($(this).attr('min')); 
                
                console.log('qtyValue:'+qtyValue);
                console.log('maxQty:'+maxQty);
                console.log('minQty:'+minQty);
                console.log(item.item_nm +'의 old_qty(출고한 수량):'+item.old_qty);
                console.log(item.item_nm +'의 stock:'+item.stock);
                console.log(item.item_nm +'의 outitem_sum_qty(지금까지 주문한 수량):'+item.outitem_sum_qty);
                console.log(item.item_nm +'의 old_order_qty(총 주문 수량):'+item.old_order_qty);
                console.log(item.item_nm +'의 checkQty(총 주문 수량):'+item.old_order_qty);
      
                console.log(Boolean(qtyValue > maxQty)); //재고보다 많으면 안됨
                console.log(Boolean(qtyValue < 0)); //0보다 작으면 안됨
                console.log(Boolean(qtyValue < minQty));
                console.log(Boolean(isNaN(qtyValue)));
                console.log("---");
      
                // 체크박스의 상태 변화에 따라 버튼 상태 업데이트
                updateInsertOutitemBtnState();
              });
                
                function updateInsertOutitemBtnState() {
                  var checkedCount = $('input[name="selectedItems"]:checked').length; //체크
                  var checkQty = item.outitem_sum_qty - item.old_qty + qtyValue; 
                  // 지금걸 제외한 출고량에서 수정할 출고량을 더한 값이 재고 또는 주문수량을 넘기면 안됨
                  console.log(checkQty>item.stock);
                  console.log(checkQty>item.old_order_qty);

                  //수정완료버튼 비활성화 조건
                  if (qtyValue > maxQty || qtyValue < 0 
                    || isNaN(qtyValue) || checkedCount == 0
                    || checkQty>item.stock || checkQty > item.old_order_qty) { 
                      qtyChk=0;
                  } else {
                      qtyChk=1;
                  }

                  console.log('qtyChk:'+ qtyChk);

                  if(qtyChk==1 && dtChk==1) { //입력한 품목수량 및 출고일자 만족 시 수정완료버튼 누르기 가능
                    $('#updateOutitemSubmitBtn').prop('disabled', false);
                  } else {
                    $('#updateOutitemSubmitBtn').prop('disabled', true);
                  }
              }
                
              
              $('#detail_outitem_item_list tbody').append(
                  $('<tr>').append(
                      $('<td>').append(checkbox),
                      $('<td>').text(item.item_nm),
                      $('<td>').text(item.stock),
                      $('<td>').text(item.old_order_qty),
                      $('<td>').text(item.old_order_qty - item.outitem_sum_qty),
                      $('<td>').append(updateQtyInput),
                  )
              );
            }); //each
      
          },  //성공시
          error: function(xhr, status, error) {
              console.error(error);
          } 
        }); //ajax끝

      

      
        // 출고일자 달력으로 변경가능하게
        var outitemDt = $("#detail_outitem_dt").text(); //(수정하기 버튼 클릭시 최초 가져옴)
        console.log('outitemDt:'+outitemDt);
        $('#detail_outitem_dt').empty();
        $('#detail_outitem_dt').append('<input type="date" class="form-control" id="calendar_outitem_dt"'
        +' name="outitem_dt" style="width: 200px;"/>');


      
        //출고일자 변경
        $('#calendar_outitem_dt').on('change', function() {
          outitemDt = $(this).val();
          console.log('outitemDt:'+outitemDt);

          console.log('orderDt:'+orderDt);
    
          // 현재 날짜 생성
          var now = new Date();
          var year = now.getFullYear();
          var month = (now.getMonth() + 1).toString();
          if(month.length===1) {month="0"+month;} //1월-9월일 경우 01 - 09로 변경    
          var day = now.getDate();
          var currentDate = year + "-" + month + "-" + day; // ex 2024-04-07
          console.log('currentDate:'+currentDate);

          var currentDateValue = Number(currentDate.replace(/-/g, ''));
          var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
          var orderDtValue =  Number(orderDt.replace(/-/g, ''));

        //출고일자가 현재시간 및 주문일자보다 늦어야함
        if (outitemDtValue > currentDateValue && outitemDtValue>orderDtValue) { 
              dtChk=1;
        } else {
              dtChk=0;
        }
        console.log('dtChk:'+ dtChk);

        if(qtyChk==1 && dtChk==1) { //입력한 품목수량 및 출고일자 만족 시 수정완료버튼 누르기 가능
          $('#updateOutitemSubmitBtn').prop('disabled', false);
        } else {
          $('#updateOutitemSubmitBtn').prop('disabled', true);
        }

      }) //날짜 변경마다



    }); /* 수정하기 버튼 클릭시...끝 */





    //수정 완료 버튼 눌렀을 떄
    $('#updateOutitemSubmitBtn').click(function(e){ 
      e.preventDefault(); // 기본 이벤트 동작 방지

      var detail_cust_emp_value = document.getElementById('change_cust_emp').value;
      console.log(detail_cust_emp_value);

      if (detail_cust_emp_value === '') {
      // 입력란이 비어 있으면 경고 메시지를 표시하고 클릭 이벤트를 취소
      alert('거래처 담당자명을 입력해주세요.');
      return false; 
      }

      console.log(orderNo);

      //주문이 삭제되었는지 체크후 삭제되었다면 출고 수정이 안 되도록
      fetch('/ujmCheckOrderDeleteChk?order_no=' + orderNo)
        .then(response => response.json())
        .then(data => {
          console.log(data);
            if (data.result === 1) { //주문이 삭제됨
              alert('해당 출고의 주문이 삭제되었으므로 출고를 수정할 수 없습니다.');
              return false; 
            } 
        })
        .catch(error => {
            console.error('에러:', error);
        });



      //주문이 취소되었는지 체크후 취소되었다면 출고 수정이 안 되도록
      fetch('/ujmCheckOrderCancelChk?order_no=' + orderNo)
      .then(response => response.json())
      .then(data => {
        console.log(data);
          if (data.result === 1) { //주문이 취소됨
            alert('해당 출고의 주문이 취소되었으므로 출고를 수정할 수 없습니다.');
            return false; 
          } 
      })
      .catch(error => {
          console.error('에러:', error);
      });

    

      //반품이 되었는지 체크 후, 반품이 된 상태라면 출고 수정이 안 되도록
      fetch('/ujmReturnChk?outitem_no=' + outitemNo)
      .then(response => response.json())
      .then(data => {
        console.log(data);
          if (data.result >0) { //해당 주문번호로 반품이 되었음
            alert('해당 출고가 이미 전달되어 반품된 상태이므로 출고를 수정할 수 없습니다.');
            return false; 
          } 
      })
      .catch(error => {
          console.error('에러:', error);
      });
        
      // form으로 제출할 outitem데이터들
      var updateOutitemData = {
          outitem_no : outitemNo, 
          order_no: orderNo,
          outitem_dt: $('#calendar_outitem_dt').val(),
          cust_emp: $('#change_cust_emp').val(),
          remark: $('#change_remark').val()
      };

      console.log(updateOutitemData);

      // 선택된 주문품목 -> 출고품목으로 : 출고품목 테이블에 insert
      var selectedItems = [];
      $('input[name="selectedItems"]:checked').each(function() {
          var itemCd = $(this).val();
          var qty = $(this).closest('tr').find('.updateQty').val(); 
          selectedItems.push({ item_cd: itemCd, qty: qty });
      });

      console.log(selectedItems);

      // 데이터 조합
      var updateData = {
          outitemData: updateOutitemData,
          selectedItems: selectedItems
      };

      console.log(updateData);

      // 조합한 updateData를 서버로 전송
      $.ajax({
          url: 'updateOutitem',
          type: 'POST',
          contentType: 'application/json',
          data: JSON.stringify(updateData),
          success: function(response){
              alert('출고 수정 완료.');
              modalContentClear();
                location.reload();
          }
          
       }); 

  
  }) //수정완료 끝





}); //js 끝


