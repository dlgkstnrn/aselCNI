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
<link
   href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i"
   rel="stylesheet">

<!-- Vendor CSS Files -->
<link href="assets/vendor/bootstrap/css/bootstrap.min.css"
   rel="stylesheet">
<link href="assets/vendor/bootstrap-icons/bootstrap-icons.css"
   rel="stylesheet">
<link href="assets/vendor/boxicons/css/boxicons.min.css"
   rel="stylesheet">
<link href="assets/vendor/quill/quill.snow.css" rel="stylesheet">
<link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet">
<link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet">
<link href="assets/vendor/simple-datatables/style.css" rel="stylesheet">

<!-- CSS File -->
<link href="assets/css/style.css" rel="stylesheet" type="text/css">

<!-- Script -->
<script defer src="assets/js/main.js"></script>
<script src="https://kit.fontawesome.com/0b22ed6a9d.js"
   crossorigin="anonymous"></script>
<script
   src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.1/jquery.min.js"></script>
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
         <h1>기준 정보 관리</h1>
         <nav>
            <ol class="breadcrumb">
               <li class="breadcrumb-item"><a href="#">기준 정보 관리</a></li>
               <li class="breadcrumb-item active">창고 관리</li>
            </ol>
         </nav>
      </div>
      <!-- End Page Title -->

      <section class="section dashboard">






         <!-- 창고 추가 -->
         <div class="row">
            <div class="col-lg-12">

               <div class="card">

                  <div class="card-body">
                     <div class="d-flex align-items-center">
									<span class="h5 me-auto card-header-title">창고 관리</span>
									<div>
										<button type="button" class="btn btn-primary"
								data-bs-toggle="modal" data-bs-target="#verticalycentered">신규</button>
									</div>
							
							          </div>

							<hr>
                     <div class="modal fade" id="verticalycentered" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title">창고등록</h5>
                                 <button type="button" class="btn-close"
                                    data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">
                                 <div class="form-check">
                                    <label class="form-check-label" for="defaultCheck1">사용여부</label>
                                    <input name="USE_FLAG"
                                       class="form-check-input" type="checkbox"
                                       id="defaultCheck1">
                                 </div>
                                 
                                    <div class="row mb-3">
                                       <legend class="col-form-label col-sm-3 pt-0">창고분류</legend>
                                       <div class="col-sm-10">
                     
                                         <div class="form-check">
                                           <input class="form-check-input" type="checkbox" id="gridCheck1" name="wh_type1">
                                           <label class="form-check-label" for="gridCheck1">
                                             자재
                                           </label>
                                         </div>
                     
                                         <div class="form-check">
                                           <input class="form-check-input" type="checkbox" id="gridCheck2" name="wh_type2">
                                           <label class="form-check-label" for="gridCheck2">
                                             출고
                                           </label>
                                         </div>
                                         <div class="form-check">
                                           <input class="form-check-input" type="checkbox" id="gridCheck3" name="wh_type3">
                                           <label class="form-check-label" for="gridCheck3">
                                             입고
                                           </label>
                                         </div>
                     
                                       </div>
                                     </div>

                                 <div class="row mb-3">
                                    <label for="inputText" class="col-sm-2 col-form-label">창고코드<span style="color: red;">*</span></label>
                                    <div class="col-sm-8">
                                       <input name="WH_CD" id="wh_cd" type="text" class="form-control" placeholder="영대문자 세자리+숫자10자리">
                                          
                                          <p style="color:red; display: none" id="fail">이미 존재하는 CD입니다.</p>
                                         <p style="color:red; display: none;" id="failid">
                                                   규격을 맞추어 주세요</p> 
                                    </div>
                                 </div>

                                 <div class="row mb-3">
                                    <label for="inputText" class="col-sm-2 col-form-label">창고명<span style="color: red;">*</span></label>
                                    <div class="col-sm-8">
                                       <input name="WH_NM" type="text" class="form-control">
                                    </div>
                                    
                                 </div>

                                 <div class="row mb-3">
                                    <label for="inputPassword" class="col-sm-2 col-form-label">설명</label>
                                    <div class="col-sm-10">
                                       <textarea name="REMARK" class="form-control" style="height: 100px"></textarea>
                                    </div>
                                 </div>


                                 <div class="row mb-3">
                                    <label for="inputText" class="col-sm-3 col-form-label">담당자ID <span style="color: red;">*</span></label>
                                    <div class="col-sm-8">
                                       <input name="WH_EMP_ID" type="text" class="form-control">
                                    </div>
                                    
                                 </div>   

                                 
                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">닫기</button>
                                 <button type="button" id="NewWhmst" class="btn btn-primary">등록</button>
                              </div>
                           </div>
                        </div>
                     </div>




                     <!-- 창고 수정 관리 삭제 -->
                     <div class="modal fade" id="verticalycentered1" tabindex="-1">
                        <div class="modal-dialog modal-dialog-centered">
                           <div class="modal-content">
                              <div class="modal-header">
                                 <h5 class="modal-title">창고</h5>
                                 <button type="button" class="btn-close"
                                    data-bs-dismiss="modal" aria-label="Close"></button>
                              </div>
                              <div class="modal-body">


                                 <div class="form-check">
                                    <input name="USE_FLAG" class="form-check-input" type="checkbox" value="1" id="defaultCheck1">
                                    <label class="form-check-label" for="defaultCheck1">사용여부</label>
                                 </div>

                                 <div class="row mb-3">
                                       <legend class="col-form-label col-sm-3 pt-0">창고분류</legend>
                                       <div class="col-sm-10">
                     
                                         <div class="form-check">
                                           <input name="wh_type1" class="form-check-input" type="checkbox" id="gridCheck1">
                                           <label class="form-check-label" for="gridCheck1">
                                             자재
                                           </label>
                                         </div>
                     
                                         <div class="form-check">
                                           <input name="wh_type2" class="form-check-input" type="checkbox" id="gridCheck2">
                                           <label class="form-check-label" for="gridCheck2">
                                             출고
                                           </label>
                                         </div>
                                         <div class="form-check">
                                           <input name="wh_type3" class="form-check-input" type="checkbox" id="gridCheck3">
                                           <label class="form-check-label" for="gridCheck3">
                                             입고
                                           </label>
                                         </div>
                     
                                       </div>
                                     </div>

                                 <div class="row mb-3">
                                    <label class="col-sm-3 col-form-label">창고코드</label>
                                    <div class="col-sm-7">
                                       <p id="WH_CD"></p>
                                    </div>
                                 </div>

                                 <div class="row mb-3">
                                    <label for="inputText" class="col-sm-2 col-form-label">창고명</label>
                                    <div class="col-sm-8">
                                       <input type="text" class="form-control" name="WH_NM">
                                    </div>
                                 </div>

                                 <div class="row mb-3">
                                    <label class="col-sm-3 col-form-label">등록날짜</label>
                                    <div class="col-sm-5">
                                       <p id="WH_REGDATE">200-14-45</p>
                                    </div>
                                 </div>

                                 <div class="row mb-3">
                                    <label class="col-sm-3 col-form-label">수정날짜</label>
                                    <div class="col-sm-5">
                                       <p id="WH_UPDATE"></p>
                                    </div>
                                 </div>



                                 <div class="row mb-3">
                                    <label for="inputPassword" class="col-sm-2 col-form-label">비고</label>
                                    <div class="col-sm-10">
                                       <textarea name="REMARK" class="form-control" style="height: 100px"></textarea>
                                    </div>
                                 </div>

                                 <div class="row mb-3">
                                    <label for="inputText" class="col-sm-3 col-form-label">담당자ID</label>
                                    <div class="col-sm-8">
                                       <input type="text" class="form-control" name="WH_EMP_ID">
                                    </div>
                                 </div>

                              </div>
                              <div class="modal-footer">
                                 <button type="button" class="btn btn-secondary"
                                    data-bs-dismiss="modal">닫기</button>
                                 <button type="button" id="chWhmst" class="btn btn-primary">수정</button>
                                 <button type="button" id="delWhmst" class="btn btn-primary">삭제</button>
                              </div>
                           </div>
                        </div>
                     </div>



                     <!-- Table with stripped rows -->
                     <div
                        class="datatable-wrapper datatable-loading no-footer sortable searchable fixed-columns search-results">
                        <div class="datatable-top">
                           <div class="datatable-dropdown"></div>



                           <div class="searchdiv">
                                    <form action="/whmst">
                                      <div class="d-flex" style="width: 600px;">
                                      <select class="form-select searchselect"
                                             aria-label="Default select example"
                                             name="searchFilter" style="width: 200px;">
                                             <option selected="">검색옵션선택</option>
                                             <option value="wh_cd">코드</option>
                                             <option value="wh_nm">이름</option>
                                           </select>
                                      
                                        <input type="text" name="keyword" class="form-control searchinput" style="width: 400px;"/>
                                        
                                        <button type="submit" class="btn btn-primary" style="width: 60px;">검색</button>
                                      </div>
                                    </form>
                                    
                                  </div>
                           <!-- End Search Bar -->




                        </div>
                        <div class="datatable-container">
                           <table id="processTable"
                              class="table datatable datatable-table datatable-table">
                              <thead>
                                 <tr>
                                    <th><b>N</b>o.</th>
                                    <th>창고코드</th>
                                    <th>창고명</th>
                                    <th>설명</th>
                                    <th>담당자</th>
                                    <th>창고구분</th>
                                    <th>사용여부</th>

                                 </tr>
                              </thead>
                              <tbody>
                                 <c:forEach var="Whmst" items="${WhmstsList}"
                                    varStatus="status">
                                    <tr>
                                       <td>${status.index + 1}</td>

                                       <td><button type="button"
                                             class="btn btn-outline-primary edit-process-btn" data-bs-toggle="modal"
                                             data-bs-target="#verticalycentered1"
                                             data-whmst-id="${Whmst.wh_cd}">${Whmst.wh_cd}</button></td>

                                       <td>${Whmst.wh_nm}</td>
                                       <td class="remark-cell">${Whmst.remark}</td>
                                       <td>${Whmst.wh_emp_id}</td>
                                       
                                       <td>
                                           <c:if test="${Whmst.wh_type1 == 1}">자재</c:if>
                                           <c:if test="${Whmst.wh_type2 == 1}">출고</c:if>
                                           <c:if test="${Whmst.wh_type3 == 1}">입고</c:if>
                                       </td>
                                       <td><c:choose>
                                             <c:when test="${Whmst.use_flag == 1}">
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
                        <div>
                        <div class="container">
                        <div class="row">
                           <div class="col">
                              <ul class="pagination d-flex justify-content-center">
                                 <c:if test="${page.startPage > page.pageBlock }">
                                    <li class="page-item"><a class="page-link"
                                       href="/whmst?currentPage=${page.startPage-page.pageBlock}">이전</a></li>
                                 </c:if>
                                 
                                 <c:forEach var="i" begin="${page.startPage}" end="${page.endPage}">
                                    <li class="page-item"><a class="page-link"
                                       href="/whmst?currentPage=${i}&searchFilter=${whmst.searchFilter}&keyword=${whmst.keyword}">${i}</a></li>
                                 </c:forEach>
                                 
                                 <c:if test="${page.endPage < page.totalPage }">
                                    <li class="page-item"><a class="page-link"
                                       href="/whmst?currentPage=${page.startPage+page.pageBlock}">다음</a></li>
                                 </c:if>
                              </ul>
                           </div>
                        </div>
                     </div>
