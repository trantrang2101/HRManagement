<%-- 
    Document   : report
    Created on : Apr 14, 2022, 10:23:19 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.*" %>
<%@page import="entity.*"%>
<%@page import="DAO.*"%>
<html lang="vi">
    <%
    User loginUser = (User) session.getAttribute("loginUser");
    Classroom choosenClass = (Classroom)session.getAttribute("classChoose");
    List<Notice> classNoticeView=(List<Notice>) session.getAttribute("classNotice");
    DetailDAO dao = new DetailDAO();
    Classroom clsl = (Classroom) session.getAttribute("classChoose");
    int task = 0;
    %>
    <head>
        <title>Report Class <%=clsl.getName()%></title>
<link rel="stylesheet" href="assests/css/style.css">
    </head>
    <body>
        <jsp:include page="included/modal.jsp"/>
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container container-fluid">
                <div class="d-flex flex-column">
                    <h1>Class <%=clsl.getName()%></h1>
                    <h2>Hi ${sessionScope.loginUser.isGender()?"Mr.":"Mrs."} <i><%=loginUser.getName()%></i>!</h2>
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
            <a href="detail?class=${sessionScope.classChoose.getName()}" class="more float-end">
                <span>Return Class<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
        </nav>
        <main class="container center">
            <header>
                <ul class="nav nav-tabs">
                    <li class="nav-item">
                        <a class="nav-link active" aria-current="page" href="#taskTableCover">Task</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="#studentTableCover">Student</a>
                    </li>
                </ul>
            </header>
            <div class="">
                <div class="cover-body fade active show" id="taskTableCover">
                    <table id="taskTable" class="cover-body table table-hover w-100">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>Task</th>
                                <th>Deadline</th>
                                <th>Done</th>
                                <th>Not Done</th>
                                <th>Average Mark</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(classNoticeView!=null){
                                    for(Notice c : classNoticeView){
                                        if(c.isTask()){
                                        task++;
                                        double average = dao.getAverageTask(c.getId())==-1?0:dao.getAverageTask(c.getId());
                            %>
                            <tr>
                                <td><%=c.getTitle()%></td>
                                <td><%=c.getDeadline()%></td>
                                <td><%=dao.getDoneTask(c.getId())%></td>
                                <td><%= choosenClass.getList().size()-dao.getDoneTask(c.getId())%></td>
                                <td><%=average%></td>
                                <td>
                                    <form action="detail" method="POST">
                                        <input type="text" name="taskid" value="<%=c.getId()%>" hidden=""/>
                                        <button type="submit" name="submit" value="detail" class="more btn bg-transparent" style="margin: 0;">
                                            <span> Task<i class="fas fa-long-arrow-alt-right"></i></span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%}}}%>
                        </tbody>
                    </table>
                </div>
                <div class="cover-body fade" id="studentTableCover">
                    <table id="studentTable" class="cover-body table table-hover w-100">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>Student ID</th>
                                <th>Name</th>
                                <th>Done</th>
                                <th>Not Done</th>
                                <th>Average Mark</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                        if(choosenClass!=null){
                                        for(User user : choosenClass.getList()){
                                        double[] average = dao.getTaskAverage(user.getId());
                            %>
                            <tr>
                                <td><%=user.getId()%></td>
                                <td><%=user.getName()%></td>
                                <td class="text-center"><%=(int)average[1]%></td>
                                <td class="text-center"><%=task-(int)average[1]%></td>
                                <td class="text-center"><%=average[0]==-1?"Not marked":average[0]%></td>
                                <td class="text-center">
                                    <form action="detail">
                                        <button type="submit" name="userid" value="<%=user.getId()%>" class="more btn bg-transparent" style="margin: 0;">
                                            <span> Task<i class="fas fa-long-arrow-alt-right"></i></span>
                                        </button>
                                    </form>
                                </td>
                            </tr>
                            <%}}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>

        <script>
            var navItem = document.querySelectorAll('.nav-link');
            navItem.forEach((item) => {
                item.addEventListener('click', () => {
                    var active = document.querySelectorAll('.active');
                    active.forEach((value) => {
                        value.classList.remove('active');
                        if (value.classList.contains('show')) {
                            value.classList.remove('show');
                        }
                    });
                    item.classList.add('active');
                    var ouputTabs = document.querySelector('#' + item.href.split('#')[1]);
                    ouputTabs.classList.add('active', 'show')
                });
            });
        </script>
    </body>

</html>