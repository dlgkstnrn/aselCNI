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
    <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
    <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
    <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
    <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

    <!-- CSS File -->
    <link href="assets/css/style.css" rel="stylesheet" type="text/css">

    <!-- Script -->
    <script defer src="assets/js/main.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

  </head>

  <body>
  <script>
  $(document).ready(function(){
    let popoverTrigger = $('[data-toggle="popover"]');
    
    popoverTrigger.popover(); // 팝오버 초기화

    popoverTrigger.click(function() {
        let dataToLoad = "Here is some dynamic content";
        // 예제로는 단순 문자열을 사용했지만, 여기에 AJAX 호출을 통해 서버에서 데이터를 가져오는 코드를 추가할 수 있습니다.
        $(this).attr('data-content', dataToLoad);
        $(this).popover('show'); // 팝오버 보여주기
    });
	});
</script>

    <!-- ======= Header ======= -->
    <%@ include file="../header.jsp" %>

      <!-- ======= Sidebar ======= -->
      <%@ include file="../asidebar.jsp" %>

        <!-- End Sidebar-->

        <main id="main" class="main ">

          <div class="pagetitle">
            <h1>구매 / 영업 관리</h1>
            <nav>
              <ol class="breadcrumb">
                <li class="breadcrumb-item"><a href="#">구매 / 영업 관리</a></li>
                <li class="breadcrumb-item active">발주 관리</li>
              </ol>
            </nav>
          </div><!-- End Page Title -->

          <section class="section dashboard">
		    <!--자재 정보 입력 폼-->
			<div class="container-fluid px-4">
			    <div class="bg-white shadow-md rounded px-4 pt-4 pb-4 mb-4">
		            <div class="mb-4">
		                <h5 class="h8 fw-bold">자재 정보</h5>
		                <p>여기 부분은 form action으로 처리해야하고 불러오는 것만 AJAX로 처리합니다.</p>
		            </div>
		            
		            <form action="/path-to-submit-form" method="POST">
		                <div class="mb-4">
		                    <label for="material-number" class="fw-bold">
		                        자재코드
		                    </label>
		                    <input type="text" id="material-number" name="material_number" placeholder="자재코드 입력" readonly class="form-control shadow-none border rounded w-75 py-2 px-3 text-gray-700"
>
		                </div>
		                
		                <div class="mb-4">
		                    <label for="material-price" class="fw-bold" >단가</label>
		                    <input type="text" id="material-price" name="material_price" placeholder="단가 입력" class="form-control shadow-none border rounded w-75 py-2 px-3 text-gray-700"
>
		                </div>
		                
		                <div class="mb-4">
		                    <label for="material-stock" class="fw-bold" >규격</label>
		                    <input type="text" id="material-stock" name="material_stock" placeholder="규격 입력" class="form-control shadow-none border rounded w-75 py-2 px-3 text-gray-700"
>
		                </div>
		                
		                <div class="mb-4">
		                    <label for="material-unit" class="fw-bold" >단위</label>
		                    <input type="text" id="material-unit" name="material_unit" placeholder="단위 입력" class="form-control shadow-none border rounded w-75 py-2 px-3 text-gray-700"
>
		                </div>
		                
						<button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#jajeinputModal">
							품목 선택
						</button>
		                
						<div class="d-flex justify-content-center mb-4">
						    <button class="btn btn-secondary" type="submit">
						        저장
						    </button>
						</div>

		                
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
									            <label for="exampleSelect1">대분류</label>
									            <select class="form-control" id="exampleSelect1">
									                <option>1</option>
									                <option>2</option>
									                <option>3</option>
									                <option>4</option>
									                <option>5</option>
									            </select>
									        </div>
									    </div>
								    
								        <div class="col">
											<label for="exampleSelect1">중분류</label>
								            <select class="form-control" id="exampleSelect1">
								                <option>1</option>
								                <option>2</option>
								                <option>3</option>
								                <option>4</option>
								                <option>5</option>
								            </select>										    
								        </div>
								        
								        <div class="col">
											<label for="exampleSelect1">소분류</label>
								            <select class="form-control" id="exampleSelect1">
								                <option>1</option>
								                <option>2</option>
								                <option>3</option>
								                <option>4</option>
								                <option>5</option>
								            </select>										    
								        </div>
								        
								        <table  style="margin: 50px 0;" class="table table-striped table-bordered t-8">
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
								            <tbody>
								                <tr>
								                    <td><input type="checkbox" id="itemSelect1" name="itemSelect"></td>
								                    <td>11012ba</td>
								                    <td>건더기스프</td>
								                    <td>10mg</td>
								                    <td>mg</td>
								                    <td>100개</td>
								                    <td>500원</td>
								                </tr>
								                <tr>
								                    <td><input type="checkbox" id="itemSelect2" name="itemSelect"></td>
								                    <td>11012bb</td>
								                    <td>너네리상사</td>
								                    <td>스프용 버섯(소분류?)</td>
								                    <td>500원</td>
								                    <td>1000개</td>
								                    <td>500000원</td>
								                </tr>
								            </tbody>
								        </table>
									
		                        </div>
		                        <div class="modal-footer">
   									 <button type="button" id="jaje" class="btn btn-primary">저장</button>
   									 <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">닫기</button>
		                        </div>

		                      </div>
		                    </div>
		                  </div>
		               </div>
		            </form>
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
          <script src="assets/vendor/apexcharts/apexcharts.min.js"></script>
          <script src="assets/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
          <script src="assets/vendor/chart.js/chart.umd.js"></script>
          <script src="assets/vendor/echarts/echarts.min.js"></script>
          <script src="assets/vendor/quill/quill.min.js"></script>
          <script src="assets/vendor/simple-datatables/simple-datatables.js"></script>
          <script src="assets/vendor/tinymce/tinymce.min.js"></script>
          <script src="assets/vendor/php-email-form/validate.js"></script>


<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>

<script>
    $(document).ready(function() {
        // 대분류 선택 이벤트 리스너
        $('#exampleSelect1').change(function() {
            var selectedOption = $(this).val();
            // AJAX 요청 보내기
            $.ajax({
                url: '/your-server-endpoint', // 서버의 엔드포인트 URL로 변경해야 합니다.
                method: 'GET', // 또는 'POST', 서버 측에서 요청을 처리하는 방식에 따라 변경합니다.
                data: { category: selectedOption }, // 선택된 옵션을 서버에 전달합니다.
                success: function(response) {
                    // 서버로부터 받은 데이터를 사용하여 테이블을 생성하거나 업데이트합니다.
                    console.log(response); // 받은 데이터를 콘솔에 출력하여 확인합니다.
                    // 여기서 받은 데이터를 사용하여 테이블을 생성하거나 업데이트하는 코드를 작성합니다.
                },
                error: function(xhr, status, error) {
                    // 오류 처리
                    console.error(error);
                }
            });
        });
    });
</script>

  </body>

  </html>
