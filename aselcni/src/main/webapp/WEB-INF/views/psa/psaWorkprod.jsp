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
    <link
      href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"
    />

    <!-- Vendor CSS Files -->
    <link
      href="assets/vendor/bootstrap/css/bootstrap.min.css"
      rel="stylesheet"
    />
    <link
      href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
      rel="stylesheet"
    />
    <!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link
      href="assets/css/psa/psaWorkprod.css"
      rel="stylesheet"
      type="text/css"
    />

    <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script
      src="https://kit.fontawesome.com/0b22ed6a9d.js"
      crossorigin="anonymous"
    ></script>
    <script src="assets/js/jquery-3.7.1.min.js"></script>
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
        <div
          class="border-bottom d-flex align-items-center justify-content-between p-3"
        >
          <h5>생산지시</h5>
          <div>
            <!-- Vertically centerd Modal -->
            <button
              type="button"
              class="btn btn-outline-success"
              data-bs-toggle="modal"
              data-bs-target="#verticalycentered"
            >
              신규
            </button>
            <div
              class="modal fade"
              id="verticalycentered"
              tabindex="-1"
              aria-hidden="true"
              style="display: none"
            >
              <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content">
                  <div class="modal-header">
                    <h5 class="modal-title">생산지시</h5>
                    <button
                      type="button"
                      class="btn-close"
                      data-bs-dismiss="modal"
                      aria-label="Close"
                    ></button>
                  </div>

                  <!-- Horizontal Form -->
                  <form action="">
                    <div class="modal-body">
                      <!-- 여기에 모달 내용 -->

                      <!-- 생산계획번호 -->
                      <div class="row mb-3">
                        <label class="col-sm-2 col-form-label"
                          >생산계획번호</label
                        >
                        <div class="col-sm-10">
                          <input
                            type="text"
                            class="form-control"
                            value="${prodplan_no}"
                            disabled
                          />
                        </div>
                      </div>

                      <!-- 생산일자 -->
                      <div class="row mb-3">
                        <label for="workprod_dt" class="col-sm-2 col-form-label"
                          >생산시작일자</label
                        >
                        <div class="col-sm-10">
                          <input
                            type="date"
                            class="form-control"
                            id="workprod_dt"
                          />
                        </div>
                      </div>

                      <!-- 제품명 -->
                      <div class="row mb-3">
                        <label for="item_nm" class="col-sm-2 col-form-label"
                          >제품명</label
                        >
                        <div class="col-sm-10">
                          <input
                            type="text"
                            class="form-control"
                            value="item_nm"
							disabled
                          />
                        </div>
                      </div>

                      <!-- 공정 -->
                      <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">공정</label>
                        <div class="col-sm-10">
                          <select
                            name=""
                            id=""
                            class="form-select"
                            aria-label="Default select example"
                          >
                            <option selected>적용할 공정을 선택하세요.</option>
                            <option value="1">반죽</option>
                            <option value="2">튀김</option>
                            <option value="3">분쇄</option>
                          </select>
                        </div>
                      </div>

                      <!-- 생산수량 -->
                      <div class="row mb-3">
                        <label for="qty" class="col-sm-2 col-form-label"
                          >생산수량</label
                        >
                        <div class="col-sm-10">
                          <input type="number" class="form-control" id="qty" />
                        </div>
                      </div>

                      <!-- 투입품 -->
                      <div class="row mb-3">
                        <label class="col-sm-2 col-form-label">투입품</label>
                        <div class="col-sm-10">
                          <select
                            name=""
                            id=""
                            class="form-select"
                            multiple
                            aria-label="multiple select example"
                          >
                            <option selected>투입품을 선택하세요.</option>
                            <option value="1">밀가루</option>
                            <option value="2">물</option>
                            <option value="3">건더기</option>
                          </select>
                        </div>
                      </div>

                      <!-- 투입수량 -->
                      <div class="row mb-3">
                        <label for="in_qty" class="col-sm-2 col-form-label"
                          >투입수량</label
                        >
                        <div class="col-sm-10">
                          <input
                            type="number"
                            class="form-control"
                            id="in_qty"
                          />
                        </div>
                      </div>

                      <!-- 작업일수 -->
                      <div class="row mb-3">
                        <label for="work_dt" class="col-sm-2 col-form-label"
                          >작업일수</label
                        >
                        <div class="col-sm-10">
                          <input
                            type="number"
                            class="form-control"
                            id="work_dt"
                          />
                        </div>
                      </div>

                      <!-- 작업시 주의사항 -->
                      <div class="row mb-3">
                        <label for="work_cmd" class="col-sm-2 col-form-label"
                          >작업시 주의사항</label
                        >
                        <div class="col-sm-10">
                          <textarea
                            name=""
                            id="work_cmd"
                            cols="30"
                            rows="10"
                            class="form-control"
                            style="height: 100px"
                          ></textarea>
                        </div>
                      </div>

                      <!-- 비고 -->
                      <div class="row mb-3">
                        <label for="remark" class="col-sm-2 col-form-label"
                          >비고</label
                        >
                        <div class="col-sm-10">
                          <textarea
                            name=""
                            id="remark"
                            cols="30"
                            rows="10"
                            class="form-control"
                            style="height: 100px"
                          ></textarea>
                        </div>
                      </div>
                    </div>

                    <div class="modal-footer">
                      <button
                        type="button"
                        class="btn btn-outline-secondary"
                        data-bs-dismiss="modal"
                      >
                        닫기
                      </button>
                      <button type="submit" class="btn btn-success">
                        저장
                      </button>
                      <button type="reset" class="btn btn-outline-secondary">
                        취소
                      </button>
                    </div>
                  </form>
                </div>
              </div>
            </div>
            <!-- End Vertically centered Modal -->

            <button type="button" class="btn btn-outline-success">수정</button>
            <button type="button" class="btn btn-outline-success">삭제</button>
          </div>
        </div>

        <div class="position-relative d-flex align-items-center p-3">
          생산일자
          <input
            class="mx-2"
            type="text"
            name="workprod_dt"
            readonly="readonly"
          />
          <button type="button" class="btn btn-success mx-2">
            <i class="bi bi-arrow-left"></i>
          </button>
          <button type="button" class="btn btn-success">
            <i class="bi bi-arrow-right"></i>
          </button>
        </div>

        <div class="card-body border border-black border-opacity-50">
          <h5 class="card-title p-3 mb-3 bg-primary-subtle">생산계획</h5>
          <table class="table table-hover p-2 text-center">
            <thead class="p-2">
              <tr>
                <th scope="col">순서?</th>
                <th scope="col">생산계획번호</th>
                <th scope="col">제품명</th>
                <th scope="col">생산수량</th>
                <th scope="col">작업일수</th>
                <th scope="col">지시여부</th>
              </tr>
            </thead>
            <tbody class="p-2">
              <tr>
                <th scope="row">순서??</th>
                <td>${prodplan_no}</td>
                <td>${item.item_nm}</td>
                <td>${qty}</td>
                <td>${work_dt}</td>
                <td>${workprod_delete-chk}</td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <%@ include file="../footer.jsp" %>
    <!-- End Footer -->

    <a
      href="#"
      class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i
    ></a>

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
