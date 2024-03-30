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
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">
<link href="assets/css/jtu/jtuProdItemRegistry.css" rel="stylesheet"
	type="text/css"
>

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"
></script>
<script src="assets/js/jquery-3.7.1.min.js"></script>

<script type="text/javascript">
	//modal 예상수량-실제수량=불량수량
	$(document).ready(function() {
		// expectedQty, actualQty 값이 변경될 때마다 defectiveQty를 업데이트합니다.
		$("#expectedQty, #actualQty").on("input", function() {
			let expectedQty = parseInt($("#expectedQty").val()) || 0;
			let actualQty = parseInt($("#actualQty").val()) || 0;
			let defectiveQty = expectedQty - actualQty;
			$("#defectiveQty").val(defectiveQty);
		});

		// defectiveQty 값이 변경될 때마다 actualQty를 업데이트합니다.
		$("#defectiveQty").on("input", function() {
			let expectedQty = parseInt($("#expectedQty").val()) || 0;
			let defectiveQty = parseInt($(this).val()) || 0;
			let actualQty = expectedQty - defectiveQty;
			$("#actualQty").val(actualQty);
		});
	});

	//닫기 버튼 클릭시 modal 입력 내용 클리어
	$(document).ready(function() {
		$('button[data-bs-dismiss="modal"]').on('click', function() {
			modalContentClear();
		});
	});
	//닫기 버튼 클릭시 modal 입력 내용 클리어
	function modalContentClear() {
		$('#dropdownMenuButton').text("생산 지시 번호를 선택");
		$(".modal-content input").val('');
		$(".modal-content textarea").val('');
	}

	//조회 테이블 행 클릭시 modal 수정창으로 이동
	$(document).ready(function() {
		$('.dropdown-toggle').dropdown();
		$('.dropdown-item').click(function() {
			let selectedValue = $(this).attr('data-value');
			$('#dropdownMenuButton').text(selectedValue);
		});
		$('tr[data-bs-toggle="modal"]').on('click', function() {
			let prodNo = $(this).find('td:nth-child(2)').text();
			$('#dropdownMenuButton').text(prodNo);
		});
	});

	//시작 날짜와 종료 날짜 논리 일관성
	$(document).ready(function() {
		$('#startDate').on('input', function() {
			let startDate = $('#startDate').val();
			let endDate = $('#endDate').val();

			// 시작 날짜가 종료 날짜보다 뒤에 있는 경우
			if (startDate > endDate) {
				// 시작 날짜를 종료 날짜와 동일하게 설정합니다.
				$('#startDate').val(endDate);
			}

		});

		$('#endDate').on('input', function() {
			let startDate = $('#startDate').val();
			let endDate = $('#endDate').val();

			// 시작 날짜가 종료 날짜보다 뒤에 있는 경우
			if (startDate > endDate) {
				// 시작 날짜를 종료 날짜와 동일하게 설정합니다.
				$('#endDate').val(startDate);
			}
		});
	});

	// 좌우 버튼 누를 때마다 날짜 7일 단위로 바뀜
	$(document).ready(function() {
		$('#dateRightBtn').click(function() {
			dateShift('right');
		});

		$('#dateLeftBtn').click(function() {
			dateShift('left');
		});
	});

	// 날짜 조정 함수
	function dateShift(direction) {
		let startDateVal = $('#startDate').val();
		let endDateVal = $('#endDate').val();

		// Date 객체로 변환
		let startDate = new Date(startDateVal);
		let endDate = new Date(endDateVal);

		// 방향에 따라 날짜를 조정
		if (direction === 'right') {
			startDate.setDate(startDate.getDate() + 7);
			endDate.setDate(endDate.getDate() + 7);
		} else if (direction === 'left') {
			startDate.setDate(startDate.getDate() - 7);
			endDate.setDate(endDate.getDate() - 7);
		}
		


		// 새로운 날짜를 입력 필드에 설정
		$('#startDate').val(startDate.toISOString().slice(0, 10));
		$('#endDate').val(endDate.toISOString().slice(0, 10));
	}

