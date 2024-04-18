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
    <link href="assets/css/kph/returnAddForm.css" rel="stylesheet" type="text/css">
     
     <!-- Script -->
    <script defer src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/main.js"></script>
    <script defer src="assets/js/kph/returnUpdateForm.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>

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
                    <li class="breadcrumb-item"><a href="/return">반품 관리</a></li>
					<li class="breadcrumb-item active">반품 수정</li>
                </ol>
            </nav>
        </div><!-- End Page Title -->
		
		<input type="hidden" name="url" value="${url }" />
		<section class="section dashboard">
			<div class="card">
				<p>반품 정보 입력</p>
				<form action="/returnUpdate" method="post">
					<input type="hidden" name="return_no" value="${returnObj.return_no }" />
					<input type="hidden" name="return_seq_no" value="${returnObj.return_seq_no }" />
					<div>
						<p>출고번호<span class="color-red">*</span></p>
						<div class="outitem-box box">
							<input name="outitem_no" type="text" class="outitem-no form-control readonly" value="${returnObj.outitem_no }" readonly />
						</div>
						<p class="return-alert outitem-no-alert">출고 번호를 조회하세요</p>
					</div>
					<div>
						<p>고객사<span class="color-red">*</span></p>
                        <input name="cust_cd" type="hidden" class="cust-cd form-control" value="${returnObj.cust_cd }" />
						<input name="cust_nm" type="text" class="cust-nm form-control readonly" value="${returnObj.cust_nm }" readonly />
						<p class="return-alert cust-cd-alert">출고 번호를 조회하세요</p>
					</div>
					<div>
						<p>고객사 담당자<span class="color-red">*</span></p>
						<input name="cust_emp" type="text" class="form-control" value="${returnObj.cust_emp }" />
						<p class="return-alert cust-emp-alert">고객사 담당자를 입력하세요</p>
					</div>
					<div>
						<p>제품코드<span class="color-red">*</span></p>
						<div class="item-box box">
							<input name="item_cd" type="text" class="box-input item-cd form-control readonly" value="${returnObj.item_cd }" readonly/>
							<button id="choose-item-btn" type="button" class="chk btn btn-secondary">제품 선택</button>
						</div>
						<p class="return-alert item-cd-alert">제품코드를 선택하세요</p>
					</div>
					<div class="item-nm-box">
						<p>제품명<span class="color-red">*</span></p>
						<input name="item_nm" type="text" class="form-control readonly" value="${returnObj.item_nm }" readonly/>
						<p class="return-alert item-cd-alert">제품코드를 선택하세요</p>
					</div>
					<div>
						<p>반품수량<span class="color-red">*</span></p>
						<input name="max_qty" type="hidden" class="max-qty form-control" value="${returnObj.max_qty }" />
						<input name="qty" type="text" class="item_qty form-control" value="${returnObj.qty }" />
						<p class="return-alert qty-alert">반품 수량을 입력하세요</p>
					</div>
					<div>
						<p>반품 사유<span class="color-red">*</span></p>
						<input name="res_rtn" type="text" class="form-control" value="${returnObj.res_rtn }" />
						<p class="return-alert res-rtn-alert">반품 사유를 입력하세요</p>
					</div>
					<div>
						<p>비고</p>
						<input name="remark" type="text" class="form-control" value="${returnObj.remark }" />
					</div>
					<div class="text-center">
						<button type="submit" class="return-update-btn btn btn-primary">저장</button>
						<button type="button" class="return-cancle-btn btn btn-secondary">취소</button>
					</div>
				</form>
			</div>
			<div class="out-item-choice-box">
                <div class="out-item-choice-box-title">출고 번호 조회</div>
                <div class="out-item-choice-box-body">
                    <div class="out-item-search-box">
                        <div class="out-item-search-filter">
                            <div class="out-item-no-search">
                                <input id="out-item-no-search-text" type="text" placeholder="검색어를 입력하세요">
                                <button id="out-item-no-search-btn">
                                    <i class="bi bi-search"></i>
                                </button>
                            </div>
                            <select name="search-filter" class="search-filter form-select">
                                <option value="all" selected>전체</option>
                                <option value="outitem_no">출고번호</option>
                                <option value="order_no">주문번호</option>
                                <option value="cust_nm">고객사명</option>
                                <option value="outitem_emp_nm">담당자명</option>
                            </select>
                        </div>
                        <select name="date-search-filter" class="date-search-filter form-select">
                            <option value="all">전체</option>
                            <option value="30day" selected>30일</option>
                            <option value="7day">7일</option>
                            <option value="1day">1일</option>
                        </select>
                    </div>
                    <div class="out-item-list-box">
                        <ul>
                        </ul>
                    </div>
                </div>
                <div class="out-item-btn-list text-center">
                    <button type="button" class="out-item-cancle-btn btn btn-secondary">취소</button>
                </div>
            </div>
            <div class="item-choice-box">
                <div class="item-choice-box-title">제품 선택</div>
                <div class="item-category-search-box">
                    <input id="item-search-text" type="text" placeholder="제품명을 입력하세요">
                    <button id="item-search-btn">
                        <i class="bi bi-search"></i>
                    </button>
                </div>
                <div class="item-list-box">
                    <ul>
                    </ul>
                </div>
                <div class="item-btn-list text-center">
					<button type="button" class="item-cancle-btn btn btn-secondary">취소</button>
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