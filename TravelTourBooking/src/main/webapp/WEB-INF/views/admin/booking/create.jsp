<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>

<html lang="vi">
    <head>
        <meta charset="UTF-8">
        <title>Tạo Đặt Chỗ | VoyagerElite Admin</title>

        ```
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet"/>
        <link href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined" rel="stylesheet"/>
        <script src="https://cdn.tailwindcss.com"></script>

        <style>
            body{
                font-family:'Inter',sans-serif;
                background:#EEF2F6;
            }
        </style>
        ```

    </head>

    <body>

        <div class="flex min-h-screen">

            ```
            <%@ include file="../layout/sidebar.jsp" %>

            <main class="flex-1 ml-[280px] p-8">

                <!-- Header -->
                <div class="mb-8">

                    <h1 class="text-3xl font-bold text-[#05285D]">
                        Tạo Đặt Chỗ Mới
                    </h1>

                    <p class="text-slate-500 mt-2">
                        Tạo booking cho khách hàng trong hệ thống.
                    </p>

                </div>

                <!-- Main Card -->
                <div class="bg-white border-2 border-slate-300 rounded-xl shadow-md p-8">

                    <form action="<c:url value='/booking/admin/create'/>"
                          method="post"
                          class="space-y-6">

                        <!-- User -->
                        <div>

                            <label class="block mb-2 font-semibold text-slate-700">
                                Khách hàng
                            </label>

                            <select
                                name="userId"
                                required
                                class="w-full rounded-lg border-2 border-slate-300 bg-white px-4 py-3 focus:border-blue-500 focus:outline-none">

                                <option value="">
                                    -- Chọn khách hàng --
                                </option>

                                <c:forEach var="user" items="${users}">

                                    <option value="${user.userId}">
                                        ${user.fullName}
                                    </option>

                                </c:forEach>

                            </select>

                        </div>

                        <!-- Tour -->
                        <div>

                            <label class="block mb-2 font-semibold text-slate-700">
                                Tour
                            </label>

                            <select
                                name="tourId"
                                required
                                class="w-full rounded-lg border-2 border-slate-300 bg-white px-4 py-3 focus:border-blue-500 focus:outline-none">

                                <option value="">
                                    -- Chọn tour --
                                </option>

                                <c:forEach var="tour" items="${tours}">

                                    <option value="${tour.tourId}">
                                        ${tour.tourName}
                                    </option>

                                </c:forEach>

                            </select>

                        </div>

                        <!-- Number Of People -->
                        <div>

                            <label class="block mb-2 font-semibold text-slate-700">
                                Số lượng khách
                            </label>

                            <input
                                type="number"
                                name="numberOfPeople"
                                min="1"
                                value="1"
                                required
                                class="w-full rounded-lg border-2 border-slate-300 px-4 py-3 focus:border-blue-500 focus:outline-none"/>

                        </div>

                        <!-- Info Box -->
                        <div class="bg-blue-50 border-2 border-blue-200 rounded-xl p-5">

                            <h3 class="font-bold text-[#05285D] mb-2">
                                Thông tin
                            </h3>

                            <p class="text-slate-600 text-sm">
                                Sau khi tạo, hệ thống sẽ tự động:
                            </p>

                            <ul class="mt-2 space-y-1 text-sm text-slate-700">
                                <li>• Trạng thái booking = PENDING</li>
                                <li>• Tính tổng tiền theo giá tour</li>
                                <li>• Chờ khách thực hiện thanh toán</li>
                            </ul>

                        </div>

                        <!-- Action -->
                        <div class="flex gap-4 pt-4">

                            <button
                                type="submit"
                                class="px-6 py-3 rounded-lg bg-orange-500 text-white font-semibold hover:bg-orange-600 transition-all">

                                Tạo Booking

                            </button>

                            <a href="<c:url value='/booking/list'/>"
                               class="px-6 py-3 rounded-lg border-2 border-slate-300 font-semibold hover:bg-slate-100 transition-all">

                                Hủy

                            </a>

                        </div>

                    </form>

                </div>

            </main>
            ```

        </div>

    </body>
</html>
