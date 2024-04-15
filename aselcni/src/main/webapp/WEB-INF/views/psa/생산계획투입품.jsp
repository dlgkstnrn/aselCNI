  <!-- 투입품 -->
  <div class="row mb-3">
    <label class="col-sm-3 col-form-label">투입품</label>

    <div class="col-sm-9 mb-3">
      
      <!-- 중첩모달 띄우는 버튼 -->
      <button type="button" class="btn btn-outline-success mb-3" 
        id="btn-submit"
        data-bs-toggle="modal"
        data-bs-target="#addItem">투입품 추가</button>

      <!-- 선택된 투입품 리스트 -->
      <div class="card-body">
        <h5 class="card-title mb-2">선택한 투입품 목록</h5>
      
        <!-- List group with custom content -->
        <ol class="list-group list-group-numbered">

          <li class="list-group-item d-flex justify-content-between align-items-start">
            <div class="ms-2 me-auto">
              <div class="fw-bold" id="in_item_nm">품목명</div>
              <p id="in_item_cd">품목CD</p>
            </div>
            <!-- 투입수량 -->
            <div class="d-flex">
              <label for="qty" class="col-sm-3 col-form-label">투입수량</label>
              <div class="col-sm-3 mx-2">
                <input type="number" class="form-control" id="in_qty"/>
              </div>
            </div>
          </li>

          <li class="list-group-item d-flex justify-content-between align-items-start">
            <div class="ms-2 me-auto">
              <div class="fw-bold">${item_nm}</div>
              <p>${item_cd}</p>
            </div>
            <span class="badge bg-primary rounded-pill">${in_qty}</span>
          </li>
          <li class="list-group-item d-flex justify-content-between align-items-start">
            <div class="ms-2 me-auto">
              <div class="fw-bold">포장지</div>
              <p>CD042516</p>
            </div>
            <span class="badge bg-primary rounded-pill">55</span>
          </li>
        </ol><!-- End with custom content -->
      
      </div>
    </div>
  </div>