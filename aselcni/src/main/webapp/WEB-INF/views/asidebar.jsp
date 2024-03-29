<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<aside id="sidebar" class="sidebar">

        <ul class="sidebar-nav" id="sidebar-nav">
        
        	<li class="nav-item">
                <a class="nav-link collapsed" href="/main">
                    <i class="bi bi-grid"></i>
                    <span>스마트 제조 시스템</span>
                </a>
            </li>
        	
        	<c:forEach var="menuList" items="${sessionScope.menuListGroupByMenu }">
				<c:choose>
					<c:when test="${menuList.size() == 1}">
						<li class="nav-item">
							<a class="nav-link collapsed" href="/${menuList.get(0).getUrl() }"> 
								<i class="${menuList.get(0).getIcon() }"></i> 
								<span>${menuList.get(0).getMenu_nm() }</span>
							</a>
						</li>
					</c:when>
					<c:otherwise>
						<li class="nav-item">
							<a class="nav-link collapsed" data-bs-target="#${menuList.get(0).getMenu_id() }" data-bs-toggle="collapse" href="#">
							   <i class="${menuList.get(0).getIcon() }"></i>
							   <span>${menuList.get(0).getMenu_nm() }</span>
							   <i class="bi bi-chevron-down ms-auto"></i>
							</a>
							<ul id="${menuList.get(0).getMenu_id() }" class="nav-content collapse " data-bs-parent="#sidebar-nav">
								<c:forEach var="menu" items="${menuList }" begin="1">
									<li>
							          <a href="/${menu.getUrl() }">
							            <i class="bi bi-circle"></i>
							            <span>${menu.getMenu_nm() }</span>
							          </a>
							        </li>
								</c:forEach>
							</ul>
						</li>
					</c:otherwise>
				</c:choose>
        	</c:forEach>
        	
        </ul>

    </aside>