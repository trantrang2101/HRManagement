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
        <script src="assests/ckeditor/ckeditor.js"></script>
        <script>
            CKEDITOR.config.pasteFromWord PromptCleanup = true;
            CKEDITOR.config.pasteFromWordRemoveFontStyles = false;
            CKEDITOR.config.pasteFromWordRemoveStyles = false;
            CKEDITOR.config.htmlEncodeOutput = false;
            CKEDITOR.config.ProcessHTML = false;
            CKEDITOR.config.entities = false;
            CKEDITOR.config.entities_latin = false;
            CKEDITOR.config.ForceSimpleAmpersand = true;
        </script>
    </head>
    <body>
        <jsp:include page="included/modal.jsp"/>
        <%
        User loginUser = (User) session.getAttribute("loginUser");
        %>
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container container-fluid">
                <div class="d-flex flex-column">
                    <h1>Class ${sessionScope.classChoose.getName()}</h1>
                    <h2>Hi ${sessionScope.loginUser.isGender()?"Mr.":"Mrs."} <i>${sessionScope.loginUser.getName()}</i>!</h2>
                </div>
                <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
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
        <nav class="container d-flex justify-content-end">
            <a href="teacher_home.jsp" class="more float-end">
                <span>Return list classes<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
        </nav>
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
                    <div class="d-flex">
                        <input class="form-control search-form" type="search" placeholder="Search" aria-label="Search">
                        <button class="btn btn-outline-primary" type="submit">Search</button>
                    </div>
                </div>
                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                    <input type="checkbox" class="btn-check" name="option" id="excercise" autocomplete="off" checked>
                    <label class="btn btn-outline-primary" for="excercise">Task</label>

                    <input type="checkbox" class="btn-check" name="option" id="notice" autocomplete="off" checked>
                    <label class="btn btn-outline-primary" for="notice">Notice</label>
                </div>
            </div>
        </div>
        <div class="accordion container" id="notice-list">
            <%
        List<Notice> classNotice=(List<Notice>) request.getAttribute("classNotice");
        Classroom choosenClass = (Classroom)session.getAttribute("classChoose");
        if(classNotice!=null&&classNotice.size()>0){
            DetailDAO dao = new DetailDAO();
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
                                        <button class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editNotice">Edit</button>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="delete?notice=<%=c.getId()%>">Delete</a>
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
                                <h2><%=dao.getWorkList(c.getId()).size()%></h2>
                                <p>Done</p>
                            </div>
                            <div class="col d-flex flex-column">
                                <h2><%= choosenClass.getList().size()-dao.getWorkList(c.getId()).size()%></h2>
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
                                        <button class="dropdown-item" href="#" data-bs-toggle="modal" data-bs-target="#editNotice">Edit</button>
                                    </li>
                                    <li>
                                        <a class="dropdown-item" href="delete?notice=<%=c.getId()%>">Delete</a>
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
            var option = document.getElementsByName('notice');
            option = [...option];
            option.forEach((item) => {
                item.addEventListener('click', () => {
                    if (option[0].checked) {
                        document.querySelector('#deadline').classList.remove('fade');
                    } else {
                        document.querySelector('#deadline').classList.add('fade');
                    }
                });
            });
            var optionEdit = document.getElementsByName('noticeEdit');
            optionEdit = [...optionEdit];
            optionEdit.forEach((item) => {
                item.addEventListener('click', () => {
                    if (optionEdit[0].checked) {
                        document.querySelector('#deadlineEdit').classList.remove('fade');
                    } else {
                        document.querySelector('#deadlineEdit').classList.add('fade');
                    }
                });
            });
            window.addEventListener('DOMContentLoaded', event => {
                CKEDITOR.replace('postAdd');
                CKEDITOR.replace('postEdit');
            });
            var datePublished = document.querySelector('#datePublished');
            datePublished.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
            datePublished.value = moment(new Date()).format('YYYY-MM-DDTHH:mm');
            var newDateInput = document.querySelector('#dateInput');
            newDateInput.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
            newDateInput.value = moment(new Date()).format('YYYY-MM-DDTHH:mm');
            var inputDate = document.querySelector('#dateUpdate');
            var date = document.querySelector('#valueDate');
            var day = date.value.split('T')[0].split('-');
            var time = date.value.split('T')[1].split(':');
            inputDate.value = moment(new Date(day[2], day[1] - 1, day[0], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            if (new Date().getTime() < new Date(day[2], day[1] - 1, day[0], time[0], time[1]).getTime()) {
                inputDate.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
            } else {
                inputDate.min = moment(new Date(day[2], day[1] - 1, day[0], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            }
        </script>
    </body>

</html>