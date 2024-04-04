<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!-- 3. 생산지시내역 조회 모달 내용 -->
<div class="modal-header">
    <h5 class="modal-title" id="WorkProdModal">생산지시내역</h5>
    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
</div>

<div class="modal-body">
  <!-- <c:forTokens var="workProd" items="${workProd}" delims=","> -->
  <c:forEach var="workProd" items="${workProd}">
    <!-- 생산지시 담당자 ID -->
    <div class="row mb-3 d-flex">
      <label class="col-sm-3 col-form-label">지시 담당자명</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${workProd.user_nm}" disabled/>
      </div>
    </div>
    <!-- 생산지시번호 -->
    <div class="row mb-3 d-flex">
      <label class="col-sm-3 col-form-label">생산지시번호</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${workProd.workprod_no}" disabled/>
      </div>
    </div>
    <!-- 생산시작일자 -->
    <div class="row mb-3">
      <label for="workprod_dt" class="col-sm-3 col-form-label">생산시작일자</label>
      <div class="col-sm-5">
        <input type="text" class="form-control" value="${workProdworkprod_dt}" disabled/>
      </div>
    </div>
    <!-- 제품 -->
    <div class="row mb-3">
      <!-- 제품명 -->
      <label for="item_nm" class="col-sm-3 col-form-label">제품명</label>
      <div class="d-flex justify-content-between col-sm-9">
        <div class="col-sm-5">
          <input type="text" class="form-control" value="${workProd.item_nm}" disabled/>
        </div>
        <!-- 제품 생산수량 -->
        <div class="d-flex mb-3">
          <label for="qty" class="col-sm-3 col-form-label">생산수량</label>
          <div class="col-sm-4 mx-2">
            <input type="text" class="form-control" value="${workProd.qty}" disabled/>
          </div>
        </div>
      </div>
    </div>
    <!-- 공정 -->
    <div class="card-body mb-3">
      <h5 class="card-title">등록된 공정 목록</h5>
      <!-- Default Table -->
      <table class="table">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">공정코드</th>
            <th scope="col">공정명</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">1</th>
            <td>CD01</td>
            <td>튀김</td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>CD02</td>
            <td>포장</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>CD03</td>
            <td>건조</td>
          </tr>
        </tbody>
      </table>
      <!-- End Default Table Example -->
    </div>
  
    <!-- 투입품 -->
    <div class="card-body mb-3">
      <h5 class="card-title">투입품 목록</h5>
      <!-- Default Table -->
      <table class="table">
        <thead>
          <tr>
            <th scope="col">#</th>
            <th scope="col">품목코드</th>
            <th scope="col">품목명</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <th scope="row">1</th>
            <td>CD01</td>
            <td>버섯</td>
          </tr>
          <tr>
            <th scope="row">2</th>
            <td>CD02</td>
            <td>소고기</td>
          </tr>
          <tr>
            <th scope="row">3</th>
            <td>CD03</td>
            <td>간장</td>
          </tr>
        </tbody>
      </table>
      <!-- End Default Table Example -->
    </div>
  
    <!-- 작업일수 -->
    <div class="row mb-3">
      <label for="work_dt" class="col-sm-3 col-form-label">작업일수</label>
      <div class="col-sm-9">
        <input type="text" class="form-control" value="${workProd.work_dt}" disabled/>
      </div>
    </div>
    <!-- 작업시 주의사항 -->
    <div class="row mb-3">
      <label for="work_cmd" class="col-sm-6 col-form-label">작업시 주의사항</label>
      <div class="col-sm-12">
        <textarea name="work_cmd" id="work_cmd" cols="30" rows="10" class="form-control" style="height: 100px" disabled>
          ${workProd.work_cmd}
        </textarea>
      </div>
    </div>
    <!-- 비고 -->
    <div class="row mb-3">
      <label for="remark" class="col-sm-3 col-form-label">비고</label>
      <div class="col-sm-12">
        <textarea name="remark" id="remark" cols="30" rows="10" class="form-control" style="height: 100px" disabled>
          ${workProd.remark}
        </textarea>
      </div>
    </div>
  </c:forEach>
  <!-- </c:forToken> -->
</div>
<!-- End modal-body -->

<div class="modal-footer">
  <button type="button" class="btn btn-outline-secondary" data-bs-dismiss="modal">닫기</button>
</div>