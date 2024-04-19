<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8" %> <%@ taglib uri="http://java.sun.com/jsp/jstl/core"
prefix="c" %>

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
    <!--     <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" type="text/css" />

    <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script
      src="https://kit.fontawesome.com/0b22ed6a9d.js"
      crossorigin="anonymous"
    ></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

    <script defer src="assets/js/csg/modalCategory.js"></script>
    <!-- 모달 대중소분류 -->
  </head>

  <body>
    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>

    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>구매 관리</h1>
            <nav>
                <ol class="breadcrumb">
	                <li class="breadcrumb-item">구매 관리</li>
                    <li class="breadcrumb-item"><a href="/purchase">발주 관리</a></li>
                    <li class="breadcrumb-item active">발주 등록</li>
                </ol>
            </nav>
      </div>
      <!-- End Page Title -->

      <section class="section dashboard w-full">
        <form id="purchaseItem2" action="purchaseSave" method="post">
          <!-- 자재 정보 입력 폼 -->
          <!--<div id="SK_itemForm" class="flex items-center justify-center min-h-screen bg-red-800"> 외부배경 회색-->
          <div id="SK_itemForm" class="min-h-screen w-full">
            <!-- 외부배경 회색 -->

            <div id="content" class="bg-white p-4 shadow-lg">
              <!-- 발주 등록 섹션 -->
              <div id="orderRegistration" class="container p-4">
                <span
                  class="h5 d-flex align-items-center card-header-title me-auto"
                  >발주 등록
                </span>
                <hr />
              </div>
              <!-- 입력 필드 그룹 -->
              <div class="container p-4">
                <div class="mb-3">
                  <label
                    for="supplier"
                    class="form-label text-lg text-gray-700 font-bold mb-2"
                    >매입처</label
                  >
                  <div class="input-group border border-green-500">
                    <span class="input-group-text bg-light" id="basic-addon1"
                      ><i class="bi bi-person-fill"></i
                    ></span>
                    <select
                      id="supplier"
                      class="form-select"
                      aria-label="Supplier"
                      aria-describedby="basic-addon1"
                    >
                      <option selected value="">매입처 선택</option>
                      <c:forEach var="cust" items="${custList}">
                        <option value="${cust.cust_cd}">${cust.cust_nm}</option>
                      </c:forEach>
                    </select>
                  </div>
                </div>

                <div class="mb-3">
                  <label
                    for="com_manager-name"
                    class="form-label text-lg text-gray-700 font-bold mb-2"
                    >발주 담당자</label
                  >
                  <div class="input-group border border-green-500">
                    <input
                      id="com_manager-name"
                      type="text"
                      class="form-control"
                      placeholder="발주 담당자 입력"
                      value="${sessionScope.user_id}"
                      hidden
                    />
                    <input
                      id="com_manager-name-display"
                      type="text"
                      class="form-control"
                      placeholder="발주 담당자 입력"
                      value="${sessionScope.user_nm}"
                      readonly
                    />
                  </div>
                </div>

                <div class="mb-3">
                  <label
                    for="op_manager-name"
                    class="form-label text-lg text-gray-700 font-bold mb-2"
                  >
                    거래처 발주 담당자
                    <span class="text-danger">*</span>
                  </label>
                  <div class="input-group border border-green-500">
                    <input
                      id="op_manager-name"
                      type="text"
                      class="form-control"
                      placeholder="거래처 발주 담당자 입력"
                    />
                  </div>
                </div>

                <div class="mb-3">
                  <label
                    for="remark"
                    class="form-label text-lg text-gray-700 font-bold mb-2"
                    >비고</label
                  >
                  <div class="input-group border border-green-500">
                    <input
                      id="remark"
                      type="text"
                      class="form-control"
                      placeholder="필요한 내용을 입력"
                    />
                  </div>
                </div>
              </div>

              <div id="materialsTableSection" class="container w-7/8 p-4">
                <span
                  class="h5 d-flex align-items-center card-header-title me-auto"
                  >자재 목록
                </span>
                <hr />
                  <div class="d-flex justify-content-end">
                    <button
                      id="jajeSelect"
                      type="button"
                      class="btn btn-success"
                      data-bs-toggle="modal"
                      data-bs-target="#jajeinputModal"
                    >
                      자재선택
                    </button>
                    <div style="width: 10px"></div>
                    <!-- 간격 조정 -->
                    <button
                      id="jajeSelectinitialize"
                      type="button"
                      class="btn btn-danger"
                    >
                      초기화
                    </button>
                  </div>
                </h2>

                <table class="table table-striped table-bordered">
                  <thead class="bg-gray-50">
                    <tr>
                      <th scope="col">번호</th>
                      <th scope="col">품목 코드</th>
                      <th scope="col">자재명</th>
                      <th scope="col">규격</th>
                      <th scope="col">단위</th>
                      <th scope="col">수량</th>
                      <th scope="col">단가</th>
                      <th scope="col">공급가액</th>
                    </tr>
                  </thead>
                  <tbody id="jajeInputBody"></tbody>
                </table>
                <div id="totalAmount" style="margin-top: 20px">
                  총합계: <span id="totalPrice">0</span> 원
                </div>
              </div>

              <!-- 버튼 그룹 -->
              <div class="d-flex justify-content-center mt-4">
                <button
                  type="button"
                  class="btn btn-primary mr-3"
                  onclick="sendOrderDetails()"
                >
                  저장
                </button>
                <div style="width: 10px"></div>
                <!-- 간격 조정 -->
                <button
                  type="button"
                  class="btn btn-secondary ml-3"
                  onclick="submitFormWithCancel()"
                >
                  취소
                </button>
              </div>
            </div>
          </div>
        </form>

        <!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

        <!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
        <!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->

        <!-- 모달 애들 -->
        <div
          class="modal fade"
          id="jajeinputModal"
          tabindex="-1"
          aria-labelledby="jajeinputModalLabel"
          aria-hidden="true"
        >
          <div class="modal-dialog modal-xl">
            <div class="modal-content">
              <div class="modal-header">
                <h5 class="modal-title" id="jajeinputModalLabel">자재 정보</h5>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>
              <div class="flex modal-body">
                <!-- 여기다가 대중소분류를 줘야함 -->
                <div class="row">
                  <div class="col">
                    <div class="form-group">
                      <label for="BigType">대분류</label>
                      <select
                        class="form-control"
                        id="BigType"
                        style="color: black; background-color: white"
                      >
                        <option selected="selected" value="">
                          대분류 선택
                        </option>
                        <c:forEach var="bigType" items="${bigTypeList}">
                          <option value="${bigType.big_no}">
                            ${bigType.big_content}
                          </option>
                        </c:forEach>
                      </select>
                    </div>
                  </div>

                  <div class="col">
                    <label for="midType">중분류</label>
                    <select class="form-control" id="midType">
                      <option selected="selected" value="">중분류 선택</option>
                    </select>
                  </div>

                  <!-- <option selected="selected" value="">중분류 선택</option>
                                    <c:forEach var="midType" items="${midTypeList}">
                                        <option value="${midType.mid_no}">${midType.mid_content}</option>
                                    </c:forEach>  -->

                  <div class="col">
                    <label for="smlType">소분류</label>
                    <select class="form-control" id="smlType">
                      <option selected="selected" value="">중분류 선택</option>
                    </select>
                  </div>

                  <table
                    id="jajeTable"
                    style="margin: 50px 0"
                    class="table table-striped table-bordered t-8"
                  >
                    <thead class="bg-gray-50">
                      <tr>
                        <th scope="col">선택</th>
                        <th scope="col">자재 코드</th>
                        <th scope="col">자재명</th>
                        <th scope="col">규격</th>
                        <th scope="col">단위</th>
                        <th scope="col">단가</th>
                      </tr>
                    </thead>
                    <tbody id="jajeTableBody"></tbody>
                  </table>
                </div>
                <div class="modal-footer">
                  <button
                    id="modalSaveButton"
                    type="button"
                    class="btn btn-primary"
                  >
                    저장
                  </button>
                  <button
                    type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal"
                  >
                    닫기
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
        <!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
        <!--  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@-->
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
    <!--    <script src="assets/vendor/apexcharts/apexcharts.min.js"></script> -->
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <!--     <script src="assets/vendor/chart.js/chart.umd.js"></script>
                <script src="assets/vendor/echarts/echarts.min.js"></script>
                <script src="assets/vendor/quill/quill.min.js"></script>
                <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
                 <script src="assets/vendor/tinymce/tinymce.min.js"></script>
                 <script src="assets/vendor/php-email-form/validate.js"></script> -->
  </body>
</html>
