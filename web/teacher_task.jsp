<%-- 
    Document   : teacher_task
    Created on : Apr 14, 2022, 10:28:25 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.*" %>
<%@page import="entity.*" %>
<%@page import="DAO.*" %>
<!DOCTYPE html>
<head>
    <%
                    int task = Integer.parseInt(request.getParameter("task"));
                    DetailDAO dao = new DetailDAO();
                    Notice noti = (Notice) request.getAttribute("choosenTask");
                    Classroom choosenClass = (Classroom)session.getAttribute("classChoose");
    %>
    <title><%=noti.getTitle()%></title>
<link rel="stylesheet" href="assests/css/style.css">
    <script src="assests/js/moment.js"></script>
    <script src="assests/ckeditor/ckeditor.js"></script>
</head>

<body>
    <jsp:include page="included/modal.jsp"/>
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
        <div class="container container-fluid">
            <div class="d-flex flex-column">
                <h1>Class ${sessionScope.classChoose.getName()}</h1>
                <h2>Hi ${sessionScope.loginUser.isGender()?"Mr.":"Mrs."} <i>${sessionScope.loginUser.getName()}</i>!</h2>
            </div>
            <div class="d-flex flex-column justify-content-around align-items-center">
                    <button class="d-flex btn btn-danger float-end text-center
" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
                    <button data-bs-toggle="modal" data-bs-target="#changePW" class="btn btn-outline-primary float-end">
                        Change Password
                    </button>
                </div>
        </div>
    </nav>
    <nav class="container d-flex justify-content-end">
        <a href="detail?class=${sessionScope.classChoose.getName()}"  class="more float-end">
            <span>Return Class<i class="fas fa-long-arrow-alt-right"></i></span>
        </a>
    </nav>
    <div class="row">
        <div class="col-3 student-mark-list">
            <table class="table table-hover" id="getSubmittedDetail">
                <thead>
                    <th>Student Name</th>
                    <th>Status</th>
                </thead>
                <tbody>
                <%
                    for(User user : choosenClass.getList()){
                        Work work = dao.getWork(task,user.getId());
                        if(work.getWorkAddress().size()>0){
                %>
                <tr>
                    <td>
                        <%=user.getName()%><br>
                        <a href="detail?student=<%=user.getId()%>&id=<%=work.getTaskid()%>" class="more"><span>More details<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </td>
                    <td class="text-success"><%=work.getMark()<0?"Not marked":work.getMark()%></td>
                </tr>
                <%
                    }else{
                %>
                <tr>
                    <td>
                        <%=user.getName()%><br>
                    </td>
                    <td class="text-danger">Not done</td>
                </tr>
                <%}}%>
                </tbody>
            </table>
        </div>
        <div class="col-9">
            <nav class="container">
                <div class="d-flex justify-content-between">
                    <div class="d-flex justify-content-start">
                        <div class="icon rounded-circle bg-primary">
                            <i class="fa-solid fa-list-check text-white"></i>
                        </div>
                        <div class="card-text d-flex flex-column justify-content-between">
                            <h5 class="carrd-title"><%=noti.getTitle()%></h5>
                            <span class="card-subtitle mb-2 text-muted text-start"><%=dao.getUser(noti.getCreateBy()).getName()%> · <%=noti.getPublicAt()%></span>
                        </div>
                    </div>
                    <div class="dropdown">
                        <a class="btn bg-transparent" href="#dropdownMenuButton1" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <i class="fa-solid fa-ellipsis-vertical"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" id="dropdownMenuButton1">
                            <li>
                                <button class="dropdown-item" data-bs-toggle="modal" data-bs-target="#editNotice">Edit</button>
                            </li>
                            <li>
                                <a class="dropdown-item" href="delete?notice=<%=task%>">Delete</a>
                            </li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-10">
                        <%=noti.getDescribe()%>
                    </div>
                    <div class="col-2 row row-cols-2">
                        <div class="col d-flex flex-column">
                            <h2><%=dao.getDoneTask(task)%></h2>
                            <p>Done</p>
                        </div>
                        <div class="col d-flex flex-column">
                            <h2><%= choosenClass.getList().size()-dao.getDoneTask(task)%></h2>
                            <p>Not Done</p>
                        </div>
                    </div>
                </div>
            </nav>
            <div class="container">
                <select class="form-select border-0 w-25" aria-label="Default select example">
                    <option selected value="0">Tất cả</option>
                    <option value="1">Done</option>
                    <option value="2">Not Done</option>
                    <option value="3">Mark</option>
                </select>
                <div class="d-flex flex-wrap justify-content-start submit-list">
                    <%
                        if(choosenClass!=null){
                        for(User user : choosenClass.getList()){
                        Work work = dao.getWork(task,user.getId());
                        if(work.getWorkAddress().size()==0){
                    %>
                    <div class="shadow-sm rounded-2">
                        <h6><%=user.getName()%></h6>
                        <button class="btn btn-light submit-folder d-flex flex-column justify-content-between">
                            <i class="fa-solid fa-folder center margin-0"></i>
                            <span class="text-muted">Not submitted</span>
                        </button>
                        <p class="text-danger">Not Done</p>
                    </div>
                    <%}else{
                        if(noti.getDeadline().compareTo(work.getDoneAt())<0){
                    %>

                    <div class="shadow-sm rounded-2">
                        <h6><%=user.getName()%></h6>
                        <a class="btn btn-light submit-folder d-flex flex-column justify-content-between" href="detail?student=<%=user.getId()%>&id=<%=work.getTaskid()%>">
                            <i class="fa-solid fa-folder center margin-0"></i>
                            <span><%=user.getId()%></span>
                        </a>
                        <p class="text-warning">Done late</p>
                    </div>
                    <%}else{%>
                    <div class="shadow-sm rounded-2">
                        <h6><%=user.getName()%></h6>
                        <a class="btn btn-light submit-folder d-flex flex-column justify-content-between" href="detail?student=<%=user.getId()%>&id=<%=work.getTaskid()%>">
                            <i class="fa-solid fa-folder-open center margin-0"></i>
                            <span><%=user.getId()%></span>
                        </a>
                        <p class="text-success">Done on time</p>
                    </div>
                    <%}}}}%>
                </div>
            </div>
        </div>
    </div>
    <script src="assests/js/script.js"></script>
    <script>
        var inputDate = document.querySelectorAll('#dateUpdate')[0];
        var date = document.querySelectorAll('#valueDate')[0];
        var day = date.value.split(' ')[0].split('-');
        var time = date.value.split(' ')[1].split(':');
        inputDate.value = moment(new Date(day[2], day[1] - 1, day[0], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
        if (new Date().getTime() < new Date(day[2], day[1] - 1, day[0], time[0], time[1]).getTime()) {
            inputDate.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        } else {
            inputDate.min = moment(new Date(day[2], day[1] - 1, day[0], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
        }
    </script>
</body>

</html>