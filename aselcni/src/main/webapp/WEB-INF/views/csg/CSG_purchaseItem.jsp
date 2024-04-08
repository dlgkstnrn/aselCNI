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

    <script src="https://cdn.tailwindcss.com"></script>

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
            <!--자재 정보 입력 폼-->
            <!--<div id="SK_itemForm" class="flex items-center justify-center min-h-screen bg-red-800"> 외부배경 회색-->
            <div id="SK_itemForm" class="min-h-screen w-full"> 외부배경 회색

              <div id="content" class="bg-white p-4 w-full shadow-lg rounded boarder-8 border-red-500">
                <!-- 발주 등록 섹션 -->
				<div id="orderRegistration" class="text-lg container mx-auto p-4">
				  <h2 class="text-2xl font-bold mb-4">발주 등록</h2>
				
				  <!-- 입력 필드 그룹 -->
				  <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
				
				    <!-- 발주번호 -->
				    <div>
				      <label for="order-number" class="text-lg block text-gray-700 font-bold mb-2">발주번호</label>
				      <input id="order-number" type="text" placeholder="발주번호는 뷰에서 생성해주고 여기는 readOnly가 되야함" class="form-input w-full">
				    </div>
				
				    <!-- 담당자 -->
				    <div>
				      <label for="manager-name" class="text-lg block text-gray-700 font-bold mb-2">담당자</label>
				      <input id="manager-name" type="text" placeholder="담당자 입력" class="form-input w-full">
				    </div>
				
				    <!-- 전화번호 -->
				    <div>
				      <label for="phone-number" class="text-lg block text-gray-700 font-bold mb-2">전화번호</label>
				      <input id="phone-number" type="text" placeholder="담당자 전화번호 입력" class="form-input w-full">
				    </div>
				
				    <!-- 담당자 이메일 -->
				    <div>
				      <label for="manager-email" class="text-lg block text-gray-700 font-bold mb-2">담당자 이메일</label>
				      <input id="manager-email" type="email" placeholder="담당자 이메일 입력" class="form-input w-full">
				    </div>
				
				    <!-- 매입처 -->
				    <div>
				      <label for="supplier" class="text-lg block text-gray-700 font-bold mb-2">매입처</label>
				      <select id="supplier" class="form-select w-full">
				        <option>업체는 디비에서 불러와야겠지요</option>
				        <option>업체A</option>
				        <option>업체B</option>
				        <!-- 추가 업체 옵션 -->
				      </select>
				    </div>
				
				    <!-- 비고 -->
				    <div>
				      <label for="remark" class="text-lg block text-gray-700 font-bold mb-2">비고</label>
				      <input id="remark" type="text" placeholder="필요한 내용을 입력" class="form-input w-full">
				    </div>
				
				  </div>
				
				  <!-- 버튼 그룹 -->
				  <div class="mt-4">
				    <button class="bg-blue-500 hover:bg-blue-700 text-white font-bold py-2 px-4 rounded">저장</button>
				    <button class="bg-gray-300 hover:bg-gray-400 text-black font-bold py-2 px-4 rounded">취소</button>
				  </div>
				</div>



                <div class="flex justify-end pt-2 items-center">
                  <button type="button" data-bs-toggle="modal" data-bs-target="#jajeinputModal"
                    class="px-4 bg-blue-500 p-3 rounded-lg text-white hover:bg-blue-400 mr-2">추가</button>

                  <!--자재등록 모달폼-->
                  <!--자재 정보 입력 폼-->
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
                        <div class="modal-body">
                          <div class="grid grid-cols-2 gap-6">
                            <div>
                              <label for="material-number" class="block text-gray-700 text-sm font-bold mb-2"
                                readonly>자재코드 웹단에서 자재코드를 만드는 로직이 필요하고 만들어 진 다음에는 여기가 input이 read only로 되도록</label>
                              <input type="text" id="material-number" placeholder="자재코드 입력"
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            
                            
							<!-- 자재 분류 선택을 위한 HTML 구조 -->

							<!-- 대분류, 중분류 선택 -->
							<div>
								<select id="category-select">
							    <option value="">대분류를 선택하세요</option>
							    <!-- 서버로부터 받아온 대분류 데이터를 동적으로 추가 -->
							  </select>
							  <select id="subcategory-select" disabled>
							    <option value="">중분류를 선택하세요</option>
							    <!-- 서버로부터 받아온 중분류 데이터를 동적으로 추가 -->
							  </select>
							  <!-- 소분류 선택 -->
								<div id="subsubcategory-container">
								  <!-- 체크박스는 자바스크립트를 통해 동적으로 추가될 예정 -->
								</div>
							</div>
							





                            
                            <div>
                              <label for="material-price" class="block text-gray-700 text-sm font-bold mb-2">단가 품목테이블에서 불러오기</label>
                              <input type="text" id="material-price" placeholder="단가 입력"
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div>
                              <label for="material-stock" class="block text-gray-700 text-sm font-bold mb-2">규격 품목테이블에서 불러오기</label>
                              <input type="text" id="material-stock" placeholder="규격 입력"
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                            <div>
                              <label for="material-unit" class="block text-gray-700 text-sm font-bold mb-2">단위 품목테이블에서 불러오기</label>
                              <input type="text" id="material-unit" placeholder="단위 입력"
                                class="shadow appearance-none border rounded w-full py-2 px-3 text-gray-700 leading-tight focus:outline-none focus:shadow-outline">
                            </div>
                          </div>
                        </div>
                        <div class="modal-footer">
                          <button type="button" id="jaje" class="btn btn-primary">저장</button>

                          <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
                        </div>
                      </div>
                    </div>
                  </div>


                  <button class="px-4 bg-gray-300 p-3 rounded-lg text-black hover:bg-gray-400">삭제</button>
                </div>

                <!--추가를 누른뒤에 자재모달에서 저장을 하면 table에다가 데이터를 넘겨줘야함-->
                <table
                  class="bg-white p-4 min-w-full divide-y divide-gray-200 max-w-4xl shadow-lg rounded mt-8 border-8 border-red-500"
                  style="width: 100%;">
                  <thead>
                    <tr>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        선택</th>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        자재 코드</th>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        자재명</th>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        규격</th>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        단위</th>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        수량</th>
                      <th
                        class="px-6 py-3 bg-gray-50 text-left text-xs font-medium text-gray-500 uppercase tracking-wider">
                        단가</th>

                  </thead>
				    
                  <tbody id="materialsTableBody" class="bg-white divide-y divide-gray-200">
                    <!-- 데이터 행 -->
                    <tr>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500 text-center">
                        <input type="checkbox" id="itemSelect1" name="itemSelect">
                      </td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500 text-center">11012ba</td>

                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">건더기스프</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">10mg</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">mg</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">100개</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">500원</td>
                    </tr>
                    <tr>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500 text-center">
                        <input type="checkbox" id="itemSelect1" name="itemSelect">
                      </td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500 text-center">11012bb</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">너네리상사</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">스프용 버섯(소분류?)</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">500원</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">1000개</td>
                      <td class="px-6 py-4 whitespace-no-wrap text-sm text-gray-500">500000원</td>
                    </tr>
                  </tbody>
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
          <!-- 	<script src="assets/vendor/apexcharts/apexcharts.min.js"></script> -->
          <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
          <!--     <script src="assets/vendor/chart.js/chart.umd.js"></script>
    <script src="assets/vendor/echarts/echarts.min.js"></script>
    <script src="assets/vendor/quill/quill.min.js"></script>
 	<script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
  	<script src="assets/vendor/tinymce/tinymce.min.js"></script>
  	<script src="assets/vendor/php-email-form/validate.js"></script> -->

  </body>

  <script>
