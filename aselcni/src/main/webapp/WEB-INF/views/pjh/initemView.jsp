<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
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
		<link
			href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
			rel="stylesheet">

		<!-- Vendor CSS Files -->
		<link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">
		<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet">
		<!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
		<!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

		<!-- CSS File -->
		<link href="assets/css/style.css" rel="stylesheet" type="text/css">
		<!-- Script -->
		<script defer src="assets/js/main.js"></script>
		<script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
		<script src="assets/js/jquery-3.7.1.min.js"></script>
		<script defer src="assets/js/pjh/initemView.js"></script>
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
								<li class="breadcrumb-item active">입고관리</li>
							</ol>
						</nav>
					</div><!-- End Page Title -->

					<section class="section dashboard h-max">
						<div class="card">
							<div class="card-body">
								<!-- 카드 제목 부  -->
								<div class="d-flex align-items-center">
									<span class="h5 me-auto card-header-title">입고 관리</span>
									<div>
										<a href="/initemWrite" type="button" class="btn btn-primary ">신규</a>
									</div>
								</div>
								<hr>

								<!-- 필터 입력 부 -->
								<div class="container text-center">
									<div class="row">
										<div class="col-md-7">
											<div class="input-group">
												<span class="input-group-text" style="width:90px">조회기간</span>
												<input id="start_date" type="date" aria-label="startDate"
													class="form-control">
												<input id="end_date" type="date" aria-label="endDate"
													class="form-control">
											</div>
										</div>
										<div class="col-md-5">
											<div class="input-group">
												<span class="input-group-text">매입처</span>
												<input id="cust_nm" type="text" class="form-control" placeholder="매입처명"
													aria-label="매입처명">
											</div>
										</div>
									</div>

									<div class="row mt-1">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-text" style="width:90px">발주번호</span>
												<input id="purc_no" type="text" class="form-control"
													placeholder="발주번호" aria-label="발주번호">
											</div>
										</div>
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-text">담당자(발주)</span>
												<input id=purc_emp_nm type="text" class="form-control" placeholder="발주 담당자"
													aria-label="발주담당자">
											</div>
										</div>
									</div>

									<div class="row mt-1">
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-text" style="width:90px">입고번호</span>
												<input id="initem_no" type="text" class="form-control"
													placeholder="입고번호" aria-label="입고번호">
											</div>
										</div>
										<div class="col-md-6">
											<div class="input-group">
												<span class="input-group-text">담당자(입고)</span>
												<input id="initem_emp_nm" type="text" class="form-control" placeholder="입고 담당자"
													aria-label="입고담당지">
											</div>
										</div>
									</div>
									
									<div class="row mt-1">
										<div class="col-md-11">
											<div class="input-group">
												<span class="input-group-text" style="width:90px">자재명</span>
												<input id="item_nm" type="text" class="form-control" placeholder="자재명"
													aria-label="자재명">
											</div>
										</div>
										<div class="col-md-1 text-end">
											<button class="btn btn-primary w-100 px-0" style="height:100%;"
												onclick="searchInitem()">조회</button>
										</div>
									</div>
								</div>


								<!-- 리스트 조회부 -->
								<table class="table table-hover mt-5">
									<thead>
										<tr>
											<th scope="col">No.</th>
											<th scope="col">입고번호</th>
											<th scope="col">담당자(입고)</th>
											<th scope="col">발주번호</th>
											<th scope="col">담당자(발주)</th>
											<th scope="col">입고일자</th>
											<th scope="col">매입처</th>
											<th scope="col">자재명</th>
										</tr>
									</thead>
									<tbody id="initemListTable">
										<c:forEach var="item" varStatus="status" items="${initems}">
											<tr onclick="detailView('${item.initem_no}')" style="cursor:pointer;">
												<th scope="row">${status.count+(page.currentPage-1)*page.rowPage}</th>
												<td>${item.initem_no}</td>
												<td>${item.initem_emp_nm}</td>
												<td>${item.purc_no}</td>
												<td>${item.purc_emp_nm}</td>
												<td>${item.initem_dt }</td>
												<td>${item.cust_nm }</td>
												<td>${item.item_nm }</td>
											</tr>
										</c:forEach>

									</tbody>
								</table>
								<nav aria-label="Page navigation example">
									<ul class="pagination justify-content-center">
										<li class="page-item">
											<button class="page-link" onclick="prevPage()" aria-label="Previous">
												<span aria-hidden="true">«</span>
											</button>
										</li>
										<c:forEach var="i" begin="${page.startPage}" end="${page.endPage }">
											<li class="page-item pageNum"><button class="page-link"
													onclick="goPage('${i}')">${i }</button></li>
										</c:forEach>
										<li id="nextPageLi" class="page-item">
											<button id="nextPageBtn" class="page-link" onclick="nextPage(this)"
												data-total-page="${page.totalPage }" aria-label="Next">
												<span aria-hidden="true">»</span>
											</button>
										</li>
									</ul>
								</nav>
							</div>
						</div>
					</section>
				</main>
				<!-- End #main -->

				<!-- 상세조회 모달 -->
				<div class="modal fade" id="detailModal" data-bs-backdrop="static" tabindex="-1">
					<div class="modal-dialog modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h5 class="modal-title">입고 상세 조회</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"></button>
							</div>
							<div class="modal-body">
								<div class="row mb-1">
									<div class="col">
										<div class="input-group">
											<span class="input-group-text" style="width:90px">입고번호</span>
											<input id="modal_initem_no" type="text" class="form-control"
												placeholder="입고번호" aria-label="입고번호" disabled>
										</div>
									</div>
									<div class="col">
										<div class="input-group">
											<span class="input-group-text" style="width:125px">담당자(입고)</span>
											<input id="modal_initem_emp_nm" data-user-nm="${sessionScope.user_nm }" type="text" class="form-control" placeholder="입고 담당자"
												aria-label="입고담당자" disabled>
										</div>
									</div>
								</div>
								<div class="row mb-1">
									<div class="col">
										<div class="input-group">
											<span class="input-group-text" style="width:90px">발주번호</span>
											<input id="modal_purc_no" type="text" class="form-control"
												placeholder="발주번호" aria-label="발주번호" disabled>
										</div>
									</div>
									<div class="col">
										<div class="input-group">
											<span class="input-group-text" style="width:125px">담당자(발주)</span>
											<input id="modal_purc_emp_nm" type="text" class="form-control" placeholder="발주 담당자"
												aria-label="발주담당자" disabled>
										</div>
									</div>
								</div>
								<div class="row mb-1">
									<div class="col">
										<div class="input-group">
											<span class="input-group-text" style="width:90px">입고일자</span>
											<input id="modal_initem_dt" type="date" class="form-control"
												placeholder="입고일" aria-label="입고일">
										</div>
									</div>
								</div>
				                 <div class="row mb-1">
									<div class="col">
										<div class="input-group">
											<span class="input-group-text" style="width:90px">매입처</span>
											<input id="modal_cust_nm" type="text" class="form-control"
												placeholder="매입처" aria-label="매입처" disabled>
										</div>
									</div>
									<div class="col mb-1">
										<div class="input-group">
											<span class="input-group-text" style="width:125px">담당자(매입처)</span>
											<input id="modal_cust_emp" type="text" class="form-control"
												placeholder="매입처 담당자" aria-label="매입처담당자">
										</div>
									</div>
								</div>
								<div class="row mt-1">
				              		<div class="col">
				              			<div class="input-group">
										  <span class="input-group-text" style="width:90px">창고</span>
										  <select id="modal_wh_cd" class="form-select">
											  	<option value="${wh.wh_cd}">${wh.wh_nm}</option>
										  </select>
										</div>
				              		</div>
				              	</div>
				              	
				              	<div class="row mt-1">
				              		<div class="col">
				              			<div class="input-group">
										  <span class="input-group-text" style="width:90px">비고</span>
										  <textarea id="modal_remark" rows="4" class="form-control"></textarea>
										</div>
				              		</div>
				              	</div>
								<div class="row mt-1">
				              		<div class="col">
				              			<div class="input-group">
										  <span class="input-group-text" style="width:90px">입고종결</span>
										  <div class="form-control form-switch px-0" style="text-align: left;">
										  	<input class="form-check-input" onchange="changeEndState(this)" id="modal_initem_end" value="0" type="checkbox" style="margin-left:12px;">
										  </div>
										</div>
				              		</div>
				              	</div>
								
								<hr>
								
								<table class="table table-hover">
					                <thead>
					                  <tr>
					                    <th scope="col">자재 코드</th>
					                    <th scope="col">자재명</th>
					                    <th scope="col">규격</th>
					                    <th scope="col">단위</th>
					                    <th scope="col">수량</th>
					                    <th scope="col">단가</th>
					                    <th scope="col">금액</th>
					                  </tr>
					                </thead>
					                <tbody id="modal_itemTableBody">
					                </tbody>
					                <tfoot id="modal_itemTableFoot">
	               	 				</tfoot>
					            </table>
								
							</div>
							<div class="modal-footer">
			                  <button id="closeBtn" type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
			                  <button id="cancleBtn" onclick="detailUpdate(false)" type="button" class="btn btn-secondary" hidden="true">취소</button>
			                  <button id="delBtn" onclick="detailDelete()" type="button" class="btn btn-danger">삭제</button>
			                  <button id="modifyBtn" onclick="detailUpdate(true)" type="button" class="btn btn-primary">수정</button>
			                  <button id="submitBtn" type="button" onclick="updateInitem()" class="btn btn-primary" hidden="true">저장</button>
			                </div>
						</div>
					</div>
				</div><!-- End detailModall-->


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