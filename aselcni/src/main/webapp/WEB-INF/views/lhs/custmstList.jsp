<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

     </style>
     <!-- Script -->
     <script type="text/javascript">
     	const custMst = ${custMst.biz_flag};
     </script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
    <script defer="defer" src="assets/js/main.js" type="text/javascript"></script>
	<script defer="defer" type="text/javascript" src="assets/js/lhs/custmstList.js"></script>
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
              거래처 관리
            </li>
          </ol>
        </nav>
      </div>
      <!-- End Page Title -->

      <section class="section">
        <div class="maindiv card">
	        <div class="card-body">
	        <div class="d-flex align-items-end justify-content-between">
				<span class="h5 d-flex align-items-center card-header-title">거래처 관리</span>
                <a href="custmstAddForm?biz_flag=${custMst.biz_flag}">
	              		<button class="btn btn-primary">신규</button>
	             </a>
            </div>
            <hr>
	          <div class="selectbtndiv">
		          <div>
			          <ul class="nav nav-pills mb-3" id="pills-tab" role="tablist">
			              <li class="nav-item" role="presentation">
				              <a href="custmst?biz_flag=2">
				                <button class="bordergray wid150"  id="selBtn">
				                  고객사
				                </button>
			                   </a>
			              </li>
			              <li class="nav-item" role="presentation">
			              	<a href="custmst?biz_flag=1">
				                <button class="bordergray wid150" id="buyBtn">
				                  구매처
				                </button>
			                </a>
			              </li>
			           </ul>
	               </div>
	          </div>
	          <div class="searchdiv d-flex justify-content-end">
	          	<div>
		            <form action="custmst" onsubmit="return searchsubmitChk()">
		              <div class="d-flex">
		                <select
		                  class="form-select searchselect"
		                  aria-label="Default select example"
		                  name="searchFilter"
		                  id="searchFilter"
		                >
		                  <option value="">검색옵션선택</option>
		                  <option value="cust_cd">코드</option>
		                  <option value="cust_nm">이름</option>
		                </select>
		                <input type="text" name="keyword" class="form-control searchinput" />
		                <input type="hidden" name="biz_flag" value="${custMst.biz_flag}">
		                <button type="submit" class="btn btn-primary">검색</button>
		              </div>
		            </form>
	            </div>
	          </div>
	          <div class="tablediv">
	            <table id="tb" class="table table-hover">
	              <thead>
	                <tr>
	                  <th scope="col" style="width: 10%">No</th>
	                  <th scope="col" style="width: 10%">업체명</th>
	                  <th scope="col" style="width: 10%">대표자명</th>
	                  <th scope="col" style="width: 15%">전화번호</th>
	                  <th scope="col" style="width: 15%">팩스번호</th>
	                  <th scope="col" style="width: 10%">담당자</th>
	                  <th scope="col" style="width: 30%">주소</th>
	                </tr>
	              </thead>
	              <tbody>
	              	<c:forEach items="${custList }" var="cust">
		                <tr data-index="${cust.cust_cd}" data-bs-toggle="modal" data-bs-target="#prodItemEditModal">
		                  <th>${cust.cust_cd }</th>
		                  <td>${cust.cust_nm }</td>
		                  <td>${cust.president_nm }</td>
		                  <td>${cust.biz_tel }</td>
		                  <td>${cust.biz_fax }</td>
		                  <td>${cust.emp_id }</td>
		                  <td>${cust.biz_addr }</td>
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
	                    <li class="page-item"><a class="page-link"
	                      href="custmst?currentPage=${page.startPage-page.pageBlock }&biz_flag=${custMst.biz_flag}&searchFilter=${custMst.searchFilter}&keyword=${custMst.keyword}"><</a>
	                    </li>
	                  </c:if>
	                  <c:forEach var="i" begin="${page.startPage }"
	                    end="${page.endPage }">
	                    <li class="page-item"><a class="page-link"
	                      href="custmst?currentPage=${i }&biz_flag=${custMst.biz_flag}&searchFilter=${custMst.searchFilter}&keyword=${custMst.keyword}">${i }</a>
	                    </li>
	                  </c:forEach>
	                  <c:if test="${page.endPage < page.totalPage }">
	                    <li class="page-item"><a class="page-link"
	                      href="custmst?currentPage=${page.startPage+page.pageBlock }&biz_flag=${custMst.biz_flag}&searchFilter=${custMst.searchFilter}&keyword=${custMst.keyword}">></a>
	                    </li>
	                  </c:if>
	              </ul>
	           </nav>
	        </div>
        </div>
        
        <!-- Start prodItemEditModal------------m2-------------------->
		<div class="modal fade" id="prodItemEditModal" tabindex="-1"
			style="display: none;" aria-hidden="true">
			<div class="modal-dialog modal-dialog-centered modal-xl">
				<div class="modal-content">
				<form action="custmstUpdate" method="post" onsubmit="return submitChk()">
					<div class="modal-header">
						<h1 class="modal-title">거래처 관리</h1>
						<button type="button" class="btn-close" data-bs-dismiss="modal"
							aria-label="Close"
						></button>
					</div>
					<div class="modal-body">
						<!-- Start modal body -->
							<input type="hidden" name="cust_cd" id="cust_cd">
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">업체 명</span></label>
								<div class="col-sm-10">
									<input name="cust_nm" id="cust_nm" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">대표자명</span></label>
								<div class="col-sm-10">
									<input id="president_nm" name="president_nm" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">사업자 번호</span></label>
								<div class="col-sm-10">
									<input id="biz_no" name="biz_no" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">종목</span></label>
								<div class="col-sm-10">
									<input id="biz_cond" name="biz_cond" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">업태</span></label>
								<div class="col-sm-10">
									<input id="biz_item" name="biz_item" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">주소</span></label>
								<div class="col-sm-10">
									<input id="biz_addr" name="biz_addr" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">전화번호</span></label>
								<div class="col-sm-10">
									<input id="biz_tel" name="biz_tel" type="text" class="form-control" value="">
								</div>
							</div>
							<div class="row mb-3">
								<label for="prodItemWHEditModal" class="col-sm-2 col-form-label label-marquee"><span class="moving-text">팩스</span></label>
								<div class="col-sm-10">
									<input id="biz_fax" name="biz_fax" type="text" class="form-control" value="">
								</div>
							</div>
						</div>
						<!-- End modal body -->
							<div class="modal-footer">
								<button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
								<button id="delBtn" type="button" class="btn btn-danger">삭제</button>
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