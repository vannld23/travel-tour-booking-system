<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="utf-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>Dashboard</title>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
    <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:wght,FILL@100..700,0..1&display=swap" rel="stylesheet"/>
    <style>
        :root {
            --navy: #0b2f6f;
            --navy-2: #07285d;
            --blue: #1492f3;
            --bg: #f4f6fb;
            --card: #ffffff;
            --line: #dce4f2;
            --text: #15304f;
            --muted: #6a7890;
            --good: #16a34a;
            --warn: #f59e0b;
            --bad: #ef4444;
            --shadow: 0 12px 32px rgba(18, 34, 62, 0.08);
        }
        * { box-sizing: border-box; }
        body {
            margin: 0;
            font-family: "Inter", sans-serif;
            background:
                radial-gradient(circle at top left, rgba(20, 146, 243, 0.08), transparent 28%),
                linear-gradient(180deg, #f6f8fc 0%, var(--bg) 100%);
            color: var(--text);
        }
        .dashboard-shell {
            min-height: 100vh;
            display: flex;
        }
        .sidebar-panel {
            width: 280px;
            min-height: 100vh;
            position: sticky;
            top: 0;
            padding: 26px 18px 18px;
            background: linear-gradient(180deg, var(--navy) 0%, var(--navy-2) 100%);
            color: white;
            display: flex;
            flex-direction: column;
            gap: 24px;
            box-shadow: inset -1px 0 0 rgba(255,255,255,0.08);
        }
        .sidebar-brand h1 {
            margin: 0;
            font-size: 28px;
            line-height: 1.05;
            font-weight: 800;
            letter-spacing: -0.03em;
        }
        .sidebar-eyebrow {
            margin: 0 0 8px;
            font-size: 13px;
            color: rgba(255,255,255,0.72);
        }
        .sidebar-nav {
            display: flex;
            flex-direction: column;
            gap: 10px;
            flex: 1;
        }
        .sidebar-link {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 14px 16px;
            border-radius: 14px;
            color: rgba(255,255,255,0.84);
            text-decoration: none;
            transition: transform .18s ease, background-color .18s ease, color .18s ease;
        }
        .sidebar-link:hover { background: rgba(255,255,255,0.08); color: white; transform: translateX(2px); }
        .sidebar-link.is-active { background: var(--blue); color: white; box-shadow: 0 10px 22px rgba(20,146,243,0.25); }
        .material-symbols-outlined { font-variation-settings: 'FILL' 0, 'wght' 400, 'GRAD' 0, 'opsz' 24; }
        .sidebar-link .material-symbols-outlined { font-size: 20px; }
        .sidebar-profile {
            display: grid;
            grid-template-columns: 44px 1fr;
            gap: 12px;
            align-items: center;
            padding: 12px;
            border-radius: 18px;
            background: rgba(255,255,255,0.08);
            border: 1px solid rgba(255,255,255,0.08);
        }
        .profile-avatar {
            width: 44px;
            height: 44px;
            border-radius: 50%;
            display: grid;
            place-items: center;
            background: linear-gradient(135deg, #7ac8ff, #2e8cff);
            font-weight: 700;
            color: white;
        }
        .profile-text { display: flex; flex-direction: column; gap: 2px; }
        .profile-text strong { font-size: 14px; }
        .profile-text span { font-size: 12px; color: rgba(255,255,255,0.72); }
        .logout-chip {
            grid-column: 1 / -1;
            margin-top: 2px;
            border: 0;
            border-radius: 999px;
            padding: 10px 12px;
            background: rgba(255,255,255,0.08);
            color: white;
            font: inherit;
            cursor: default;
        }
        .dashboard-content {
            flex: 1;
            padding: 24px 28px 28px;
        }
        .topbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 18px;
            margin-bottom: 20px;
        }
        .eyebrow {
            margin: 0 0 8px;
            color: var(--blue);
            font-weight: 600;
            font-size: 13px;
        }
        .page-title {
            margin: 0;
            font-size: 30px;
            line-height: 1.1;
            font-weight: 800;
            letter-spacing: -0.03em;
        }
        .page-subtitle {
            margin: 6px 0 0;
            color: var(--muted);
            font-size: 14px;
        }
        .top-actions {
            display: flex;
            align-items: center;
            gap: 12px;
            min-width: 0;
        }
        .search-box {
            width: 320px;
            max-width: 38vw;
            display: flex;
            align-items: center;
            gap: 10px;
            padding: 12px 14px;
            border-radius: 14px;
            background: rgba(255,255,255,0.92);
            border: 1px solid var(--line);
            box-shadow: var(--shadow);
            color: var(--muted);
        }
        .search-box input {
            border: 0;
            outline: none;
            width: 100%;
            background: transparent;
            font: inherit;
        }
        .date-chip {
            white-space: nowrap;
            padding: 12px 14px;
            border-radius: 14px;
            background: rgba(255,255,255,0.92);
            border: 1px solid var(--line);
            box-shadow: var(--shadow);
            font-weight: 600;
        }
        .metrics-grid {
            display: grid;
            grid-template-columns: repeat(4, minmax(0, 1fr));
            gap: 16px;
            margin-bottom: 16px;
        }
        .metric-card, .panel {
            background: rgba(255,255,255,0.95);
            border: 1px solid rgba(220,228,242,0.9);
            box-shadow: var(--shadow);
            border-radius: 20px;
        }
        .metric-card {
            padding: 18px;
            display: flex;
            flex-direction: column;
            gap: 14px;
            min-height: 140px;
        }
        .metric-row {
            display: flex;
            justify-content: space-between;
            align-items: start;
            gap: 12px;
        }
        .metric-icon {
            width: 44px;
            height: 44px;
            border-radius: 14px;
            display: grid;
            place-items: center;
            background: linear-gradient(135deg, rgba(20,146,243,0.12), rgba(20,146,243,0.04));
            color: var(--blue);
        }
        .metric-trend {
            font-size: 12px;
            font-weight: 700;
            color: var(--good);
            background: rgba(22,163,74,0.08);
            padding: 6px 10px;
            border-radius: 999px;
        }
        .metric-label {
            font-size: 12px;
            color: var(--muted);
            text-transform: uppercase;
            letter-spacing: 0.05em;
            margin-bottom: 6px;
            font-weight: 700;
        }
        .metric-value {
            margin: 0;
            font-size: 30px;
            font-weight: 800;
            letter-spacing: -0.03em;
        }
        .metric-caption {
            color: var(--muted);
            font-size: 13px;
        }
        .metric-card:nth-child(2) .metric-icon { color: #f97316; background: linear-gradient(135deg, rgba(249,115,22,0.12), rgba(249,115,22,0.04)); }
        .metric-card:nth-child(3) .metric-icon { color: #10b981; background: linear-gradient(135deg, rgba(16,185,129,0.12), rgba(16,185,129,0.04)); }
        .metric-card:nth-child(4) .metric-icon { color: #22c55e; background: linear-gradient(135deg, rgba(34,197,94,0.12), rgba(34,197,94,0.04)); }
        .content-grid {
            display: grid;
            grid-template-columns: minmax(0, 1.6fr) minmax(280px, 0.9fr);
            gap: 16px;
            margin-bottom: 16px;
        }
        .panel {
            padding: 18px;
        }
        .panel-head {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 12px;
            margin-bottom: 16px;
        }
        .panel-title {
            margin: 0;
            font-size: 16px;
            font-weight: 800;
        }
        .panel-note, .panel-link {
            color: var(--muted);
            font-size: 13px;
            text-decoration: none;
        }
        .chart {
            display: flex;
            align-items: end;
            gap: 10px;
            height: 240px;
            padding: 14px 0 6px;
            border-radius: 16px;
            background:
                linear-gradient(180deg, rgba(20,146,243,0.03), rgba(20,146,243,0)),
                radial-gradient(circle at top right, rgba(20,146,243,0.08), transparent 40%);
        }
        .chart-col {
            flex: 1;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: end;
            gap: 10px;
            min-width: 0;
        }
        .chart-bar-wrap {
            width: 100%;
            height: 180px;
            display: flex;
            align-items: end;
        }
        .chart-bar {
            width: 100%;
            border-radius: 14px 14px 8px 8px;
            background: linear-gradient(180deg, #78c2ff 0%, #4fa5f5 100%);
            box-shadow: inset 0 -1px 0 rgba(255,255,255,0.34);
            min-height: 18px;
        }
        .chart-label {
            font-size: 12px;
            color: var(--muted);
            font-weight: 600;
        }
        .chart-value {
            font-size: 12px;
            color: var(--text);
            font-weight: 700;
        }
        .dest-list {
            display: flex;
            flex-direction: column;
            gap: 14px;
        }
        .dest-item {
            display: grid;
            grid-template-columns: 62px 1fr auto;
            gap: 12px;
            align-items: center;
        }
        .dest-thumb {
            width: 62px;
            height: 44px;
            border-radius: 12px;
            background:
                linear-gradient(135deg, rgba(20,146,243,0.24), rgba(20,146,243,0.78)),
                linear-gradient(45deg, rgba(255,255,255,0.2), rgba(255,255,255,0.05));
            position: relative;
            overflow: hidden;
        }
        .dest-thumb::after {
            content: "";
            position: absolute;
            inset: 8px;
            border-radius: 10px;
            background: rgba(255,255,255,0.12);
        }
        .dest-name {
            font-weight: 700;
            margin: 0 0 4px;
        }
        .dest-meta {
            margin: 0;
            color: var(--muted);
            font-size: 13px;
        }
        .percent {
            font-weight: 800;
            color: var(--blue);
        }
        .progress {
            grid-column: 2 / 4;
            height: 8px;
            border-radius: 999px;
            background: #e8eef8;
            overflow: hidden;
            margin-top: -4px;
        }
        .progress > span {
            display: block;
            height: 100%;
            border-radius: inherit;
            background: linear-gradient(90deg, #5fb4ff, #1492f3);
        }
        .table-wrap {
            overflow: auto;
        }
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            text-align: left;
            padding: 14px 12px;
            border-bottom: 1px solid #e6edf7;
            font-size: 14px;
        }
        th {
            color: #6a7890;
            font-size: 12px;
            letter-spacing: .04em;
            text-transform: uppercase;
        }
        tbody tr:hover { background: #f8fbff; }
        .status-pill {
            display: inline-flex;
            align-items: center;
            padding: 7px 10px;
            border-radius: 999px;
            font-size: 12px;
            font-weight: 700;
            white-space: nowrap;
        }
        .status-success { background: rgba(22,163,74,0.12); color: #15803d; }
        .status-warning { background: rgba(245,158,11,0.12); color: #b45309; }
        .status-danger { background: rgba(239,68,68,0.12); color: #b91c1c; }
        .status-neutral { background: rgba(100,116,139,0.12); color: #475569; }
        .row-actions {
            display: inline-flex;
            gap: 10px;
            color: #94a3b8;
        }
        .subtle-note {
            margin-top: 10px;
            font-size: 12px;
            color: var(--muted);
        }
        @media (max-width: 1180px) {
            .metrics-grid { grid-template-columns: repeat(2, minmax(0, 1fr)); }
            .content-grid { grid-template-columns: 1fr; }
        }
        @media (max-width: 860px) {
            .dashboard-shell { flex-direction: column; }
            .sidebar-panel { width: 100%; min-height: auto; position: relative; }
            .dashboard-content { padding: 18px; }
            .topbar { flex-direction: column; align-items: stretch; }
            .top-actions { flex-direction: column; align-items: stretch; }
            .search-box { width: 100%; max-width: none; }
        }
    </style>
</head>
<body>
<div class="dashboard-shell">
    <%@ include file="../layout/sidebar.jsp" %>
    <main class="dashboard-content">
        <div class="topbar">
            <div>
                <p class="eyebrow">Bảng điều khiển Tổng Quan</p>
                <h2 class="page-title">Chào mừng trở lại! Đây là tóm tắt hoạt động hôm nay.</h2>
                <p class="page-subtitle">Cập nhật nhanh số liệu tour, đặt chỗ và doanh thu trong một màn hình.</p>
            </div>
            <div class="top-actions">
                <label class="search-box">
                    <span class="material-symbols-outlined">search</span>
                    <input type="text" value="Tìm điểm đi đến, tour..." aria-label="Tìm kiếm">
                </label>
                <div class="date-chip">
                    <span class="material-symbols-outlined" style="font-size:18px; vertical-align:middle; margin-right:6px;">event</span>
                    Hôm nay
                </div>
            </div>
        </div>

        <section class="metrics-grid">
            <article class="metric-card">
                <div class="metric-row">
                    <div class="metric-icon"><span class="material-symbols-outlined">groups</span></div>
                    <span class="metric-trend"><c:out value="${userTrend}"/></span>
                </div>
                <div>
                    <div class="metric-label">Tổng người dùng</div>
                    <p class="metric-value"><fmt:formatNumber value="${totalUsers}" groupingUsed="true"/></p>
                    <div class="metric-caption">Tài khoản đang có trong hệ thống</div>
                </div>
            </article>

            <article class="metric-card">
                <div class="metric-row">
                    <div class="metric-icon"><span class="material-symbols-outlined">explore</span></div>
                    <span class="metric-trend"><c:out value="${tourTrend}"/></span>
                </div>
                <div>
                    <div class="metric-label">Tour đang hoạt động</div>
                    <p class="metric-value"><fmt:formatNumber value="${activeTours}" groupingUsed="true"/></p>
                    <div class="metric-caption">Các tour đang hiển thị và bán</div>
                </div>
            </article>

            <article class="metric-card">
                <div class="metric-row">
                    <div class="metric-icon"><span class="material-symbols-outlined">confirmation_number</span></div>
                    <span class="metric-trend"><c:out value="${bookingTrend}"/></span>
                </div>
                <div>
                    <div class="metric-label">Đơn đặt mới</div>
                    <p class="metric-value"><fmt:formatNumber value="${newBookings}" groupingUsed="true"/></p>
                    <div class="metric-caption">Đơn trong 30 ngày gần nhất</div>
                </div>
            </article>

            <article class="metric-card">
                <div class="metric-row">
                    <div class="metric-icon"><span class="material-symbols-outlined">paid</span></div>
                    <span class="metric-trend"><c:out value="${revenueTrend}"/></span>
                </div>
                <div>
                    <div class="metric-label">Tổng doanh thu</div>
                    <p class="metric-value"><c:out value="${totalRevenue}"/></p>
                    <div class="metric-caption">Tổng thu đã thanh toán</div>
                </div>
            </article>
        </section>

        <section class="content-grid">
            <article class="panel">
                <div class="panel-head">
                    <div>
                        <h3 class="panel-title">Doanh thu theo thời gian</h3>
                        <div class="panel-note">7 ngày qua</div>
                    </div>
                    <a class="panel-link" href="<c:url value='/report/revenue'/>">Xem báo cáo chi tiết</a>
                </div>
                <div class="chart">
                    <c:forEach var="point" items="${revenueChart}">
                        <div class="chart-col">
                            <div class="chart-bar-wrap">
                                <div class="chart-bar" style="height: ${point.heightPercent}%"></div>
                            </div>
                            <div class="chart-value"><fmt:formatNumber value="${point.value}" groupingUsed="true" maxFractionDigits="0"/></div>
                            <div class="chart-label"><c:out value="${point.label}"/></div>
                        </div>
                    </c:forEach>
                </div>
                <div class="subtle-note">Nếu chưa có doanh thu thực tế, biểu đồ sẽ hiển thị số liệu minh họa để dashboard không bị trống.</div>
            </article>

            <article class="panel">
                <div class="panel-head">
                    <div>
                        <h3 class="panel-title">Điểm đến hàng đầu</h3>
                        <div class="panel-note">Theo số tour đang mở</div>
                    </div>
                    <a class="panel-link" href="<c:url value='/destination/list'/>">Xem tất cả</a>
                </div>
                <div class="dest-list">
                    <c:forEach var="dest" items="${topDestinations}">
                        <div class="dest-item">
                            <div class="dest-thumb"></div>
                            <div>
                                <p class="dest-name"><c:out value="${dest.name}"/></p>
                                <p class="dest-meta"><c:out value="${dest.count}"/> tour đang mở</p>
                            </div>
                            <div class="percent"><c:out value="${dest.percent}"/>%</div>
                            <div class="progress"><span style="width: ${dest.percent}%"></span></div>
                        </div>
                    </c:forEach>
                </div>
            </article>
        </section>

        <section class="panel">
            <div class="panel-head">
                <div>
                    <h3 class="panel-title">Đơn đặt gần đây</h3>
                    <div class="panel-note">Cập nhật theo dữ liệu booking mới nhất</div>
                </div>
                <a class="panel-link" href="<c:url value='/booking/list'/>">Xem tất cả</a>
            </div>
            <div class="table-wrap">
                <table>
                    <thead>
                        <tr>
                            <th>Khách hàng</th>
                            <th>Tên tour</th>
                            <th>Ngày đi</th>
                            <th>Giá trị</th>
                            <th>Trạng thái</th>
                            <th></th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="booking" items="${recentBookings}">
                            <tr>
                                <td><c:out value="${booking.customerName}"/></td>
                                <td><c:out value="${booking.tourName}"/></td>
                                <td><c:out value="${booking.bookingDate}"/></td>
                                <td><c:out value="${booking.amount}"/></td>
                                <td><span class="status-pill ${booking.statusClass}"><c:out value="${booking.status}"/></span></td>
                                <td><span class="row-actions">⋮</span></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </section>
    </main>
</div>
</body>
</html>
