<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
	<meta charset="UTF-8">
	<title>스마트 제조 시스템</title>
	<!-- Favicons -->
	<link href="assets/img/favicon.png" rel="icon">
	
	<!-- Google Fonts -->
	<link href="https://fonts.gstatic.com" rel="preconnect">
	<link
		href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
		rel="stylesheet">
	
	<script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
	<!-- Vendor CSS Files -->
	<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
		rel="stylesheet">
	<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
		rel="stylesheet">
	
	<link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
	<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
	<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
	<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">
	<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
	
	<!-- CSS File -->
	<link href="assets/css/style.css" rel="stylesheet" type="text/css">
	
	<!-- Script -->
	<script defer src="assets/js/main.js"></script>
	<script type="module" src="assets/js/jdj/jdjOrdModule.js"></script>
	<script  src="assets/js/jdj/jdjOrdReg.js"></script>
	<script src="assets/js/jdj/jdjOrdSpec.js"></script>

</head>
<body>
<!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>
    <!-- ======= Sidebar ======= -->
    <%@ include file="../asidebar.jsp" %>
    
    <main id="main" class="main">
    	<div class="pagetitle">
            <h1>영업 관리</h1>
            <nav>
                <ol class="breadcrumb">
                    <li class="breadcrumb-item">영업 관리</li>
                    <li class="breadcrumb-item active"><a href="/order">주문 조회</a></li>
                    <li class="breadcrumb-item active">주문 상세</li>
                </ol>
            </nav>
        </div> <!-- page title -->
        <form action=""method="post"></form>
        <section class="section dashboard">
        	<div class="card">		
		        <div class="container">
	        		<div class="card-body">
		        		<div class="d-flex align-items-center">
							<span class="h5 me-auto card-header-title">주문 상세</span>
						</div><hr>
        				<!--<c:if test="${orderSpec.order_status_chk == 0}"> -->
	        				<!-- 수정 버튼  -->
			        		<!-- <div class="d-grid gap-2 d-md-flex justify-content-md-end  py-2"> -->
			        			<!-- 주문 수정을 눌렀을 때 활성화 -->
								<!-- <button class="btn btn-outline-secondary btn px-4" type="reset">취소</button> -->
								<!-- <button class="d-inline-flex align-items-center btn btn-primary btn px-4" type="button">수정</button>
								<button class="d-inline-flex align-items-center btn btn-primary btn px-4" type="button">주문 취소</button>
							</div>
       					</c:if> -->
       					<!-- 입력 폼 -->
						<div class="row mb-3">
							<div class="col-sm-1"></div>
							<label class="col-sm-1 col-form-label">주문번호</label>
							<div class="col-sm-3">
								<input id="order_no" type="text" class="form-control" value=${orderSpec.order_no} disabled>
							</div>
							<div class="col-sm-1"></div>
							
							<label for="inputText" class="col-sm-1 col-form-label">담당자명</label>
							<div class="col-sm-1"></div>
							<div class="col-sm-3">
								<input id="order_emp_id" type="text" class="form-control" value=${orderSpec.user_nm} disabled="disabled">
							</div>
						</div>
        		
						<div class="row mb-3">
							<div class="col-1"> </div>
							<label for="order_dt" class="col-sm-1 col-form-label">착수일</label>
							<div class="col-sm-3">
								<input id="order_dt" type="date" class="form-control"  value=${orderSpec.order_dt} disabled="disabled" >
							</div>
							<div class="col-1"> </div>
							<label class="col-sm-1 col-form-label">매출처</label>
							<div class="col-1"> </div>
							<div class="col-sm-3">
								<input id="cust_cd" type="text" class="form-control" value="${orderSpec.cust_nm}" disabled="disabled">
							</div>
						</div>
        		
						<div class="row mb-3">
							<div class="col-1"> </div>
							<label for="order_end_dt" class="col-sm-1 col-form-label">납기일</label>
							<div class="col-sm-3">
								<input id="order_end_dt" type="date" class="form-control" value=${orderSpec.order_end_dt}>
							</div>
							<div class="col-1"> </div>
							<label for="inputText" class="col-sm-2 col-form-label">매출처 담당자</label>
							<div class="col-sm-3">
								<input id="cust_emp" type="text" class="form-control" value="${orderSpec.cust_emp}">
							</div>
							<div class="col-1"> </div>
							
						</div>
        		
						<div class="row mb-3">
							<div class="col-1"></div>
							<label for="inputPassword" class="col-sm-1 col-form-label">비고</label>
							<div class="col-sm-9">
								<textarea id="order_remark" class="form-control" style="height: 100px">${orderSpec.remark}</textarea>
							</div>
							<div class="col-1"></div>
						</div>
						
        				<c:if test="${orderSpec.order_status_chk == 0}">
							<div class="d-flex gap-2 justify-content-center py-2">
								<button id="delOrd"  value="${ orderSpec.order_no}" class="btn btn-danger btn px-4 rounded-pill" type="button">주문 취소</button>
								<button id="modiOrd" class="d-inline-flex align-items-center btn btn-primary btn px-4 rounded-pill" type="button">수정</button>
							</div>
						</c:if>
					<p>
						<div class="col-12">
		                	<label for="inputNanme4" class="form-label">주문 품목 </label>
		                	<%-- <c:set></c:set> --%>
		                 	<table class="table table-hover text-center">
								<thead><tr>
									<th scope="col"></th>
									<th scope="col">제품코드</th>
									<th scope="col">제품명</th>
									<th scope="col">단위</th>
									<th scope="col">수량</th>
									<th scope="col">단가</th>
									<th scope="col">금액</th>
								</tr></thead>
								<tbody  id="itemTB2">
									<c:forEach var = "orderItem" items = "${orderItems}" varStatus="status">
									<tr class="${orderItem.item_cd}">
										<td><input class="checkBox form-check-input" type="checkbox" id="chkBtn" style="display: none"></td>
										<td id="item_cd">${orderItem.item_cd}</td>
										<td id="item_nm">${orderItem.item_nm}</td>
										<td id="item_unit">${orderItem.item_unit}</td>
										<td><div class="btn-group border-1" role="group">
							                <button  onclick="decreaseCnt2('${orderItem.item_cd}')"  id="decreaseBtn2" type="button" class="decreaseBtn2 btn btn-light" style="display: none"><i class="bi bi-dash"></i></button>
							                <button id="${orderItem.item_cd}" type="button" class="btn btn-light" disabled>${orderItem.qty}</button>
							                <button onclick="increaseCnt2('${orderItem.item_cd}')" id="increaseBtn2" type="button" class="increaseBtn2 btn btn-light" style="display: none"><i class="bi bi-plus"></i></button>
	             						</div></td>
										<td id="$item_cost">${orderItem.item_cost}</td>
										<td id="${orderItem.item_cd}_cost2">${orderItem.cost}</td>
										<%-- <td id="'${orderItem.item_cd}'_cost">${orderItem.cost}</td> --%>
									</tr>									
									</c:forEach>
								</tbody>
							</table>
							
							<div id="totalAmount" style="margin-top: 20px;">
						    	합계 금액 : <span id="totalPrice"></span>
							</div>
							
		                </div> <!-- col-12, 품목 리스트 -->
		                <c:if test="${orderSpec.order_status_chk == 0}">
							<div class="d-grid gap-2 d-md-flex justify-content-md-end">
								<button id="itemDel2" class="btn btn-danger me-md-2" type="button"><i class="bi bi-trash3-fill"></i> 삭제</button>
								<button id="itemAdd2" type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#disablebackdrop">
									<i class="bi bi-bag-plus-fill"></i> 추가
	              				</button>
							</div>
						</c:if>
					</div>  <!-- card-body1 -->	
						
					<!-- 제품 입력 모달 -->
					<div class="modal fade modal-lg" id="disablebackdrop" tabindex="-1" data-bs-backdrop="false" aria-hidden="true" style="display: none;">
	                	<div class="modal-dialog modal-dialog-centered">
	                  		<div class="modal-content">
	                    		<div class="modal-header">
									<h5 class="modal-title"> 주문 제품 등록</h5>
									<button type="button" id="closeBtn2" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                    		</div> <!-- modal-header -->
	                    		<div class="modal-body">
	                    		
	                    		<div class="row g-3">
					                
					                <div class="col-md-5">
						                  <label for="selItem_cd2" class="form-label">제품코드</label>
						                  <input type="text" class="form-control" id="selItem_cd2" disabled value="${itemMst.item_cd}">
						                </div>
						                <div class="col-md-7">
						                  <label for="item_nm2" class="form-label">제품명</label>
						                  <select id="item_nm2" class="form-select">
						                  	<option selected value = "">제품명 선택</option>
						                  	<c:forEach var = "itemMst" items="${itemMsts}" varStatus="status">
						                    	<option id="order_item_cd" value="${itemMst.item_cd }" >${itemMst.item_nm}</option>
						                    </c:forEach>
						                  </select>
						                </div>
						                <div class="col-md-3">
						                  <label for="item_unit2" class="form-label">단위</label>
						                  <input type="text" disabled class="form-control" id="item_unit2">
						                </div>
						                <div class="col-md-3">
						                  <label for="order_qty2" class="form-label">수량</label>
						                  <input type="number" class="form-control" id="order_qty2">
						                </div>
						                <div class="col-md-3">
						                  <label for="item_cost2" class="form-label">단가</label>
						                  <input type="number" disabled class="form-control" id="item_cost2">
						                </div>
						                <div class="col-md-3">
						                  <label for="order_item_cost2" class="form-label">금액</label>
						                  <input type="number"class="form-control" disabled="disabled" id="order_item_cost2">
						                </div>

					              </div>
             
                    			</div>
	                    		<div class="modal-footer">
		                      			<button id="ord_item_saveBtn2" type="button" class="btn btn-primary"> 저장 </button>
	                    		</div> <!-- modal-footer -->
	                  		</div>  <!-- modal-content -->
                		</div>  <!-- modal-dialog -->
               		</div> <!-- modal fade -->	       			
		        </div> <!-- content -->
        	</div> <!-- card -->
        </section>
    </main>   
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