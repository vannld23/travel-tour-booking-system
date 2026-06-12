<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<aside class="sidebar-panel">
    <div class="sidebar-brand">
        <p class="sidebar-eyebrow">Bảng điều khiển Quản trị</p>
        <h1>Hạ cánh Du lịch</h1>
    </div>

    <nav class="sidebar-nav">
        <a class="sidebar-link" href="<c:url value='/dashboard'/>">
            <span class="material-symbols-outlined">dashboard</span>
            <span>Tổng quan</span>
        </a>
        <a class="sidebar-link is-active" href="<c:url value='/tuormanagement/list'/>">
            <span class="material-symbols-outlined">explore</span>
            <span>Quản lý Tour</span>
        </a>
        <a class="sidebar-link" href="<c:url value='/booking/list'/>">
            <span class="material-symbols-outlined">confirmation_number</span>
            <span>Quản lý Đặt chỗ</span>
        </a>
        <a class="sidebar-link" href="<c:url value='/report/revenue'/>">
            <span class="material-symbols-outlined">analytics</span>
            <span>Báo cáo</span>
        </a>
        <a class="sidebar-link" href="<c:url value='/system/setting'/>">
            <span class="material-symbols-outlined">settings</span>
            <span>Cài đặt</span>
        </a>
    </nav>

    <div class="sidebar-profile">
        <div class="profile-avatar">QT</div>
        <div class="profile-text">
            <strong>Quản trị viên</strong>
            <span>Logistics Du lịch</span>
        </div>
        <button type="button" class="logout-chip">Đăng xuất</button>
    </div>
</aside>
