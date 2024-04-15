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
<link href="assets/css/jtu/jtuProdItemView.css" rel="stylesheet"
	type="text/css"
>

<!-- Script -->
<script src="assets/js/jquery-3.7.1.min.js"></script>
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"
></script>


<!--sc1  -->

</head>

<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->

	<main id="main" class="main">

		<div class="pagetitle">
			<h1>생산 실적 조회</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">생산 관리</a></li>
					<li class="breadcrumb-item active">생산 실적 조회</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		<section class="section dashboard h-max">
			<div class="card">
				<div class="card-body">

					<!--등록  버튼  -->
					<div class="d-flex align-items-end justify-content-between">
						<h4>
							<span class="d-flex align-items-center">생산 실적 조회</span>
						</h4>
						<div
							class="col-sm-2 d-flex align-items-center justify-content-end"
						>

							<button id="regiModalBtn" type="button"
								class="btn btn-primary m-2" data-bs-toggle="modal"
								data-bs-target="#workProdRegiModal"
							>신규</button>
						</div>
					</div>
					<hr>



					<!-- 검색 s1 -->
					<div class="container text-center m-4">
						<div class="row">
							<div class="col-md-7">
								<div class="input-group">
									<button id="dateLeftBtn" type="button" class="btn btn-primary">
										<i class="bi bi-caret-left-fill"></i>
									</button>

									<input id="startDate" type="date" aria-label="startDate"
										class="form-control prodItemDate"
										onchange="changeData('startDate', this.value)"
									> <input id="endDate" type="date" aria-label="endDate"
										onchange="changeData('endDate', this.value)"
										class="form-control prodItemDate"
									>
									<button id="dateRightBtn" type="button" class="btn btn-primary">
										<i class="bi bi-caret-right-fill"></i>
									</button>
								</div>
							</div>
							<div class="col-md-5">
								<div class="input-group">
									<span class="input-group-text">생산실적담당자</span> <input
										id="prodItemEmpSearch"
										onchange="changeData('proditem_emp_id',this.value)"
										type="text" class="form-control" placeholder="생산실적담당자"
										aria-label="생산실적담당자" aria-describedby="button-addon2"
									>
								</div>
							</div>
						</div>

						<div class="row mt-1">
							<div class="col-md-6">
								<div class="input-group">
									<span class="input-group-text">생산실적번호</span> <input
										id="prodItemNoSearch"
										onchange="changeData('proditem_no',this.value)" type="text"
										class="form-control" placeholder="생산실적번호" aria-label="생산실적번호"
										aria-describedby="button-addon5"
									>
								</div>
							</div>
							<div class="col-md-6">
								<div class="input-group">
									<span class="input-group-text">생산지시번호</span> <input
										id="workProdNoSearch"
										onchange="changeData('workprod_no',this.value)" type="text"
										class="form-control" placeholder="생산지시번호" aria-label="생산지시번호"
										aria-describedby="button-addon6"
									>
								</div>
							</div>
						</div>

						<div class="row mt-1">
							<div class="col-md-6">
								<div class="input-group">
									<span class="input-group-text">창고번호</span> <input
										id="whNoAndNameSearch"
										onchange="changeData('whNoAndNameKeyword',this.value)"
										type="text" class="form-control" placeholder="창고번호&이름"
										aria-label="창고번호&이름" aria-describedby="button-addon3"
									>
								</div>
							</div>
							<div class="col-md-5">
								<div class="input-group">
									<span class="input-group-text">제품번호</span> <input
										id="itemNoAndNameSearch"
										onchange="changeData('itemNoAndNameKeyword',this.value)"
										type="text" class="form-control" placeholder="제품번호&이름"
										aria-label="제품번호&이름" aria-describedby="button-addon4"
									>
								</div>
							</div>
							<div class="col-md-1 text-end">
								<button class="btn btn-primary btn-sm px-0 w-100"
									style="height: 100%;" onclick="getPriListAjax(1)"
								>조회</button>
							</div>
						</div>


					</div>

					<table class="table table-hover">
						<thead>
							<tr>
								<th scope="col">생산 실적 번호</th>
								<th scope="col">생산 지시 번호</th>
								<th scope="col">생산 완료 일자</th>
								<th scope="col">제품명</th>
								<th scope="col">창고명</th>
								<th scope="col">예정 생산 수량</th>
								<th scope="col">불량 생산 수량</th>
							</tr>
						</thead>
						<tbody id="prodItemTbody">
							<c:choose>
								<c:when test="${jpriList.size() != 0}">
									<c:forEach var="pri" items="${jpriList}">
										<tr data-bs-toggle="modal" data-bs-target="#prodItemEditModal">
											<th scope="row">${pri.proditem_no}</th>
											<td>${pri.workprod_no}</td>
											<td>${pri.proditem_end_dt}</td>
											<td>${pri.item_nm}(${pri.item_cd})</td>
											<td>${pri.wh_nm}(${pri.wh_cd})</td>
											<td>${pri.pln_qty}</td>
											<td>${pri.bad_qty}</td>
										</tr>
									</c:forEach>
								</c:when>
								<c:otherwise>
									<tr>
										<td colspan="7"><span> 해당하는 생산 실적이 조회되지 않습니다.</span></td>
									</tr>
								</c:otherwise>
							</c:choose>
						</tbody>
					</table>


					<!--pagenation p1  -->
					<nav aria-label="Page navigation example">
						<ul id="paginationUl" class="pagination justify-content-center">
							<c:choose>
								<c:when test="${paging.total!=0}">
									<li id="prevPageLi" class="page-item">
										<button class="page-link" onclick="prevPage()"
											aria-label="Previous"
										>
											<span aria-hidden="true">&lt;</span>
										</button>
									</li>
									<c:forEach var="item" begin="${paging.startPage}"
										end="${paging.endPage }"
									>
										<li class="page-item pageNum"><button class="page-link"
												onclick="goPage('${item}')"
											>${item}</button></li>
									</c:forEach>
									<li id="nextPageLi" class="page-item">
										<button id="nextPageBtn" class="page-link"
											onclick="nextPage(this)"
											data-total-page="${paging.totalPage }" aria-label="Next"
										>
											<span aria-hidden="true">&gt;</span>
										</button>
									</li>
								</c:when>
								<c:otherwise>
									<li id="prevPageLi" class="page-item" style="display: none;">
										<button class="page-link" onclick="prevPage()"
											aria-label="Previous"
										>
											<span aria-hidden="true">&lt;</span>
										</button>
									</li>
									<li id="nextPageLi" class="page-item" style="display: none;">
										<button id="nextPageBtn" class="page-link"
											onclick="nextPage(this)"
											data-total-page="${paging.totalPage }" aria-label="Next"
										>
											<span aria-hidden="true">&gt;</span>
										</button>
									</li>
								</c:otherwise>
							</c:choose>
						</ul>
					</nav>



					<!-- Start workProdRegiModal ---ㅡ1-m1-->
					<div class="modal fade" id="workProdRegiModal" tabindex="-1"
						style="display: none;" aria-hidden="true"
					>
						<div class="modal-dialog modal-dialog-centered modal-xl">
							<div class="modal-content p-16">
								<div class="modal-header">
									<h1 class="modal-title">생산 실적 등록</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"
									></button>
								</div>
								<div class="modal-body">

									<!-- Start modal body -->
									<form id="workProdRegiForm" action="submitWorkProdRegiModal"
										method="post"
									>

										<div class="row mb-3">
											<label class="col-sm-2 col-form-label label-marquee"><span
												class="moving-text"
											>생산 지시 번호</span></label>
											<div class="d-flex justify-content-between col-sm-10">

												<button
													class="btn btn-secondary dropdown-toggle col-sm-4 label-marquee"
													type="button" id="workProdNoRegiModal"
													data-bs-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false"
												>
													<span class="moving-text">생산 지시 번호 선택</span>
												</button>
												<input id="hiddenWorkProdNoRegiModal" type="hidden"
													name="workprod_no"
												>
												<ul id="workProdNoRegiModalList"
													class="dropdown-menu col-sm-3"
													aria-labelledby="workProdNoRegiModal"
												>
												</ul>

												<label for="workStartDateRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">생산 지시 일자</span></label>
												<div class="col-sm-5">
													<input id="workStartDateRegiModal" type="date"
														class="form-control" required disabled
													>
												</div>

											</div>
										</div>

										<div class="row mb-3">
											<label for="empRegiModal"
												class="col-sm-2 col-form-label label-marquee"
											> <span class="moving-text">생산 실적 담당자</span></label>
											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="empRegiModal" type="text" class="form-control"
														name="proditem_emp_id" value="jtu"
													>
												</div>


												<label for="prodEndDateRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												> <span class="moving-text">생산 완료 일자</span>
												</label>
												<div class="col-sm-5">
													<input id="prodEndDateRegiModal" type="date"
														name="proditem_end_dt" class="form-control" required
													>
												</div>
											</div>
										</div>


										<div class="row mb-3">
											<label for="prodItemWHRegiModal"
												class="col-sm-2 col-form-label label-marquee"
											><span class="moving-text">입고 창고</span></label>
											<div class="col-sm-10">
												<input id="hiddenProdItemWHCdRegiModal" type="hidden"
													name="wh_cd" class="form-control"
												>
												<button
													class="btn btn-secondary dropdown-toggle col-sm-12 label-marquee"
													type="button" id="prodItemWHRegiModal"
													data-bs-toggle="dropdown" aria-haspopup="true"
													aria-expanded="false"
												>
													<span class="moving-text moving-animation">제품을 넣어둘
														창고를 선택</span>
												</button>
												<ul id="whListRegiModal" class="dropdown-menu col-sm-9"
													aria-labelledby="prodItemWHRegiModal"
												>
												</ul>

											</div>
										</div>

										<div class="row mb-3">
											<label for="itemNameRegiModal"
												class="col-sm-2 col-form-label"
											>제품명</label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="hiddenItemCdRegiModal" type="hidden"
														name="item_cd" class="form-control" value="buldak001"
													> <input id="itemNameRegiModal" type="text"
														class="form-control" disabled
													>
												</div>


												<label for="expectedQtyRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">예정 생산 수량</span></label>
												<div class="col-sm-5">
													<input id="hiddenExpQtyRegiModal" type="hidden"
														name="pln_qty" class="form-control"
													> <input id="expectedQtyRegiModal" type="number"
														class="form-control" disabled="disabled"
													>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label for="actualQtyRegiModal"
												class="col-sm-2 col-form-label label-marquee"
											><span class="moving-text">실제 생산 수량</span></label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="actualQtyRegiModal" type="number"
														name="prod_qty" class="form-control" required
													>
												</div>
												<label for="defectiveQtyRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">불량 생산 수량</span></label>
												<div class="col-sm-5">
													<input id="defectiveQtyRegiModal" type="number"
														name="bad_qty" class="form-control" required
													>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label for="badCdRegiModal"
												class="col-sm-2 col-form-label label-marquee"
											> <span class="moving-text">불량 코드</span>
											</label>
											<div class="d-flex justify-content-between col-sm-10">

												<button id="badRegiModalBtn" type="button"
													onclick="openBadModal()" class="btn btn-primary"
												>
													<span>코드 선택</span>
												</button>
											</div>
										</div>
										<div class="row mb-3">
											<!--불량 번호, 불량 내역 둘다 검색으로 찾게하기  -->
											<!--불량 추가는 모달로 한번더.  -->
											<!--불량코드 리스트를 클릭, 더블클릭하면 또하나 아래 테이블에 옮겨가게 하기
										불량 코드랑, 불량 내역 각각 리스트?로 된거 서비스쪽에서 pribad객체로 변환 -->
											<label for="" class="col-sm-2 col-form-label"></label>
											<div class="row category-search-list-container col-sm-10">
												<table class="table category-search-list table-hover">
													<thead>
														<tr>
															<th scope="col">No.</th>
															<th scope="col">불량 코드</th>
															<th scope="col">불량 코드 내역</th>
														</tr>
													</thead>
													<tbody id="badListRegiModal" class="badListTbody">
														<tr>
															<td colspan="3">불량 내역이 발생하였다면 코드를 선택해주세요</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>

										<div class="row mb-3">
											<label for="remarkRegiModal" class="col-sm-2 col-form-label">비고</label>
											<div class="col-sm-10">
												<textarea id="remarkRegiModal" class="form-control"
													name="remark" style="height: 100px"
												>비고 비었음</textarea>
											</div>
										</div>

									</form>

								</div>
								<!-- End modal body -->

								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal"
									>닫기</button>
									<button type="submit" form="workProdRegiForm"
										class="btn btn-primary"
									>등록</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End modal -->




					<!-- Start prodItemEditModal------------m2-------------------->
					<div class="modal fade" id="prodItemEditModal" tabindex="-1"
						style="display: none;" aria-hidden="true"
						data-bs-backdrop="static" data-bs-keyboard="false"
					>
						<div class="modal-dialog modal-dialog-centered modal-xl">
							<div class="modal-content">
								<div class="modal-header">
									<h1 id="titleProdItemEditModal" class="modal-title">생산 실적 상세</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"
									></button>
								</div>
								<div class="modal-body p-4">

									<!-- Start prodItemEditModal body -->
									<form id="prodItemEditForm" action="submitProdItemEditModal"
										method="post"
									>

									<input id="hiddenProdItemEditModal" type="hidden" name="proditem_no">
										<div class="row mb-3">
											<label class="col-sm-2 col-form-label label-marquee"><span
												class="moving-text"
											>생산 지시 번호</span></label>
											<div class="d-flex justify-content-between col-sm-10">

												<button class="btn btn-secondary col-sm-4 label-marquee"
													type="button" id="workProdNoEditModal"
												>
													<span class="moving-text">생산 지시 번호 선택</span>
												</button>
												 <label for="proditemUpdateEditModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">등록 및 수정일</span></label>
												<div class="col-sm-5">
													<input id="proditemUpdateEditModal" type="date"
														class="form-control" value="2024-04-01" required
													>
												</div>

											</div>
										</div>

										<div class="row mb-3">
											<label for="empEditModal"
												class="col-sm-2 col-form-label label-marquee"
											> <span class="moving-text">생산 실적 담당자</span></label>
											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="empEditModal" type="text" class="form-control"
														name="proditem_emp_id" value="jtu"
													>
												</div>


												<label for="prodEndDateEditModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												> <span class="moving-text">생산 완료 일자</span>
												</label>
												<div class="col-sm-5">
													<input id="prodEndDateEditModal" type="date"
														name="proditem_end_dt" class="form-control" required
													>
												</div>
											</div>
										</div>


										<div class="row mb-3">
											<label for="prodItemWHEditModal"
												class="col-sm-2 col-form-label label-marquee"
											><span class="moving-text">입고 창고</span></label>
											<div class="col-sm-10">
												<input id="hiddenProdItemWHCdEditModal" type="hidden"
													name="wh_cd" class="form-control" value=""
												>
												<button class="btn btn-secondary col-sm-12 label-marquee"
													type="button" id="prodItemWHEditModal"
												>
													<span class="moving-text moving-animation"></span>
												</button>
												<ul id="whListEditModal" class="dropdown-menu col-sm-9"
													aria-labelledby="prodItemWHEditModal"
												>
												</ul>
											</div>
										</div>


										<div class="row mb-3">
											<label for="itemNameEditModal"
												class="col-sm-2 col-form-label"
											>제품명</label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="hiddenItemCdEditModal" type="hidden"
														name="item_cd" class="form-control" value=""
													> <input id="itemNameEditModal" type="text"
														class="form-control" value=""
													>
												</div>


												<label for="expectedQtyEditModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">예정 생산 수량</span></label>
												<div class="col-sm-5">
													<input id="expectedQtyEditModal" type="number"
														name="pln_qty" class="form-control" value=""
													>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label for="actualQtyEditModal"
												class="col-sm-2 col-form-label label-marquee"
											><span class="moving-text">실제 생산 수량</span></label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="actualQtyEditModal" type="number"
														name="prod_qty" class="form-control" value="" required
													>
												</div>
												<label for="defectiveQtyEditModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">불량 생산 수량</span></label>
												<div class="col-sm-5">
													<input id="defectiveQtyEditModal" type="number"
														name="bad_qty" class="form-control" required
													>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label for="defectiveLogEditModal"
												class="col-sm-2 col-form-label"
											><span class="moving-text">불량 내역</span></label>
											<div class="d-flex justify-content-between col-sm-10">

												<button id="badEditModalBtn" type="button" onclick="openBadModal()" class="btn btn-primary">
													<span>코드 선택</span>
												</button>
											</div>
										</div>
										
										<div class="row mb-3">
											<label for="" class="col-sm-2 col-form-label"></label>
											<div class="row category-search-list-container col-sm-10">
												<table class="table category-search-list table-hover">
													<thead>
														<tr>
															<th scope="col">No.</th>
															<th scope="col">불량 코드</th>
															<th scope="col">불량 코드 내역</th>
														</tr>
													</thead>
													<tbody id="badListEditModal" class="badListTbody">
														<tr>
															<td colspan="3">제품에 발생한 불량이 없습니다.</td>
														</tr>
													</tbody>
												</table>
											</div>
										</div>
										

										<div class="row mb-3">
											<label for="remarkEditModal" class="col-sm-2 col-form-label">비고</label>
											<div class="col-sm-10">
												<textarea id="remarkEditModal" class="form-control"
													name="remark" style="height: 100px"
												>비고 비었음</textarea>
											</div>
										</div>

									</form>

								</div>
								<!-- End modal body -->

								<div class="modal-footer">
									<button type="button" class="btn btn-secondary"
										data-bs-dismiss="modal"
									>닫기</button>
									<button id="editModaldeleteBtn" type="button"
										class="btn btn-primary"
									>삭제</button>
									<button id="editModalEditBtn" type="button"
										class="btn btn-primary"
									>수정</button>
									<button id="editModalUpdateBtn" type="submit"
										form="prodItemEditForm" class="btn btn-primary"
										style="display: none;"
									>저장</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End modal -->


					<!-- Start badModal------------m3-------------------->
					<div class="modal fade" id="badModal" tabindex="-1"
						aria-hidden="true"
					>
						<div class="modal-dialog modal-dialog-centered modal-xl">
							<div class="modal-content" style="min-height: 507px;">
								<div class="modal-header">
									<h1 class="modal-title">불량 코드 관리</h1>
									<button type="button" class="btn-close" data-bs-dismiss="modal"
										aria-label="Close"
									></button>
								</div>
								<div class="modal-body p-4">

									<!-- Start badModal body -->
									<div class="container text-center">

										<div class="row mt-1">
											<div class="col-md-5">
												<div class="input-group">
													<span class="input-group-text">불량 코드</span> <input
														id="badCdBadModal" type="text" class="form-control"
														placeholder="불량 코드" aria-label="불량 코드"
														aria-describedby="button-addon3"
														oninput="getBadList( '' , this.value, $('#badResBadModal').val())"
													>
												</div>
											</div>
											<div class="col-md-6">
												<div class="input-group">
													<span class="input-group-text">불량 내역</span> <input
														id="badResBadModal" type="text" class="form-control"
														placeholder="불량 내역" aria-label="불량 내역"
														aria-describedby="button-addon4"
														oninput="getBadList( '' , $('#badCdBadModal').val(), this.value)"
													>
												</div>
											</div>
											<button class="btn btn-primary px-0 col-md-1"
												onclick="submitBadModal()" style="height: 100%;"
											>기타</button>
										</div>

										<div class="row category-search-list-container col-sm-12">
											<table class="table category-search-list table-hover">
												<thead>
													<tr>
														<th scope="col">선택</th>
														<th scope="col">불량 코드</th>
														<th scope="col">불량 코드 내역</th>
													</tr>
												</thead>
												<tbody id="badListBadModal">
													<tr id="trowBadModal">
														<td class="checkbox-center"><input type="checkbox"
															name="selectedBad"
														></td>
														<th scope="row">1</th>
														<td>자재 예시 1</td>
													</tr>

												</tbody>
											</table>
										</div>


									</div>
									<!-- End modal body -->

									<div class="modal-footer">
										<button type="button" class="btn btn-secondary"
											data-bs-dismiss="modal"
										>닫기</button>
										<button id="" type="button" class="btn btn-primary">삭제</button>
										<button id="" type="button" onclick="moveSelectedBad()"
											class="btn btn-primary"
										>선택</button>
									</div>
								</div>
							</div>
						</div>
						<!-- End modal -->

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


