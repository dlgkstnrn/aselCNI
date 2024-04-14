<%@ page language="java" contentType="text/html; charset=UTF-8"
pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>

    <!-- Favicons -->
    <link href="assets/img/favicon.png" rel="icon" />

    <!-- Google Fonts -->
    <link href="https://fonts.gstatic.com" rel="preconnect" />
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,300i,400,400i,600,600i,700,700i|Nunito:300,300i,400,400i,600,600i,700,700i|Poppins:300,300i,400,400i,500,500i,600,600i,700,700i" rel="stylesheet"/>

    <!-- Vendor CSS Files -->
    <link href="assets/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet"/>
    <link href="assets/vendor/bootstrap-icons/bootstrap-icons.css" rel="stylesheet"/>
    <!-- <link href="assets/vendor/boxicons/css/boxicons.min.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.snow.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/quill/quill.bubble.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/remixicon/remixicon.css" rel="stylesheet"> -->
    <!-- <link href="assets/vendor/simple-datatables/style.css" rel="stylesheet"> -->

    <!-- CSS File -->
    <link href="assets/css/psa/psaWorkprod.css" rel="stylesheet" type="text/css">
    <link href="assets/css/style.css" rel="stylesheet"  type="text/css">

    <!-- Script -->
    <script src="assets/js/jquery-3.7.1.min.js"></script>
    <script defer src="assets/js/main.js"></script>
    <script defer src="assets/js/psa/workProd.js"></script>
    <script src="https://kit.fontawesome.com/0b22ed6a9d.js" crossorigin="anonymous"></script>

</head>
<body>

    <!-- ajax로 갈아끼울 테이블 -->
    <!-- <table class="table table-hover p-2 text-center" id="workprodTB"> -->

        <thead class="p-2">
          <tr>
            <th scope="col">생산지시번호</th>
            <th scope="col">동일 계획번호 내 순번</th>
            <th scope="col">제품명</th>
            <th scope="col">생산수량</th>
            <th scope="col">작업일수</th>
          </tr>
        </thead>
    
        <tbody class="p-2">
          <c:forEach var="workList" varStatus="workStat" items="${workList}">
    
            <!-- 생산지시내역 조회 모달 띄우기 : tr 클릭 시 -->
            <tr data-bs-toggle="modal" data-bs-target="#workprod" data-index="${workList.workprod_no}" >
              <th scope="row">${workList.workprod_no}</th>
              <td>${workList.seq_no}</td>
              <td>${workList.item_nm}</td>
              <td>${workList.qty}</td>
              <td>${workList.work_dt}</td>
            </tr>
          </c:forEach>
        </tbody>
    
    <!-- </table> -->


    <!-- 3. 생산지시내역 조회 모달 -->
    <div class="modal fade" id="workprod" tabindex="-1" aria-hidden="true" style="display: none">
        
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
              
                <!-- 3. 생산지시내역 조회 모달 내용 -->
                <div class="modal-header">
                    <h5 class="modal-title">생산지시내역</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>

                <div class="modal-body">

                    <!-- 생산지시 담당자 -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label">지시 담당자명</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="user_nm" disabled/>
                      </div>
                    </div>

                    <!-- 생산지시번호 -->
                    <div class="row mb-3 d-flex">
                      <label class="col-sm-3 col-form-label">생산지시번호</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="workprod_no" disabled/>
                      </div>
                    </div>

                    <!-- 생산시작일자 -->
                    <div class="row mb-3">
                      <label for="workprod_dt" class="col-sm-3 col-form-label">생산시작일자</label>
                      <div class="col-sm-5">
                        <input type="text" class="form-control" id="workprod_dt" disabled/>
                      </div>
                    </div>

                    <!-- 제품 -->
                    <div class="row mb-3">
                      <!-- 제품명 -->
                      <label for="item_nm" class="col-sm-3 col-form-label">제품명</label>
                      <div class="d-flex justify-content-between col-sm-9">
                        <div class="col-sm-5">
                          <input type="text" class="form-control" id="item_nm" disabled/>
                        </div>
                        <!-- 제품 생산수량 -->
                        <div class="d-flex mb-3">
                          <label for="qty" class="col-sm-3 col-form-label">생산수량</label>
                          <div class="col-sm-4 mx-2">
                            <input type="text" class="form-control" id="qty" disabled/>
                          </div>
                        </div>
                      </div>
                    </div>

                    <!-- 공정 -->
                    <div class="card-body mb-3">
                      <h5 class="card-title">등록된 공정 목록</h5>
                      <table class="table">
                        <thead>
                          <tr>
                            <th scope="col">#</th>
                            <th scope="col">공정코드</th>
                            <th scope="col">공정명</th>
                          </tr>
                        </thead>
                        <tbody id="proc_tbody">
                          <tr id="proc_tr">
                            <th scope="row"></th>
                            <td></td>
                            <td></td>
                          </tr>
                        </tbody>
                      </table>
                    </div>
              
                    <!-- 투입품 -->
                    <div class="card-body mb-3">
                        <h5 class="card-title">투입품 목록</h5>
                        <table class="table">
                            <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">품목코드</th>
                                <th scope="col">품목명</th>
                                <th scope="col">투입수량</th>
                            </tr>
                            </thead>
                            <tbody id="in_item_tbody">
                            <tr id="in_item_tr">
                                <!-- <th scope="row"></th>
                                <td></td>
                                <td></td>
                                <td></td> -->
                            </tr>
                            </tbody>
                        </table>
                    </div>
              
                    <!-- 작업일수 -->
                    <div class="row mb-3">
                      <label for="work_dt" class="col-sm-3 col-form-label">작업일수</label>
                      <div class="col-sm-9">
                        <input type="text" class="form-control" id="work_dt" disabled/>
                      </div>
                    </div>

                    <!-- 작업시 주의사항 -->
                    <div class="row mb-3">
                      <label for="work_cmd" class="col-sm-6 col-form-label">작업시 주의사항</label>
                      <div class="col-sm-12">
                        <textarea id="work_cmd" cols="30" rows="10" class="form-control" style="height: 100px" disabled>
                        </textarea>
                      </div>
                    </div>

                    <!-- 비고 -->
                    <div class="row mb-3">
                      <label for="remark" class="col-sm-3 col-form-label">비고</label>
                      <div class="col-sm-12">
                        <textarea id="remark" cols="30" rows="10" class="form-control" style="height: 100px" disabled>
                        </textarea>
                      </div>
                    </div>

                </div>
                <!-- End modal-body -->

                <div class="modal-footer">
                  <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
                </div>
                <!-- End modal-footer -->

            </div>
        </div>
    </div>
    <!-- 생산지시내역 조회 모달 끝 -->

</body>
</html>


