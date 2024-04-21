<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"
%>
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
	rel="stylesheet"
>

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet"
>
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet"
>
<link href="assets/vendor/boxicons/css/boxicons.min.css"
	rel="stylesheet"
>
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"
></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"
></script>
<style type="text/css">
.remark-cell {
	max-width: 100px; /* 최대 너비 설정 */
	white-space: nowrap; /* 텍스트를 한 줄로 설정 */
	overflow: hidden; /* 내용이 넘치면 숨김 */
	text-overflow: ellipsis; /* 넘치는 텍스트를 '...'으로 표시 */
}
</style>
</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>기준 정보 관리 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">기준 정보 관리</a></li>
					<li class="breadcrumb-item active">공정 관리</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->

		<section class="section dashboard">






			<!-- 공정 추가 -->
			<div class="row">
				<div class="col-lg-12">

					<div class="card">

						<div class="card-body">
							<div class="d-flex align-items-center">
								<span class="h5 me-auto card-header-title">공정 관리</span>
								<div>
									<button type="button" class="btn btn-primary"
										data-bs-toggle="modal" data-bs-target="#verticalycentered"
									>신규</button>
								</div>

							</div>

							<hr>


							<div class="modal fade" id="verticalycentered" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">공정등록</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"
											></button>
										</div>
										<div class="modal-body">
											<div class="form-check">
												<label class="form-check-label" for="defaultCheck1">사용여부</label>
												<input name="use_Flag" class="form-check-input"
													type="checkbox" id="defaultCheck1"
												>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">공정코드<span
													style="color: red;"
												>*</span></label>
												<div class="col-sm-8">
													<input name="proc_Cd" type="text" class="form-control">
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">공정명<span
													style="color: red;"
												>*</span></label>
												<div class="col-sm-8">
													<input name="proc_Nm" type="text" class="form-control">
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
												<div class="col-sm-10">
													<textarea name="remark" class="form-control"
														style="height: 100px"
													></textarea>
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-3 col-form-label">담당자ID<span
													style="color: red;"
												>*</span></label>
												<div class="col-sm-8">
													<input name="proc_Emp_Id" type="text" class="form-control">
												</div>
											</div>

										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal"
											>닫기</button>
											<button type="button" id="NewProcmst" class="btn btn-primary">등록</button>
										</div>
									</div>
								</div>
							</div>




							<!-- 공정 수정 관리 삭제 -->
							<div class="modal fade" id="verticalycentered1" tabindex="-1">
								<div class="modal-dialog modal-dialog-centered">
									<div class="modal-content">
										<div class="modal-header">
											<h5 class="modal-title">공정</h5>
											<button type="button" class="btn-close"
												data-bs-dismiss="modal" aria-label="Close"
											></button>
										</div>
										<div class="modal-body">


											<div class="form-check">
												<input name="use_Flag" class="form-check-input"
													type="checkbox" value="1" id="defaultCheck1"
												> <label class="form-check-label" for="defaultCheck1">사용여부</label>
											</div>

											<div class="row mb-3">
												<label class="col-sm-3 col-form-label">공정코드</label>
												<div class="col-sm-7">
													<p id="procCode"></p>
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-2 col-form-label">공정명</label>
												<div class="col-sm-8">
													<input type="text" class="form-control" name="proc_Nm">
												</div>
											</div>

											<div class="row mb-3">
												<label class="col-sm-3 col-form-label">등록날짜</label>
												<div class="col-sm-5">
													<p id="proc_Regdate">200-14-45</p>
												</div>
											</div>

											<div class="row mb-3">
												<label class="col-sm-3 col-form-label">수정날짜</label>
												<div class="col-sm-5">
													<p id="proc_Update"></p>
												</div>
											</div>



											<div class="row mb-3">
												<label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
												<div class="col-sm-10">
													<textarea name="remark" class="form-control"
														style="height: 100px"
													></textarea>
												</div>
											</div>

											<div class="row mb-3">
												<label for="inputText" class="col-sm-3 col-form-label">담당자ID</label>
												<div class="col-sm-8">
													<input type="text" class="form-control" name="proc_Emp_Id">
												</div>
											</div>

										</div>
										<div class="modal-footer">
											<button type="button" class="btn btn-secondary"
												data-bs-dismiss="modal"
											>닫기</button>
											<button type="button" id="chProcmst" class="btn btn-primary">수정</button>
											<button type="button" id="delProcmst" class="btn btn-primary">삭제</button>
										</div>
									</div>
								</div>
							</div>



							<!-- Table with stripped rows -->
							<div
								class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns search-results"
							>
								<div class="datatable-top">
									<div class="datatable-dropdown"></div>





									<div class="searchdiv">
										<form action="/procmst">
											<div class="d-flex" style="width: 600px;">
												<select class="form-select searchselect"
													aria-label="Default select example" name="searchFilter"
													style="width: 200px;"
												>
													<option selected="">검색옵션선택</option>
													<option value="proc_Cd">코드</option>
													<option value="proc_Nm">이름</option>
												</select> <input type="text" name="keyword"
													class="form-control searchinput" style="width: 400px;"
												>

												<button type="submit" class="btn btn-primary"
													style="width: 60px;"
												>검색</button>
											</div>
										</form>
									</div>
									<!-- End Search Bar -->




								</div>
								<div class="datatable-container">
									<table id="processTable"
										class="table datatable datatable-table datatable-table"
									>
										<thead>
											<tr>
												<th><b>N</b>o.</th>
												<th>공정코드</th>
												<th>공정명</th>
												<th>설명</th>
												<th>담당자</th>
												<th>사용여부</th>

											</tr>
										</thead>
										<tbody>
											<c:forEach var="Procmst" items="${processList}"
												varStatus="status"
											>
												<tr>
													<td>${status.index + 1}</td>

													<td><button type="button"
															class="btn btn-outline-primary edit-process-btn"
															data-bs-toggle="modal"
															data-bs-target="#verticalycentered1"
															data-proc-id="${Procmst.proc_Cd}"
														>${Procmst.proc_Cd}</button></td>

													<td>${Procmst.proc_Nm}</td>
													<td class="remark-cell">${Procmst.remark}</td>
													<td>${Procmst.proc_Emp_Id}</td>
													<td><c:choose>
															<c:when test="${Procmst.use_Flag == 1}">
                                                사용
                                            </c:when>
															<c:otherwise>
                                                비사용
                                            </c:otherwise>
														</c:choose></td>
												</tr>
											</c:forEach>
										</tbody>
									</table>
								</div>


								<div class="container">
									<div class="row">
										<div class="col">
											<ul class="pagination d-flex justify-content-center">
												<c:if test="${page.startPage > page.pageBlock }">
													<li class="page-item"><a class="page-link"
														href="/procmst?currentPage=${page.startPage-page.pageBlock}"
													>이전</a></li>
												</c:if>
												
												<c:forEach var="i" begin="${page.startPage}"
													end="${page.endPage}"
												>
													<li class="page-item"><a class="page-link"
														href="/procmst?currentPage=${i}&searchFilter=${Procmst.searchFilter}&keyword=${Procmst.keyword}">${i}</a></li>
												</c:forEach>
												
												<c:if test="${page.endPage < page.totalPage }">
													<li class="page-item"><a class="page-link"
														href="/procmst?currentPage=${page.startPage+page.pageBlock}"
													>다음</a></li>
												</c:if>
											</ul>
										</div>
									</div>
								</div>

							</div>
							<!-- End Table with stripped rows -->

						</div>
					</div>

				</div>
			</div>














			<div class="modal fade" id="verticalycentered1" tabindex="-1">
				<div class="modal-dialog modal-dialog-centered">
					<div class="modal-content">
						<div class="modal-header">
							<h5 class="modal-title">Vertically Centered</h5>
							<button type="button" class="btn-close" data-bs-dismiss="modal"
								aria-label="Close"
							></button>
						</div>
						<div class="modal-body">수정</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-secondary"
								data-bs-dismiss="modal"
							>Close</button>
							<button type="button" class="btn btn-primary">Save
								changes</button>
						</div>
					</div>
				</div>
			</div>

		</section>

	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="../footer.jsp"%>
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
	<script type="text/javascript">
		//=====================공정정보 가져오기======================
		$(document)
				.ready(
						function() {
							$('.edit-process-btn')
									.on(
											'click',
											function() {
												var procId = $(this).data(
														'proc-id');

												$
														.ajax({
															url : 'procmstDetails', // 서버의 URL을 지정해야 합니다.
															type : 'GET',
															data : {
																'id' : procId
															}, // 서버로 보낼 데이터
															dataType : 'json', // 응답 받을 데이터의 타입
															success : function(
																	data) {
																// 모달의 입력 필드에 공정 정보를 채움

																console
																		.log(
																				"Use Flag:",
																				data.use_Flag);

																$('#procCode')
																		.text(
																				data.proc_Cd);
																$(
																		'#verticalycentered1 input[name="proc_Nm"]')
																		.val(
																				data.proc_Nm);
																$(
																		'#proc_Regdate')
																		.text(
																				data.proc_Regdate);
																$(
																		'#proc_Update')
																		.text(
																				data.proc_Update);
																$(
																		'#verticalycentered1 textarea[name="remark"]')
																		.val(
																				data.remark);
																$(
																		'#verticalycentered1 input[name="proc_Emp_Id"]')
																		.val(
																				data.proc_Emp_Id);

																if (data.use_Flag === 1) {
																	$(
																			'#verticalycentered1 input[name="use_Flag"]')
																			.prop(
																					'checked',
																					true);
																} else {
																	$(
																			'#verticalycentered1 input[name="use_Flag"]')
																			.prop(
																					'checked',
																					false);
																}

																// 모달을 열음
																$(
																		'#processModal')
																		.modal(
																				'show');
															},
															error : function(
																	xhr,
																	status,
																	error) {
																console
																		.error("AJAX Error: "
																				+ status
																				+ error);
															}
														});
											});
						});

		//=====================공정수정=========================
		$(document)
				.on(
						'click',
						'#chProcmst',
						function() {
							// 사용여부
							var use_Flag = $(
									'#verticalycentered1 input[name="use_Flag"]')
									.is(':checked') ? 1 : 0;
							var procCode = $('#procCode').text();
							var proc_Nm = $(
									'#verticalycentered1 input[name="proc_Nm"]')
									.val(); // 수정된 부분
							var remark = $(
									'#verticalycentered1 textarea[name="remark"]')
									.val();
							var proc_Emp_Id = $(
									'#verticalycentered1 input[name="proc_Emp_Id"]')
									.val(); // 수정된 부분

							console.log("Use Flag:", use_Flag);
							console.log("proc_Nm:", proc_Nm);
							console.log("proc_Emp_Id:", proc_Emp_Id);

							// AJAX 요청을 통해 서버에 데이터 전송
							$.ajax({
								url : 'updateProc', // 요청을 처리할 서버의 URL
								type : 'POST',
								data : {
									'use_Flag' : use_Flag,
									'proc_Cd' : procCode,
									'proc_Nm' : proc_Nm,
									'remark' : remark,
									'proc_Emp_Id' : proc_Emp_Id
								},
								dataType : 'text',
								success : function(response) {
									if (response === 'success') {
										alert('공정정보가 성공적으로 변경되었습니다');
										location.reload();
									} else {
										alert('음...잘못된 담당자입니다...');
									}
								},
								error : function(xhr, status, error) {
									// 요청 처리 중 오류가 발생했을 때 실행할 코드
									alert('잘못된 담당자입니다...');
								}
							});
						});
		//=====================공정삭제=========================
		$(document).on('click', '#delProcmst', function() {
			// 사용여부
			var procCode = $('#procCode').text();

			// AJAX 요청을 통해 서버에 데이터 전송
			$.ajax({
				url : 'DelDateProc', // 요청을 처리할 서버의 URL
				type : 'POST',
				data : {
					'proc_Cd' : procCode,
				},
				dataType : 'text',
				success : function(response) {
					if (response === 'success') {
						alert('공정정보가 성공적삭제 되었습니다.');
						location.reload();
					} else {
						alert('문제발생1');
					}
				},
				error : function(xhr, status, error) {
					// 요청 처리 중 오류가 발생했을 때 실행할 코드
					alert('문제발생2');
				}
			});
		});

		//=====================공정추가=========================
		$(document).on('click', '#NewProcmst', function() {
			// 사용여부
			var use_Flag = $('input[name="use_Flag"]').is(':checked') ? 1 : 0;
			var proc_Cd = $('input[name="proc_Cd"]').val();
			var proc_Nm = $('input[name="proc_Nm"]').val();
			var remark = $('textarea[name="remark"]').val();
			var proc_Emp_Id = $('input[name="proc_Emp_Id"]').val();

			var formData = new FormData();
			formData.append('use_Flag', use_Flag);
			formData.append('proc_Cd', proc_Cd);
			formData.append('proc_Nm', proc_Nm);
			formData.append('remark', remark);
			formData.append('proc_Emp_Id', proc_Emp_Id);

			// AJAX 요청을 통해 서버에 데이터 전송
			$.ajax({
				url : 'NewProc', // 요청을 처리할 서버의 URL
				type : 'POST',
				data : formData,
				processData : false,
				contentType : false,
				dataType : 'text',
				success : function(response) {
					if (response === 'success') {
						alert('공정정보가 성공적으로 변경되었습니다');
						location.reload();
					} else if (response === 'error1') {
						alert('공정 코드 또는 공정 이름이 비어 있습니다');
					} else if (response === 'error2') {
						alert('중복된 공정코드입니다!');
					}
					 else if (response === 'error3') {
						alert('존재하지않는 담당자입니다!');
					}
				},
				error : function(xhr, status, error) {
					// 요청 처리 중 오류가 발생했을 때 실행할 코드
					alert('잘못되었음');
				}
			});
		});

		//====================공정 검색============================

		/*    document.getElementById('searchInput').addEventListener(
		         'input',
		         function() {
		            var searchQuery = this.value.toLowerCase();
		            var table = document.getElementById('processTable');
		            var tr = table.getElementsByTagName('tr');

		            for (var i = 1; i < tr.length; i++) { // 행 반복 (첫 번째 행은 제외 - 헤더)
		               var tdCode = tr[i].getElementsByTagName('td')[1]; // 공정코드 열
		               var tdName = tr[i].getElementsByTagName('td')[2]; // 공정명 열
		               if (tdCode || tdName) {
		                  var textValueCode = tdCode.textContent
		                        || tdCode.innerText;
		                  var textValueName = tdName.textContent
		                        || tdName.innerText;
		                  if (textValueCode.toLowerCase()
		                        .indexOf(searchQuery) > -1
		                        || textValueName.toLowerCase().indexOf(
		                              searchQuery) > -1) {
		                     tr[i].style.display = "";
		                  } else {
		                     tr[i].style.display = "none"; // 일치하지 않으면 숨김
		                  }
		               }
		            }
		         }); */
	</script>
</body>

</html>