</body>

<script type="text/javascript">
	let startDate = $('#startDate').val();
	let endDate = $('#endDate').val();
	let proditem_emp_id="";
	let proditem_no="";
	let workprod_no="";
	let whNoAndNameKeyword="";
	let itemNoAndNameKeyword="";
	let currentPage=1;
	
	let badCdKeyword="";
	let badResKeyword="";
	let bad_cd="";
	let bad_res="";

	let selectedRows = []; // 체크된 행의 데이터를 저장할 리스트
	const data = {
		startDate,
		endDate,
		proditem_no,
		workprod_no,
		proditem_emp_id,
		whNoAndNameKeyword,
		itemNoAndNameKeyword,
		currentPage,
		
		badCdKeyword,
		badResKeyword,
		bad_cd,
		bad_res
	}

	function changeData(key, value){
		data[key] = value;
		console.log(data[key], value);
	}

	//modal 예상수량-실제수량=불량수량
	$(document).ready(function() {
				// RegiModal에 대한 설정
				setupModalQty("#expectedQtyRegiModal", "#actualQtyRegiModal",
						"#defectiveQtyRegiModal");

				// EditModal에 대한 설정
				setupModalQty("#expectedQtyEditModal", "#actualQtyEditModal",
						"#defectiveQtyEditModal");
			});
	//예상수량-실제수량=불량수량 함수
	function setupModalQty(expQty, actQty, defQty) {
		// expectedQty, actualQty 값이 변경될 때마다 defectiveQty를 업데이트
		$(expQty + ", " + actQty).on("input",
						function() {
							let expectedQty = parseInt($(expQty)
									.val()) || 0;
							let actualQty = parseInt($(actQty).val()) || 0;
							let defectiveQty = expectedQty - actualQty;
							$(defQty).val(defectiveQty);
						});

		// defectiveQty 값이 변경될 때마다 actualQty를 업데이트
		$(defQty).on("input", function() {
			let expectedQty = parseInt($(expQty).val()) || 0;
			let defectiveQty = parseInt($(this).val()) || 0;
			let actualQty = expectedQty - defectiveQty;
			$(actQty).val(actualQty);
		});
	}

	
	//닫기 버튼 클릭시 modal 입력 내용 클리어
	$(document).ready(function() {
		$('button[data-bs-dismiss="modal"]').on('click', function() {
		
		});
	});
	
	//클리어 함수
	function modalContentClear() {
		$('#workProdNoRegiModal').text("생산 지시 번호를 선택");
		$(".modal-content input").val('');
		$(".modal-content textarea").val('');
	}


	//로딩시 날짜 설정
	$(document).ready(function() {
		inputToday("#startDate");
		
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();
		
		let startDt = new Date(startDate);
		let endDt = new Date(startDate);
		
		endDt.setDate(startDt.getDate()+7);
		
		endDate = endDt.toISOString().slice(0,10);
		$('#endDate').val(endDate);
		
		console.log("endDt",endDt);
		console.log("endDate",endDate);
		
		//시작 날짜와 종료 날짜 논리 일관성
		$('#startDate').on('change', function() {
			 startDate = $('#startDate').val();
			 endDate = $('#endDate').val();

			if (startDate > endDate) {
				$('#startDate').val(endDate);
			}
		});
		
		//시작 날짜와 종료 날짜 논리 일관성
		$('#endDate').on('change', function() {
			 startDate = $('#startDate').val();
			 endDate = $('#endDate').val();

			if (startDate > endDate) {
				$('#endDate').val(startDate);
			}
		});
	});

	// 좌우 버튼 누를 때마다 날짜 7일 단위로 바뀜, 
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
		startDate = $('#startDate').val();
		endDate = $('#endDate').val();

		// Date 객체로 변환
		let startDt = new Date(startDate);
		let endDt = new Date(endDate);

		// 방향에 따라 날짜를 조정
		if (direction === 'right') {
			startDt.setDate(startDt.getDate() + 7);
			endDt.setDate(endDt.getDate() + 7);
		} else if (direction === 'left') {
			startDt.setDate(startDt.getDate() - 7);
			endDt.setDate(endDt.getDate() - 7);
		}

		// 새로운 날짜를 입력 필드에 설정
		$('#startDate').val(startDt.toISOString().slice(0, 10));
		$('#endDate').val(endDt.toISOString().slice(0, 10));
		
		changeData('startDate', startDate);
		changeData('endDate', endDate);
	}

	//모달 창이 좁아지면 텍스트가 움직이게 설정
	$(document).ready(function() {
		adjustMarquee();
		$(window).on('resize', adjustMarquee);

		// 모달이 완전히 보여진 후에 실행
		$('#workProdRegiModal').on('shown.bs.modal', adjustMarquee);
		$('#prodItemEditModal').on('shown.bs.modal', adjustMarquee);
	});
	
	
	//모달 창이 좁아지면 텍스트가 움직이게하는 함수
	function adjustMarquee() {
		$('.label-marquee').each(function() {
			const label = $(this); // 현재 label
			const text = label.find('.moving-text'); // 현재 label 내의 .moving-text

			// 조건을 검사하여 애니메이션을 적용하거나 제거
			if (text.width() > label.width()) {
				text.addClass('moving-animation'); // 너비가 label보다 클 경우, 애니메이션 클래스 추가
			} else {
				text.removeClass('moving-animation'); // 그렇지 않다면, 애니메이션 클래스 제거
			}
		});
	}
	
	
	//dropdown 기능 
	$(document).ready(function() {
		$('#workProdNoRegiModal').dropdown();
		$('#prodItemWHRegiModal').dropdown();
		$('#prodItemWHEditModal').dropdown();
	});
	

	//등록버튼 눌렀을때
	$(document).ready(function() {
	    $("#regiModalBtn").click(function() {
	    	//오늘날짜 넣기
	    	inputToday("#prodEndDateRegiModal",);
	    	//창고 리스트 넣어줌
	    	getWHListModal("RegiModal");
	    })
	})

	//오늘 날짜 넣어주는 함수
	function inputToday(tagId){
		let todayLong= new Date();
		let today = todayLong.toISOString().slice(0,10)

		
		$(tagId).val(today);
	}
	
	//창고 리스트 불러오는 함수
	function getWHListModal(modalType) {
	    var ulSelector = "";
	    var itemSelector = "";
	    var hiddenSelector = "";
	
	    if (modalType === "RegiModal") {
	        ulSelector = "#whListRegiModal";
	        itemSelector = "#prodItemWHRegiModal";
	        hiddenSelector = "#hiddenProdItemWHCdRegiModal";
	    } else if (modalType === "EditModal") {
	        ulSelector = "#whListEditModal";
	        itemSelector = "#prodItemWHEditModal";
	        hiddenSelector = "#hiddenProdItemWHCdEditModal";
	    }
	
	    $(ulSelector).find("li").remove();
	    $.ajax({
	        url: 'getWHListModal',
	        method: 'POST',
	        dataType: 'json',
	        success: function(whList) {
	            console.log("whList", whList);
	            let ulTag = $(ulSelector); 
	            $.each(whList, function(index, wh) {
	                let liTag = $("<li></li>");
	                let aTag = $("<a></a>", {
	                    "class": "dropdown-item",
	                    "href": "#",
	                    "data-val": wh.wh_cd,
	                    "text": wh.wh_nm + '(' + wh.wh_cd + ')'
	                });
	
	                liTag.append(aTag); 
	                ulTag.append(liTag);
	            });
	
	            $(ulSelector + " a").click(function(){
	                $(itemSelector).text($(this).text());
	                $(hiddenSelector).val($(this).data('val'));
	
	                console.log(hiddenSelector, $(hiddenSelector).val());
	            });
	        },
	        error : function(xhr, status, error) {
	            console.error("Error occurred: " + error);
	        }
	    });
	}


	//리스트 불러오고 생산 지시번호를 선택하면, 자동 텍스트 입력
	$(document).ready(function() {
	    $("#workProdNoRegiModal").click(function() {
	        $.ajax({
	            url : 'getWorkProdNoRegiModalList',
	            method : 'POST',
	            dataType : 'json',
	            success : function(wprList) {
	                console.log("wprList", wprList);
	                let ulTag = $("#workProdNoRegiModalList");
	                ulTag.empty(); 
	                $.each(wprList, function(index, wpr) {
	                    let liTag = $("<li></li>");
	                    let aTag = $("<a></a>", {
	                        "class": "dropdown-item",
	                        "href": "#",
	                        "data-value": wpr.workprod_no,
	                        "text": wpr.workprod_no
	                    });
	                    liTag.append(aTag); 
	                    ulTag.append(liTag); 
	                });//each
                    
        			$('#workProdNoRegiModalList a').on('click', function() {
        				let selectedValue = $(this).attr('data-value');
        				let foundWpr = wprList.find(wpr => wpr.workprod_no == selectedValue);
        				console.log("foundWpr", foundWpr);
        				
        				$('#workProdNoRegiModal').text(selectedValue);
        				$('#hiddenWorkProdNoRegiModal').val(selectedValue);
       				    $('#workStartDateRegiModal').val(foundWpr.workprod_dt);
       				    $('#hiddenItemCdRegiModal').val(foundWpr.item_cd);
       				    $('#itemNameRegiModal').val(foundWpr.item_nm+"("+foundWpr.item_cd+")");
       				    $('#expectedQtyRegiModal').val(foundWpr.qty);
       				    $('#hiddenExpQtyRegiModal').val(foundWpr.qty);
       				    
        				
        			});
	            },//success
	            error : function(xhr, status, error) {
	            }
	        });//ajax
	       
	    });
	});
	
	
	//조회 테이블 행 클릭시 modal 수정창으로 이동
	$(document).on('click', 'tr[data-bs-target="#prodItemEditModal"]', function() {
	    let prodNo = $(this).find('th:nth-child(1)').text();
	    getPriOneAjax(prodNo);
	});
	
	//pri 선택하면 상세 보기
	function getPriOneAjax(prodNo){
		data.proditem_no=prodNo;
		
		$.ajax({
			url : "getPriOneAjax",
			method : "POST",
			data,
			dataType : "json",
			success : function(pri){
				console.log("pri",pri)
				
				$('#titleProdItemEditModal').text(pri.proditem_no);
				$('#hiddenProdItemEditModal').val(pri.proditem_no);
				$('#workProdNoEditModal').text(pri.workprod_no);
				$('#proditemUpdateEditModal').val(pri.proditem_update);
				$('#empEditModal').val(pri.proditem_emp_id);
				$('#prodEndDateEditModal').val(pri.proditem_end_dt);
				$('#prodItemWHEditModal').text(pri.wh_nm+'('+pri.wh_cd+')');
				$('#hiddenProdItemWHCdEditModal').val(pri.wh_cd);
				$('#itemNameEditModal').val(pri.item_nm+'('+pri.item_cd+')');
				$('#hiddenItemCdEditModal').val(pri.item_cd);
				$('#expectedQtyEditModal').val(pri.pln_qty);
				$('#actualQtyEditModal').val(pri.prod_qty);
				$('#defectiveQtyEditModal').val(pri.bad_qty);
				$('#remarkEditModal').val(pri.remark);
				
				if(pri.jpriBadList.length !=0){
					$('#badListEditModal').empty();
					selectedRows=[];
				    $.each(pri.jpriBadList, function(index, row) {
				        var trTag = $('<tr></tr>');
				        trTag.append('<th scope="row">' + (index + 1) + '</th>'); // 인덱스를 1부터 시작하도록 설정
				        trTag.append('<td>' + row.bad_cd + '<input type="hidden" name="jpriBadList[' + index +'].bad_cd" value="' + row.code + '"></td>'); 
				        trTag.append('<td>' + row.bad_res + '</td>');
				        $('#badListEditModal').append(trTag);
				        
                        selectedRows.push({ // 예시로 행의 체크박스와 불량 코드를 객체로 저장
                        	
                            code: row.bad_cd, // 불량 코드 
                            res : row.bad_res // 불량 코드 내역
                        });
				    });
				}
				
				let disabledList=[$('#workProdNoEditModal'),$('#proditemUpdateEditModal'),$('#empEditModal'),$('#prodEndDateEditModal'),$('#prodItemWHEditModal'),$('#itemNameEditModal'),
					$('#expectedQtyEditModal'),$('#actualQtyEditModal'),$('#defectiveQtyEditModal'),$('#badEditModalBtn'),$('#remarkEditModal')];
				
				disabledOnoff(disabledList, true)
				
			},//success
            error : function(xhr, status, error) {
            }
		})//ajax
		
	}
	// 수정 버튼 누르면 isDisabled
	function disabledOnoff(list, isDisabled) {
	    list.forEach(item => {
	        item.prop("disabled", isDisabled);
	    });
	}

	//priList 가져오는 함수 p2
	function getPriListAjax(page){
		data.startDate = $('#startDate').val();
		data.endDate = $('#endDate').val();
		data.currentPage= page;

		console.log("data", data);

		$.ajax({
			url : "getPriListAjax",
			method : "POST",
			data,
			dataType : "json",
			success : function(jpriMap){
				console.log("jpriMap",jpriMap);
				$("#prodItemTbody").empty();
				$('.pageNum').empty();
				
				
	            if(jpriMap.priList.length!=0){
	            	$("#prevPageLi").show();
	            	$("#nextPageLi").show();
	            } else{
	            	$("#prevPageLi").hide();
	            	$("#nextPageLi").hide();
	            	$("#prodItemTbody").append("<tr><td colspan='7'>해당하는 생산 실적이 조회되지 않습니다.</td></tr>")
	            }

	            $.each(jpriMap.priList, function(index, pri) {
	            	$("#prodItemTbody").append(
                        '<tr data-bs-toggle="modal" data-bs-target="#prodItemEditModal">' +
                        '<th scope="row">' + pri.proditem_no + '</th>' +
                        '<td>' + pri.workprod_no + '</td>' +
                        '<td>' + pri.proditem_end_dt + '</td>' +
                        '<td>' + pri.item_nm +'('+pri.item_cd+')</td>' +
                        '<td>' + pri.wh_nm +'('+pri.wh_cd+')</td>' +
                        '<td>' + pri.pln_qty + '</td>' +
                        '<td>' + pri.bad_qty + '</td>' +
                        '</tr>'
                    );
	            });
	            
	           

		            for (let i = jpriMap.paging.startPage; i <= jpriMap.paging.endPage; i++) {
		            	$('#nextPageLi').before(
		            		    '<li class="page-item pageNum"><button class="page-link" onclick="goPage( '+ i +' )">' + i + '</button></li>'
		            		);

		            }
	            $("#nextPageBtn").attr("data-total-page", jpriMap.paging.totalPage);
	            

	            
				
			},//success
            error : function(xhr, status, error) {
            	console.error("Error occurred: " + error);
            }
		});//ajax
	}
	
	//수정 버튼 눌렀을 때 로직
	$(document).ready(function() {
		$("#editModalEditBtn").click(function(){
			let disabledList=[$('#empEditModal'),$('#prodEndDateEditModal'),$('#prodItemWHEditModal'),
				$('#actualQtyEditModal'),$('#defectiveQtyEditModal'),$('#badEditModalBtn'),$('#remarkEditModal')];
			
			disabledOnoff(disabledList, false);
			
			$("#prodItemWHEditModal").attr("data-bs-toggle","dropdown");
			$("#expectedQtyEditModal").attr("readonly","");
			getWHListModal("EditModal");
			
			$("#editModalEditBtn").hide();
			$("#editModalUpdateBtn").show();
		})
	})
	
	//닫기 버튼 or X 버튼 눌렀을 때, 수정 버튼 눌렀을때 로직
	$(document).ready(function() {
		  $('#prodItemEditModal').on('hidden.bs.modal', function () {
			
			$("#prodItemWHEditModal").attr("data-bs-toggle","");
			
			$("#editModalEditBtn").show();
			$("#editModalUpdateBtn").hide();
		});
	})
	
	//삭제 버튼 눌렀을 때 로직
	$(document).ready(function() {
		$("#editModaldeleteBtn").click(function(){
			alert("생산 실적 삭제는 관리자를 호출해주세요.");
			data.workprod_no=$("#hiddenWorkProdNoEditModal").val();
			
			$.ajax({
				url : "deleteProdItemEditModal",
				method : 'POST',
				data,
				dataType : "json",
				success : function(){
					
				},//success
					error : function(xhr, status, error) {
					    console.error("Error occurred: " + error);
					}
			})//ajax
		})

	})
	
	//불량 코드, 내역 추가 함수
	function badInsertRegiModal(){
		data.badCdKeyword=$("#badCdRegiModal").val();
		data.badResKeyword=$("#badResRegiModal").val();
		
		$.ajax({
			url : "deleteProdItemEditModal",
			method : 'POST',
			data,
			dataType : "json",
			success : function(){
				
			},//success
				error : function(xhr, status, error) {
				    console.error("Error occurred: " + error);
				}
		})//ajax
	}
	
	
	

