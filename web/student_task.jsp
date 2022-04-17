<%-- 
    Document   : student_task
    Created on : Apr 14, 2022, 10:25:30 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.*" %>
<%@page import="entity.*" %>
<%@page import="DAO.*" %>
<!DOCTYPE html>
<head>
    <%
                    DetailDAO dao = new DetailDAO();
                    Notice noti = (Notice) request.getAttribute("choosenTask");
                    User loginUser = (User) session.getAttribute("loginUser");
                    Work work = (Work)dao.getWork(noti.getId(),loginUser.getId());
    %>
    <title><%=noti.getTitle()%></title>
    <script src="assests/js/moment.js"></script>
    <script src="assests/ckeditor/ckeditor.js"></script>
</head>

<body>
    <jsp:include page="included/modal.jsp"/>
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
        <div class="container container-fluid">
            <div class="d-flex flex-column">
                <h1>Class ${sessionScope.classChoose.getName()}</h1>
                <h2>Hi <i>${sessionScope.loginUser.getName()}</i>!</h2>
            </div>
            <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
        </div>
    </nav>
    <div class="container center">
        <a href="detail?class=${sessionScope.classChoose.getName()}"  class="more float-end">
            <span>Return Class<i class="fas fa-long-arrow-alt-right"></i></span>
        </a>
        <nav class="container row">
            <div class="col-8 d-flex flex-column">
                <div class="d-flex justify-content-start">
                    <div class="icon-large rounded-circle bg-primary d-flex align-items-center">
                        <i class="fa-solid fa-list-check text-white"></i>
                    </div>
                    <div class="card-text d-flex flex-column justify-content-between">
                        <h5 class="carrd-title"><%=noti.getTitle()%></h5>
                        <input type="text" hidden="" id="deadlineNotice" value="<%=noti.getDeadline()%>">
                        <span class="card-subtitle mb-2 text-danger fw-bold text-start" id="remain"></span>
                        <span class="card-subtitle mb-2 text-muted text-start"><%=dao.getUser(noti.getCreateBy()).getName()%> · <%=noti.getPublicAt()%></span>
                    </div>
                </div>
                <div>
                    <%=noti.getDescribe()%>
                </div>
            </div>
            <nav class="col-4 d-flex flex-column justify-content-around">
                <button class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#fileOpenStudent" style="margin: 0;">
                    <i class="fa-solid fa-plus"></i>
                    <span> Task</span>
                </button>
                <div class="text-center align-items-center row fw-bold">
                    <span class="col border-end"><%=work==null?"Not Done":"Done"%> </span>
                    <span class="col d-flex flex-column justify-content-between">
                        <span>Mark</span>
                        <span><%=work==null?"Not Done":work.getMark()==-1?"Not Marked":work.getMark()%></span>
                    </span>
                </div>
            </nav>
        </nav>
    </div>
    <script>
        var deadline = document.querySelector('#deadlineNotice').value;
        var countDownDate = new Date(deadline).getTime();

        var x = setInterval(function () {

            var now = new Date().getTime();

            var distance = countDownDate - now;

            var days = Math.floor(distance / (1000 * 60 * 60 * 24));
            var hours = Math.floor((distance % (1000 * 60 * 60 * 24)) / (1000 * 60 * 60));
            var minutes = Math.floor((distance % (1000 * 60 * 60)) / (1000 * 60));

            document.getElementById("remain").innerHTML = days + " days " + hours + " hours " + minutes + " minutes";

            if (distance < 0) {
                clearInterval(x);
                document.getElementById("remain").innerHTML = "EXPIRED";
            }
        }, 1000);
    </script>
</body>

</html>