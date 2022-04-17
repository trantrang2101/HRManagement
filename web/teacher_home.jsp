<%-- 
    Document   : teacher_home
    Created on : Apr 14, 2022, 10:27:37 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.*" %>
<%@ page import="java.util.List, java.text.*" %>
<!DOCTYPE html>
<head>
    <title>Teacher - Homepage</title>
    <script src="assests/ckeditor/ckeditor.js"></script>
    <script src="assests/js/moment.js"></script>
</head>

<body>
    <jsp:include page="included/modal.jsp"/>
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
        <div class="container container-fluid">
            <h2>Hi ${sessionScope.loginUser.isGender()?"Mr.":"Mrs."} <i>${sessionScope.loginUser.getName()}</i>!</h2>
            <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
        </div>
    </nav>
    <%
        User user = (User)session.getAttribute("loginUser");
        if(user.getRoleID()==0){
    %>
    <nav class="container d-flex justify-content-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addClass">
            <i class="fa-solid fa-plus"></i>
            <span>Add Class</span>
        </button>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPerson">
            <i class="fa-solid fa-plus"></i>
            <span>Add Student/Teacher</span>
        </button>
        <a class="btn btn-primary" href="view_people.jsp">
            <i class="fa-solid fa-eye"></i>
            <span>View Student/Teacher</span>
        </a>
    </nav>
    <%}%>
    <div class="container class-list center d-flex flex-wrap justify-content-between">
        <%
            List<Classroom> listClass=(List<Classroom>) session.getAttribute("listClass");
            if(listClass!=null){
            for(Classroom c : listClass){
        %>
        <div class="col rounded-2 shadow-sm card">
            <div class="card-body">
                <form action="delete" method="POST">
                    <div class="card-title d-flex justify-content-between">
                        <h4><%=c.getName()%></h4>
                        <input type="text" hidden="" name="class" value="<%=c.getName()%>"/>
                        <button type="submit" name="action" value="deleteClass" class="btn-close"></button>
                    </div>
                </form>
                <a href="detail?class=<%=c.getName()%>" class="more float-end">
                    <span>More details<i class="fas fa-long-arrow-alt-right"></i></span>
                </a>
            </div>
        </div>
        <%}}%>
    </div>
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
        var role = document.getElementsByName('role');
        role = [...role];
        role.forEach((item) => {
            item.addEventListener('click', () => {
                if (role[0].checked) {
                    document.querySelector('#studentClass').classList.remove('fade');
                    document.querySelector('#teacherClasses').classList.add('fade');
                    document.querySelector('#teacherRole').classList.add('fade');
                } else if (role[1].checked) {
                    document.querySelector('#teacherClasses').classList.remove('fade');
                    document.querySelector('#studentClass').classList.add('fade');
                    document.querySelector('#teacherRole').classList.remove('fade');
                } else {
                    document.querySelector('#teacherRole').classList.add('fade');
                    document.querySelector('#teacherClasses').classList.add('fade');
                    document.querySelector('#studentClass').classList.add('fade');
                }
            });
        });
        var newDateInput = document.querySelector('#dateInput');
        newDateInput.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        newDateInput.value = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        var datePublished = document.querySelector('#datePublished');
        datePublished.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        datePublished.value = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        window.addEventListener('DOMContentLoaded', event => {
            CKEDITOR.replace('postAdd');
        });
    </script>
</body>

</html>