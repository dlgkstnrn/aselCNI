 <%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>주문 등록</title>
<!-- Favicons -->
<link href="assets/img/favicon.png" rel="icon">

<!-- Google Fonts -->
<link href="https://fonts.gstatic.com" rel="preconnect">
<link
	href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
	rel="stylesheet">
<!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
<!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
	crossorigin="anonymous"></script>
<script
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
</head>
<body>

	<!-- ======= Header ======= -->
	<%@ include file="../header.jsp"%>

	<!-- ======= Sidebar ======= -->
	<%@ include file="../asidebar.jsp"%>

	<!-- End Sidebar-->
	<main id="main" class="main">
		<div class="card">
            <div class="card-body">
              <!-- <h5 class="card-title">주문 등록</h5> -->
				<form class="row m-1">
             		<div class="row mb-12">
                  		<label for="inputOrdCD" class="col-sm-2 col-form-label">주문 번호</label>
                 		<div class="col-sm-10">
                    		<input type="text" class="form-control" id="inputText">
                  		</div>
                	</div>
                	

              			<div class="row mb-6 m-2">
				    		<label for="inputTime" class="col-sm-1 col-form-label">착수일</label>
				    		<div class="col-sm-5">
				        		<input type="date" class="form-control">
				    		</div>
				    		<label for="inputTime" class="col-sm-1 col-form-label">납기일</label>
				    		<div class="col-sm-5">
				        		<input type="date" class="form-control">
				    		</div>	
						</div>
				<div class="row mb-6">
				    <label for="inputTime" class="col-sm-1 col-form-label">매입처</label>
				   <!--  <div class="col-sm-5">
				        <input type="text" class="form-control">
				    </div> -->
				    <div class="col-sm-5">
				    <select id="inputState" class="form-select">
	                    <option selected="">Choose...</option>
	                    <option>...</option>
                  </select>
				    
				    </div>
				    <label for="inputTime" class="col-sm-1 col-form-label">담당자</label>
				    <div class="col-sm-5">
				        <input type="text" class="form-control">
				    </div>
				</div>
						
              		</div>
			
			
			</div>
              </form><!-- End Multi Columns Form -->

            </div>
          </div>


			<div class="card">
			<div class="card-header">주문등록</div>
			<div class="card-body">
				<%-- <h5 class="card-title">주문등록</h5> --%>
				<!-- 제품등록 Modal -->
				<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#disablebackdrop">추가</button>
				<!-- 모달 추가할 주문 목록내용 입력 -->
				<div class="modal fade  modal-lg" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false" style="display: none;" aria-hidden="true">
					<div class="modal-dialog modal-dialog-centered w-100">
						<div class="modal-content">
							<div class="modal-header"> 
								<h5 class="modal-title">주문 물품 등록</h5>
								<button type="button" class="btn-close" data-bs-dismiss="modal"></button>
							</div>
							<div class="modal-body">
								<form action="forms/contact.php" method="post" class="php-email-form">
								<form class="row-2">
								
                					
									
									
									

                <div class="col-md-6">
                  <label for="inputPassword5" class="form-label">Password</label>
                  <input type="password" class="form-control" id="inputPassword5">
                </div>
                <div class="col-12">
                  <label for="inputAddress5" class="form-label">매입처</label>
                  <input type="text" class="form-control" id="inputAddres5s" placeholder="1234 Main St">
                </div>
                <div class="col-12">
                  <label for="inputAddress2" class="form-label">담당자</label>
                  <input type="text" class="form-control" id="inputAddress2" placeholder="Apartment, studio, or floor">
                </div>
                <div class="col-md-6">
                  <label for="inputCity" class="form-label">City</label>
                  <input type="text" class="form-control" id="inputCity">
                </div>
                <div class="col-md-4">
                  <label for="inputState" class="form-label">물품코드</label>
                  <select id="inputState" class="form-select">
                    <option selected="">Choose...</option>
                    <option>...</option>
                  </select>
                </div>
                <div class="col-md-2">
                  <label for="inputZip" class="form-label">Zip</label>
                  <input type="text" class="form-control" id="inputZip">
                </div>
                <div class="col-12">
                  <div class="form-check">
                    <input class="form-check-input" type="checkbox" id="gridCheck">
                    <label class="form-check-label" for="gridCheck">
                      Check me out
                    </label>
                  </div>
                </div>
              </form>
											</form>

								</div>
								<div class="modal-footer">
									<button type="button" class="btn btn-primary">Save
										changes</button>
								</div>
							</div>
						</div>
					</div>
					<!-- End Disabled Backdrop Modal-->




					<!-- 페이지 이동 버튼 -->
					<nav aria-label="Page navigation example">
						<ul class="pagination">
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Previous"> <span aria-hidden="true">«</span>
							</a></li>
							<li class="page-item"><a class="page-link" href="#">1</a></li>
							<li class="page-item"><a class="page-link" href="#">2</a></li>
							<li class="page-item"><a class="page-link" href="#">3</a></li>
							<li class="page-item"><a class="page-link" href="#"
								aria-label="Next"> <span aria-hidden="true">»</span>
							</a></li>
						</ul>
					</nav>
					<!-- End Pagination with icons -->
				</div>
			</div>


		

	</main>
	<!-- End #main -->

	<!-- ======= Footer ======= -->
	<%@ include file="../footer.jsp"%>
	<!-- End Footer -->

	<a href="#"
		class="back-to-top d-flex align-items-center justify-content-center"><i
		class="bi bi-arrow-up-short"></i></a>

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