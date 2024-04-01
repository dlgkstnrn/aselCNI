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
    <script src="assets/js/psa/workProd.js"></script>
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
        <h1>생산 지시</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item"><a href="#">생산 관리</a></li>
            <li class="breadcrumb-item active">생산 지시</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section dashboard">

        <form action="workprod">
          <!-- 조회할 생산일자 -->
          <div class="position-relative d-flex align-items-center p-3">
            생산시작일자
            <!-- name 값이 컨트롤러에서 받는 param 된다. -->
            <input class="mx-2" type="date" id="currentDate" name="prodplan_dt"/>
            <button type="button" class="btn btn-success mx-2">
              <i class="bi bi-arrow-left"></i>
            </button>
            <button type="button" class="btn btn-success">
              <i class="bi bi-arrow-right"></i>
            </button>
          </div>
        </form>

        <div class="d-flex justify-content-between">
          
          <!-- 등록된 생산계획 리스트 -->
          <div class="card-body border border-black border-opacity-50">
            <h5 class="card-title p-3 mb-3 bg-primary-subtle">생산계획내역</h5>
            <table class="table table-hover p-2 text-center">

              <thead class="p-2">
                <tr>
                  <th scope="col">순서?</th>
                  <th scope="col">생산계획번호</th>
                  <th scope="col">제품명</th>
                  <th scope="col">생산수량</th>
                  <th scope="col">작업일수</th>
                </tr>
              </thead>

              <c:forEach var="planList" varStatus="planStat" items="${planList}">
                <tbody class="p-2">
                  <!-- 생산지시 등록 모달 띄우기 : tr 클릭 시 -->
                  <!-- Vertically centered Modal -->
                  <tr data-bs-toggle="modal" data-bs-target="#prodplan">
                    <th scope="row">${planStat.count}</th>
                    <td>${planList.prodplan_no}</td>
                    <td>${planList.item_nm}</td>
                    <td>${planList.qty}</td>
                    <td>${planList.work_dt}</td>
                  </tr>
                </tbody>
              </c:forEach>

            </table>
          </div>

          <!-- 등록된 생산지시 리스트 -->
          <div class="card-body border border-black border-opacity-50">
            <h5 class="card-title p-3 mb-3 bg-primary-subtle">생산지시내역</h5>
            <table class="table table-hover p-2 text-center">

              <thead class="p-2">
                <tr>
                  <th scope="col">순서?</th>
                  <th scope="col">생산지시번호</th>
                  <th scope="col">제품명</th>
                  <th scope="col">생산수량</th>
                  <th scope="col">작업일수</th>
                </tr>
              </thead>

              <c:forEach var="workList" varStatus="workStat" items="${workList}">
                <tbody class="p-2">
                  <!-- 생산지시내역 조회 모달 띄우기 : tr 클릭 시 -->
                  <!-- Vertically centered Modal -->
                  <tr data-bs-toggle="modal" data-bs-target="#workprod">
                    <th scope="row">${workStat.count}</th>
                    <td>${workList.workprod_no}</td>
                    <td>${workList.item_nm}</td>
                    <td>${workList.qty}</td>
                    <td>${workList.work_dt}</td>
                  </tr>
                </tbody>
              </c:forEach>

            </table>
          </div>

        </div>



        <!-- Modal -->

        <!-- 1. 생산지시 등록 모달 -->
        <!-- Vertically centered Modal -->
        <div class="modal fade" id="prodplan" tabindex="-1" aria-hidden="true" style="display: none">
          <div class="modal-dialog modal-lg">
            <div class="modal-content">

              <!-- 모달 제목 -->
              <div class="modal-header">
                <h5 class="modal-title">생산지시등록</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
              </div>

              <!-- 모달 내용 작성부분 -->
              <!-- Horizontal Form -->
              <form action="workprodInsert">
                <div class="modal-body">

                  <!-- 생산지시 담당자 ID -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">지시 담당자 ID</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" value="${prodplan_emp_id}" readonly/>
                    </div>
                  </div>

                  <!-- 생산계획번호 -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">생산계획번호</label>
                    <div class="col-sm-9">
                      <input type="text" class="form-control" value="${prodplan_no}" readonly/>
                    </div>
                  </div>

                  <!-- 생산일자 -->
                  <div class="row mb-3">
                    <label for="workprod_dt" class="col-sm-3 col-form-label">생산시작일자</label>
                    <div class="col-sm-9">
                      <input type="date" class="form-control" id="workprod_dt"/>
                    </div>
                  </div>

                  <!-- 제품 -->
                  <div class="row mb-3">
                    <label for="item_nm" class="col-sm-3 col-form-label">제품명</label>
                    <div class="d-flex justify-content-between col-sm-9">
                      <!-- 제품명 -->
                      <div class="col-sm-5">
                        <input type="text" class="form-control" value="item_nm" readonly/>
                      </div>
                      <!-- 제품 생산수량 -->
                      <div class="d-flex mb-3">
                        <label for="qty" class="col-sm-3 col-form-label">생산수량</label>
                        <div class="col-sm-3 mx-2">
                          <input type="number" class="form-control" id="qty" />
                        </div>
                      </div>
                    </div>
                  </div>

                  <!-- 공정 -->
                  <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">공정</label>
                    <div class="col-sm-9">
                      <select name="proc_nm" id="" class="form-select" aria-label="Default select example">
                        <option selected>적용할 공정을 선택하세요.</option>
                        <option value="1">반죽</option>
                        <option value="2">튀김</option>
                        <option value="3">분쇄</option>
                      </select>
                    </div>
                  </div>
                  
                  <!-- 투입품 -->
                  <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">투입품</label>

                    <div class="col-sm-9 mb-3">
                      <!-- 중첩모달 띄우는 버튼 -->
                      <!-- Vertically centered Modal -->
                      <button type="button" class="btn btn-outline-success mb-3" id="btn-submit"
                        data-bs-toggle="modal"
                        data-bs-target="#addItem">투입품 추가</button>

                      <!-- 선택된 투입품 리스트 -->
                      <div class="card-body">
                        <h5 class="card-title mb-2">선택한 투입품 목록</h5>
                      
                        <!-- List group with custom content -->
                        <ol class="list-group list-group-numbered">
                          <li class="list-group-item d-flex justify-content-between align-items-start">
                            <div class="ms-2 me-auto">
                              <div class="fw-bold">품목명</div>
                              품목CD
                            </div>
                            <!-- 투입수량 -->
                            <div class="d-flex">
                              <label for="qty" class="col-sm-3 col-form-label">투입수량</label>
                              <div class="col-sm-3 mx-2">
                                <input type="number" class="form-control" id="qty" />
                              </div>
                            </div>
                          </li>
                          <li class="list-group-item d-flex justify-content-between align-items-start">
                            <div class="ms-2 me-auto">
                              <div class="fw-bold">${item_nm}</div>
                              ${item_cd}
                            </div>
                            <span class="badge bg-primary rounded-pill">${in_qty}</span>
                          </li>
                          <li class="list-group-item d-flex justify-content-between align-items-start">
                            <div class="ms-2 me-auto">
                              <div class="fw-bold">포장지</div>
                              CD042516
                            </div>
                            <span class="badge bg-primary rounded-pill">55</span>
                          </li>
                        </ol><!-- End with custom content -->
                      
                      </div>
                    </div>
                  </div>
                  
                  <!-- 작업일수 -->
                  <div class="row mb-3">
                    <label for="work_dt" class="col-sm-3 col-form-label">작업일수</label>
                    <div class="col-sm-9">
                      <input type="number" class="form-control" id="work_dt"/>
                    </div>
                  </div>

                  <!-- 작업시 주의사항 -->
                  <div class="row mb-3">
                    <label for="work_cmd" class="col-sm-6 col-form-label">작업시 주의사항</label>
                    <div class="col-sm-12">
                      <textarea name="work_cmd" id="work_cmd" cols="30" rows="10" class="form-control" style="height: 100px"></textarea>
                    </div>
                  </div>

                  <!-- 비고 -->
                  <div class="row mb-3">
                    <label for="remark" class="col-sm-3 col-form-label">비고</label>
                    <div class="col-sm-12">
                      <textarea name="remark" id="remark" cols="30" rows="10" class="form-control" style="height: 100px"></textarea>
                    </div>
                  </div>
                </div>

                <!-- 모달 버튼 -->
                <div class="modal-footer">
                  <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                  <button type="submit" class="btn btn-success">등록</button>
                  <button type="reset" class="btn btn-outline-secondary">Reset</button>
                </div>

              </form>
              <!-- End Horizontal Form -->
            </div>
          </div>
        </div>
        <!-- 생산지시 등록 모달 끝 -->
        <!-- End Vertically centered Modal -->



        <!-- 2. 중첩모달 (투입품 선택) -->
        <!-- Vertically centered Modal -->
        <div class="modal fade"
          id="addItem"
          tabindex="-1"
          aria-hidden="true"
          style="display: none;">
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
                      <input type="text" name="st_department" list="big_no">
                    </div>

                    <div>
                      <p>중분류</p> 
                      <input type="text" name="st_department" list="mid_no">
                    </div>

                    <div>
                      <p>소분류</p> 
                      <input type="text" name="st_department" list="sml_no">
                    </div>
                  </div>

                  <!-- 대분류 리스트 -->
                  <datalist id="big_no" class="w-auto">
                    <!-- <option value="select">대분류</option> -->
                    <option value="포장재"></option>
                    <option value="식재료"></option>
                  </datalist>

                  <!-- 중분류 리스트 -->
                  <datalist id="mid_no" class="w-auto">
                    <option value="컵"></option>
                    <option value="봉지"></option>
                    <option value="면"></option>
                    <option value="스프"></option>
                  </datalist>
                  
                  <!-- 소분류 리스트 -->
                  <datalist id="sml_no" class="w-auto">
                    <option value="밀가루"></option>
                    <option value="물"></option>
                    <option value="기름"></option>
                    <option value="버섯"></option>
                    <option value="대파"></option>
                    <option value="마늘"></option>
                    <option value="고춧가루"></option>
                  </datalist>

                  <!-- 조회된 품목 리스트 -->
                  <div class="card-body mt-3">
                    <h5 class="card-title mb-2">품목 선택</h5>
      
                    <!-- List group With Checkboxes and radios -->
                    <ul class="list-group">
                      <li class="list-group-item">
                        <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
                        First checkbox
                      </li>
                      <li class="list-group-item">
                        <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
                        Second checkbox
                      </li>
                      <li class="list-group-item">
                        <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
                        Third checkbox
                      </li>
                      <li class="list-group-item">
                        <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
                        Fourth checkbox
                      </li>
                      <li class="list-group-item">
                        <input class="form-check-input me-1" type="checkbox" value="" aria-label="...">
                        Fifth checkbox
                      </li>
                    </ul><!-- End List Checkboxes and radios -->
      
                  </div>

                  <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                    <button type="submit" class="btn btn-success">등록</button>
                    <button type="reset" class="btn btn-outline-secondary">Reset</button>
                  </div>

                </form>
              </div>
            </div>
          </div>
        </div>
        <!-- 중첩모달 끝 -->
        <!-- End Vertically centered Modal -->
        


        <!-- 3. 생산지시내역 조회 모달 -->
        <!-- Vertically centered Modal -->
        <div
          class="modal fade"
          id="workprod"
          tabindex="-1"
          aria-hidden="true"
          style="display: none">
          
          <div class="modal-dialog modal-lg">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title">생산지시내역</h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>

              <div class="modal-body">

                <!-- 생산지시 담당자 ID -->
                <div class="row mb-3 d-flex">
                  <label class="col-sm-3 col-form-label">지시 담당자 ID</label>
                  <div class="col-sm-9">
                    <input type="text" class="form-control" value="${prodplan_emp_id}" disabled/>
                  </div>
                </div>

                <!-- 생산지시번호 -->
                <div class="row mb-3 d-flex">
                  <label class="col-sm-3 col-form-label">생산지시번호</label>
                  <div class="col-sm-9">
                    <input
                      type="text"
                      class="form-control"
                      value="${workprod_no}"
                      disabled/>
                  </div>
                </div>

                <!-- 생산시작일자 -->
                <div class="row mb-3">
                  <label for="workprod_dt" class="col-sm-3 col-form-label">생산시작일자</label>
                  <div class="col-sm-5">
                    <input type="date" class="form-control" id="workprod_dt" disabled/>
                  </div>
                </div>

                <!-- 제품 -->
                <div class="row mb-3">
                  <!-- 제품명 -->
                  <label for="item_nm" class="col-sm-3 col-form-label">제품명</label>
                  <div class="d-flex justify-content-between col-sm-9">
                    <div class="col-sm-5">
                      <input type="text" class="form-control" value="item_nm" disabled/>
                    </div>
                    <!-- 제품 생산수량 -->
                    <div class="d-flex mb-3">
                      <label for="qty" class="col-sm-3 col-form-label">생산수량</label>
                      <div class="col-sm-4 mx-2">
                        <input type="number" class="form-control" id="qty" disabled/>
                      </div>
                    </div>
                  </div>
                </div>

                <!-- 공정 -->
                <div class="card-body mb-3">
                  <h5 class="card-title">등록된 공정 목록</h5>
                  <!-- Default Table -->
                  <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">공정코드</th>
                        <th scope="col">공정명</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row">1</th>
                        <td>CD01</td>
                        <td>튀김</td>
                      </tr>
                      <tr>
                        <th scope="row">2</th>
                        <td>CD02</td>
                        <td>포장</td>
                      </tr>
                      <tr>
                        <th scope="row">3</th>
                        <td>CD03</td>
                        <td>건조</td>
                      </tr>
                    </tbody>
                  </table>
                  <!-- End Default Table Example -->
                </div>
                
                <!-- 투입품 -->
                <div class="card-body mb-3">
                  <h5 class="card-title">투입품 목록</h5>
                  <!-- Default Table -->
                  <table class="table">
                    <thead>
                      <tr>
                        <th scope="col">#</th>
                        <th scope="col">품목코드</th>
                        <th scope="col">품목명</th>
                      </tr>
                    </thead>
                    <tbody>
                      <tr>
                        <th scope="row">1</th>
                        <td>CD01</td>
                        <td>버섯</td>
                      </tr>
                      <tr>
                        <th scope="row">2</th>
                        <td>CD02</td>
                        <td>소고기</td>
                      </tr>
                      <tr>
                        <th scope="row">3</th>
                        <td>CD03</td>
                        <td>간장</td>
                      </tr>
                    </tbody>
                  </table>
                  <!-- End Default Table Example -->
                </div>
                
                <!-- 작업일수 -->
                <div class="row mb-3">
                  <label for="work_dt" class="col-sm-3 col-form-label">작업일수</label>
                  <div class="col-sm-9">
                    <input type="number" class="form-control" id="work_dt" disabled/>
                  </div>
                </div>

                <!-- 작업시 주의사항 -->
                <div class="row mb-3">
                  <label for="work_cmd" class="col-sm-6 col-form-label">작업시 주의사항</label>
                  <div class="col-sm-12">
                    <textarea name="work_cmd" id="work_cmd" cols="30" rows="10" class="form-control" style="height: 100px" disabled></textarea>
                  </div>
                </div>

                <!-- 비고 -->
                <div class="row mb-3">
                  <label for="remark" class="col-sm-3 col-form-label">비고</label>
                  <div class="col-sm-12">
                    <textarea name="remark" id="remark" cols="30" rows="10" class="form-control" style="height: 100px" disabled></textarea>
                  </div>
                </div>
              </div>

              <div class="modal-footer">
                <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
              </div>
            </div>
          </div>
        </div>
        <!-- 생산지시내역 조회 모달 끝 -->
        <!-- End Vertically centered Modal -->


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
