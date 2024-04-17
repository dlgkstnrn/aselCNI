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
<script defer src="assets/js/jtu/jtuProdItem.js"></script>
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
			<h1>생산 관리</h1>
			<nav>
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#">생산 관리</a></li>
					<li class="breadcrumb-item active">생산 실적</li>
				</ol>
			</nav>
		</div>
		<!-- End Page Title -->
		<section class="section dashboard h-max">
			<div class="card">
				<div class="card-body">

					<!--등록  버튼  -->
					<div class="d-flex align-items-end justify-content-between">
						<span class="h5 d-flex align-items-center card-header-title">생산 실적</span>
                     	<button id="regiModalBtn" type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#workProdRegiModal">신규</button>
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
								<button class="btn btn-primary px-0 w-100"
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
								<th scope="col">실제 생산 수량</th>
								<th scope="col">불량 생산 수량</th>
							</tr>
						</thead>
						<tbody id="prodItemTbody">
							<c:choose>
								<c:when test="${jpriList.size() != 0}">
									<c:forEach var="pri" items="${jpriList}">
										<tr data-bs-toggle="modal" data-bs-target="#prodItemEditModal" style="cursor:pointer;">
											<th scope="row">${pri.proditem_no}</th>
											<td>${pri.workprod_no}</td>
											<td>${pri.proditem_end_dt}</td>
											<td>${pri.item_nm}(${pri.item_cd})</td>
											<td>${pri.wh_nm}(${pri.wh_cd})</td>
											<td><fmt:formatNumber value="${pri.pln_qty}" type="number" /></td>
											<td><fmt:formatNumber value="${pri.prod_qty}" type="number" /></td>
											<td><fmt:formatNumber value="${pri.bad_qty}" type="number" /></td>
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
										onsubmit="return validateRegiForm()" method="post"
									>

										<div class="row mb-3">
											<label class="col-sm-2 col-form-label label-marquee"><span
												class="moving-text"
											>생산 지시 번호<span class="text-danger">*</span></span></label>
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
												><span class="moving-text">생산 지시 일자<span class="text-danger">*</span></span></label>
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
											> <span class="moving-text">생산 실적 담당자<span class="text-danger">*</span></span></label>
											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="empRegiModal" type="text" class="form-control" required="required"
														name="proditem_emp_id" value="${sessionScope.user_id }"
													>
												</div>


												<label for="prodEndDateRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												> <span class="moving-text">생산 완료 일자<span class="text-danger">*</span></span>
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
											><span class="moving-text">입고 창고<span class="text-danger">*</span></span></label>
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
													<span class="moving-text moving-animation">제품을 넣어둘 창고를 선택</span>
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
											>제품명<span class="text-danger">*</span></label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="hiddenItemCdRegiModal" type="hidden"
														name="item_cd" class="form-control" value=""
													> <input id="itemNameRegiModal" type="text"
														class="form-control" required="required" disabled
													>
												</div>


												<label for="expectedQtyRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">예정 생산 수량<span class="text-danger">*</span></span></label>
												<div class="col-sm-5">
													<input id="hiddenExpQtyRegiModal" type="hidden"
														name="pln_qty" class="form-control"
													> <input id="expectedQtyRegiModal" type="number" required="required"
														class="form-control" disabled="disabled"
													>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label for="actualQtyRegiModal"
												class="col-sm-2 col-form-label label-marquee"
											><span class="moving-text">실제 생산 수량<span class="text-danger">*</span></span></label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="actualQtyRegiModal" type="number"
														min="0"
														name="prod_qty" class="form-control" required
													>
												</div>
												<label for="defectiveQtyRegiModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">불량 생산 수량<span class="text-danger">*</span></span></label>
												<div class="col-sm-5">
													<input id="defectiveQtyRegiModal" type="number"
														min="0"
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
											> <span class="moving-text">생산 실적 담당자<span class="text-danger">*</span></span></label>
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
											><span class="moving-text">입고 창고<span class="text-danger">*</span></span></label>
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
														 class="form-control"
													>
													<input id="hiddenExpectedQtyEditModal" type="hidden"
														name="pln_qty" class="form-control" 
													>
												</div>
											</div>
										</div>

										<div class="row mb-3">
											<label for="actualQtyEditModal"
												class="col-sm-2 col-form-label label-marquee"
											><span class="moving-text">실제 생산 수량<span class="text-danger">*</span></span></label>

											<div class="d-flex justify-content-between col-sm-10">
												<div class="col-sm-4">
													<input id="actualQtyEditModal" type="number"
														name="prod_qty" class="form-control" value="" required
													>
												</div>
												<label for="defectiveQtyEditModal"
													class="col-sm-2 col-form-label text-end label-marquee"
												><span class="moving-text">불량 생산 수량<span class="text-danger">*</span></span></label>
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
													<tr id="trowBadModal" style="cursor:pointer;">
														<td class="checkbox-center"><input class="badCheckBox" type="checkbox"
															name="selectedBad"
														></td>
														<th scope="row"></th>
														<td></td>
														<td class="checkbox-center" style="display: none;"><input type="checkbox"
														></td>
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
										<!-- <button id="" type="button" onclick="deleteSelectedBad()" class="btn btn-primary">삭제</button> -->
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

<script type="text/javascript">/* sc1 */
	
	
</script>
</html>