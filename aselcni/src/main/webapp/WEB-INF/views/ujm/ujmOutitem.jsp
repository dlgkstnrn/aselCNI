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
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
      rel="stylesheet"/>

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"
    />
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>
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
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
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
        <h1>영업 관리</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item">영업 관리</li>
            <li class="breadcrumb-item active"><a href="/#">출고 관리</a></li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section dashboard" id="section">
        
        <div class="card">
          <div class="card-body">

            <div class="d-flex align-items-center justify-content-between">
              <span class="h-5 d-flex align-items-center card-header-title">출고 관리</span>
              
              <!-- 등록버튼 (등록폼을 띄우는 버튼) -->
              <button type="button"
                class="btn btn-primary"
                data-bs-toggle="modal"
                data-bs-target="#outitem_insert" 
                id="outitem_insert_btn"> 
                등록
              </button>
            </div>

            <!-- 제목 아래 밑줄 -->
            <hr>



            <div class="card-body">
              



              <!-- 일반페이지(조회페이지). 하단 출력 조건 걸어주는 곳 -->

              <!-- 주문번호로 검색 -->
              <div class="search">
                <div>
                  <div class="input-group day-box">
                    <span class="input-group-text">조회기간</span>
                    <input type="date" class="start-day form-control" value="${start_day}">
                    <input type="date" class="end-day form-control" value="${end_day}">
                  </div>
                  <div class="input-group return-no-box">
                    <span class="input-group-text">출고번호</span>
                    <input type="text" class="outitem-no-text form-control" placeholder="출고번호를 입력하세요" value="${outitem_no}" />
                  </div>
                  <div class="input-group outitem-no-box">
                    <span class="input-group-text">주문번호</span>
                    <input type="text" class="order-no-text form-control" placeholder="주문번호를 입력하세요" value="${order_no}" />
                  </div>
                </div>
                <div>
                  <div class="input-group cust-nm-box">
                    <span class="input-group-text">고객사</span>
                    <input type="text" class="cust-nm-text form-control" placeholder="고객사명을 입력하세요" value="${cust_nm}" />
                  </div>
                  <div class="input-group item-nm-box">
                    <span class="input-group-text">제품명</span>
                    <input type="text" class="item-nm-text form-control" placeholder="제품명을 입력하세요" value="${item_nm}" />
                  </div>
                  <div class="input-group user-nm-box">
                    <span class="input-group-text">담당자</span>
                    <input type="text" class="outitem-user-nm-text form-control" placeholder="담당자명을 입력하세요" value="${outitem_user_nm}" />
                    &nbsp;
                    <button type="button" id="search-btn" class="search-btn btn btn-primary">검색</button>
                  </div>
                </div>
                <!-- 검색 끝 -->



                <!-- 테이블, 조회 -->
                <c:set var="num" value="${page.total-page.start+1 }"></c:set>
                <!-- Table with stripped rows -->
                <table class="table table-hover">
                  <thead>
                    <tr>
                      <th scope="col">No</th>
                      <th scope="col">출고번호</th>
                      <th scope="col">주문번호</th>
                      <th scope="col">고객사</th>
                      <th scope="col">제품명</th>
                      <th scope="col">주문일자</th>
                      <th scope="col">납기일자</th>
                      <th scope="col">출고일자</th>
                      <th scope="col">담당자</th>
                      <th scope="col">진행</th>

                    </tr>
                  </thead>

                  <tbody id="outitemList">
                    <c:forEach var="outitem" items="${listOutitem}">
                  
                    <tr data-bs-toggle="modal"
                      data-bs-target="#outitemDetailModal">
                      <td>${outitem.num}</td>
                      <td>${outitem.outitem_no}</td>
                      <td>${outitem.order_no}</td>
                      <td>${outitem.cust_nm}</td>
                      <td>${outitem.items}</td>
                      <td>${outitem.order_dt}</td>
                      <td>${outitem.order_end_dt}</td>
                      <td>${outitem.outitem_dt}</td>
                      <td>${outitem.outitem_user_nm}</td>
                      <td>
                        <c:if test="${outitem.order_status_chk==0}"><span class="badge bg-warning text-dark">주문 완료</span></c:if>
                        <c:if test="${outitem.order_status_chk==1}"><span class="badge bg-secondary">주문 취소</span></c:if>
                        <c:if test="${outitem.order_status_chk==2}"><span class="badge bg-primary">일부 출고</span></c:if>
                        <c:if test="${outitem.order_status_chk==3}"><span class="badge bg-secondary">전체 출고 완료</span></c:if>
                      </td>
                      
                    </tr>
                    <c:set var="num" value="${num + 1 }"></c:set>

                  </c:forEach>

                  </tbody>
                </table>
             
                <!-- End Table with stripped rows -->
              </div>
              <!-- End .search -->


            
              
            




              <!-- 번호디자인 -->
              <nav class="page-navigation">
                <ul class="pagination">
                  <c:if test="${page.startPage > page.pageBlock }">
                    <li class="page-item"><a class="page-link" href="outitem?currentPage=${page.startPage-page.pageBlock}&start_day=${start_day}&end_day=${end_day}&outitem_no=${outitem_no}&order_no=${order_no}&cust_nm=${cust_nm}&item_nm=${item_nm}&outitem_user_nm=${outitem_user_nm}"><span>&laquo;</span></a></li>
                  </c:if>
                  <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                    <li class="page-item ${page.currentPage == i ? 'active' : ''}">
                      <a class="page-link" href="outitem?currentPage=${i}&start_day=${start_day}&end_day=${end_day}&outitem_no=${outitem_no}&order_no=${order_no}&cust_nm=${cust_nm}&item_nm=${item_nm}&outitem_user_nm=${outitem_user_nm}">${i}</a>
                    </li>
                  </c:forEach>
                  <c:if test="${page.endPage < page.totalPage }">
							      <li class="page-item"><a class="page-link" href="outitem?currentPage=${page.startPage+page.pageBlock }&start_day=${start_day}&end_day=${end_day}&outitem_no=${outitem_no}&order_no=${order_no}&cust_nm=${cust_nm}&item_nm=${item_nm}&outitem_user_nm=${outitem_user_nm}"><span>&raquo;</span></a></li>
						      </c:if>

                </ul>
              </nav>
              <!-- End Disabled and active states -->
              <!-- 번호디자인 끝 -->

            </div>
            <!-- End Card-body -->

          </div>
          <!-- End Card-body -->
        </div>
        <!-- End card -->



        <!-- 등록 Modal -->
        <div class="modal fade" id="outitem_insert" tabindex="-1" aria-hidden="true" style="display: none"> 
          <div class="modal-dialog modal-dialog-centered modal-xl">
            
            
            <div class="modal-content"> <!-- 닫기버튼 눌렀을 때 
              이 부분의 input과 textarea의 val이 초기화 -->
              
              <div class="modal-header">
                <h5 class="modal-title" >출고등록</h5>
                <button type="button" class="btn-close" 
                data-bs-dismiss="modal" aria-label="Close"></button>
                  <!-- 좌측 상단의 닫기버튼(X) -->
              </div> <!-- modal-header -->

                <!-- 등록 폼 form -->
              <form action="insertOutitem" method="get" id="insertOutitemForm">
                <div class="modal-body detail">
                  <!-- 주문번호 -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">주문번호</label>
                    <div class="col-sm-9">
                      <select
                        class="form-select" id="selectOrderNo" name="order_no">
                          <option value="">주문 선택</option>
                            <!-- ajax로 선택할 수 있는 주문번호 추가됨  -->
                    
                      </select>
                      <input type="hidden" name="order_no" id="insertOrderNo"
                      required="required">
                      <!-- form에 들어가는 값 -->
                    </div>
                  </div>

                  <!-- 고객사 -->
                  <div class="row mb-3">
                    <label
                      for="cust_nm"
                      class="col-sm-3 col-form-label">매입처</label>
                    <div class="col-sm-9 orderInfo_cust_nm" id="orderInfo_cust_nm">
                      <!-- ajax -->
                    </div>
                    <input type="hidden" class="orderInfo_cust_nm" name="cust_nm"
                    required="required"> 
                      <!-- form에 들어가는값 -->
                  </div>


                  <!-- 주문일자(단순조회) -->
                  <div class="row mb-3 d-flex">
                    <label class="col-sm-3 col-form-label">주문일자
                      </label>
                    <div class="col-sm-9" id="orderInfo_order_dt" >
                      <!-- ajax로 -->
                    </div>
                  </div>

                  <!-- 납기일자 -->
                  <div class="row mb-3">
                    <label for="order_end_dt"
                      class="col-sm-3 col-form-label">납기일자</label>
                    <div class="col-sm-9 orderInfo_order_end_dt" 
                    id="orderInfo_order_end_dt">
                      <!-- ajax -->
                    </div>
                  </div>


                  <!-- 출고일자 -->
                  <div class="row mb-3">
                    <label
                      for="outitem_dt"
                      class="col-sm-3 col-form-label red-star">출고일자</label>
                    <div class="col-sm-9">
                      <input type="date" class="form-control" id="insert_outitem_dt" 
                        name="outitem_dt" style="width: 200px;" required="required"/>
                    </div>
                  </div>
                  
                  <!-- 거래처담당자 -->
                  <div class="row mb-3">
                    <label
                      for="outitem.cust_emp"
                      class="col-sm-3 col-form-label red-star">거래처 담당자</label>
                    <div class="col-sm-9">
                      <input
                        type="text"
                        class="form-control"
                        id="insert_cust_emp"
                        placeholder="거래처 담당자명 입력"
                        name="cust_emp"
                        autocomplete="off"
                        required="required"/>
                    </div>
                  </div>
                  <!-- 주문상태 -->
                  <div class="row mb-3">
                    <label
                      for="order_status_chk"
                      class="col-sm-3 col-form-label">진행상태</label>
                    <div class="col-sm-9" 
                    id="orderInfo_order_status_chk">   
                      <!-- ajax -->
                    </div>
                  </div>
                  
                  <!-- 출고할 제품 선택-->
                  <div class="row mb-3">
                    <label class="col-sm-3 col-form-label">
                      제품명</label>
                    <div class="col-sm-9 mb-3">
                      <!-- Vertically centered Modal -->
                      <!-- 선택된 투입품 리스트 -->
                      <div class="card-body">
                        <h5 class="card-title mb-1"></h5>
                        <table class="table table-hover" id="outitem_item_list">
                          <thead>
                            <tr>
                              <th></th> <!-- 체크박스 공간 -->
                              <th>제품명</th>
                              <th>현재 재고</th>
                              <th>주문수량</th>
                              <th>남은 주문 수량</th>
                              <th>출고수량</th>
                            </tr>
                          </thead>
        
                          <tbody>
                        <!-- ajax로 들어감 -->
                          
        
                          </tbody>
                        </table>
                        <!-- End with custom content -->
                      </div> <!-- 투입품 card body -->
                    </div> <!-- col-sm-9 mb-3 -->
                  </div> <!-- row mb-3 -->
                  <!-- 비고 -->
                  <div class="row mb-3">
                    <label
                      for="outitem.remark"
                      class="col-sm-3 col-form-label">비고</label>
                    <div class="col-sm-9">
                      <input
                        type="text"
                        class="form-control"
                        id="insert_remark"
                        name="remark"/>
                    </div>
                  </div>
                  
                </div> <!-- modal-body detail -->
                <!-- 신규버튼 modal의 하단 버튼 -->
                <div class="modal-footer">
                  <button type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal">
                    닫기
                  </button>
                  <button type="submit" class="btn btn-primary"
                  form="insertOutitemForm" id="insertOutitemBtn" disabled>
                    등록
                  </button> <!-- form으로 이어지는 실제 출고등록 버튼 -->
                </div> <!-- footer -->
              </form>

            </div> <!-- modal-content -->

          </div> <!-- modal-xl -->
        </div>
        <!-- 등록 모달 끝 -->            



        <!-- 상세, Detail 사용-->
        <div
          class="modal fade"
          id="outitemDetailModal"
          tabindex="-1"
          style="display: none"
          aria-hidden="true"> <!-- 상세 부분.. (수정,삭제에도 사용) -->

          <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content" data-backdrop="static"> <!-- 닫기버튼 눌렀을 때 
              이 부분의 input과 textarea의 val이 초기화 -->
              <div class="modal-header">
                <h5 class="modal-title">출고 상세</h5>
                <button type="button"
                  class="btn-close"
                  data-bs-dismiss="modal"
                  aria-label="Close"></button> <!-- 닫기 버튼 -->
              </div>


              <div class="modal-body detail"> <!-- Start modal body -->
                <form action="updateOutitem" method="get" id="updateOutitemForm">
    
                    <!-- 출고번호 -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label">출고번호</label>
                      <div class="col-sm-9" id="detail_outitem_no">
                        <!-- ajax로 소환 -->
                      </div>
                    </div>

                    <!-- 주문번호 -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label">주문번호</label>
                      <div class="col-sm-9" id="detail_order_no">
                        <!-- ajax -->
                      </div>
                    </div>

                    <!-- 고객사 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label">고객사</label>
                      <div class="col-sm-9" id="detail_cust_nm">
                      </div>
                    </div>

                    <!-- 주문일자 -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label">주문일자</label>
                      <div class="col-sm-9" id="detail_order_dt">
                       
                      </div>
                    </div>

                    <!-- 주문마감일-->
                    <div class="row mb-3">
                      <label for="order_end_dt" class="col-sm-3 col-form-label">납기일자</label>
                      <div class="col-sm-9" id="detail_order_end_dt">
                      </div>
                    </div>

                    <!-- 출고일자 -->
                    <div class="row mb-3">
                      <label for="outitem_dt" class="col-sm-3 col-form-label red-star">출고일자</label>
                      <div class="col-sm-9" id="detail_outitem_dt">
                      </div>
                    </div>

                    <!-- 거래처담당자 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label red-star">거래처 담당자</label>
                      <div class="col-sm-9" id="detail_cust_emp">
                      </div>
                    </div>

                    <!-- 주문상태 -->
                    <div class="row mb-3">
                      <label for="order_status_chk" class="col-sm-3 col-form-label">진행 상태</label>
                      <div class="col-sm-9" id="detail_order_status_chk">
                        
                      </div>
                    </div>


                    <!-- 출고할 제품 선택-->
                    <div class="row mb-3">
                      <label class="col-sm-3 col-form-label">제품명</label>

                      <div class="col-sm-9 mb-3">

                        <!-- 선택된 투입품 리스트 -->
                        <div class="card-body">
                          <h5 class="card-title mb-1"></h5>

                          <table class="table table-hover" id="detail_outitem_item_list">
                            <thead>
                              <tr>
                                <th></th> <!-- 체크박스 공간 -->
                                <th>제품명</th>
                                <th>현재 재고</th>
                                <th>주문수량</th>
                                <th>남은 주문 수량</th>
                                <th>출고한 수량</th>
                              </tr>
                            </thead>
          
                            <tbody>
                           <!-- ajax로 들어감 -->
                            </tbody>

                          </table>

                        </div> <!-- 투입품 card body -->
                          
                      </div> <!-- col-sm-9 mb-3 -->
                    </div> <!-- row mb-3 -->


                    <!-- 비고 -->
                    <div class="row mb-3">
                      <label for="detail_remark" class="col-sm-3 col-form-label">비고</label>
                      <div class="col-sm-9" id="detail_remark">

                      </div>
                    </div>


                  <!-- 신규버튼 modal의 하단 버튼 -->
                  <div class="modal-footer">


                    <!-- 닫기버튼 -->
                    <button
                      type="button"
                      class="btn btn-secondary"
                      data-bs-dismiss="modal">
                      닫기
                    </button>

                    <button type="submit" class="btn btn-danger"
                    id="deleteOutitemSubmitBtn">
                      삭제
                    </button>

                    <button type="submit" id="updateOutitemBtn" class="btn btn-primary">수정</button>

                    <button type="submit" id="updateOutitemSubmitBtn" class="btn btn-primary" 
                    style="display: none;">수정완료</button>







                  </div> <!-- modal-footer -->
                </form>
              </div> <!-- End modal body -->



            </div> <!-- modal-content -->
          </div>
        </div>
        <!-- End modal -->
      </section>
    </main>
    <!-- End #main -->

    <!-- ======= Footer ======= -->
    <%@ include file="../footer.jsp" %>
    <!-- End Footer -->

    <a href="#"
      class="back-to-top d-flex align-items-center justify-content-center"
      ><i class="bi bi-arrow-up-short"></i></a>

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
