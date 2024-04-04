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
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet" />
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet" />
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet" />
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet" />
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet" />

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" type="text/css" />
    <link href="assets/css/ujm/outitem.css" rel="stylesheet" type="text/css" />

    <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script
      src="https://kit.fontawesome.com/0b22ed6a9d.js"
      crossorigin="anonymous"
    ></script>
    <script src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/ujm/outitem.js"></script>
  </head>

  <body>
    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>

    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>출고 관리</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">구매/영업 관리</li>
            <li class="breadcrumb-item active">출고 관리</li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section">
        <div class="row">
          <div class="col-lg-12">
            <div class="card">
              <div class="card-body">
                <h5 class="card-title">

                  <!-- 출고 등록 -->
                  <div id="upper-btn" style="float: right">

                    <button
                      type="button"
                      class="btn btn-primary"
                      data-bs-toggle="modal"
                      data-bs-target="#outitem_insert" 
                    > <!-- 등록버튼 -->
                      등록
                    </button>

                    <!-- 등록 Modal -->
                    <div
                      class="modal fade"
                      id="outitem_insert"
                      tabindex="-1"
                      aria-hidden="true"
                      style="display: none"> 
                      <!-- 등록모달 -->
                      
                    <div class="modal-dialog modal-dialog-centered modal-xl">



                        <div class="modal-content"> <!-- 닫기버튼 눌렀을 때 
                          이 부분의 input과 textarea의 val이 초기화 -->


                          <div class="modal-header">
                            <h5 class="modal-title">출고등록</h5>
                            <button
                              type="button"
                              class="btn-close"
                              data-bs-dismiss="modal"
                              aria-label="Close"
                            ></button>
                          </div>

                            <!-- 등록 폼 -->
                          <form action="insertOutitem">

                            <div class="modal-body">

                              <!-- 주문번호 -->
                              <div class="row mb-3 d-flex">
                                <label class="col-sm-3 col-form-label"
                                  >주문번호</label
                                >
                                <div class="col-sm-9">
                                  <select
                                    class="form-select"
                                    id="floatingSelect"
                                    aria-label="Floating label select example"
                                  style="width: 200px"
                                  name="${order.no}"
                                  >

                                  <option selected>선택</option>
                                  <option value="1">${order.order_no} (제품:${item_nm}, 기업:${cust_nm})</option>
                                  <option value="2">Two</option>
                                  <option value="3">Three</option>
                                </div>
                              </div>

                              <!-- 주문일자(단순조회) -->
                              <div class="row mb-3 d-flex">
                                <label class="col-sm-3 col-form-label"
                                  >주문일자(단순조회)</label
                                >
                                <div class="col-sm-9">
                                  <input
                                    type="text"
                                    class="form-control"
                                    value="${order_dt}"
                                    readonly
                                  />
                                </div>
                              </div>

                              <!-- 출고일자 -->
                              <div class="row mb-3">
                                <label
                                  for="outitem_dt"
                                  class="col-sm-3 col-form-label"
                                  >출고일자(달력)-주문일자보다 늦어야함</label
                                >
                                <div class="col-sm-9">
                                  <input
                                    type="date"
                                    class="form-control"
                                    id="outitem_dt"
                                    name="outitem_dt"
                                  />
                                </div>
                              </div>

                              <!-- 매입처이름 -->
                              <div class="row mb-3">
                                <label
                                  for="cust_nm"
                                  class="col-sm-3 col-form-label"
                                  >매입처이름</label
                                >
                                <div class="col-sm-9">
                                  <p style="color: black">거래처이름 ${cust_nm}</p>
                                </div>
                              </div>

                              <!-- 거래처담당자 -->
                              <div class="row mb-3">
                                <label
                                  for="outitem.cust_emp"
                                  class="col-sm-3 col-form-label"
                                  >거래처담당자이름</label
                                >
                                <div class="col-sm-9">
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="cust_emp"
                                    placeholder="거래처담당자명 임의로 입력"
                                    name="cust_emp"
                                    autocomplete="off"
                                    required="required"
                                  />
                                </div>
                              </div>

                              <!-- 주문상태 -->
                              <div class="row mb-3">
                                <label
                                  for="order_status_chk"
                                  class="col-sm-3 col-form-label"
                                  >주문상태</label
                                >
                                <div class="col-sm-9">
                                  <p style="color: black">
                                    <c:if test="${order_status_chk==0}">미출고</c:if>
                                    <c:if test="${order_status_chk==1}">일부 출고</c:if>
                                    <c:if test="${order_status_chk==2}">출고완료</c:if>
                                  </p>
                                </div>
                              </div>

                              <!-- 주문마감일 -->
                              <div class="row mb-3">
                                <label
                                  for="order_end_dt"
                                  class="col-sm-3 col-form-label"
                                  >주문마감일</label
                                >
                                <div class="col-sm-9">
                                  <p style="color: black">주문마감일 ${order_end_dt}</p>
                                </div>
                              </div>

                              <!-- 출고할 제품 선택-->
                              <div class="row mb-3">
                                <label class="col-sm-3 col-form-label"
                                  >제품명(거래처cd 가져와서)</label
                                >

                                <div class="col-sm-9 mb-3">
                                  <!-- 중첩모달 띄우는 버튼 -->
                                  <!-- Vertically centered Modal -->

                                  <!-- 선택된 투입품 리스트 -->
                                  <div class="card-body">
                                    <h5 class="card-title mb-1"></h5>

                                    <!-- List group with custom content -->
                                    <ol class="list-group list-group-numbered">
                                      <li
                                        class="list-group-item d-flex justify-content-between align-items-start"
                                      >
                                        <div class="ms-2 me-auto">
                                          <div class="fw-bold">제품명</div>
                                          ${item_nm}
                                        </div>
                                        <!-- 현재재고 -->
                                        <div class="d-flex">
                                          <label
                                            for="stock"
                                            class="col-sm-3 col-form-label"
                                            >현재재고</label
                                          >
                                          <div class="col-sm-3 mx-2">
                                            <input
                                              type="number"
                                              class="form-control"
                                              id="stock"
                                              name="stock"
                                              readonly
                                            />
                                          </div>
                                        </div>
                                        <div class="d-flex">
                                          <label
                                            for="order_item_qty"
                                            class="col-sm-3 col-form-label"
                                            >주문수량</label
                                          >
                                          <div class="col-sm-3 mx-2">
                                            <input
                                              type="number"
                                              class="form-control"
                                              id="qty"
                                            />
                                          </div>
                                        </div>
                                        <div class="d-flex">
                                          <label
                                            for="qty"
                                            class="col-sm-3 col-form-label"
                                            >출고수량(재고, 주문보다 많으면
                                            안됨)</label
                                          >
                                          <div class="col-sm-3 mx-2">
                                            <input
                                              type="number"
                                              class="form-control"
                                              id="qty"
                                            />
                                          </div>
                                        </div>

                                        <div class="d-flex">
                                          <label
                                            for="qty"
                                            class="col-sm-3 col-form-label"
                                            >단가</label
                                          >
                                          <div class="col-sm-3 mx-2">
                                            <input
                                              type="number"
                                              class="form-control"
                                              id="qty"
                                            />
                                          </div>
                                        </div>
                                        
                                      </li>
                                    </ol>
                                    <!-- End with custom content -->
                                  </div>
                                </div>
                              </div>

                              <!-- 비고 -->
                              <div class="row mb-3">
                                <label
                                  for="outitem.remark"
                                  class="col-sm-3 col-form-label"
                                  >비고</label
                                >
                                <div class="col-sm-9">
                                  <input
                                    type="text"
                                    class="form-control"
                                    id="outitem.remark"
                                    name="outitem.remark"
                                  />
                                </div>
                              </div>

                              <!-- 출고삭제여부 -->
                              <div class="row mb-3">
                                <label
                                  for="outitem_delete_chk"
                                  class="col-sm-3 col-form-label"
                                  >출고삭제여부</label
                                >
                                <div class="col-sm-9">
                                  <p style="color: black">
                                    출고삭제여부(단순조회)
                                    ${outitem_delete_chk}
                                  </p>
                                </div>
                              </div>
                            </div>

                            <!-- 신규버튼 modal의 하단 버튼 -->
                            <div class="modal-footer">
                              <button
                                type="button"
                                class="btn btn-outline-secondary"
                                data-bs-dismiss="modal"
                              >
                                닫기
                              </button>
                              <button type="submit" class="btn btn-success">
                                등록
                              </button>
                              <button
                                type="reset"
                                class="btn btn-outline-secondary"
                              >
                                Reset
                              </button>
                            </div>
                          </form>
                          <!-- End Horizontal Form -->
                        </div>
                      </div>
                    </div>
                    <!-- 등록 모달 끝 -->
                  </div>
                </h5>





                <!-- 일반페이지(조회페이지). 하단 출력 조건 걸어주는 곳 -->

                <!-- 주문번호로 검색 -->
                <p style="display: inline">주문번호</p>
                <form
                  class="search-form d-flex align-items-center"
                  method="POST"
                  action="#"
                >
                  <input
                    type="text"
                    class="form-control"
                    style="width: 200px"
                    name="order_no"
                  />
                  <button class="btn" type="submit" title="Search">
                    <i class="bi bi-search"></i>
                  </button>
                </form>

                <!-- 출고번호로 검색 -->
                <p style="display: inline">출고번호</p>

                <form
                  class="search-form d-flex align-items-center"
                  method="POST"
                  action="#"
                >
                  <input
                    type="text"
                    class="form-control"
                    style="width: 200px"
                  />
                  <button class="btn" type="submit" title="Search">
                    <i class="bi bi-search"></i>
                  </button>
                </form>

          
                <br />

                <!-- 매입처(이름)로 검색 -->
                <div class="form-floating mb-3">
                  <input
                    type="text"
                    class="form-control"
                    id="floatingInput"
                    placeholder="1"
                    style="width: 200px"
                    name="cust_nm"
                  />
                  <label for="floatingInput"
                    >매입처</label
                  >
                </div>

                <!-- 제품/자재명으로 검색 -->
                <div class="form-floating mb-3">
                  <input
                    type="text"
                    class="form-control"
                    id="item_nm"
                    name="item_nm"
                    placeholder="1"
                    style="width: 200px"
                    
                  />
                  <label for="floatingTextarea"
                    >제품/자재명</label
                  >
                </div>

                <div class="form-floating mb-3">
                  <select
                    class="form-select"
                    id="floatingSelect"
                    aria-label="Floating label select example"
                    style="width: 200px"
                  >
                    <option selected>선택</option>
                    <option value="1">One</option>
                    <option value="2">Two</option>
                    <option value="3">Three</option>
                  </select>
                  <label for="floatingSelect">출고관리자</label>
                </div>

                <br />




                <!-- 날짜 -->
                <div
                  style="
                    display: flex;
                    align-items: center;
                    justify-content: center;
                    gap: 20px;
                    margin: 20px 50px;
                  "
                >
                  <button
                    id="dateLeftBtn"
                    type="button"
                    class="btn btn-primary"
                  >
                    <i class="bi bi-caret-left-fill"></i>
                  </button>
                  <div>
                    <label for="start"></label>
                    <input
                      type="date"
                      class="prodItemDate"
                      id="startDate"
                      value="2024-03-01"
                    />&nbsp;&nbsp;~&nbsp;&nbsp;<label for="end"></label>
                    <input
                      type="date"
                      class="prodItemDate"
                      id="endDate"
                      value="2024-03-07"
                    />
                  </div>

                  <button
                    id="dateRightBtn"
                    type="button"
                    class="btn btn-primary"
                  >
                    <i class="bi bi-caret-right-fill"></i>
                  </button>
                </div>




                <!-- 테이블 -->
                <c:set var="num" value="${page.total-page.start+1 }"></c:set>
                <!-- Table with stripped rows -->
                <table class="table table-hover">
                  <thead>
                    <tr>
  <!--                     <th scope="col">
                        <b>출고번호</b>
                      </th> -->
                      <th scope="col">출고번호</th>
                      <th scope="col">순번</th>
                      <th scope="col">주문번호</th>
                      <th scope="col">주문일자</th>
                      <th scope="col">주문납기일</th>
                      <th scope="col">출고일자</th>
                      <th scope="col">매입처</th>
                      <th scope="col">제품명</th>
                      <th scope="col">주문상태</th>
                      <th scope="col">출고수량</th>
                      <th scope="col">비고</th>
                      <th scope="col">출고관리자</th>
                    </tr>
                  </thead>

                  <tbody>
                    <c:forEach var="outitem" items="${listOutitem}">
                 
                    <tr
                      data-bs-toggle="modal"
                      data-bs-target="#outitemDetailModal"
                    >
                      <td>${outitem.outitem_no}</td>
                      <td>${outitem.seq_no}</td>
                      <td>${outitem.order_no}</td>
                      <td>${outitem.order_dt}</td>
                      <td>${outitem.order_end_dt}</td>
                      <td>${outitem.outitem_dt}</td>
                      <td>${outitem.cust_nm}</td>
                      <td>${outitem.item_nm}</td>
                      <td>
                        <c:if test="${outitem.order_status_chk==0}">주문완료</c:if>
                        <c:if test="${outitem.order_status_chk==1}">일부 출고</c:if>
                        <c:if test="${outitem.order_status_chk==2}">전체 출고 완료</c:if>
                      </td>
                      <td>${outitem.qty}</td>
                      <td>${outitem.remark}</td>
                      <td>${outitem.user_nm}</td>
                    </tr>
                    <c:set var="num" value="${num - 1 }"></c:set>

                  </c:forEach>

                  </tbody>
                </table>

                <c:if test="${page.startPage > page.pageBlock }">
                  <a href="listOutitem?currentPage=${page.startPage-page.pageBlock}">[이전]</a>
                </c:if>
                <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                  <a href="listOutitem?currentPage=${i}">[${i}]</a>
                </c:forEach>
                <c:if test="${page.endPage < page.totalPage }">
                  <a href="listOutitem?currentPage=${page.startPage+page.pageBlock}">[다음]</a>
                </c:if>



                <!-- End Table with stripped rows -->
              </div>

              <!-- 번호디자인 -->
              <!-- Disabled and active states -->
              <nav aria-label="..." style="margin: auto">
                <ul class="pagination">
                  <li class="page-item disabled">
                    <a
                      class="page-link"
                      href="#"
                      tabindex="-1"
                      aria-disabled="true"
                      >Previous</a
                    >
                  </li>
                  <li class="page-item"><a class="page-link" href="#">1</a></li>
                  <li class="page-item active" aria-current="page">
                    <a class="page-link" href="#">2</a>
                  </li>
                  <li class="page-item"><a class="page-link" href="#">3</a></li>
                  <li class="page-item">
                    <a class="page-link" href="#">Next</a>
                  </li>
                </ul>
              </nav>
              <!-- End Disabled and active states -->
              <!-- 번호디자인 끝 -->

              

            </div>
          </div>
        </div>







        <!-- 상세, Detail 사용-->
        <div
          class="modal fade"
          id="outitemDetailModal"
          tabindex="-1"
          style="display: none"
          aria-hidden="true"
        > <!-- 상세 부분.. (수정,삭제에도 사용) -->

          <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
              <div class="modal-header">
                <h1 class="modal-title">출고 상세</h1>
                <button
                  type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"
                ></button>
              </div>


              <div class="modal-body"> <!-- Start modal body -->
                <form>
    
                    <!-- 주문번호 -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label"
                        >주문번호(주문 테이블에서 가져와서 선택할 수
                        있게)</label
                      >
                      <div class="col-sm-9">
                        <input
                          type="text"
                          class="form-control"
                          value="${order_no}"
                          readonly
                          id="order_no_modal" 
                        /> <!-- 닫기버튼 눌렀을때 이 부분이 주문번호 선택으로 변경 -->
                      </div>
                    </div>

                    <!-- 주문일자(단순조회) -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label"
                        >주문일자(단순조회)</label
                      >
                      <div class="col-sm-9">
                        <input
                          type="text"
                          class="form-control"
                          value="${order_dt}"
                          readonly
                        />
                      </div>
                    </div>

                    <!-- 출고일자 -->
                    <div class="row mb-3">
                      <label for="outitem_dt" class="col-sm-3 col-form-label"
                        >출고일자(달력)-주문일자보다 늦어야함</label
                      >
                      <div class="col-sm-9">
                        <input
                          type="date"
                          class="form-control"
                          id="outitem_dt"
                          name="outitem_dt"
                        />
                      </div>
                    </div>

                    <!-- 매입처이름 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label"
                        >매입처이름</label
                      >
                      <div class="col-sm-9">
                        <p style="color: black">거래처이름 ${cust_nm}</p>
                      </div>
                    </div>

                    <!-- 거래처담당자 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label"
                        >거래처담당자이름</label
                      >
                      <div class="col-sm-9">
                        <input
                          type="text"
                          class="form-control"
                          placeholder="거래처담당자명 임의로 입력"
                          name="cust_emp"
                          autocomplete="off"
                          required="required"
                        />
                      </div>
                    </div>

                    <!-- 주문상태 -->
                    <div class="row mb-3">
                      <label for="order_status_chk" class="col-sm-3 col-form-label"
                        >주문상태</label
                      >
                      <div class="col-sm-9">
                        <p style="color: black">
                          <c:if test="${order_status_chk==0}">미출고</c:if>
                          <c:if test="${order_status_chk==1}">일부 출고</c:if>
                          <c:if test="${order_status_chk==2}">출고완료</c:if>
                        </p>
                      </div>
                    </div>

                    <!-- 주문마감일 -->
                    <div class="row mb-3">
                      <label for="order_end_dt" class="col-sm-3 col-form-label"
                        >주문마감일</label
                      >
                      <div class="col-sm-9">
                        <p style="color: black">주문마감일 ${order_end_dt}</p>
                      </div>
                    </div>

                    <!-- 출고할 제품 선택-->
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label"
                        >제품명(거래처cd 가져와서)</label
                      >

                      <div class="col-sm-9 mb-3">
                        <!-- 중첩모달 띄우는 버튼 -->
                        <!-- Vertically centered Modal -->

                        <!-- 선택된 투입품 리스트 -->
                        <div class="card-body">
                          <h5 class="card-title mb-1"></h5>

                          <!-- List group with custom content -->
                          <ol class="list-group list-group-numbered">
                            <li
                              class="list-group-item d-flex justify-content-between align-items-start"
                            >
                              <div class="ms-2 me-auto">
                                <div class="fw-bold">제품명</div>
                                품목CD에서..
                              </div>
                              <!-- 현재재고 -->
                              <div class="d-flex">
                                <label for="qty" class="col-sm-3 col-form-label"
                                  >현재재고</label
                                >
                                <div class="col-sm-3 mx-2">
                                  <input
                                    type="number"
                                    class="form-control"
                                    id="qty"
                                    readonly
                                  />
                                </div>
                              </div>
                              <div class="d-flex">
                                <label for="qty" class="col-sm-3 col-form-label"
                                  >주문수량</label
                                >
                                <div class="col-sm-3 mx-2">
                                  <input
                                    type="number"
                                    class="form-control"
                                    id="qty"
                                  />
                                </div>
                              </div>
                              <div class="d-flex">
                                <label for="qty" class="col-sm-3 col-form-label"
                                  >출고수량(재고, 주문보다 많으면 안됨)</label
                                >
                                <div class="col-sm-3 mx-2">
                                  <input
                                    type="number"
                                    class="form-control"
                                    id="qty"
                                  />
                                </div>
                              </div>
                              그 외 품목cd, 품목명, 분류번호, 규격, 단위, 수량,
                              단가 등을 가져옴 (단순조회)
                            </li>
                          </ol>
                          <!-- End with custom content -->
                        </div>
                      </div>
                    </div>

                    <!-- 비고 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label"
                        >비고</label
                      >
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="" />
                      </div>
                    </div>

                    <!-- 출고삭제여부 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label"
                        >출고삭제여부</label
                      >
                      <div class="col-sm-9">
                        <p style="color: black">출고삭제여부(단순조회)</p>
                      </div>
                    </div>
                  </div>

                  <!-- 신규버튼 modal의 하단 버튼 -->
                  <div class="modal-footer">


                    <!-- 닫기버튼 -->
                    <button
                      type="button"
                      class="btn btn-outline-secondary"
                      data-bs-dismiss="modal"
                    >
                      닫기버튼
                    </button>




                    <button type="submit" class="btn btn-success">수정</button>



                    <button type="submit" class="btn btn-outline-secondary">
                      삭제
                    </button>



                  </div>
                </form>
              </div> <!-- End modal body -->



            </div>
          </div>
        </div>
        <!-- End modal -->
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
    <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
    <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
    <script src="assets/vendor/chart.js/chart.umd.js"></script>
    <script src="assets/vendor/echarts/echarts.min.js"></script>
    <script src="assets/vendor/quill/quill.min.js"></script>
    <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
    <script src="assets/vendor/tinymce/tinymce.min.js"></script>
    <script src="assets/vendor/php-email-form/validate.js"></script>
  </body>
</html>
