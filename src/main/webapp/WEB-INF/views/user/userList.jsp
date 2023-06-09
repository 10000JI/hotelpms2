<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Users List - SB Admin Pro</title>
        <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
        <link href="/css/styles.css" rel="stylesheet" />
        <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
        <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/js/all.min.js" crossorigin="anonymous"></script>
        <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="/webjars/sockjs-client/sockjs.min.js"></script>
        <script src="/webjars/stomp-websocket/stomp.min.js"></script>
        <script src="/js/webSocket.js"></script>
    </head>
    <body class="nav-fixed">
    <c:import url="../temp/topheader.jsp"></c:import>
        <div id="layoutSidenav">
            <c:import url="../temp/leftheader.jsp"></c:import>
            <div id="layoutSidenav_content">
                <main>

                    <header class="page-header page-header-compact page-header-light border-bottom bg-white mb-4">
                        <div class="container-fluid px-4">
                            <div class="page-header-content">
                                <div class="row align-items-center justify-content-between pt-3">
                                    <div class="col-auto mb-3">
                                        <h1 class="page-header-title">
                                            <div class="page-header-icon"><i data-feather="user"></i></div>
                                            고객관리
                                        </h1>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </header>
                    <!-- Main page content-->
                    <div class="container-fluid px-4">
                        <div class="card">
                            <div class="card-header">유저 정보</div>
                            <div class="card-body">
                                    <div class="col-12 col-xl-3 mb-3">

                                    <form action="/user/download" method="get">
                                        <button class="btn btn-sm btn-light text-primary" type="submit">Excel 파일 출력</button>
                                    </form>
                                    </div>
                                <table id="datatablesSimple">
                                    <thead>
                                        <tr>
                                            <th>이름</th>
                                            <th>아이디</th>
                                            <th>이메일</th>
                                            <th>권한</th>
                                            <th>전화번호</th>
<%--                                            <th>유저정보 수정</th>--%>
                                        </tr>
                                    </thead>
                                    <tfoot>
                                        <tr>
                                            <th>User</th>
                                            <th>Email</th>
                                            <th>Role</th>
                                            <th>Groups</th>
                                            <th>Joined Date</th>
<%--                                            <th>Actions</th>--%>
                                        </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach var="userVO" items="${userVO}">
                                        <!-- 유저 정보-->
                                        <tr>
                                            <td>
                                                <div class="d-flex align-items-center">
                                                    <div class="avatar me-2"><img class="avatar-img img-fluid" src="/assets/img/illustrations/profiles/profile-1.png" /></div>
                                                    ${userVO.name}
                                                </div>
                                            </td>
                                            <td>${userVO.id}</td>
                                            <td>${userVO.email}</td>
                                            <td>
                                                <c:if test="${userVO.roleName eq 'ROLE_MEMBER'}">
                                                    <span class="badge bg-green-soft text-green">ROLE_MEMBER</span>
                                                </c:if>
                                                <c:if test="${userVO.roleName eq 'ROLE_MANAGER'}">
                                                    <span class="badge bg-blue-soft text-blue">ROLE_MANAGER</span>
                                                </c:if>
                                                <c:if test="${userVO.roleName eq 'ROLE_CLEAN'}">
                                                    <span class="badge bg-red-soft text-red">ROLE_CLEAN</span>
                                                </c:if>
                                                <c:if test="${userVO.roleName eq 'ROLE_STOCK'}">
                                                    <span class="badge bg-purple-soft text-purple">ROLE_STOCK</span>
                                                </c:if>
                                                <c:if test="${userVO.roleName eq 'ROLE_ADMIN'}">
                                                    <span class="badge bg-yellow-soft text-yellow">ROLE_ADMIN</span>
                                                </c:if>


                                            </td>
                                            <td>${userVO.phoneNumber}</td>
<%--                                            <td>--%>
<%--                                                <a class="btn btn-datatable btn-icon btn-transparent-dark me-2" href="/user-management-edit-user.html"><i data-feather="edit"></i></a>--%>
<%--                                                <a class="btn btn-datatable btn-icon btn-transparent-dark" href="#!"><i data-feather="trash-2"></i></a>--%>
<%--                                            </td>--%>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>


                            </div>
                        </div>
                    </div>

                    <div class="container-fluid px-4 mt-5">
                        <div class="card">
                            <div class="card-header">유저 예약정보</div>
                            <div class="card-body">
                                <div class="col-12 col-xl-3 mb-3">

<%--                                    <form action="/user/download" method="get">--%>
<%--                                        <button class="btn btn-sm btn-light text-primary" type="submit">Excel 파일 출력</button>--%>
<%--                                    </form>--%>
                                </div>
                                <table id="datatablesSimple2">
                                    <thead>
                                    <tr>
                                        <th>이름</th>
                                        <th>아이디</th>
                                        <th>방번호</th>
                                        <th>룸타입</th>
                                        <th>CHECKINDATE</th>
                                        <th>CHECKOUTDATE</th>
                                        <th>예약인원</th>
                                        <th>전화번호</th>
                                        <th>이메일</th>
                                    </tr>
                                    </thead>
                                    <tfoot>
                                    <tr>
                                        <th>User</th>
                                        <th>Email</th>
                                        <th>Role</th>
                                        <th>Groups</th>
                                        <th>Joined Date</th>
                                        <th>Actions</th>
                                        <th>예약인원</th>
                                        <th>전화번호</th>
                                        <th>이메일</th>
                                    </tr>
                                    </tfoot>
                                    <tbody>
                                    <c:forEach var="userBookingList" items="${userBookingList}">
                                        <!-- 유저 정보-->
                                        <tr>
                                            <td>${userBookingList.name}</td>
                                            <td>${userBookingList.id}</td>
                                            <td>${userBookingList.roomNumber}호</td>
                                            <td>${userBookingList.roomType}</td>
                                            <td>${userBookingList.checkinDate}</td>
                                            <td>${userBookingList.checkoutDate}</td>
                                            <td>${userBookingList.guestCount}명</td>
                                            <td>${userBookingList.phoneNumber}</td>
                                            <td>${userBookingList.reservationEmail}</td>
                                        </tr>
                                    </c:forEach>
                                    </tbody>
                                </table>


                            </div>
                        </div>
                    </div>
                </main>
                <footer class="footer-admin mt-auto footer-light">
                    <div class="container-xl px-4">
                        <div class="row">
                            <div class="col-md-6 small">Copyright &copy; Your Website 2021</div>
                            <div class="col-md-6 text-md-end small">
                                <a href="#!">Privacy Policy</a>
                                &middot;
                                <a href="#!">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        <script src="/js/scripts.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
        <script src="/js/datatables/datatables-simple-demo.js"></script>
    <script src="/webjars/sockjs-client/sockjs.min.js"></script>
    <script src="/webjars/stomp-websocket/stomp.min.js"></script>
    <script src="/js/webSocket.js"></script>
    </body>
</html>
