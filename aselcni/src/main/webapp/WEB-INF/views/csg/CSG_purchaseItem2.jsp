<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

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
    <!--     <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" type="text/css">

    <!-- Script -->
	<script defer src="assets/js/main.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  	<script src="assets/js/csg/purchaseSave.js"></script> <!-- 발주등록폼에서 저장 누르면 폼 저장 -->
  	<script defer src="assets/js/csg/modalCategory.js"></script> <!-- 모달 대중소분류 -->
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
                <li class="breadcrumb-item"><a href="#">기준 정보 관리</a></li>
                <li class="breadcrumb-item active">사업장 관리</li>
              </ol>
            </nav>
          </div><!-- End Page Title -->

			<section class="section dashboard w-full">
			    <form id="purchaseItem2" action="purchaseSave" method="post">
			        <!-- 자재 정보 입력 폼 -->
			        <!--<div id="SK_itemForm" class="flex items-center justify-center min-h-screen bg-red-800"> 외부배경 회색-->
			        <div id="SK_itemForm" class="min-h-screen w-full"> <!-- 외부배경 회색 -->
			
			            <div id="content" class="bg-white p-4 shadow-lg rounded boarder-8 border-red-500">
			                <!-- 발주 등록 섹션 -->
			                <div id="orderRegistration" class="container p-4">
			                    <h2 class="text-2xl font-bold mb-4">
			                        <i class="fas fa-clipboard-list fa-lg text-primary"></i>
			                        발주 등록
			                    </h2>
			
			                    <!-- 입력 필드 그룹 -->
			                    <div class="row row-cols-1 row-cols-md-2 row-cols-lg-4 g-4">
			
			                        <!-- 발주번호 -->
			                        <div class="border border-green-500">
			                            <label for="order-number" class="form-label text-lg text-gray-700 font-bold mb-2">발주번호</label>
			                            <input id="order-number" type="text" placeholder="발주번호는 뷰에서 생성해주고 여기는 readOnly가 되야함"
			                                class="form-control">
			                        </div>
		
			                        <!-- 매입처 -->
			                        <div class="border border-green-500">
			                            <label for="supplier" class="form-label text-lg text-gray-700 font-bold mb-2">매입처</label>
			                            <select id="supplier" class="form-select">
			                                <option>TB_CUSTMST에서 CUST_NM</option>
			                                <option>업체A</option>
			                                <option>업체B</option>
			                                <option>업체B</option>
			                                <option>업체B</option>
			                                <option>업체B</option>
			                                <option>업체B</option>
			                                <!-- 추가 업체 옵션 -->
			                            </select>
			                        </div>
			
			                        <!-- 거래처 담당자 -->
			                        <div class="border border-green-500">
			                            <label for="manager-name" class="form-label text-lg text-gray-700 font-bold mb-2">거래처 발주담당자 TB_PURCHASE의 CUST_EMP</label>
			                            <input id="manager-name" type="text" placeholder="거래처 담당자 입력" class="form-control">
			                        </div>
			
			                        <!-- 비고 -->
			                        <div class="border border-green-500">
			                            <label for="remark" class="form-label text-lg text-gray-700 font-bold mb-2">비고</label>
			                            <input id="remark" type="text" placeholder="필요한 내용을 입력" class="form-control">
			                        </div>
			
			                    </div>
			

			                </div>

							
							
			        
						    <div id="materialsTableSection" class="container w-7/8 p-4">
						        <h2 class="text-2xl font-bold mb-4">
						            <i class="fas fa-clipboard-list fa-lg text-primary"></i>
						            자재 목록
						       		<div class="d-flex justify-content-end">
										<button type="button" class="btn btn-success" data-bs-toggle="modal" data-bs-target="#jajeinputModal">자재선택</button>
									</div>
						        </h2>
						
						        <table class="table table-striped table-bordered">
						            <thead class="bg-gray-50">
						                <tr>
						                    <th scope="col">번호</th>
						                    <th scope="col">품목 코드 TB_ITEMMST</th>
						                    <th scope="col">품목중에서 자재명 TB_ITEMMST</th>
						                    <th scope="col">규격 TB_ITEMMST</th>
						                    <th scope="col">단위 TB_ITEMMST</th>
						                    <th scope="col">수량 TB_PURCHASE_ITEM</th>
						                    <th scope="col">단가 TB_ITEMMST</th>
						                    <th scope="col">공급가액(단가 TB_PURCHASE_ITEM</th>
						                </tr>
						            </thead>
						            <tbody>
						                <tr>
						                    <td>1</td>
						                    <td>11012ba</td>
						                    <td>건더기스프</td>
						                    <td>10mg</td>
						                    <td>mg</td>
						                    <td>100개</td>
						                    <td>500원</td>
						                    <td>공급가액(단가)</td>
						                </tr>
						                <tr>
						                    <td>2</td>
						                    <td>ITEM_CD</td>
						                    <td>CUST_NM</td>
						                    <td>ITEM_SPEC</td>
						                    <td>ITEM_UNIT</td>
						                    <td>TB_PURCHASE_ITEM QTY</td>
						                    <td>ITEM_COST원</td>
						                    <td>TB_PURCHASE_ITEM의 PURC_COST</td>
						                </tr>
						            </tbody>
						        </table>
						    </div>
						    
						   <!-- 버튼 그룹 -->
		                   <div class="d-flex justify-content-center mt-4">
		                       <button class="btn btn-primary me-2" onclick="submitFormWithSave()">저장</button>
		                       <button type="button" class="btn btn-secondary " onclick="submitFormWithCancel()">취소</button>
		                   </div>
						    
				    	</div>

				    </div>

			    </form>
			    
			   
			   
			   
			    <form action="CSG_purchaseItem2Form" >
			    <!-- 모달 애들 -->
	                <div class="modal fade" id="jajeinputModal" tabindex="-1" aria-labelledby="jajeinputModalLabel"
	                    aria-hidden="true">
	                    <div class="modal-dialog modal-xl">
	                      <div class="modal-content">
	                        <div class="modal-header">
	                          <h5 class="modal-title" id="jajeinputModalLabel">자재 정보</h5>
	                          여기 부분은 form action으로 처리해야하고 불러오는것만 ajax로 처리하자. 자재들 불러오는 부분
	                          자재코드는 js로 코드 13글자 나오도록 해야함
	                          자재명은 item_table 에서 상태값이 제품인 부분
	                          <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	                        </div>
	                        <div class="flex modal-body "> <!-- 여기다가 대중소분류를 줘야함 -->
								<div class="row">
								
								    <div class="col">
								        <div class="form-group">
								            <label for="BigType">대분류</label>
									            <select class="form-control" id="BigType" style="color: black; background-color: white;">
										            <option selected="selected" value="">대분류 선택</option>
										            <c:forEach var="bigType" items="${bigTypeList}">
										                <option value="${bigType.big_no}">${bigType.big_content}</option>
											         </c:forEach>
									            </select>
								        </div>
								    </div>
							    
							        <div class="col">
										<label for="midType" >중분류</label>
							            <select class="form-control" id="midType">
							                <option>DB에서 값을 불러오자구</option>
							                <option>2</option>
							                <option>3</option>
							                <option>4</option>
							                <option>5</option>
							            </select>										    
							        </div>
							        
							        		<!-- <option selected="selected" value="">중분류 선택</option>
								            <c:forEach var="midType" items="${midTypeList}">
								                <option value="${midType.mid_no}">${midType.mid_content}</option>
									         </c:forEach>  -->
							        
							        <div class="col">
										<label for="smlType">소분류</label>
							            <select class="form-control" id="smlType">
							                <option>DB에서 값을 불러오자구</option>
							                <option>2</option>
							                <option>3</option>
							                <option>4</option>
							                <option>5</option>
							            </select>										    
							        </div>
							        
							        <table id="jajeTable" style="margin: 50px 0;" class="table table-striped table-bordered t-8">
							            <thead class="bg-gray-50">
							                <tr>
							                    <th scope="col">선택</th>
							                    <th scope="col">자재 코드</th>
							                    <th scope="col">자재명</th>
							                    <th scope="col">규격</th>
							                    <th scope="col">단위</th>
							                    <th scope="col">수량</th>
							                    <th scope="col">단가</th>
							                </tr>
							            </thead>
							            <tbody id = "jajaTableBody">
							                <tr>
							                    <td><input type="checkbox" id="itemSelect1" name="itemSelect"></td>
							                    <td>11012ba</td>
							                    <td>건더기스프</td>
							                    <td>10mg</td>
							                    <td>mg</td>
       												<td><input type="number" id="quantity1" name="quantity1" min="1" value="100"></td>
							                    <td>500원</td>
							                </tr>
							                <tr>
							                    <td><input type="checkbox" id="itemSelect2" name="itemSelect"></td>
							                    <td>11012bb</td>
							                    <td>너네리상사</td>
							                    <td>스프용 버섯(소분류?)</td>
							                    <td>mg</td>
        												<td><input type="number" id="quantity2" name="quantity1" min="1" value="100"></td>
							                    <td>300원</td>
							                </tr>
							            </tbody>
							        </table>
	                        </div>
	                        <div class="modal-footer">
  									 <button id="modalSaveButton" class="btn btn-primary">저장</button>
  									 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
	                        </div>

	                      </div>
	                    </div>
	                  </div>
	               </div>
	    		</form>
			</section>

        </main>
        <!-- End #main -->

        <!-- ======= Footer ======= -->
        <%@ include file="../footer.jsp" %>
          <!-- End Footer -->

          <a href="#" class="back-to-top d-flex align-items-center justify-content-center"><i
              class="bi bi-arrow-up-short"></i></a>

          <!-- Vendor JS Files -->
          <!-- 	<script src="assets/vendor/apexcharts/apexcharts.min.js"></script> -->
          <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
          <!--     <script src="assets/vendor/chart.js/chart.umd.js"></script>
				    <script src="assets/vendor/echarts/echarts.min.js"></script>
				    <script src="assets/vendor/quill/quill.min.js"></script>
				 	<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
				  	<script src="assets/vendor/tinymce/tinymce.min.js"></script>
				  	<script src="assets/vendor/php-email-form/validate.js"></script> -->



  	

  </body>


  </html>