<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<aside id="sidebar" class="sidebar">

        <ul class="sidebar-nav" id="sidebar-nav">
        
        	<li class="nav-item">
                <a class="nav-link collapsed" href="/main">
                    <i class="bi bi-grid"></i>
                    <span>스마트 제조 시스템</span>
                </a>
            </li>
        
        	
			 <li class="nav-item">
		        <a class="nav-link collapsed" data-bs-target="#standard-info-nav" data-bs-toggle="collapse" href="#">
		          <i class="bi bi-credit-card-2-front-fill"></i>
		          <span>기준 정보 관리</span>
		          <i class="bi bi-chevron-down ms-auto"></i>
		        </a>
		        <ul id="standard-info-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
		          <li>
		            <a href="/compmst">
		              <i class="bi bi-circle"></i><span>사업장 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/custmst">
		              <i class="bi bi-circle"></i><span>거래처 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/itemmst">
		              <i class="bi bi-circle"></i><span>품목 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/procmst">
		              <i class="bi bi-circle"></i><span>공정 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/whmst">
		              <i class="bi bi-circle"></i><span>창고 관리</span>
		            </a>
		          </li>
		        </ul>
      		</li>
      		
      		<li class="nav-item">
		        <a class="nav-link collapsed" data-bs-target="#purchase-sales-nav" data-bs-toggle="collapse" href="#">
		          <i class="bi bi-briefcase-fill"></i>
		          <span>구매 / 영업 관리</span>
		          <i class="bi bi-chevron-down ms-auto"></i>
		        </a>
		        <ul id="purchase-sales-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
		          <li>
		            <a href="/purchase">
		              <i class="bi bi-circle"></i><span>발주 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/order">
		              <i class="bi bi-circle"></i><span>주문 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/outitem">
		              <i class="bi bi-circle"></i><span>출고 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/return">
		              <i class="bi bi-circle"></i><span>반품 관리</span>
		            </a>
		          </li>
		        </ul>
      		</li>
      		
      		<li class="nav-item">
		        <a class="nav-link collapsed" data-bs-target="#material-nav" data-bs-toggle="collapse" href="#">
		          <i class="bi bi-bricks"></i>
		          <span>자재 관리</span>
		          <i class="bi bi-chevron-down ms-auto"></i>
		        </a>
		        <ul id="material-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
		          <li>
		            <a href="/initem">
		              <i class="bi bi-circle"></i><span>입고 관리</span>
		            </a>
		          </li>
		        </ul>
      		</li>
      		
      		<li class="nav-item">
		        <a class="nav-link collapsed" data-bs-target="#produce-nav" data-bs-toggle="collapse" href="#">
		          <i class="bi bi-box-seam"></i>
		          <span>생산 관리</span>
		          <i class="bi bi-chevron-down ms-auto"></i>
		        </a>
		        <ul id="produce-nav" class="nav-content collapse " data-bs-parent="#sidebar-nav">
		          <li>
		            <a href="/prodplan">
		              <i class="bi bi-circle"></i><span>생산 계획</span>
		            </a>
		          </li>
		          <li>
		            <a href="/proditem">
		              <i class="bi bi-circle"></i><span>생산 실적 관리</span>
		            </a>
		          </li>
		          <li>
		            <a href="/workprod">
		              <i class="bi bi-circle"></i><span>생산 지시</span>
		            </a>
		          </li>
		        </ul>
      		</li>
      		 
        </ul>

    </aside>