
$(document).ready(function () {
  //닫기 버튼 클릭시 modal 입력 내용 클리어
  $(document).ready(function () {

    $('button[data-bs-dismiss="modal"]').on(
      "click", //닫기버튼 누르면
      function () {
        modalContentClear(); //아래
      }
    );
  });
  //닫기 버튼 클릭시 modal 입력 내용 클리어
  function modalContentClear() {
    $("#order_no_modal").text("주문 번호 선택");
    $(".modal-content input").val("");
    $(".modal-content textarea").val("");
  }

  //날짜
  //시작 날짜와 종료 날짜 논리 일관성
  $(document).ready(function () {
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
  });

  // 좌우 버튼 누를 때마다 날짜 7일 단위로 바뀜
  $(document).ready(function () {
    $("#dateRightBtn").click(function () {
      dateShift("right");
    });

    $("#dateLeftBtn").click(function () {
      dateShift("left");
    });
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
  $(document).ready(function () {

    $("#order_no_modal").dropdown();
    /* 주문번호 부분이 드롭다운으로 내려오게 */

/*     $("#outitem_insert").dropdown();
     등록모달 */ 

 /*      $(".dropdown-menu a").on("click", function () {
        var selectedValue = $(this).attr("data-value");
        $("#outitem_insert").text(selectedValue);
      }); */


}); 

    //조회 테이블 행 클릭시 modal 수정창으로 이동
    $('tr[data-bs-toggle="modal"]').on("click", function () {
      let orderNo = $(this).find("td:nth-child(2)").text();
      $("#order_no_modal").val(orderNo);
    });
  });