</script>


</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>기준 정보 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">기준 정보 관리</a></li>
					<li class="breadcrumb-item active">사업장 관리</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		<div class="card">
			<section class="section dashboard">

				<div
					style="display: flex; align-items: center; justify-content: space-between;"
				>
					<h1>생산 실적 조회</h1>

					<!--등록  버튼  -->
					<div>
						<button type="button" class="btn btn-outline-primary"
							data-bs-toggle="modal" data-bs-target="#workProdRegiModal"
						>등록</button>
					</div>
					<!-- 					<div class="form-check form-switch">
						<input class="form-check-input" type="checkbox" role="switch"
							id="flexSwitchCheckDefault"
						> <label class="form-check-label" for="flexSwitchCheckDefault"></label>
					</div> -->
				</div>


				<div
					style="display: flex; align-items: center; justify-content: space-between; margin: 20px 50px;"
				>

					<button id="dateLeftBtn" type="button" class="btn btn-primary">
						<i class="bi bi-caret-left-fill"></i>
					</button>
					<div>
						<label for="start"></label> <input type="date"
							class="prodItemDate" id="startDate" value="2024-03-01"
						>&nbsp;&nbsp;~&nbsp;&nbsp;<label for="end"></label> <input
							type="date" class="prodItemDate" id="endDate" value="2024-03-07"
						>
					</div>

					<button id="dateRightBtn" type="button" class="btn btn-primary">
						<i class="bi bi-caret-right-fill"></i>
					</button>
				</div>

				<table class="table table-hover">
					<thead>
						<tr>
							<th scope="col">생산 완료 일자</th>
							<th scope="col">등록된 생산 지시 번호</th>
							<th scope="col">제품명</th>
							<th scope="col">예정 수량</th>
							<th scope="col">불량 수량</th>
						</tr>
					</thead>
					<tbody>
						<tr data-bs-toggle="modal" data-bs-target="#prodItemModal">
							<th scope="row">2024-04-12</th>
							<td>WPR202404120001</td>
							<td>불닭</td>
							<td>28</td>
							<td>4</td>

						</tr>
						<tr data-bs-toggle="modal" data-bs-target="#prodItemModal">
							<th scope="row">2024-04-13</th>
							<td>WPR202404120002</td>
							<td>참깨</td>
							<td>35</td>
							<td>6</td>
						</tr>
					</tbody>
				</table>



				<!-- Start workProdRegiModal -->
				<div class="modal fade" id="workProdRegiModal" tabindex="-1"
					style="display: none;" aria-hidden="true"
				>
					<div class="modal-dialog modal-dialog-centered modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title">생산 실적 실적 등록</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"
								></button>
							</div>
							<div class="modal-body">

								<!-- Start modal body -->
								<form>

									<div class="row mb-3">
										<label class="col-sm-2 col-form-label">생산 지시 번호</label>
										<div class="col-sm-10">

											<button class="btn btn-secondary dropdown-toggle"
												type="button" id="dropdownMenuButton"
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false"
											>생산 지시 번호 선택</button>
											<ul class="dropdown-menu"
												aria-labelledby="dropdownMenuButton"
											>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110001"
												>WPR202404110001</a></li>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110002"
												>WPR202404110002</a></li>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110003"
												>WPR202404110003</a></li>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110004"
												>WPR202404110004</a></li>
											</ul>

										</div>
									</div>

									<div class="row mb-3">
										<label for="inputDate" class="col-sm-2 col-form-label">생산
											완료 일자</label>
										<div class="col-sm-10">
											<input id="prodEndDate" type="date" class="form-control"
												value="2024-04-12" required
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="inputText" class="col-sm-2 col-form-label">제품명</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="붉닭라면(buldak001)"
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="expectedQty" class="col-sm-2 col-form-label">예정
											생산 수량</label>
										<div class="col-sm-10">
											<input id="expectedQty" type="number" class="form-control"
												readonly value=50000
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="actualQty" class="col-sm-2 col-form-label">실제
											생산 수량</label>
										<div class="col-sm-10">
											<input id="actualQty" type="number" class="form-control"
												value=49990 required
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="defectiveQty" class="col-sm-2 col-form-label">불량
											수량</label>
										<div class="col-sm-10">
											<input id="defectiveQty" type="number" class="form-control"
												required
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="inputTextarea" class="col-sm-2 col-form-label">불량
											내역</label>
										<div class="col-sm-10">
											<textarea class="form-control" style="height: 100px">불닭이 너무매움</textarea>
										</div>
									</div>

								</form>

							</div>
							<!-- End modal body -->

							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal"
								>닫기</button>
								<button type="button" class="btn btn-primary">등록</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End modal -->




				<!-- Start prodItemModal -->
				<div class="modal fade" id="prodItemModal" tabindex="-1"
					style="display: none;" aria-hidden="true"
				>
					<div class="modal-dialog modal-dialog-centered modal-xl">
						<div class="modal-content">
							<div class="modal-header">
								<h1 class="modal-title">생산 실적 상세</h1>
								<button type="button" class="btn-close" data-bs-dismiss="modal"
									aria-label="Close"
								></button>
							</div>
							<div class="modal-body">

								<!-- Start modal body -->
								<form>

									<div class="row mb-3">
										<label class="col-sm-2 col-form-label">생산 지시 번호</label>
										<div class="col-sm-10">

											<button class="btn btn-secondary dropdown-toggle"
												type="button" id="dropdownMenuButton"
												data-bs-toggle="dropdown" aria-haspopup="true"
												aria-expanded="false"
											>생산 지시 번호 선택</button>
											<ul class="dropdown-menu"
												aria-labelledby="dropdownMenuButton"
											>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110001"
												>WPR202404110001</a></li>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110002"
												>WPR202404110002</a></li>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110003"
												>WPR202404110003</a></li>
												<li><a class="dropdown-item" href="#"
													data-value="WPR202404110004"
												>WPR202404110004</a></li>
											</ul>

										</div>
									</div>

									<div class="row mb-3">
										<label for="inputDate" class="col-sm-2 col-form-label">생산
											완료 일자</label>
										<div class="col-sm-10">
											<input id="prodEndDate" type="date" class="form-control"
												value="2024-04-12" required
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="inputText" class="col-sm-2 col-form-label">제품명</label>
										<div class="col-sm-10">
											<input type="text" class="form-control"
												value="붉닭라면(buldak001)"
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="expectedQty" class="col-sm-2 col-form-label">예정
											생산 수량</label>
										<div class="col-sm-10">
											<input id="expectedQty" type="number" class="form-control"
												readonly value=50000
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="actualQty" class="col-sm-2 col-form-label">실제
											생산 수량</label>
										<div class="col-sm-10">
											<input id="actualQty" type="number" class="form-control"
												required value=49990
											>
										</div>
									</div>

									<div class="row mb-3">
										<label for="defectiveQty" class="col-sm-2 col-form-label">불량
											수량</label>
										<div class="col-sm-10">
											<input id="defectiveQty" type="number" class="form-control"
												required
											>
										</div>
									</div>


									<div class="row mb-3">
										<label for="inputTextarea" class="col-sm-2 col-form-label">불량
											내역</label>
										<div class="col-sm-10">
											<textarea class="form-control" style="height: 100px">불닭이 너무매움</textarea>
										</div>
									</div>

								</form>

							</div>
							<!-- End modal body -->

							<div class="modal-footer">
								<button type="button" class="btn btn-secondary"
									data-bs-dismiss="modal"
								>닫기</button>

								<button type="button" class="btn btn-outline-primary"
									onclick="alert('정말로 삭제하시겠습니까?')">삭제</button>
								<button type="button" class="btn btn-primary">저장</button>
							</div>
						</div>
					</div>
				</div>
				<!-- End modal -->


			</section>
		</div>
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


</body>

</html>