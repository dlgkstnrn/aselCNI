<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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
     
     <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<script defer="defer" type="text/javascript" src="assets/js/pjh/initemWriteView.js"></script>
</head>

<body>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <!-- End Sidebar-->

    <main id="main" class="main">

        <div class="pagetitle">
            <h1>자재 관리</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">자재관리</li>
                    <li class="breadcrumb-item"><a href="/initem">입고관리</a></li>
                    <li class="breadcrumb-item active">입고등록</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->

        <section class="section dashboard">
        	<div class="card">
        		<!-- 제목 탭  -->
	            <div class="card-body">
	              <div class="d-flex align-items-center">
		              <span class="h5 me-auto card-header-title">입고 등록</span>
		              <div>
		              	<button onclick="regInitem()" type="button" class="btn btn-primary">저장</button>
		              	<a href="/initem" type="button" class="btn btn-primary">취소</a>
		              </div>
	              </div>
	              <hr>
	              
	              
	              <!-- 입고정보 입력부  -->
	              <div class="container text-center">
	              	<div class="row">
	              		<div class="col-md-8">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">입고일자<span class="color-red">*</span></span>
							  <input id="initem_dt" name="initem_dt" type="date" aria-label="initem_dt" class="form-control">
							</div>
	              		</div>
	              	</div>
	              	
	              	<div class="row mt-1">
	              		<div class="col-md-8">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">발주번호<span class="color-red">*</span></span>
							  <input id="purc_no" type="text" class="form-control" placeholder="발주번호" aria-label="발주번호" aria-describedby="button-addon1" readonly>
							  <button class="btn btn-outline-secondary" type="button" id="button-addon1" data-bs-toggle="modal" data-bs-target="#modalDialogScrollable"><i class="bi bi-search"></i></button>
							</div>
	              		</div>
	              	</div>
	              	
	              <div class="modal fade" id="modalDialogScrollable" data-bs-backdrop="static" tabindex="-1">
	                <div class="modal-dialog modal-dialog-scrollable">
	                  <div class="modal-content">
	                    <div class="modal-header">
	                      <h5 class="modal-title">발주번호 선택</h5>
	                      <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    </div>
	                    <div class="modal-body">
	                    	<div class="row">
	                    		<div class="col-3">
	                    			<span>조회기간</span>
	                    		</div>
	                    		<div class="col-9">
	                    			<select id="period" class="w-100">
	                    				<option value="1">1일</option>
	                    				<option value="2">7일</option>
	                    				<option value="3" selected="selected">30일</option>
	                    				<option value="0">전체기간</option>
	                    			</select>
	                    		</div>
	                    	</div>
	                    	<div class="row mt-2">
	                    		<div class="col-3">
	                    			<span>매입처</span>
	                    		</div>
	                    		<div class="col-9">
	                    			<input id="custNm" type="text" class="w-100">
	                    		</div>
	                    	</div>
	                    	<div class="row mt-2">
	                    		<div class="col-3">
	                    			<span>발주번호</span>
	                    		</div>
	                    		<div class="col-7">
	                    			<input id="purCd" type="text" class="w-100">
	                    		</div>
	                    		<div class="col-auto px-0">
	                    			<button class="btn btn-primary btn-sm" onclick="searchPurc()">조회</button>
	                    		</div>
	                    	</div>
	                    	
	                    	<hr>
	                    	
	                    	
	                    	<span class="fw-bold">발주번호 검색 결과</span>
	                    	<div class="row mt-3">
	                    		<div class="col-12">
	                    			<select id="purcSelect" onchange="selectPurc(this)" size="5" class="w-100">
	                    			</select>
	                    		</div>
	                    	</div>
	                    </div>
	                    <div class="modal-footer">
	                      <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">취소</button>
	                      <button onclick="pickPurcNo()" type="button" class="btn btn-primary">선택</button>
	                    </div>
	                  </div>
	                </div>
	              </div><!-- End Modal Dialog Scrollable-->
	              	
	              	<div class="row mt-1">
	              		<div class="col-md-4">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">매입처</span>
							  <input id="cust_nm" type="text" class="form-control" placeholder="매입처명" readonly="readonly">
							</div>
	              		</div>
	              		<div class="col-md-4">
	              			<div class="input-group">
							  <span class="input-group-text">담당자(매입처)<span class="color-red">*</span></span>
							  <input id="cust_emp" type="text" class="form-control" placeholder="담당자명">
							</div>
	              		</div>
	              	</div>
	              	
	              	<div class="row mt-1">
	              		<div class="col-md-8">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">입고담당자</span>
							  <input  type="text" value="${sessionScope.user_nm}" class="form-control" readonly>
							</div>
	              		</div>
	              	</div>
	              	
	              	<div class="row mt-1">
	              		<div class="col-md-8">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">창고<span class="color-red">*</span></span>
							  <select id="wh_cd" class="form-select">
							  	<c:forEach var="wh" items="${whs}">
								  	<option value="${wh.wh_cd}">${wh.wh_nm}</option>
							  	</c:forEach>
							  </select>
							</div>
	              		</div>
	              	</div>
	              	
	              	
	              	<div class="row mt-1">
	              		<div class="col-md-8">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">비고</span>
							  <textarea id="remark" rows="4" class="form-control"></textarea>
							</div>
	              		</div>
	              	</div>
	              	
	              	<div class="row mt-1">
	              		<div class="col-md-8">
	              			<div class="input-group">
							  <span class="input-group-text" style="width:106px">입고종결</span>
							  <div class="form-control form-switch px-0" style="text-align: left;">
							  	<input class="form-check-input" onchange="changeEndState(this)" id="initem_end" value="0" type="checkbox" style="margin-left:12px;">
							  </div>
							</div>
	              		</div>
	              	</div>
	              	
	              </div>
	              
	              <!-- 자재 입력 및 수정  -->
	              <div class="hstack mt-5 gap-1">
	              	<button onclick="getItemList()" type="button" class="ms-auto btn btn-primary btn-sm ">초기화</button>
		            <button onclick="deleteRow()" type="button" class="btn btn-primary btn-sm ">삭제</button>
	              </div>
	              <table class="table table-hover">
	                <thead>
	                  <tr>
	                    <th scope="col">선택</th>
	                    <th scope="col">자재 코드</th>
	                    <th scope="col">자재명</th>
	                    <th scope="col">규격</th>
	                    <th scope="col">단위</th>
	                    <th scope="col">수량</th>
	                    <th scope="col">단가</th>
	                    <th scope="col">금액</th>
	                  </tr>
	                </thead>
	                <tbody id="itemTableBody">
	                </tbody>
	                <tfoot id="itemTableFoot">
	                </tfoot>
	              </table>
	            </div>
	        </div>
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