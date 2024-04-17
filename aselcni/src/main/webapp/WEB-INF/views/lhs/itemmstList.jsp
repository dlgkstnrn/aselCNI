<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">

<head>
    <meta charset="utf-8">
    <meta content="width=device-width, initial-scale=1.0" name="viewport">

    <title>스마트 제조 시스템</title>
    
    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon">

    <!-- Google Fonts -->
  	<link href="https://fonts.gstatic.com" rel="preconnect">
  	<link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet">
    
    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
    <!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet"  type="text/css">
     <style type="text/css">
		.selectbtndiv {
		  padding: 0px 10px;
		}
		
		.wid150 {
		  width: 150px;
		}
		.bordergray {
		  border: 1px solid gray;
		  color: black;
		}
		.searchdiv {
		  height: 40px;
		  padding: 0px 20px;
		  margin-bottom: 10px;
		}
		.searchselect {
		  width: 150px;
		  margin-right: 10px;
		}
		.searchinput {
		  width: 300px;
		  margin-right: 10px;
		}
		.m-r10{
		  margin-right: 10px;
		}
     </style>
     <!-- Script -->
      <script type="text/javascript">
     	const itemMst = ${itemMst.item_flag};
     </script> 
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script defer="defer" src="assets/js/main.js" type="text/javascript"></script>
	<script defer="defer" type="text/javascript" src="assets/js/lhs/itemmstList.js"></script> 
</head>

