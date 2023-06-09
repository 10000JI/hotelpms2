<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import = "java.util.Calendar" %>
<%
    String Date = new java.text.SimpleDateFormat("yyyy. MM. dd").format(new java.util.Date());
    String Today = new java.text.SimpleDateFormat("yyyyMMdd").format(new java.util.Date());
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no"/>
    <meta name="description" content=""/>
    <meta name="author" content=""/>
    <title>Dashboard - SB Admin Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet"/>
    <link href="/css/styles.css" rel="stylesheet"/>
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png"/>
    <link rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@48,500,0,0"/>
    <script data-search-pseudo-elements defer
            src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/js/all.min.js"
            crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js"
            crossorigin="anonymous"></script>
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.8/index.global.min.js'></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<%--    <script src="/webjars/sockjs-client/sockjs.min.js"></script>--%>
<%--    <script src="/webjars/stomp-websocket/stomp.min.js"></script>--%>
<%--    <script src="/js/webSocket.js"></script>--%>


</head>
<body class="nav-fixed">

<c:import url="../temp/topheader.jsp"></c:import>
<div id="layoutSidenav">
    <c:import url="../temp/leftheader.jsp"></c:import>
    <div id="layoutSidenav_content">
        <main>
            <header class="page-header page-header-dark bg-gradient-primary-to-secondary pb-10">
                <div class="container-xl px-4">
                    <div class="page-header-content pt-4">
                        <div class="row align-items-center justify-content-between">
                            <div class="col-auto mt-4">
                                <h1 class="page-header-title">
                                    <div class="page-header-icon"><i data-feather="activity"></i></div>
                                    청소 스케줄
                                </h1>
                                <div class="page-header-subtitle"></div>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- 입력 modal -->

            <div class="modal fade" id="exampleModalLg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">청소 스케줄 등록 </h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>
                        <div class="modal-body">
                            <form id="insertSchedule" method="post" action="/clean/insertSchedule">
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1">시작날짜</label>
                                    <input class="form-control form-control-solid" id="exampleFormControlInput1"
                                           name="scheduleStartdate" type="date">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1">종료날짜</label>
                                    <input class="form-control form-control-solid" id="exampleFormControlInput2"
                                           name="scheduleEnddate" type="date">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1">팀 번호</label>
                                    <input class="form-control form-control-solid" id="exampleFormControlInput3"
                                           name="scheduleNumber" type="number" min="0">
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" id="btn" type="submit">등록</button>
                                    <button class="btn btn-primary" type="button" data-bs-dismiss="modal">Close</button>

                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>


            <!-- 수정 modal -->
            <div class="modal fade" id="exampleModalLg2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel"
                 aria-hidden="true">
                <div class="modal-dialog modal-lg" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title">청소 스케줄 등록 </h5>
                            <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                        </div>

                        <div class="modal-body">
                            <form id="insertSchedule2" method="post" action="/insertSchedule">
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1">시작날짜</label>
                                    <input class="form-control form-control-solid" id="exampleFormControlInput1-1"
                                           name="scheduleStartdate" type="date">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1">종료날짜</label>
                                    <input class="form-control form-control-solid" id="exampleFormControlInput2-1"
                                           name="scheduleEnddate" type="date">
                                </div>
                                <div class="mb-3">
                                    <label for="exampleFormControlInput1">팀 번호</label>
                                    <input class="form-control form-control-solid" id="exampleFormControlInput3-1"
                                           name="scheduleNumber" type="number" min="0">
                                </div>
                                <div class="modal-footer">
                                    <button class="btn btn-primary" id="btn2" type="submit">등록</button>
                                    <button class="btn btn-primary" type="button" data-bs-dismiss="modal">Close</button>

                                </div>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
            <%--청소보고 모달--%>
            <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <form action="/clean/upload" method="post" enctype="multipart/form-data">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel">Default Bootstrap Modal</h5>
                                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="col-md-12">
                                    <label class="small mb-1" for="1">객실</label>
                                    <input class="form-control" name="roomNumber" id="1" type="text" placeholder="ex) 101" value="">
                                </div>  <div class="col-md-12" style="margin-top: 10px">
                                <label class="small mb-1" for="2">소속</label>
                                <input class="form-control" name="scheduleNumber" id="2" type="text" placeholder="ex 1" value="">
                            </div>
                                <div class="col-md-12" style="margin-top: 15px">
                                    <input type="file" name="file">
                                </div>
                                <div class="col-md-12" style="margin-top: 10px">
                                    <label class="small mb-1" for="3">비고</label>
                                    <input class="form-control" name="note" id="3" type="text" placeholder="" value="">
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button class="btn btn-secondary" type="button" data-bs-dismiss="modal">취소</button>
                                <button class="btn btn-primary" type="submit">보고</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>


            <!-- Main page content-->
            <div class="container-xl px-4 mt-n10">
                <div class="row">
                    <div class="col-xl-4 mb-4">
                        <!-- Dashboard example card 1-->
                        <a class="card lift h-100" href="#!">
                            <div class="card-body d-flex justify-content-center flex-column">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="me-3">
                                        <i class="feather-xl text-primary mb-3" data-feather="package"></i>
                                        <h5>금일 체크아웃 객실</h5>
                                        <c:forEach var = "todayCheckOut" items="${todayCheckOut}">

                                            <div class="text-muted small"> 체크아웃 : ${todayCheckOut.checkinDate} 객실번호 : ${todayCheckOut.roomNumber}
                                            </div>

                                            
                                        </c:forEach>
                                    </div>
                                    <img src="/assets/img/illustrations/browser-stats.svg" alt="..."
                                         style="width: 8rem"/>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xl-4 mb-4">
                        <!-- Dashboard example card 2-->
                        <a class="card lift h-100" href="#!">
                            <div class="card-body d-flex justify-content-center flex-column">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="me-3">
                                        <i class="feather-xl text-secondary mb-3" data-feather="book"></i>
                                        <h5>금일 체크인 객실</h5>
                                        <c:forEach var = "todayCheckIn" items="${todayCheckIn}">

                                        <div class="text-muted small"> 체크인 : ${todayCheckIn.checkinDate} 객실번호 : ${todayCheckIn.roomNumber}
                                        </div>
                                        </c:forEach>
                                    </div>
                                    <img src="/assets/img/illustrations/processing.svg" alt="..." style="width: 8rem"/>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-xl-4 mb-4">
                        <!-- Dashboard example card 3-->
                        <a class="card lift h-100" href="#!">
                            <div class="card-body d-flex justify-content-center flex-column">
                                <div class="d-flex align-items-center justify-content-between">
                                    <div class="me-3">
                                        <i class="feather-xl text-green mb-3" data-feather="layout"></i>
                                        <h5>금일 청소팀</h5>
                                        <div class="text-muted small">청소 ${today.scheduleNumber}팀</div>
                                    </div>
                                    <img src="/assets/img/illustrations/windows.svg" alt="..." style="width: 8rem"/>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
                <div class="row">
                    <div class="col-xxl-8">
                        <!-- Tabbed dashboard card example-->
                        <div class="card mb-3">
                                    <div class="card-header">청소부 스케줄 관리</div>
                            <div class="card-body py-5">
                                <div class="justify-content-left">
                                    <c:set value="<%=Date%>" var="today" />
                                    <h5>* Today : ${today}</h5><br>
                                    <div>* 캘린더의 청소팀을 클릭하여 스케줄을 삭제합니다.</div><br>
                                    <div>* 스케줄 등록 버튼을 이용하여 청소팀의 스케줄을 입력합니다.</div><br>
                                    <div>* 청소를 완료한 뒤 청소보고 버튼을 이용하여 객실 상태를 보고합니다.</div>

                                </div>
                                <div class="d-flex flex-column justify-content-center">
                                    <div class="text-center px-0 px-lg-5">

                                    </div>
                                </div>
                            </div>
                        </div>
                        <!-- 풀 캘린더 사용 -->
                        <div id='calendar' class="mb-4">

                        </div>
                        <script>
                            document.addEventListener('DOMContentLoaded', function() {
                                let calendarEl = document.getElementById('calendar');
                                let calendar = new FullCalendar.Calendar(calendarEl, {
                                    eventClick: function(info) {
                                        let scheduleNumber = info.event.id;


                                        let action = prompt('청소' + scheduleNumber + "팀" + '\n\n삭제 하시겠습니까?: \n1. No\n2. Yes');

                                        if (action === '1') {

                                            alert("청소" + scheduleNumber + '팀 스케줄 삭제 취소');


                                        } else if (action === '2') {

                                            alert("청소" + scheduleNumber + '팀 스케줄 삭제 ');

                                            $.ajax({
                                                url: "/clean/deleteSchedule",
                                                type: "POST",
                                                data: {
                                                    scheduleNumber: scheduleNumber
                                                },
                                                success: function(response) {
                                                    if (response === 'success') {
                                                        info.event.remove();
                                                        alert('이벤트 삭제 완료');
                                                    } else {
                                                        alert('이벤트 삭제 실패.');
                                                    }
                                                },
                                                error: function() {
                                                    alert('스케줄 삭제 완료.');
                                                    info.event.remove();
                                                }
                                            });
                                        } else {
                                            // Invalid action or cancel
                                            return;
                                        }
                                    },
                                    initialView: 'dayGridMonth',
                                    events: [

                                        <c:forEach var="event" items="${events}">
                                        {
                                            id : '${event.scheduleNumber}',
                                            title: '청소${event.scheduleNumber}팀',
                                            start: '${event.scheduleStartdate}',
                                            end: '${event.scheduleEnddate}',
                                            color: getRandomColor(),
                                        },
                                        </c:forEach>
                                    ]
                                });
                                calendar.render();
                                function getRandomColor() {
                                    let letters = '0123456789ABCDEF';
                                    let color = '#';
                                    for (let i = 0; i < 6; i++) {
                                        color += letters[Math.floor(Math.random() * 16)];
                                    }
                                    return color;
                                }

                            });
                        </script>




                    </div>
                    <div class="col-xxl-4">
                        <div class="row">
                            <div class="col-xl-6 col-xxl-12">
                                <!-- Team members / people dashboard card example-->
                                <div class="card mb-4">
                                    <div class="card-header">체크 리스트</div>
                                    <div class="card-header" >
                                        <div id="checkList">



                                        </div>


                                    </div>
                                </div>
                            </div>
                            <div class="col-xl-6 col-xxl-12">
                                <!-- Project tracker card example-->
                                <button class="btn btn-dark" type="button" data-bs-toggle="modal"
                                        data-bs-target="#exampleModalLg">스케줄 등록
                                </button>
                                <button class="btn btn-dark" type="button" data-bs-toggle="modal" data-bs-target="#exampleModal">
                                    청소보고
                                </button>


                            </div>
                        </div>
                        <!-- Illustration dashboard card example-->

                    </div>
                </div>
            </div>



        </main>
        <c:import url="../temp/footer.jsp"></c:import>
    </div>
</div>


<script src="/assets/demo/chart-area-demo.js"></script>
<script src="/assets/demo/chart-pie-demo.js"></script>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
        crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="/js/cleanSchedule.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.9.4/Chart.min.js" crossorigin="anonymous"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
        crossorigin="anonymous"></script>
<script src="/js/datatables/datatables-simple-demo.js"></script>


</body>
</html>