</div>
                     </div>
                     <!-- End Table with stripped rows -->

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
   <script type="text/javascript">
      //=====================창고정보 가져오기======================
      $(document).ready(function() {
         $('.edit-process-btn').on('click', function() {
            var WhmstId = $(this).data('whmst-id');

            $.ajax({
               url : 'whmstDetails', // 서버의 URL을 지정해야 합니다.
               type : 'GET',
               data : {
                  'id' : WhmstId
               }, // 서버로 보낼 데이터
               dataType : 'json', // 응답 받을 데이터의 타입
               success : function(data) {
                  // 모달의 입력 필드에 공정 정보를 채움
                  
                  console.log("data:", data);
                  console.log("Use Flag:", data.use_flag);
                  console.log("WH_CD:", data.wh_cd);
                   
                  $('#WH_CD').text(data.wh_cd);
                  $('#verticalycentered1 input[name="WH_NM"]').val(data.wh_nm);
                  $('#WH_REGDATE').text(data.wh_regdate);
                  $('#WH_UPDATE').text(data.wh_update);
                  $('#verticalycentered1 textarea[name="REMARK"]').val(data.remark);
                  $('#verticalycentered1 input[name="WH_EMP_ID"]').val(data.wh_emp_id);
                  
                   if(data.wh_type1 === 1) {
                             $('#verticalycentered1 input[name="wh_type1"]').prop('checked', true);
                         } else {
                             $('#verticalycentered1 input[name="wh_type1"]').prop('checked', false);
                         }
                   if(data.wh_type2 === 1) {
                             $('#verticalycentered1 input[name="wh_type2"]').prop('checked', true);
                         } else {
                             $('#verticalycentered1 input[name="wh_type2"]').prop('checked', false);
                         }
                   if(data.wh_type3 === 1) {
                             $('#verticalycentered1 input[name="wh_type3"]').prop('checked', true);
                         } else {
                             $('#verticalycentered1 input[name="wh_type3"]').prop('checked', false);
                         }

                   if(data.use_flag === 1) {
                             $('#verticalycentered1 input[name="USE_FLAG"]').prop('checked', true);
                         } else {
                             $('#verticalycentered1 input[name="USE_FLAG"]').prop('checked', false);
                         }
                  
                  // 모달을 열음
                  $('#processModal').modal('show');
               },
               error : function(xhr, status, error) {
                  console.error("AJAX Error: " + status + error);
               }
            });
         });
      });
      
      //=====================창고수정=========================
       $(document).on('click','#chWhmst', function() {
              // 사용여부
            var use_flag = $('#verticalycentered1 input[name="USE_FLAG"]').is(':checked') ? 1 : 0;
              
            var wh_type1 = $('#verticalycentered1 input[name="wh_type1"]').is(':checked') ? 1 : 0;
            var wh_type2 = $('#verticalycentered1 input[name="wh_type2"]').is(':checked') ? 1 : 0;
            var wh_type3 = $('#verticalycentered1 input[name="wh_type3"]').is(':checked') ? 1 : 0;

              
             var wh_cd = $('#WH_CD').text();
             var wh_nm = $('#verticalycentered1 input[name="WH_NM"]').val(); // 수정된 부분
             var remark = $('#verticalycentered1 textarea[name="REMARK"]').val();
               var wh_emp_id = $('#verticalycentered1 input[name="WH_EMP_ID"]').val(); // 수정된 부분
              
            


              // AJAX 요청을 통해 서버에 데이터 전송
              $.ajax({
                  url: 'updateWhmst', // 요청을 처리할 서버의 URL
                  type: 'POST',
                  data: {
                      'wh_cd': wh_cd, 
                      'use_flag': use_flag, 
                      'wh_type1': wh_type1, 
                      'wh_type2': wh_type2, 
                      'wh_type3': wh_type3, 
                      'wh_nm': wh_nm ,
                      'remark': remark,
                      'wh_emp_id': wh_emp_id 
                  },
                  dataType: 'text',
                  success: function(response) {
                     if (response === 'success') {
                          alert('공정정보가 성공적으로 변경되었습니다');
                          location.reload();
                      } else {
                          alert('음...잘못된 담당자입니다...');
                      }
                  } ,
                  error: function(xhr, status, error) {
                      // 요청 처리 중 오류가 발생했을 때 실행할 코드
                      alert('잘못된 담당자입니다...');
                  }
              });
          });
      //=====================창고삭제=========================
       $(document).on('click','#delWhmst', function() {
              // 사용여부
              var wh_cd = $('#WH_CD').text();
              
              // AJAX 요청을 통해 서버에 데이터 전송
              $.ajax({
                  url: 'DelDateWhmst', // 요청을 처리할 서버의 URL
                  type: 'POST',
                  data: {
                      'wh_cd': wh_cd, 
                  },
                  dataType: 'text',
                  success: function(response) {
                     if (response === 'success') {
                          alert('공정정보가 성공적삭제 되었습니다.');
                          location.reload();
                      } else {
                          alert('문제발생1');
                      }
                  } ,
                  error: function(xhr, status, error) {
                      // 요청 처리 중 오류가 발생했을 때 실행할 코드
                      alert('문제발생2');
                  }
              });
          });
      
      
      
      
         //=====================창고코드 중복여부,주요정보 입력유무 확인=========================
         var idCheck = 0;
         
            function regMemberId(wh_cd) {
                   // 영어 대문자와 숫자만 포함되어 있는지 검사하는 정규 표현식
                   var regExp = /^[A-Z0-9]{13}$/;
                   
                   if (!regExp.test(wh_cd)) {
                       return false; // 정규 표현식에 맞지 않으면 바로 false 반환
                   }
               
                   // 영어 대문자와 숫자의 개수를 세기
                   var countDigits = (wh_cd.match(/\d/g) || []).length;
                   var countUppercase = (wh_cd.match(/[A-Z]/g) || []).length;
               
                   // 영어 대문자가 3개이고 숫자가 10개인지 확인
                   return countDigits === 10 && countUppercase === 3;
               }
            
         
            $(document).ready(function() {
                // 창고 코드 입력 필드에 대한 입력 이벤트 리스너 설정
                $('#wh_cd').on('input', function() {
                    checkCd(); // 사용자 입력마다 checkCd 함수 호출
                });
            });

            function checkCd() {
                var inputed = $('#wh_cd').val(); // 입력된 창고 코드 가져오기
                
                if (!regMemberId(inputed)) {
                    // 규격에 맞지 않으면 규격 경고 메시지 표시하고 중복 경고 메시지는 숨김
                    $("#failid").show();
                    $("#fail").hide();
                    $("#wh_cd").css("background-color", "#FFCECE"); // 입력 필드 배경색 변경
                    $("#NewWhmst").prop("disabled", true).css("background-color", "#aaaaaa");
                    idCheck = 0; // 글로벌 변수 idCheck 설정
                    return; // 여기서 함수 실행 종료
                }
                
                
                $.ajax({
                    data : {'wh_cd' : inputed}, // 서버로 보낼 데이터
                    url : "hshWhCk", // 서버 URL
                    success : function(data) {
                        if(data == '1') { // 중복된 코드일 때
                            $("#fail").show(); // 중복 경고 메시지 표시
                            $("#failid").hide(); // 규격 경고 메시지 숨기기
                            $("#NewWhmst").prop("disabled", true).css("background-color", "#aaaaaa");
                            $("#wh_cd").css("background-color", "#FFCECE");
                            idCheck = 0;
                        } else {
                            // 규격 검사 로직 추가할 수 있음 (예: regMemberId 함수 사용)
                            $("#fail").hide(); // 중복 경고 메시지 숨기기
                            $("#failid").hide(); // 규격 경고 메시지 숨기기
                            $("#wh_cd").css("background-color", ""); // 입력 필드 배경색 초기화
                            $("#NewWhmst").prop("disabled", false).css("background-color", "#0D6CF9");
                            idCheck = 1;
                        }
                    },
                    error : function(xhr, status, error) {
                        console.error("AJAX Error: " + status + error);
                    }
                });
            }

         
            
            //================생성버튼 활성화=============
             function activateSignUpBtn() { 
                   console.log('idCheck'+idCheck);
          
             
             if(idCheck == 1) {
                $("#NewWhmst").prop("disabled", false);   
              $("#NewWhmst").css("background-color", "#0D6CF9");
             }
             else  {
                $("#NewWhmst").css("background-color", "#aaaaaa");
                $("#NewWhmst").prop("disabled", true);
          }
            }
            
            
            
         //=====================기존 관리자 id 유무확인및 등록===========================
            $(document).on('click','#NewWhmst', function() {
              // 사용여부
            var use_flag = $('input[name="USE_FLAG"]').is(':checked') ? 1 : 0;
            var wh_type1 = $('#verticalycentered input[name="wh_type1"]').is(':checked') ? 1 : 0;
            var wh_type2 = $('#verticalycentered input[name="wh_type2"]').is(':checked') ? 1 : 0;
            var wh_type3 = $('#verticalycentered input[name="wh_type3"]').is(':checked') ? 1 : 0;
              var wh_cd = $('input[name="WH_CD"]').val();
              var wh_nm = $('input[name="WH_NM"]').val();
              var remark = $('textarea[name="REMARK"]').val();
              var wh_emp_id = $('input[name="WH_EMP_ID"]').val();
              
            var formData = new FormData();
            formData.append('use_flag',use_flag);
            formData.append('wh_type1',wh_type1);
            formData.append('wh_type2',wh_type2);
            formData.append('wh_type3',wh_type3);
            formData.append('wh_cd',wh_cd);
            formData.append('wh_nm',wh_nm);
            formData.append('remark',remark);
            formData.append('wh_emp_id',wh_emp_id);
              
            
              // AJAX 요청을 통해 서버에 데이터 전송
              $.ajax({
                  url: 'NewWhmst', // 요청을 처리할 서버의 URL
                  type: 'POST',
                  data: formData,
                  processData: false, 
                  contentType: false,
                  dataType: 'text',
                  success: function(response) {
                     if (response === 'success') {
                          alert('창고정보가 성공적으로 추가되었습니다');
                          location.reload();
                      } else if(response === 'error1') {
                          alert('창고 코드 또는 창고 이름이 비어 있습니다');
                      }
                       else if(response === 'error2') {
                          alert('존재하지않는 담당자입니다!');
                      }
                     
                  } ,
                  error: function(xhr, status, error) {
                      if(xhr.status === 409) { // 409 Conflict 응답 처리
                          alert('중복된 코드입니다.');
                      } else {
                          alert('오류 발생: ' + xhr.responseText);
                      }
                  }
              });
          });
      
   
   </script>
</body>

</html>