<body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <!-- End Sidebar-->

    <main id="main" class="main">
      <div class="pagetitle">
        <h1>기준 정보 관리</h1>
        <nav>
          <ol class="breadcrumb">
            <li class="breadcrumb-item active">
              기준정보 관리
            </li>
            <li class="breadcrumb-item active">
              품목 관리
            </li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section">
        <div class="maindiv card">
	        <div class="card-body">
	        <div class="d-flex align-items-end justify-content-between">
				<span class="h5 d-flex align-items-center card-header-title">품목 관리</span>
                <a href="itemmstAddForm?item_flag=${itemMst.item_flag }">
	                <button class="btn btn-primary">신규</button>
	            </a>
            </div>
            <hr>
	          <div class="selectbtndiv d-flex justify-content-between">
		          <div>
		            <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
		              <li class="nav-item" role="presentation">
		                <a href="itemmst?item_flag=1">
		                  <button class="bordergray wid150" id="matBtn">자재</button>
		                </a>
		              </li>
		              <li class="nav-item" role="presentation">
		                <a href="itemmst?item_flag=2">
		                  <button class="bordergray wid150" id="proBtn">제품</button>
		                </a>
		              </li>
		            </ul>
	            </div>
	          </div>
	          <div class="searchdiv">
	            <form action="itemmst" onsubmit="return searchsubmitChk()">
	              <div class="d-flex justify-content-end">
	                <select
	                  class="form-select wid150 h-100 m-r10"
	                  aria-label="Default select example"
	                  name="big_no" id="searchBig"
	                >
	                  <option selected="" value="0">대분류</option>
	                  <c:forEach items="${bigList}" var="big">
	                  	<option value="${big.big_no }">${big.big_content}</option>
	                  </c:forEach>
	                </select>
	
	                <select
	                  class="form-select wid150 h-100 m-r10"
	                  aria-label="Default select example"
	                  name="mid_no" id="searchMid"
	                >
	                  <option selected="" value="0">중분류</option>
	                </select>
	
	                <select
	                  class="form-select wid150 h-100 m-r10"
	                  aria-label="Default select example"
	                  name="sml_no" id="searchSml"
	                >
	                  <option selected="" value="0">소분류</option>
	                </select>
	
	                <div class="d-flex">
	                  <select
	                    class="form-select searchselect"
	                    aria-label="Default select example"
	                    name="searchFilter" id="searchFilter"
	                  >
	                    <option value="">검색옵션선택</option>
	                    <option value="item_cd">코드</option>
	                    <option value="item_nm">이름</option>
	                  </select>
	                  <input
	                    type="text"
	                    name="keyword"
	                    id="keyword"
	                    class="form-control searchinput"
	                  />
	                  <input
	                    type="hidden"
	                    name="item_flag"
	                    value="${itemMst.item_flag}"
	                  />
	                  <button type="submit" class="btn btn-primary">검색</button>
	                </div>
	              </div>
	            </form>
	          </div>
	          <div class="tablediv">
	            <table id="tb" class="table table-hover">
	              <thead>
	                <tr>
	                  <th scope="col" style="width: 10%">품목코드</th>
	                  <th scope="col" style="width: 30%">품목명</th>
	                  <th scope="col" style="width: 30%">거래처</th>
	                  <th scope="col" style="width: 15%">규격</th>
	                  <th scope="col" style="width: 15%">단가</th>
	                </tr>
	              </thead>
	              <tbody>
	                <c:forEach items="${itemList }" var="item">
	                  <tr
	                    data-index="${item.item_cd}"
	                    data-bs-toggle="modal"
	                    data-bs-target="#prodItemEditModal"
	                  >
	                    <th>${item.item_cd }</th>
	                    <td>${item.item_nm }</td>
	                    <c:if test="${item.cust_nm ne null}">
	                    	<td>${item.cust_nm }(${ item.cust_cd})</td>
	                    </c:if>
	                    <c:if test="${item.cust_nm eq null}">
	                    	<td></td>
	                    </c:if>
	                    <td>${item.item_spec }</td>
	                    <td>
	                    	<fmt:formatNumber value="${item.item_cost }" />
	                    </td>
	                  </tr>
	                </c:forEach>
	              </tbody>
	            </table>
	          </div>
          </div>
          <div class="d-flex justify-content-center">
	          <nav aria-label="Page navigation example">
	            <ul class="pagination">
	              <c:if test="${page.startPage>page.pageBlock }">
	                <li class="page-item">
	                  <a
	                    class="page-link"
	                    href="itemmst?currentPage=${page.startPage-page.pageBlock }&item_flag=${itemMst.item_flag}&searchFilter=${itemMst.searchFilter}&keyword=${itemMst.keyword}"
	                    ><</a
	                  >
	                </li>
	              </c:if>
	              <c:forEach
	                var="i"
	                begin="${page.startPage }"
	                end="${page.endPage }"
	              >
	                <li class="page-item">
	                  <a
	                    class="page-link"
	                    href="itemmst?currentPage=${i }&biz_flag=${itemMst.item_flag}&searchFilter=${itemMst.searchFilter}&keyword=${itemMst.keyword}"
	                    >${i }</a
	                  >
	                </li>
	              </c:forEach>
	              <c:if test="${page.endPage < page.totalPage }">
	                <li class="page-item">
	                  <a
	                    class="page-link"
	                    href="itemmst?currentPage=${page.startPage+page.pageBlock }&item_flag=${itemMst.item_flag}&searchFilter=${itemMst.searchFilter}&keyword=${itemMst.keyword}"
	                    >></a
	                  >
	                </li>
	              </c:if>
	            </ul>
	          </nav>
	        </div>
        </div>

        <!-- Start prodItemEditModal------------m2-------------------->
        <div
          class="modal fade"
          id="prodItemEditModal"
          tabindex="-1"
          style="display: none"
          aria-hidden="true"
        >
          <div class="modal-dialog modal-dialog-centered modal-xl">
            <div class="modal-content">
              <form action="itemmstUpdate" method="post" onsubmit="return submitChk()">
                <div class="modal-header">
                  <h1 class="modal-title">품목 관리</h1>
                  <button
                    type="button"
                    class="btn-close"
                    data-bs-dismiss="modal"
                    aria-label="Close"
                  ></button>
                </div>
                <div class="modal-body">
                  <!-- Start modal body -->
                  <input type="hidden" name="item_cd" id="item_cd" />
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">품목 명</span></label
                    >
                    <div class="col-sm-10">
                      <input
                        name="item_nm"
                        id="item_nm"
                        type="text"
                        class="form-control"
                        value=""
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">거래처</span></label
                    >
                    <div class="col-sm-10">
                      <select
                        class="form-select"
                        aria-label="Default select example"
                        name="cust_cd"
                        id="cust_cd"
                      >
                        <option selected="">거래처선택</option>
                      </select>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">분류</span></label
                    >
                    <div class="col">
                      <select
                        class="form-select"
                        aria-label="Default select example"
                        name="big_no" id="modalbig">
                        <option selected="">대분류</option>
                        <c:forEach items="${bigList}" var="big">
		                  	<option class="modalbig" value="${big.big_no }">${big.big_content}</option>
		                </c:forEach>
                      </select>
                    </div>
                    <div class="col">
                      <select
                        class="form-select"
                        aria-label="Default select example"
                        name="mid_no" id="mid">
                        <option selected="">중분류</option>
                      </select>
                    </div>
                    <div class="col">
                      <select
                        class="form-select"
                        aria-label="Default select example"
                        name="sml_no" id="sml">
                        <option selected="">소분류</option>
                      </select>
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">규격</span></label
                    >
                    <div class="col-sm-10">
                      <input
                        id="item_spec"
                        name="item_spec"
                        type="text"
                        class="form-control"
                        value=""
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">단위</span></label
                    >
                    <div class="col-sm-10">
                      <input
                        id="item_unit"
                        name="item_unit"
                        type="text"
                        class="form-control"
                        value=""
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">단가</span></label
                    >
                    <div class="col-sm-10">
                      <input
                        id="item_cost"
                        name="item_cost"
                        type="text"
                        class="form-control"
                        value=""
                      />
                    </div>
                  </div>
                  <div class="row mb-3">
                    <label
                      for="prodItemWHEditModal"
                      class="col-sm-2 col-form-label label-marquee"
                      ><span class="moving-text">비고</span></label
                    >
                    <div class="col-sm-10">
                      <input
                        id="remark"
                        name="remark"
                        type="text"
                        class="form-control"
                        value=""
                      />
                    </div>
                  </div>
                </div>
                <!-- End modal body -->
                <div class="modal-footer">
                  <button
                    type="button"
                    class="btn btn-secondary"
                    data-bs-dismiss="modal"
                  >
                    닫기
                  </button>
                  <button id="delBtn" type="button" class="btn btn-danger">
                    삭제
                  </button>
                  <button type="submit" class="btn btn-primary">수정</button>
                </div>
              </form>
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

    <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
            class="bi bi-arrow-up-short"></i></a>

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