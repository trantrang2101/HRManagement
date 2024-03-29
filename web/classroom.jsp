<%-- 
    Document   : teacher_classroom
    Created on : Apr 14, 2022, 10:26:18 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.*" %>
<%@page import="entity.*"%>
<%@page import="DAO.*"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Class ${sessionScope.classChoose.getName()}</title>
        <script src="assests/js/moment.js"></script>
<link rel="stylesheet" href="assests/css/style.css">
    </head>
    <body>
        <jsp:include page="included/modal.jsp"/>
        <%
        DetailDAO dao = new DetailDAO();
        User loginUser = (User) session.getAttribute("loginUser");
        Classroom clsl = (Classroom) session.getAttribute("classChoose");
        String optionChoose = (String) request.getAttribute("optionChoose");
        String searchWords = request.getAttribute("searchWords")==null?"":(String) request.getAttribute("searchWords");
        Classroom detailClass = dao.getClassroom(clsl.getId());
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container container-fluid">
                <div class="d-flex flex-column">
                    <h1>Class ${sessionScope.classChoose.getName()}</h1>
                    <h5 class="text-muted"><%=detailClass.getBuilding()==null?"Not arrange":detailClass.getBuilding()%> · <%=detailClass.getRoom()==0?"Not arrange":detailClass.getRoom()%></h5>
                    <h2>Hi ${sessionScope.loginUser.getRoleID()!=1?sessionScope.loginUser.isGender()?"Mr.":"Mrs.":""} <i>${sessionScope.loginUser.getName()}</i>!</h2>
                </div>
                <div class="d-flex flex-column justify-content-around align-items-center">
                    <button class="d-flex btn btn-danger float-end text-center" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
                    <button data-bs-toggle="modal" data-bs-target="#changePW" class="btn btn-outline-primary float-end">
                        Change Password
                    </button>
                </div>
            </div>
        </nav>
        <nav class="container d-flex justify-content-end">
            <%if(loginUser.getRoleID()!=1){%>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNotice">
                <i class="fa-solid fa-plus"></i>
                <span>Add Notice</span>
            </button>
            <a class="btn btn-primary" href="report.jsp">
                <i class="fa-solid fa-eye"></i>
                <span> Report</span>
            </a>
            <%}%>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewMark">
                <i class="fa-solid fa-eye"></i>
                <span>Mark Report</span>
            </button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewStudent">
                <i class="fa-solid fa-eye"></i>
                <span>View Member</span>
            </button>
        </nav>
        <%if(loginUser.getRoleID()!=1){%>
        <nav class="container d-flex justify-content-end">
            <a href="detail?action=return" class="more float-end">
                <span>Return list classes<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
        </nav>
        <%}%>
        <div class="filter container flex-column">
            <div class="d-flex justify-content-between">
                <div class="d-flex">
                    <div class="dropdown">
                        <a class="btn bg-transparent" type="button" href="#dropdownMenuButton1" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <i class="fa-solid fa-filter text-primary"></i>
                        </a>
                        <ul class="dropdown-menu" id="dropdownMenuButton1">
                            <li><a class="dropdown-item" href="#">Newest Posts</a></li>
                            <li><a class="dropdown-item" href="#">Oldest Posts</a></li>
                        </ul>
                    </div>
                    <form class="d-flex" action="detail">
                        <input class="form-control search-form" name="search" type="search" placeholder="Search" value="<%=searchWords%>" aria-label="Search">
                        <input type="text" hidden="" name="class" value="<%=clsl.getName()%>"/>
                        <%
                        if(optionChoose==null){
                        %>
                        <input type="checkbox" hidden="" name="option" value="1" checked=""/>
                        <input type="checkbox" hidden="" name="option" value="0" checked=""/>
                        <%}else{
                            if(optionChoose.equals("1")){
                        %>
                        <input type="checkbox" hidden="" name="option" value="1" checked=""/>
                        <input type="checkbox" hidden="" name="option" value="0"/>
                        <%}else{%>
                        <input type="checkbox" hidden="" name="option" value="1"/>
                        <input type="checkbox" hidden="" name="option" value="0" checked=""/>
                        <%}}%>
                        <button class="btn btn-outline-primary" type="submit">Search</button>
                    </form>
                </div>
                <form action="detail" class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                    <%
                        if(optionChoose==null){
                    %>
                    <input type="checkbox" onchange="this.parentNode.submit()" class="btn-check" name="option" value="1" id="excercise" checked>
                    <label class="btn btn-primary" for="excercise">Task</label>
                    <input class="form-control search-form fade" hidden="" name="search" type="search" placeholder="Search" value="<%=searchWords%>" aria-label="Search">
                    <input type="text" hidden="" class="fade" name="class" value="<%=clsl.getName()%>"/>
                    <input type="checkbox" onchange="this.parentNode.submit()" class="btn-check" name="option" value="0" id="notice" checked>
                    <label class="btn btn-primary" for="notice">Notice</label>
                    <%}else{
                        if(optionChoose.equals("1")){
                    %>
                    <input type="checkbox" onchange="this.parentNode.submit()" class="btn-check" name="option" value="1" id="excercise" checked>
                    <label class="btn btn-primary" for="excercise">Task</label>
                    <input class="form-control search-form fade" hidden="" name="search" type="search" placeholder="Search" value="<%=searchWords%>" aria-label="Search">
                    <input type="text" hidden="" class="fade" name="class" value="<%=clsl.getName()%>"/>
                    <input type="checkbox" onchange="this.parentNode.submit()" class="btn-check" name="option" value="0" id="notice">
                    <label class="btn btn-outline-primary" for="notice">Notice</label>
                    <%
                        }else{
                    %>
                    <input type="checkbox" onchange="this.parentNode.submit()" class="btn-check" name="option" value="1" id="excercise">
                    <label class="btn btn-outline-primary" for="excercise">Task</label>
                    <input class="form-control search-form fade" hidden="" name="search" type="search" placeholder="Search" value="<%=searchWords%>" aria-label="Search">
                    <input type="text" hidden="" class="fade" name="class" value="<%=clsl.getName()%>"/>
                    <input type="checkbox" onchange="this.parentNode.submit()" class="btn-check" name="option" value="0" id="notice" checked>
                    <label class="btn btn-primary" for="notice">Notice</label>
                    <%}}%>
                </form>
            </div>
        </div>
        <div class="accordion container" id="notice-list">
            <%
        List<Notice> classNotice=(List<Notice>) session.getAttribute("classNotice");
        Classroom choosenClass = (Classroom)session.getAttribute("classChoose");
        if(classNotice!=null&&classNotice.size()>0){
            for(Notice c : classNotice){
                if(c.isTask()){
            %>
            <div class="accordion-item rounded-3 shadow-sm">
                <div class="accordion-header notice rounded-top rounded-3" id="heading<%=c.getId()%>">
                    <a class="w-100" type="button" data-bs-toggle="collapse" href="#notice<%=c.getId()%>" aria-expanded="true"
                       aria-controls="panelsStayOpen-collapseOne">
                        <div class="d-flex justify-content-between">
                            <div class="d-flex justify-content-start">
                                <div class="icon rounded-circle bg-primary">
                                    <i class="fa-solid fa-list-check text-white"></i>
                                </div>
                                <div class="card-text d-flex flex-column justify-content-between">
                                    <h5 class="carrd-title"><%=dao.getUser(c.getCreateBy()).getName()%> post a task: <%=c.getTitle()%></h5>
                                    <span class="card-subtitle mb-2 text-muted text-start"><%=c.getPublicAt()%></span>
                                </div>
                            </div>
                            <%if(loginUser.getRoleID()!=1){%>
                            <div class="dropdown">
                                <a class="btn bg-transparent" type="button" href="#dropdownMenuButton1"
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" id="dropdownMenuButton1">
                                    <li>
                                        <a class="dropdown-item" href="edit?action=editNotice&id=<%=c.getId()%>" >Edit</a>
                                    </li>
                                    <li>
                                        <form action="delete" method="POST">
                                            <input type="text" name="noticeDelete" value="<%=c.getId()%>" hidden/>
                                            <button class="dropdown-item" name="action" value="deleteNotice" type="submit">Delete</button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                            <%}%>
                        </div>
                    </a>
                </div>
                <div id="notice<%=c.getId()%>" class="accordion-collapse collapse" aria-labelledby="heading1">
                    <div class="accordion-body row">
                        <div class="col-10">
                            <%=c.getDescribe()%>
                        </div>
                        <div class="col-2 row row-cols-2">
                            <div class="col d-flex flex-column">
                                <h2><%=dao.getDoneTask(c.getId())%></h2>
                                <p>Done</p>
                            </div>
                            <div class="col d-flex flex-column">
                                <h2><%= choosenClass.getList().size()-dao.getDoneTask(c.getId())%></h2>
                                <p>Not Done</p>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-footer">
                        <a href="detail?task=<%=c.getId()%>" class="more"><span> More detail<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </div>
                </div>
            </div>
            <%}else{%>
            <div class="accordion-item rounded-3 shadow-sm">
                <div class="accordion-header notice rounded-top rounded-3" id="heading<%=c.getId()%>">
                    <a class="w-100" type="button" data-bs-toggle="collapse" href="#notice<%=c.getId()%>" aria-expanded="true"
                       aria-controls="panelsStayOpen-collapseOne">
                        <div class="d-flex justify-content-between">
                            <div class="d-flex justify-content-start">
                                <div class="icon rounded-circle bg-primary">
                                    <i class="fa-solid fa-note-sticky text-white"></i>
                                </div>
                                <div class="card-text d-flex flex-column justify-content-between">
                                    <h5 class="carrd-title"><%=dao.getUser(c.getCreateBy()).getName()%> post a  Notice:<%=c.getTitle()%></h5>
                                    <span class="card-subtitle mb-2 text-muted text-start"><%=c.getPublicAt()%></span>
                                </div>
                            </div>
                            <%if(loginUser.getRoleID()!=1){%>
                            <div class="dropdown">
                                <a class="btn bg-transparent" type="button" href="#dropdownMenuButton1"
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" id="dropdownMenuButton1">
                                    <li>
                                        <a class="dropdown-item" href="edit?action=editNotice&id=<%=c.getId()%>" >Edit</a>
                                    </li>
                                    <li>
                                        <form action="delete" method="POST">
                                            <input type="text" name="noticeDelete" value="<%=c.getId()%>" hidden/>
                                            <button class="dropdown-item" name="action" value="deleteNotice" type="submit">Delete</button>
                                        </form>
                                    </li>
                                </ul>
                            </div>
                            <%}%>
                        </div>
                    </a>
                </div>
                <div id="notice<%=c.getId()%>" class="accordion-collapse collapse" aria-labelledby="heading<%=c.getId()%>">
                    <div class="accordion-body">
                        <%=c.getDescribe()%>
                    </div>
                </div>            
            </div>
            <%}}}else{%>
            <h3 class="text-center text-success">No Notification Yet</h3>
            <div class="d-flex justify-content-between">
                <img src="assests/image/noNotification.png" class="center" style="max-width: 100%;height: 300px;object-fit: cover;"/>
            </div>
            <%}%>
        </div>
        <script src="./assests/ckeditor/ckeditor.js"></script>
        <script>
                        document.querySelector('#datePublished').oninput(function () {
                            var day = this.value.split('T')[0].split('-');
                            var time = this.value.split('T')[1].split(':');
                            document.querySelector('#datePublished').min = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
                            document.querySelector('#datePublished').value = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
                        });
        </script>
    </body>

</html>