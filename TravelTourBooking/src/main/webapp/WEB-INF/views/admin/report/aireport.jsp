<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>AI Report Dashboard</title>
        <!-- Thêm Bootstrap để giao diện đẹp -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
        <!-- Thêm jQuery -->
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <!-- Thêm Chart.js -->
        <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    </head>
    <body class="bg-light">

        <div class="container mt-5">
            <div class="card shadow">
                <div class="card-header bg-primary text-white">
                    <h5 class="mb-0">Trợ lý Phân tích Dữ liệu AI</h5>
                </div>
                <div class="card-body">
                    <!-- Khu vực nhập liệu -->
                    <div class="input-group mb-3">
                        <input type="text" id="questionInput" class="form-control" placeholder="Ví dụ: Doanh thu tháng này của tôi là bao nhiêu?">
                        <button class="btn btn-success" onclick="askAI()">Phân tích</button>
                    </div>

                    <!-- Khu vực hiển thị thông báo/tóm tắt -->
                    <div id="resultArea" class="mt-3">
                        <p id="summaryText" class="text-muted"></p>
                    </div>

                    <!-- Khu vực hiển thị biểu đồ -->
                    <div class="mt-4" style="max-width: 600px; margin: auto;">
                        <canvas id="reportChart"></canvas>
                    </div>
                </div>
            </div>
        </div>

        <script>
            let myChart = null;

            function askAI() {
                var question = $('#questionInput').val();
                if (!question)
                    return;

                $.ajax({
                    url: '${pageContext.request.contextPath}/admin/ai/ask',
                    type: 'POST',
                    data: {question: question},
                    success: function (response) {
                        // Kiểm tra console để xem dữ liệu trả về có đúng không
                        console.log("Dữ liệu từ server:", response);

                        if (response.isValid) {
                            $('#summaryText').text(response.summary);
                            if (response.chartType && response.chartType !== 'NONE') {
                                // Gọi hàm với dữ liệu thực từ response.data
                                renderChart(response.chartType, response.data);
                            }
                        } else {
                            $('#summaryText').text("AI phản hồi: " + response.summary);
                        }
                    },
                    error: function (xhr, status, error) {
                        console.error("Lỗi AJAX:", error);
                        alert("Có lỗi xảy ra khi kết nối với AI!");
                    }
                });
            }

            function renderChart(type, chartData) {
                const ctx = document.getElementById('reportChart').getContext('2d');
                if (myChart)
                    myChart.destroy();

                myChart = new Chart(ctx, {
                    type: type.toLowerCase(),
                    data: {
                        labels: ['Tháng 1', 'Tháng 2', 'Tháng 3', 'Tháng 4', 'Tháng 5', 'Tháng 6'], // Bạn có thể sửa labels tùy ý
                        datasets: [{
                                label: 'Doanh thu',
                                data: chartData,
                                backgroundColor: 'rgba(54, 162, 235, 0.5)',
                                borderColor: 'rgba(54, 162, 235, 1)',
                                borderWidth: 1
                            }]
                    },
                    options: {
                        responsive: true
                    }
                });
            }
        </script>

    </body>
</html>