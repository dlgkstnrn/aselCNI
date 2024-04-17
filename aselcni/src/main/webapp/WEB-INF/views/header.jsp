<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<header id="header" class="header fixed-top d-flex align-items-center">
<script type="text/javascript">
	let loginChk = '${user_id}';
	if(loginChk== null || loginChk == ""){
		location.href="/";
	}
</script>
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
                    	<span class="d-none d-md-block dropdown-toggle ps-2">${sessionScope.user_nm }</span>
                    </a><!-- End Profile Iamge Icon -->

                    <ul class="dropdown-menu dropdown-menu-end dropdown-menu-arrow profile">
                        <li class="dropdown-header">
                            <h6>${sessionScope.user_nm }</h6>
                            <c:choose>
                            	<c:when test="${sessionScope.user_comm_code == 10010}">
                            		<span>관리자</span>
                            	</c:when>
                            	<c:otherwise>
                            		<span>${sessionScope.comm_content }</span>
                            	</c:otherwise>
                            </c:choose>
                        </li>
                        <li>
                            <hr class="dropdown-divider">
                        </li>

			            <li>
			              <a class="dropdown-item d-flex align-items-center" href="/userLogout">
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