//서버로부터 받아온 대분류 데이터를 가정합니다.
//실제로는 서버 요청을 통해 이 데이터를 가져와야 합니다.
const categoryData = {
 '대분류1': { '중분류1': ['소분류1', '소분류2'], '중분류2': ['소분류3', '소분류4'] },
 '대분류2': { '중분류3': ['소분류5', '소분류6'], '중분류4': ['소분류7', '소분류8'] },
 // ...
};

//페이지 로드 시 대분류 데이터를 채웁니다.
window.onload = function() {
 const categorySelect = document.getElementById('category-select');
 for (const category in categoryData) {
   const option = new Option(category, category);
   categorySelect.add(option);
 }
};

//대분류 선택 시 중분류 데이터를 채웁니다.
document.getElementById('category-select').addEventListener('change', function() {
 const selectedCategory = this.value;
 const subcategorySelect = document.getElementById('subcategory-select');
 subcategorySelect.innerHTML = '<option value="">중분류를 선택하세요</option>'; // 초기화
 subcategorySelect.disabled = selectedCategory === '';
 if (selectedCategory) {
   for (const subcategory in categoryData[selectedCategory]) {
     const option = new Option(subcategory, subcategory);
     subcategorySelect.add(option);
   }
 }
});

//중분류 선택 시 소분류 데이터를 채웁니다.
document.getElementById('subcategory-select').addEventListener('change', function() {
 const selectedCategory = document.getElementById('category-select').value;
 const selectedSubcategory = this.value;
 const subsubcategoryContainer = document.getElementById('subsubcategory-container');
 subsubcategoryContainer.innerHTML = ''; // 초기화
 if (selectedSubcategory) {
   categoryData[selectedCategory][selectedSubcategory].forEach(subsubcategory => {
     const label = document.createElement('label');
     const checkbox = document.createElement('input');
     checkbox.type = 'checkbox';
     checkbox.value = subsubcategory;
     label.appendChild(checkbox);
     label.append(subsubcategory);
     subsubcategoryContainer.appendChild(label);
     subsubcategoryContainer.appendChild(document.createElement('br'));
   });
 }
});


  </script>

  </html>