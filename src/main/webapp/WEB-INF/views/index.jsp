<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ page import="java.util.*, java.text.*" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%
    // 오늘 날짜 가져오기
    Calendar cal = Calendar.getInstance();
    cal.setTime(new Date());
    SimpleDateFormat month = new SimpleDateFormat("yyyy-MM-dd");
    String monthDayOfMonth = month.format(cal.getTime());

    // 달의 첫 번째 날짜로 설정
    cal.set(Calendar.DAY_OF_MONTH, 1);

    // 날짜 형식 변환
    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
    String firstDayOfMonth = sdf.format(cal.getTime());

%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>Home</title>
    <link href="css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <style>
        .datatable-info {
            display: none;
        }
    </style>
</head>
<body class="nav-fixed">

<!-- Header Section Begin -->
<c:import url="./temp/topheader.jsp"></c:import>
<!-- Header End -->
<div id="layoutSidenav">
    <!-- Header Section Begin -->
    <c:import url="./temp/leftheader.jsp"></c:import>
    <!-- Header End -->
    <div id="layoutSidenav_content">
        <main>
            <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
                <div class="container-fluid px-4">
                    <div class="page-header-content">
                        <div class="row align-items-center justify-content-between pt-3">
                            <div class="col-auto mb-3">
                                <h1 class="page-header-title">
                                    <div class="page-header-icon"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-user"><path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path><circle cx="12" cy="7" r="4"></circle></svg></div>
                                    DASH BOARD
                                </h1>
                            </div>
                        </div>
                    </div>
                </div>
            </header>
            <form>
                <!-- Main page content-->
                <div class="container-fluid px-4">
                    <div class="card mb-4">
                        <div class="card-body">
                            지점: <input type="text" value="Mohotel" disabled>
                            조회기간:<input id="startDate" type="date" value="<%= firstDayOfMonth %>" readonly> ~
                            <input id="endDate" type="date" value="<%= monthDayOfMonth %>">
                            <div class="btn-group" role="group" aria-label="Button group">
                                <button class="btn btn-dark btn-sm" type="button" id="btn-day">일</button>
                                <button class="btn btn-dark btn-sm" type="button" id="btn-month">월</button>
                            </div>
                        </div>

                    </div>
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="todaySales">
                                <div class="row" style="position: relative;">
                                    <div class="col-6" style="overflow: hidden;">
                                    <div id="piechart" style="width: 900px; height: 500px;"></div>
                                        <script>
                                            var chartData = [
                                                <c:forEach var="monthSalesPie" items="${monthSalesPie}" varStatus="status">
                                                ['${monthSalesPie.roomType} (${monthSalesPie.count})', ${monthSalesPie.count}]${!status.last ? ',' : ''}
                                                </c:forEach>
                                            ];

                                            // 차트 그리기 함수
                                            function drawChart() {
                                                var data = google.visualization.arrayToDataTable([
                                                    ['Room Type', 'Count'],
                                                    ...chartData
                                                ]);

                                                var options = {
                                                    title: 'Month 예약 현황',
                                                    // 툴팁에 백분율 표시
                                                    tooltip: {
                                                        showPercentage: true
                                                    }
                                                };

                                                var chart = new google.visualization.PieChart(document.getElementById('piechart'));

                                                chart.draw(data, options);
                                            }

                                            // Google Charts 로드 후 차트 그리기 함수 호출
                                            google.charts.load('current', {'packages':['corechart']});
                                            google.charts.setOnLoadCallback(drawChart);
                                        </script>
                                    </div>

                                    <div class="col-6" style="display: flex; align-items: center;">
                                        <table id="datatablesSimple" class="datatable-table">
                                            <thead>
                                            <tr>
                                                <%-- <th data-orderable="false"></th>--%>
                                                <th>객실</th>
                                                <th>분류</th>
                                                <th>매출</th>
                                            </tr>
                                            </thead>
                                            <tbody id="myTable">
                                            <%--<c:forEach var="monthVO" items="${monthVO}">
                                            <tr>
                                                <td>${monthVO.roomType}</td>
                                                <td>ROOM</td>
                                                <td align="right"><span class="total">${monthVO.total}</span>원</td>
                                            </tr>
                                            </c:forEach>--%>
                                            <c:forEach var="monthVO" items="${monthVO}">
                                                <!-- 유저 정보-->
                                                <tr>
                                                    <td>${monthVO.roomType}</td>
                                                    <td>ROOM</td>
                                                        <%--                    <td align="right">${vo.todaySales}원</td>--%>
                                                    <td><fmt:formatNumber value="${monthVO.total}" pattern="#,###"/>원</td>
                                                </tr>
                                            </c:forEach>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-body">
                            <div class="chart-area">
                                <%--<div class="chartjs-size-monitor">
                                    <div class="chartjs-size-monitor-expand">
                                        <div class=""></div>
                                    </div>
                                    <div class="chartjs-size-monitor-shrink">
                                        <div class=""></div>
                                    </div>
                                </div>--%>
                                <canvas id="myAreaChart" width="1347" height="240"
                                        style="display: block; height: 240px; width: 1347px;"
                                        class="chartjs-render-monitor"></canvas>
                            </div>
                        </div>
                    </div>
                </div>
            </form>
        </main>
        <!-- Footer Section Begin -->
        <c:import url="./temp/footer.jsp"></c:import>
        <!-- Footer Section End -->
    </div>
</div>
<script>
    // 페이지 로드 시 차트 그리기 함수 호출
    google.charts.load('current', {'packages':['corechart']});
    google.charts.setOnLoadCallback(drawChart);
</script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="/js/datatables-simple-demo-sub.js"></script>
<script src="js/index.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
<script src="/js/chart-area-demo.js"></script>
<script src="/js/managerStock.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/js/partnerWebSocket.js"></script>
</body>
</html>