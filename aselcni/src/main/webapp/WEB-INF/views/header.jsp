<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<header id="header" class="header fixed-top d-flex align-items-center">

        <div class="d-flex align-items-center justify-content-between">
            <a href="main" class="logo d-flex align-items-center">
                <span class="d-none d-lg-block">스마트 제조 시스템</span>
            </a>
            <i class="bi bi-list toggle-sidebar-btn"></i>
        </div><!-- End Logo -->

        <nav class="header-nav ms-auto">
            <ul class="d-flex align-items-center">

                <li class="nav-item dropdown pe-3">

                    <a class="nav-link nav-profile d-flex align-items-center pe-0" href="#" data-bs-toggle="dropdown">
                    </a><!-- End Profile Iamge Icon -->

                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                        <li class="dropdown-header">
                            <h6>${sessionScope.user_name }</h6>
                            <span>회원</span>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>

                        <li>
			              <a class="dropdown-item d-flex align-items-center" href="myPage">
			                <i class="bi bi-person"></i>
			                <span>마이페이지</span>
			              </a>
			            </li>
			            <li>
			              <hr class="dropdown-divider">
			            </li>
			            
			            <li>
			              <a class="dropdown-item d-flex align-items-center" href="askMain">
			                <i class="bi bi-question-circle"></i>
			                <span>문의하기</span>
			              </a>
			            </li>
			            <li>
			              <hr class="dropdown-divider">
			            </li>
			
			            <li>
			              <a class="dropdown-item d-flex align-items-center" href="userLogout">
			                <i class="bi bi-box-arrow-right"></i>
			                <span>로그아웃</span>
			              </a>
			            </li>
			            <li>
			              <hr class="dropdown-divider">
			            </li>

                    </ul><!-- End Profile Dropdown Items -->
                </li><!-- End Profile Nav -->

            </ul>
        </nav><!-- End Icons Navigation -->

    </header><!-- End Header -->