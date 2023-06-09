<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8" />
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
    <meta name="description" content="" />
    <meta name="author" content="" />
    <title>ProductLists List - SB Admin Pro</title>
    <link href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css" rel="stylesheet" />
    <link href="/css/styles.css" rel="stylesheet" />
    <link rel="icon" type="image/x-icon" href="/assets/img/favicon.png" />
    <script data-search-pseudo-elements defer src="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.3.0/js/all.min.js" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.29.0/feather.min.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        thead th svg {
            display: none;
        }

        .truncate-text {
            display: inline-block;
            width: 100px; /* 표시할 글자 수에 맞게 조정하세요 */
            white-space: nowrap;
            overflow: hidden;
            text-overflow: ellipsis;
        }
    </style>
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
                                    ProductStock List
                                </h1>
                            </div>
                        </div>
                    </div>
                </div>
            </header>

            <!-- Main page content-->
            <div class="container-fluid px-4">
                <div class="card">
                    <div class="card-body">
                        <button class="btn btn-outline-dark" type="button" style="margin-bottom: 15px;" data-bs-toggle="modal" data-bs-target="#exampleModalLg1">품목추가</button>
                        <button class="btn btn-outline-dark" type="button" style="margin-bottom: 15px;" data-bs-toggle="modal" data-bs-target="#exampleModalLg2">품목수정</button>
                        <button class="btn btn-outline-dark" type="button" style="margin-bottom: 15px;" id="btn-delete">품목삭제</button>
                        <table id="datatablesSimple">
                            <thead>
                            <tr>
                                <th data-orderable="false"><div style="display: flex; justify-content: center; align-items: center; height: 100%;">
                                    <input type="checkbox" id="checkAll" class="myCheckbox">
                                </div>
                                </th>
                                <th>품목번호</th>
                                <th>상호명</th>
                                <th>품목명</th>
                                <th>품목코드</th>
                                <th>단가</th>
                                <th>단위</th>
                                <th>비고</th>
                            </tr>
                            </thead>
                            <tfoot>
                            <tr>
                                <th></th>
                                <th>품목번호</th>
                                <th>상호명</th>
                                <th>품목명</th>
                                <th>품목코드</th>
                                <th>단가</th>
                                <th>단위</th>
                                <th>비고</th>
                            </tr>
                            </tfoot>
                            <tbody>
                            <c:forEach var="vo" items="${list}">
                                <!-- 유저 정보-->
                                <tr>
                                    <td><div style="display: flex; justify-content: center; align-items: center; height: 100%;">
                                        <input type="checkbox" class="myCheckbox">
                                    </div>
                                    </td>
                                    <td>${vo.itemId}</td>
                                    <td>${vo.partnerVOS[0].companyName}</td>
                                    <td>${vo.productName}</td>
                                    <td>${vo.itemCode}</td>
                                    <td>${vo.unitPrice}원</td>
                                    <td>${vo.unit}</td>
                                    <td>
                                        <div class="truncate-text">${vo.remarks}</div>
                                    </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                        </table>


                    </div>
                </div>
            </div>
            <%--insert 모달--%>
            <div class="modal fade" id="exampleModalLg1" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">
                        <form id="insertForm" action="/partnerStock/stockInsert" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel1">품목추가</h5>
                                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="productName">품목명</label>
                                    <input class="form-control form-control-solid form-input" id="productName"
                                           name="productName" type="text">
                                </div>
                                <div class="mb-3">
                                    <%--<label for="itemCode">분류코드</label>
                                    <div>
                                        <select id="itemCode" name="itemCode" style="height: 30px;">
                                            <option value="${itemCode}">${itemCode}</option>
                                        </select>
                                    </div>--%>

                                    <label>분류코드</label>
                                    <div class="dropdown">
                                        <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false">${itemCode}</button>
                                        <div class="dropdown-menu animated--fade-in-up" aria-labelledby="selectedRoomTypeButton">
                                            <a class="dropdown-item" href="#" data-itemCode="${itemCode}">${itemCode}</a>
                                        </div>
                                        <input type="hidden" id="itemCodeInput" name="itemCode" value="${itemCode}" />
                                    </div>
                                    <%--<input class="form-control form-control-solid form-input" id="itemCode"
                                           name="itemCode" type="text">
                                    <span class="code-message"></span>--%>
                                </div>
                                <div class="mb-3">
                                    <label for="unitPrice">단가</label>
                                    <input class="form-control form-control-solid form-input" id="unitPrice"
                                           name="unitPrice" type="text">
                                    <span class="price-message"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="unit">단위</label>
                                    <input class="form-control form-control-solid form-input" id="unit"
                                           name="unit" type="text">
                                    <span class="unit-message"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="remarks">비고</label>
                                    <textarea  class="form-control form-control-solid form-input"  cols="30" rows="5"
                                               name="remarks" id="remarks"></textarea>
                                </div>

                                <div class="modal-footer">
                                    <button class="btn btn-dark" type="button" data-bs-dismiss="modal">취소</button>
                                    <sec:authentication property="Principal" var="user"/>
                                    <input type="hidden" name="businessNumber" value="${user.id}">
                                    <button class="btn btn-dark" type="button" id="btn-insert">추가</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>

            <%--update 모달--%>
            <div class="modal fade" id="exampleModalLg2" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
                    <div class="modal-content">
                        <form id="updateForm" action="/partnerStock/stockUpdate" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="exampleModalLabel2">품목수정</h5>
                                <button class="btn-close" type="button" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <div class="mb-3">
                                    <label for="productName0">품목명</label>
                                    <input class="form-control form-control-solid form-update" id="productName0"
                                           name="productName" type="text">
                                </div>
                                <div class="mb-3">
                                    <%--update모달 분류코드 오류--%>
                                    <label>분류코드</label>
                                    <div class="dropdown">
                                        <button class="btn btn-light dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-haspopup="true" aria-expanded="false" id="itemCodeBtn"></button>
                                        <div class="dropdown-menu animated--fade-in-up" aria-labelledby="selectedRoomTypeButton">
                                            <a class="dropdown-item" href="#" id="itemCode0"></a>
                                        </div>
                                        <input type="hidden" id="itemCodeUpdate" name="itemCode" />
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label for="unitPrice0">단가</label>
                                    <input class="form-control form-control-solid form-update" id="unitPrice0"
                                           name="unitPrice" type="text">
                                    <span class="price-message"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="unit0">단위</label>
                                    <input class="form-control form-control-solid form-update" id="unit0"
                                           name="unit" type="text">
                                    <span class="unit-message"></span>
                                </div>
                                <div class="mb-3">
                                    <label for="remarks0">비고</label>
                                    <textarea  class="form-control form-control-solid form-update"  cols="30" rows="5"
                                               name="remarks" id="remarks0"></textarea>
                                </div>

                                <div class="modal-footer">
                                    <button class="btn btn-dark" type="button" data-bs-dismiss="modal">취소</button>
                                    <input type="hidden" name="itemId" id="itemId0">
                                    <button class="btn btn-dark" type="button" id="btn-update">수정</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </main>
        <!-- Footer Section Begin -->
        <c:import url="../temp/footer.jsp"></c:import>
        <!-- Footer Section End -->
    </div>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
<script src="/js/scripts.js"></script>
<script src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js" crossorigin="anonymous"></script>
<script src="/js/datatables/datatables-simple-demo.js"></script>
<script src="/js/partnerStock.js"></script>
<script src="/webjars/sockjs-client/sockjs.min.js"></script>
<script src="/webjars/stomp-websocket/stomp.min.js"></script>
<script src="/js/partnerWebSocket.js"></script>
</body>
</html>
