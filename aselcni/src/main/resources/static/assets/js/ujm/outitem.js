
$(document).ready(function () {

  //modal 입력 내용 클리어
  function modalContentClear() {
    $(".modal-content input").val("");
    $(".modal-content textarea").val("");
    $('#insertOutitemBtn').prop('disabled', true);
    $('#updateOutitemSubmitBtn').hide();
    $('#updateOutitemBtn').show();
    $('#detail_outitem_item_list tbody').empty();
  }

  //현재 날짜 설정
  let currentDate;

  function nowDate() {
    var now = new Date();
    var year = now.getFullYear();
    var month = (now.getMonth() + 1).toString();
    if(month.length===1) {month="0"+month;} //1월-9월일 경우 01 - 09로 변경

    var day = now.getDate();
    currentDate = year + "-" + month + "-" + day; // ex 2024-04-07

  }

  

  function redStar() { // 필수 입력란에 * 추가
    var redStarLabels = document.querySelectorAll('label.red-star');

    redStarLabels.forEach(function(labelElement) {
          // 이미 '*'이 추가되어 있는지 확인하고 초기화
          if (!labelElement.querySelector('.color-red')) {
            
            var spanElement = document.createElement('span');
            spanElement.className = 'color-red';
            spanElement.innerText = '*';

            labelElement.appendChild(spanElement);
        }
    });
  }

  function resetStar() { // * 삭제
    
    var starElements = document.querySelectorAll('.color-red');

    // 각 '*' 요소를 제거
    starElements.forEach(function(starElement) {
        starElement.parentNode.removeChild(starElement);
    });
  }

  //페이지 이동시
  window.addEventListener('beforeunload', resetStar);

  //모달 바깥을 클릭해 모달 밖 페이지로 벗어나왔을 시
  var modalElement = document.getElementById('outitemDetailModal');
  modalElement.addEventListener('hidden.bs.modal', resetStar);


  //닫기버튼 눌렀을 때
  $('button[data-bs-dismiss="modal"]').on("click", 
    function () {
      modalContentClear(); 
      resetStar();
    }
  );

  /* 검색 */

  //검색버튼 클릭 시
  $("#search-btn").on("click", () => {
    const start_day = $('.start-day').val();
    const end_day = $('.end-day').val();
    const outitem_no = $('.outitem-no-text').val();
    const order_no = $('.order-no-text').val();
    const cust_nm = $('.cust-nm-text').val();
    const item_nm = $('.item-nm-text').val();
    const outitem_user_nm = $('.outitem-user-nm-text').val(); //검색에 사용할 user_nm

    var url = `outitem?currentPage=1&start_day=${start_day}&end_day=${end_day}&outitem_no=${outitem_no}&order_no=${order_no}&cust_nm=${cust_nm}&item_nm=${item_nm}&outitem_user_nm=${outitem_user_nm}`;
  
    window.location.href = url;

  
  }); /* 검색 클릭 function 끝 */


  //메인화면에서 검색에 사용하는 날짜 선택 논리성
  let start_day_pre = $('.start-day').val();;
  let end_day_pre = $('.end-day').val();
  
  $('.day-box').on('change', function () {  
    
    const start_day_string = $('.start-day').val();
    const end_day_string = $('.end-day').val();
    const start_day = new Date(start_day_string);
    const end_day = new Date(end_day_string);
  
    if(start_day > end_day) {
      alert('날짜를 제대로 설정해주세요.');
      $('.start-day').val(start_day_pre);
      $('.end-day').val(end_day_pre);
    } else {
      start_day_pre = start_day_string;
      end_day_pre = end_day_string;
    }
  
  });




     //메인화면에서 등록버튼 눌렀을 때..
    $("#outitem_insert_btn").click(function(){ 
      
      //모달 초기화
      modalContentClear();
      redStar();

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
                    $('<td>').text((item.stock).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                    $('<td>').text((item.qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                    $('<td>').text((item.remain_qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
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
    nowDate();
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
            outitem_no : outitemDt, //일단 2024-04-07 그대로 보내고, OUT2404070001..으로의 변환은 자바에서
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
                /* location.reload(); */
                window.location.href='outitem';
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
      resetStar();
      

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

      //remark는 컨트롤러를 통해 가져옴
      $.ajax({
        url: "ujmFindOutitemRemark",
        method: "POST", 
        data: { outitem_no: outitemNo },
        success: function(response){
            $("#detail_remark").html(response);
        },
        error: function(xhr, status, error){
          $("#detail_remark").html("");
        }
      })



      let orderStatusChk = $(this).find("td:nth-child(10)").text(); //출고 상태
      $("#detail_order_status_chk").html(orderStatusChk);


      nowDate();
      console.log('currentDate:'+currentDate);

      var currentDateValue = Number(currentDate.replace(/-/g, ''));
      var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
      console.log('수정 전 outitemDtValue:'+outitemDtValue);

      if(currentDateValue > outitemDtValue) { //이미 출고가 되었다면
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
                    $('<td>').text((item.stock).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")), 
                    $('<td>').text((item.qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                    $('<td>').text((item.qty - item.order_qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                    $('<td>').text((item.outitem_qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
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
      redStar(); // 별 달기


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
                      $('<td>').text((item.item_nm).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                      $('<td>').text((item.stock).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                      $('<td>').text((item.old_order_qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
                      $('<td>').text((item.old_order_qty - item.outitem_sum_qty).toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",")),
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
          nowDate();
          console.log('currentDate:'+currentDate);

          var currentDateValue = Number(currentDate.replace(/-/g, ''));
          var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
          var orderDtValue =  Number(orderDt.replace(/-/g, ''));

        //출고일자가 현재시간 및 주문일자보다 같거나 늦어야 수정 가능
        if (outitemDtValue >= currentDateValue && outitemDtValue>=orderDtValue) { 
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

      console.log(orderNo);

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

    if (detail_cust_emp_value === '') {
      // 담당자 입력란이 비어 있으면 경고 메시지를 표시하고 클릭 이벤트를 취소
      alert('거래처 담당자명을 입력해주세요.');
      return false; 
      } else { //담당자 입력란이 비어잇지 않으면

      //주문이 삭제되었는지 체크후 삭제되었다면 출고 수정이 안 되도록
      fetch('/ujmCheckOrderDeleteChk?order_no=' + orderNo)
        .then(response => response.json())
        .then(data => {
          console.log('주문 삭제 체크:'+data);
            if (data == 1) { //주문이 삭제됨 (order_delete_chk이 1)
              alert('해당 출고의 주문이 삭제되었으므로 출고를 수정할 수 없습니다.');
              return false; 
            } else { //주문 삭제가 되지 않았을 때

                    //주문이 취소되었는지 체크후 취소되었다면 출고 수정이 안 되도록
                    fetch('/ujmCheckOrderCancelChk?order_no=' + orderNo)
                    .then(response => response.json())
                    .then(data => {
                      console.log('주문 취소 체크: '+data);
                        if (data == 1) { //주문이 취소됨 (order_status_chk이 1)
                          alert('해당 출고의 주문이 취소되었으므로 출고를 수정할 수 없습니다.');
                          return false; 
                        } else { //주문 취소가 되지 않았을 때

                                  //반품이 되었는지 체크 후, 반품이 된 상태라면 출고 수정이 안 되도록
                                  fetch('/ujmReturnChk?outitem_no=' + outitemNo)
                                  .then(response => response.json())
                                  .then(data => {
                                    console.log('반품 체크:'+data);
                                      if (data >0) { //해당 주문번호로 반품이 되었음 (반품 삭제 아닌 반품만 체크)
                                        alert('해당 출고 상품이 이미 전달되어 반품된 상태이므로 출고를 수정할 수 없습니다.');
                                        return false; 
                                      } else { //반품이 되지 않았다면
                                 
                                         // 조합한 updateData를 서버로 전송
                                        $.ajax({
                                          url: 'updateOutitem',
                                          type: 'POST',
                                          contentType: 'application/json',
                                          data: JSON.stringify(updateData),
                                          success: function(response){
                                              alert('출고 수정 완료.');
                                              modalContentClear();
                                              window.location.href='outitem';
                                          },
                                          
                                      }); 
                                      }
                                  })
                                  .catch(error => {
                                      console.error('반품 체크 에러:', error);
                                      return false; 
                                  });

                        }
                    })
                    .catch(error => { 
                        console.error('주문 취소 체크 에러:', error);
                        return false; 
                    });
            }
        })
        .catch(error => {
            console.error('주문 삭제 체크 에러:', error);
            return false; 
        });

      }

  
  }) //수정완료 끝


  //삭제버튼 누를시
  $('#deleteOutitemSubmitBtn').click(function(e){ 
    e.preventDefault(); // 기본 이벤트 동작 방지

    var delChk=confirm('정말 삭제하시겠습니까?');

    if(delChk) {
      console.log('delChk"'+delChk);
      console.log('outitemNo'+outitemNo);
      console.log('orderNo'+orderNo);
      console.log('outitemDt'+outitemDt);

      // 현재 날짜 생성
      nowDate();
      console.log('currentDate:'+currentDate);

      var currentDateValue = Number(currentDate.replace(/-/g, ''));
      var outitemDtValue = Number(outitemDt.replace(/-/g, ''));
      console.log('수정 전 outitemDtValue:'+outitemDtValue);

      if(currentDateValue > outitemDtValue) { //이미 출고가 되었다면
        alert('이미 출고되었으므로 수정할 수 없습니다.');
        return false; 
      } else {
          //주문이 삭제되었는지 체크후 삭제되었다면 출고 삭제가 안 되도록
          fetch('/ujmCheckOrderDeleteChk?order_no=' +orderNo)
          .then(response => response.json())
          .then(data => {
            console.log('주문 삭제 체크:'+data);
              if (data == 1) { //주문이 삭제됨 (order_delete_chk이 1)
                alert('해당 출고의 주문이 삭제되었으므로 출고를 삭제할 수 없습니다.');
                return false; 
              } else { //주문 삭제가 되지 않았을 때

                      //주문이 취소되었는지 체크후 취소되었다면 출고 삭제가 안 되도록
                      fetch('/ujmCheckOrderCancelChk?order_no=' + orderNo)
                      .then(response => response.json())
                      .then(data => {
                        console.log('주문 취소 체크: '+data);
                          if (data == 1) { //주문이 취소됨 (order_status_chk이 1)
                            alert('해당 출고의 주문이 취소되었으므로 출고를 삭제할 수 없습니다.');
                            return false; 
                          } else { //주문 취소가 되지 않았을 때

                                    //반품이 되었는지 체크 후, 반품이 된 상태라면 출고 삭제가 안 되도록
                                    fetch('/ujmReturnChk?outitem_no=' + outitemNo)
                                    .then(response => response.json())
                                    .then(data => {
                                      console.log('반품 체크:'+data);
                                        if (data >0) { //해당 주문번호로 반품이 되었음 (반품 삭제 아닌 반품만 체크)
                                          alert('해당 출고 상품이 이미 전달되어 반품된 상태이므로 출고를 삭제할 수 없습니다.');
                                          return false; 
                                        } else { //반품이 되지 않았다면
      
                                          $.ajax({
                                            url: 'deleteOutitem',
                                            type: 'GET',
                                            data: { order_no: orderNo, outitem_no: outitemNo},
                                            success: function(response){
                                                alert('출고 삭제 완료.');
                                                modalContentClear();
                                                window.location.href='outitem';
                                            },
                                            
                                        }); 
                                        }
                                    })
                                    .catch(error => {
                                        console.error('반품 체크 에러:', error);
                                        return false; 
                                    });

                          }
                      })
                      .catch(error => { 
                          console.error('주문 취소 체크 에러:', error);
                          return false; 
                      });
              }
          })
          .catch(error => {
              console.error('주문 삭제 체크 에러:', error);
              return false; 
          });
        }



    }

  }) //삭제버튼 끝


}); //js 끝
