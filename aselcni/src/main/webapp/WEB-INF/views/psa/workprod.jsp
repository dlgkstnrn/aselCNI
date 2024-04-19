<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
  <head>
    <meta charset="utf-8" />
    <meta content="width=device-width, initial-scale=1.0" name="viewport" />

    <title>스마트 제조 시스템</title>

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon" />

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet"/>

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>
    <!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link href="assets/css/psa/psaWorkprod.css" rel="stylesheet" type="text/css">
    <link href="assets/css/style.css" rel="stylesheet"  type="text/css">

    <!-- Script -->
    <script src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/main.js"></script>
    <script defer src="assets/js/psa/workProd.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
  </head>

  <body>
    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>

    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>생산 관리</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">생산 관리</a></li>
            <li class="breadcrumb-item active">생산 지시</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section dashboard">

        <div class="card">
          <div class="card-body">

            <div class="d-flex align-items-center justify-content-between">
              <span class="h-5 d-flex align-items-center card-header-title">생산 지시</span>
              <button type="button" class="btn btn-primary">지시 등록할 생산 계획을 클릭하세요.</button>
            </div>

            <!-- 제목 아래 밑줄 -->
            <hr>

            <!-- 조회할 생산일자 -->
            <div class="position-relative d-flex align-items-center p-3">
              생산시작일자
              <!-- name 값이 컨트롤러에서 받는 param 된다. -->
              <input class="mx-2" type="date" onchange="setWorkprod_dt()" id="currentDate" name="prodplan_dt" min="2000-01-01"/>
              <!-- <button type="submit">조회</button> -->
              <!-- yesterday -->
              <!-- <button onclick="addDays(-1)" type="button" class="btn btn-primary mx-2">
                <i class="bi bi-arrow-left"></i>
              </button> -->
              <!-- tomorrow -->
              <!-- <button onclick="addDays(1)" type="button" class="btn btn-primary">
                <i class="bi bi-arrow-right"></i>
              </button> -->
            </div>

            <!-- <div class="ms-3 color-red">지시 등록할 생산 계획을 클릭하세요.</div> -->

            <div class="d-flex justify-content-between">

              <!-- 등록된 생산계획 리스트 -->
              <div class="card-body border-black border-opacity-50">
                <h5 class="card-title p-3 mb-3 bg-primary-subtle">지시 대기중인 생산계획</h5>
                <table class="table table-hover p-2 text-center" id="prodplanTB">

                  <thead class="p-2">
                    <tr>
                      <th scope="col">생산계획번호</th>
                      <th scope="col">순번</th>
                      <th scope="col">제품명</th>
                      <th scope="col">계획수량</th>
                      <th scope="col">지시총량</th>
                      <th scope="col">계획작업일수</th>
                    </tr>
                  </thead>

                  <tbody class="p-2">
                    <c:forEach var="planList" varStatus="planStat" items="${planList}">

                      <!-- 생산지시 등록 모달 띄우기 : tr 클릭 시 -->
                      <tr data-bs-toggle="modal" data-bs-target="#prodplan" data-index="${planList.prodplan_no}" style="cursor:pointer;">
                        <th scope="row">${planList.prodplan_no}</th>
                        <td>${planList.seq_no}</td>
                        <td>${planList.item_nm}</td>
                        <td><fmt:formatNumber value="${planList.qty}" pattern="#,###"/></td>
                        <td><fmt:formatNumber value="${planList.work_total_qty}" pattern="#,###"/></td>
                        <td>${planList.work_dt}</td>
                      </tr>

                    </c:forEach>
                  </tbody>

                </table>
              </div>

              <!-- 등록된 생산지시 리스트 -->
              <div class="card-body border-black border-opacity-50">
                <h5 class="card-title p-3 mb-3 bg-primary-subtle">등록된 생산지시 내역</h5>
                <table class="table table-hover p-2 text-center" id="workprodTB">

                  <thead class="p-2">
                    <tr>
                      <th scope="col">생산지시번호</th>
                      <th scope="col">순번</th>
                      <th scope="col">제품명</th>
                      <th scope="col">생산수량</th>
                      <th scope="col">작업일수</th>
                    </tr>
                  </thead>

                  <tbody class="p-2">
                    <c:forEach var="workList" varStatus="workStat" items="${workList}">

                      <!-- 생산지시내역 조회 모달 띄우기 : tr 클릭 시 -->
                      <tr data-bs-toggle="modal" data-bs-target="#workprod" data-index="${workList.workprod_no}" style="cursor:pointer;">
                      <!-- <tr onclick="showWprModal()" data-bs-toggle="modal" data-bs-target="#workprod" data-index="${workList.workprod_no}" > -->
                        <th scope="row">${workList.workprod_no}</th>
                        <td>${workList.seq_no}</td>
                        <td>${workList.item_nm}</td>
                        <td><fmt:formatNumber value="${workList.qty}" pattern="#,###"/></td>
                        <td>${workList.work_dt}</td>
                      </tr>
                    </c:forEach>
                  </tbody>

                </table>
              </div>

            </div>

          </div>
          <!-- End card-body  -->
        </div>
        <!-- End card  -->





        <!-- Modal 3개 -->

        <!-- 1. 생산지시 등록 모달 -->
        <div class="modal fade" id="prodplan" tabindex="-1" aria-hidden="true" style="display: none">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <!-- 모달 제목 -->
              <div class="modal-header">
                <h5 class="modal-title">생산지시등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <!-- 모달 내용 작성부분 -->
              <!-- Form -->
              <form action="workprodInsert" method="post">
                <div class="modal-body">

                  <!-- 생산지시 담당자 ID -->
                  <input type="hidden" name="workprod_emp_id" id="workprod_emp_id">

                  <!-- 생산지시번호 -->
                  <input type="hidden" name="workprod_no">

                  <!-- 생산계획 담당자 ID -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">생산계획 담당자</label>
                    <div class="col-sm-9">
                      <input type="hidden" class="form-control" id="prodplan_emp_id" value="${prodplan_emp_id}" readonly/>
                      <input type="text" class="form-control" id="prp_user_nm" readonly/>
                    </div>
                  </div>

                  <!-- 생산계획번호 -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">생산계획번호</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="prodplan_no" name="prodplan_no" readonly/>
                    </div>
                  </div>

                  <!-- 생산일자 -->
                  <div class="row mb-3">
                    <label for="workprod_dt" class="col-sm-3 col-form-label">
                      생산시작일자
                      <span class="color-red">*</span>
                    </label>
                    <div class="col-sm-9">
                      <input type="date" class="form-control" id="prp_prodplan_dt" name="workprod_dt" required/>
                    </div>
                  </div>

                  <!-- 제품 -->
                  <div class="row mb-3">
                    <!-- 제품코드 -->
                    <input type="hidden" id="prp_item_cd" name="item_cd">
                    <label for="item_nm" class="col-sm-3 col-form-label">제품명</label>
                    <div class="d-flex justify-content-between col-sm-9">
                      <!-- 제품명 -->
                      <div class="col-sm-5">
                        <input type="text" class="form-control" id="prp_item_nm" name="item_nm" readonly/>
                      </div>
                      <!-- 제품 생산수량 -->
                      <div class="d-flex mb-3">
                        <label for="qty" class="col-sm-4 col-form-label">
                          생산수량
                          <span class="color-red">*</span>
                        </label>
                        <div class="col-sm-7 mx-2">
                          <input type="number" class="form-control" id="prp_qty" name="qty" required/>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- 공정 -->
                  <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">
                      공정
                      <span class="color-red">*</span>
                    </label>
                    <div class="col-sm-9">

                      <!-- select box -->
                      <!-- select tag form = 셀렉트박스가 포함될 form tag id -->
                      <!-- <select id="selectProc" name="proc_nm" form="prodplan" class="form-select" aria-label="Default select example">
                        <option selected>적용할 공정을 선택하세요.</option>
                        <c:forEach var="procList" items="${procList }">
                          <option value="${procList.proc_cd}">${procList.proc_nm}</option>
                        </c:forEach>
                      </select> -->

                      <!-- check box -->
                      <c:forEach var="procList" items="${procList }">
                        <!-- name = key, value = value -->
                        <input type="checkbox" name="procList" id="" value="${procList.proc_cd}">${procList.proc_nm}
                      </c:forEach>
                    </div>
                  </div>
                  
                  <!-- 투입품 -->
                  <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">
                      투입품
                      <span class="color-red">*</span>
                    </label>

                    <!-- 투입품 선택 모달 띄우는 버튼 -->
                    <div class="col-sm-9 mb-3">
                      <button type="button" class="btn btn-outline-primary mb-3" 
                        id="btn-submit"
                        data-bs-toggle="modal"
                        data-bs-target="#addItem">투입품 추가</button>
                    </div>

                    <!-- 선택된 투입품 리스트 테이블 -->
                    <div class="card-body mx-3 mb-3">
                      <table class="table">
                        <thead>
                          <tr>
                            <th scope="col">#</th>
                            <th scope="col">품목코드</th>
                            <th scope="col">품목명</th>
                            <th scope="col">투입수량</th>
                          </tr>
                        </thead>
                        <tbody id="prp_item_tbody">
                          <tr id="prp_item_tr">
                          </tr>
                        </tbody>
                      </table>
                    </div>
                      
                  </div>
                  
                  <!-- 작업일수 -->
                  <div class="row mb-3">
                    <label for="work_dt" class="col-sm-3 col-form-label">
                      작업일수
                      <span class="color-red">*</span>
                    </label>
                    <div class="col-sm-9">
                      <input type="number" id="prp_work_dt" name="work_dt" class="form-control" required/>
                    </div>
                  </div>

                  <!-- 작업시 주의사항 -->
                  <div class="row mb-3">
                    <label for="work_cmd" class="col-sm-6 col-form-label">작업시 주의사항</label>
                    <div class="col-sm-12">
                      <textarea id="prp_work_cmd" name="work_cmd" cols="30" rows="10" class="form-control" style="height: 100px"></textarea>
                    </div>
                  </div>

                  <!-- 비고 -->
                  <div class="row mb-3">
                    <label for="remark" class="col-sm-3 col-form-label">비고</label>
                    <div class="col-sm-12">
                      <textarea id="prp_remark" name="remark" cols="30" rows="10" class="form-control" style="height: 100px"></textarea>
                    </div>
                  </div>
                </div>

                <div class="color-red text-lg-center mb-3">
                  등록 버튼 클릭 후 수정할 수 없습니다.
                </div>

                <!-- 모달 버튼 -->
                <div class="modal-footer">
                  <button id="cancle" type="reset" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
                  <button type="submit" id="insertDataBtn" class="btn btn-primary">지시 등록</button>
                  <!-- <button type="reset" class="btn btn-outline-primary">Reset</button> -->
                </div>

              </form>
              <!-- End Form -->

            </div>
          </div>
        </div>
        <!-- 생산지시 등록 모달 끝 -->



        <!-- 2. 투입품 선택 모달 -->
        <div class="modal fade" id="addItem" tabindex="-1" aria-hidden="true" style="display: none;">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">투입품 추가</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <div class="modal-body">
                <form action="addItems" method="get">

                  <div class="d-flex justify-content-around w-auto text-center align-items-center">
                    <div>
                      <p>대분류</p> 
                      <select name="big_no" id="big_no" class="form-select" aria-label="Default select example">
                        <option selected>대분류 선택</option>
                        <c:forEach var="big" items="${bigList}">
                          <option value="${big.big_no}">${big.big_content}</option>
                        </c:forEach>
                      </select>
                    </div>

                    <div>
                      <p>중분류</p> 
                      <select name="mid_no" id="mid_no" class="form-select" aria-label="Default select example">
                        <option selected>중분류 선택</option>
                      </select>
                    </div>

                    <div>
                      <p>소분류</p> 
                      <select name="sml_no" id="sml_no" class="form-select" aria-label="Default select example">
                        <option selected>소분류 선택</option>
                      </select>
                    </div>
                  </div>

                  <!-- 조회된 품목 리스트 -->
                  <div class="card-body mt-3">
                    <h5 class="card-title mb-2">품목 선택</h5>
                    <table class="table">
                      <thead>
                        <tr>
                          <th scope="col"></th>
                          <th scope="col">품목코드</th>
                          <th scope="col">품목명</th>
                          <!-- <th scope="col">투입수량</th> -->
                        </tr>
                      </thead>
                      <tbody id="addItem_tbody">
                        <tr id="addItem_tr">
                        </tr>
                      </tbody>
                    </table>
                  </div>

                  <div class="modal-footer">
                    <button type="button" class="btn btn-primary" data-bs-dismiss="modal">닫기</button>
                    <button type="button" class="btn btn-primary" id="addItemSave">등록</button>
                    <button type="reset" class="btn btn-outline-primary">Reset</button>
                  </div>

                </form>
              </div>
            </div>
          </div>
        </div>
        <!-- 투입품 선택 모달 끝 -->
        


        <!-- 3. 생산지시내역 조회 모달 -->
        <div class="modal fade" id="workprod" tabindex="-1" aria-hidden="true" style="display: none">
          
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <!-- 3. 생산지시내역 조회 모달 내용 -->
              <div class="modal-header">
                  <h5 class="modal-title">생산지시내역</h5>
                  <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <div class="modal-body">

                  <!-- 생산지시 담당자 -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">지시 담당자명</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="user_nm" disabled/>
                    </div>
                  </div>

                  <!-- 생산지시번호 -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">생산지시번호</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="workprod_no" disabled/>
                    </div>
                  </div>

                  <!-- 생산시작일자 -->
                  <div class="row mb-3">
                    <label for="workprod_dt" class="col-sm-3 col-form-label">생산시작일자</label>
                    <div class="col-sm-5">
                      <input type="text" class="form-control" id="workprod_dt" disabled/>
                    </div>
                  </div>

                  <!-- 제품 -->
                  <div class="row mb-3">
                    <!-- 제품명 -->
                    <label for="item_nm" class="col-sm-3 col-form-label">제품명</label>
                    <div class="d-flex justify-content-between col-sm-9">
                      <div class="col-sm-5">
                        <input type="text" class="form-control" id="item_nm" disabled/>
                      </div>
                      <!-- 제품 생산수량 -->
                      <div class="d-flex mb-3">
                        <label for="qty" class="col-sm-3 col-form-label">생산수량</label>
                        <div class="col-sm-4 mx-2">
                          <input type="text" class="form-control" id="qty" disabled/>
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- 공정 -->
                  <div class="card-body mb-3">
                    <h5 class="card-title">공정</h5>
                    <table class="table">
                      <thead>
                        <tr>
                          <th scope="col">#</th>
                          <th scope="col">공정코드</th>
                          <th scope="col">공정명</th>
                        </tr>
                      </thead>
                      <tbody id="proc_tbody">
                        <tr id="proc_tr">
                        </tr>
                      </tbody>
                    </table>
                  </div>
                
                  <!-- 투입품 -->
                  <div class="card-body mb-3">
                    <h5 class="card-title">투입품</h5>
                    <table class="table">
                      <thead>
                        <tr>
                          <th scope="col">#</th>
                          <th scope="col">품목코드</th>
                          <th scope="col">품목명</th>
                          <th scope="col">투입수량</th>
                        </tr>
                      </thead>
                      <tbody id="in_item_tbody">
                        <tr id="in_item_tr">
                        </tr>
                      </tbody>
                    </table>
                  </div>
                
                  <!-- 작업일수 -->
                  <div class="row mb-3">
                    <label for="work_dt" class="col-sm-3 col-form-label">작업일수</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" id="work_dt" disabled/>
                    </div>
                  </div>

                  <!-- 작업시 주의사항 -->
                  <div class="row mb-3">
                    <label for="work_cmd" class="col-sm-6 col-form-label">작업시 주의사항</label>
                    <div class="col-sm-12">
                      <textarea id="work_cmd" cols="30" rows="10" class="form-control" style="height: 100px" disabled>
                      </textarea>
                    </div>
                  </div>

                  <!-- 비고 -->
                  <div class="row mb-3">
                    <label for="remark" class="col-sm-3 col-form-label">비고</label>
                    <div class="col-sm-12">
                      <textarea id="remark" cols="30" rows="10" class="form-control" style="height: 100px">
                      </textarea>
                    </div>
                  </div>
              </div>
              <!-- End modal-body -->

              <div class="modal-footer">
                <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">취소</button>
                <button type="button" id="updateWorkBtn" class="btn btn-primary" data-bs-dismiss="modal">수정</button>
                <!-- <button type="button" id="deleteWorkBtn" class="btn btn-outline-primary" data-bs-dismiss="modal">삭제</button> -->
              </div>
              <!-- End modal-footer -->

            </div>
          </div>
        </div>
        <!-- 생산지시내역 조회 모달 끝 -->


      </section>
    </main>
    <!-- End #main -->

    
    <!-- ======= Footer ======= -->
    <%@ include file="../footer.jsp" %>
    <!-- End Footer -->

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i class="bi bi-arrow-up-short"></i></a>

    <!-- Vendor JS Files -->
    <!-- <script src="assets/vendor/apexcharts/apexcharts.min.js"></script> -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!-- <script src="assets/vendor/chart.js/chart.umd.js"></script> -->
    <!-- <script src="assets/vendor/echarts/echarts.min.js"></script> -->
    <!-- <script src="assets/vendor/quill/quill.min.js"></script> -->
    <!-- <script src="assets/vendor/simple-datatables/simple-datatables.js"></script> -->
    <!-- <script src="assets/vendor/tinymce/tinymce.min.js"></script> -->
    <!-- <script src="assets/vendor/php-email-form/validate.js"></script> -->
  </body>
</html>