/* 	$(document).ready(function() {
		//badModal 닫힐때 regiModal 나오게 하기
	    $('#badModal').on('hidden.bs.modal', function (e) {
	        $('#workProdRegiModal').modal('show');
	    });

	}) */
	
		//코드 선택 눌렀을때 모달 체인지
	function openBadModal() {
   		/* $('#workProdRegiModal').modal('hide'); */
        $('#badModal').modal('show');

    	//불량 코드 리스트 넣어줌
   		getBadList();
	}
	
	
		//불량 코드 리스트 불러오는 함수
	function getBadList(prodItemNo, badCd, badRes) {
	    data.proditem_no=prodItemNo;
		data.badCdKeyword=badCd;
	    data.badResKeyword=badRes;
	    
	    $.ajax({
	        url: 'getBadListModal',
	        method: 'POST',
	        data,
	        dataType: 'json',
	        success: function(badList) {
	            let tbodyTag = $("#badListBadModal"); 
	           
	            tbodyTag.empty();
	            
            	
	        	if(badList.length==0){
	        		let trTag = $("<tr></tr>");
	        		trTag.append("<td colspan='3'> 해당하는 코드가 없습니다. 추가 하고 싶으시다면 코드와 내역을 입력하고, 기타 버튼을 눌러주세요 </td>");
	        		tbodyTag.append(trTag); 
	        	}
	            
	            $.each(badList, function(index, bad) {
	    
	            	let trTag = $("<tr></tr>");
	                trTag.append('<td class="checkbox-center"><input type="checkbox"></td>'); 
	                trTag.append("<td>" + bad.bad_cd + "</td>"); 
	                trTag.append("<td>" + bad.bad_res + "</td>"); 
	                tbodyTag.append(trTag); 
	            });
	            
	            // 리스트가 새로 로드된 후에 저장된 항목들을 기반으로 체크박스 체크
	            $('#badListBadModal tr').each(function() {
	                let tr = $(this);
	                let badCd = tr.find('td:nth-child(2)').text();
	                
	                let isSelected = selectedRows.some(row => row.code === badCd);

	                if (isSelected) {
	                    tr.find('input[type="checkbox"]').prop('checked', true);
	                }
	            });
	            
	            
	            
                // 체크박스 클릭 이벤트
                $('#badListBadModal tr').click(function(e) {
                    var checkbox = $(this).find('input[type="checkbox"]');
                    
                    // 행이 아닌 체크박스를 직접 클릭한 경우에도 동작하도록 예외 처리
                    if (!$(e.target).is('input')) {
                        checkbox.prop('checked', !checkbox.prop('checked'));
                    }
                    
                    // 체크박스가 체크되면 리스트에 추가, 아니면 리스트에서 제거
                    if (checkbox.prop('checked')) {
                        selectedRows.push({ // 예시로 행의 체크박스와 불량 코드를 객체로 저장
                            checkbox: checkbox,
                            code: $(this).find('td:nth-child(2)').text(), // 불량 코드 
                            res : $(this).find('td:nth-child(3)').text() // 불량 코드 내역
                        });
                        console.log("selectedRows", selectedRows);
                    } else {
                        selectedRows = selectedRows.filter(function(row) {
                            return row.code !== $(this).find('td:nth-child(2)').text();
                        }.bind(this)); // 현재 컨텍스트(this)를 filter 함수 내부로 바인딩
                        console.log("selectedRows", selectedRows);
                    }
                });
	            


	        },
	        error : function(xhr, status, error) {
	            console.error("Error occurred: " + error);
	        }
	    });//ajax
	}
	
	//선택된 행을 다른 테이블로 이동
	function moveSelectedBad(){
		$('.badListTbody').empty();
		$('#badModal').modal('hide');
		
	    // selectedRows 배열을 순회하며 tbody에 항목을 추가
	    $.each(selectedRows, function(index, row) {
	        var trTag = $('<tr></tr>');
	        trTag.append('<th scope="row">' + (index + 1) + '</th>'); // 인덱스를 1부터 시작하도록 설정
	        trTag.append('<td>' + row.code + '<input type="hidden" name="jpriBadList[' + index +'].bad_cd" value="' + row.code + '"></td>'); 
	        trTag.append('<td>' + row.res + '</td>');
	        $('.badListTbody').append(trTag);
	    });
	}
	
	
	
	// 기타 버튼을 눌렀을 때 불량 코드를 추가하는 함수
	function submitBadModal() {
	    if ($('#badCdBadModal').val() === "" || $('#badResBadModal').val() === "") {
	        alert("코드와 내역을 입력해주세요");
	    } else {
	        let result = confirm("코드를 추가 하시겠습니까? 코드를 다시 한번 확인해주세요");
	        if (result) {
	            // 대문자로 입력되도록 설정
	            let data = {
	                bad_cd: $('#badCdBadModal').val().toUpperCase(),
	                bad_res: $('#badResBadModal').val()
	            };
	            $.ajax({
	                url: 'submitBadModal',
	                method: 'POST',
	                data: data,
	                dataType: 'json',
	                success: function () {
	                    alert('불량코드 추가 성공');
	                },
	                error: function (xhr, status, error) {
	                    console.error("Error occurred: " + error);
	                }
	            }); // ajax
	        }
	    }
	}

	//paging
	function goPage(currentPage){
		changeData("currentPage",currentPage)
		
		console.log("currentPage",currentPage);
		console.log("data.currentPage",data.currentPage);
		
		getPriListAjax(currentPage);
	}
	

	function nextPage(ele){
		if(data.currentPage==ele.dataset.totalPage){
			alert('마지막 페이지 입니다.')
			
		} else{
			
		data.currentPage= data.currentPage*1+1;
		
		console.log("currentPage",currentPage);
		console.log("data.currentPage",data.currentPage);
		
		getPriListAjax(data.currentPage);
		}
	}
	
	function prevPage(){
		if(data.currentPage==1){
			alert('첫번째 페이지 입니다.');
		} else{
		
		data.currentPage= data.currentPage*1-1;
		
		console.log("currentPage",currentPage);
		console.log("data.currentPage",data.currentPage);
		
		getPriListAjax(data.currentPage);
		}
	}
	

	
</script>
</html>