<%-- 
    Document   : view_people
    Created on : Apr 15, 2022, 5:05:58 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.*" %>
<%@ page import="java.util.List, java.text.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Students/Teacher</title>
    </head>
    <body>
        <jsp:include page="included/modal.jsp"/>
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container container-fluid">
                <h2>Hi ${sessionScope.loginUser.isGender()?"Mr.":"Mrs."} <i>${sessionScope.loginUser.getName()}</i>!</h2>
                <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
            </div>
        </nav>
        <nav class="container d-flex justify-content-end">
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPerson">
                <i class="fa-solid fa-plus"></i>
                <span>Add Student/Teacher</span>
            </button>
            <!--            <a class="btn btn-primary" href="report.jsp">
                            <i class="fa-solid fa-eye"></i>
                            <span> Report</span>
                        </a>-->
        </nav>
        <nav class="container d-flex justify-content-end">
            <a href="teacher_home.jsp" class="more float-end">
                <span>Return list classes<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
        </nav>
        <div class="container">
            <header class="d-flex justify-content-between">
                <div class="d-flex justify-content-between">
                    <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                        <input type="checkbox" class="btn-check" name="roleSearch" id="student" autocomplete="off" checked="">
                        <label class="btn btn-outline-primary" for="student">Student</label>
                        <input type="checkbox" class="btn-check" name="roleSearch" id="teacher" autocomplete="off" checked="">
                        <label class="btn btn-outline-primary" for="teacher">Teacher</label>
                        <input type="checkbox" class="btn-check" name="roleSearch" id="admin" autocomplete="off" checked="">
                        <label class="btn btn-outline-primary" for="admin">Admin</label>
                    </div>
                </div>
                <div class="d-flex">
                    <form class="form-group input-group" action="MainController">
                        <span class="btn input-group-text bg-transparent"><i class="fa-solid fa-magnifying-glass"></i></span>
                        <input type="text" placeholder="ID/Name" class="text-start btn form-control border-bottom" name="search" onchange="this.parentNode.submit()" value="${param.search}"/>
                    </form>
                </div>
            </header>
            <nav>
                <table class="table table-hover" border="1">
                    <thead class="table-primary">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Password</th>
                            <th>Gender</th>
                            <th>Role</th>
                            <th>Class</th>
                            <th>Notice</th>
                            <th>Edit</th>
                            <th>Delete</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            List<Teacher> listUser = (List<Teacher>) session.getAttribute("listUser");
                            for(Teacher t:listUser){
                        %>
                    <form method="POST">
                        <tr>
                            <td><%=t.getId()%></td>
                            <td><input class="w-100 bg-transparent" type="text" name="name" value="<%=t.getName()%>"></td>
                            <td>
                                <div class="form-group d-flex bg-transparent border-bottom justify-content-between">
                                    <input type="password" class="input-password input-group bg-transparent" value="<%=t.getPassword()%>" name="password">
                                    <input type="radio" hidden="" id="password1" onclick="showPassword(this)">
                                    <label for="password1">
                                        <i class="fa-solid fa-eye"></i>
                                    </label>
                                </div>
                            </td>
                            <td>
                                <select name="gender" class="form-select bg-transparent border-0">
                                    <%if(t.isGender()){%>
                                    <option value="1" selected>Male</option>
                                    <option value="0">Female</option>
                                    <%}else{%>
                                    <option value="1">Male</option>
                                    <option value="0"selected>Female</option>
                                    <%}%>
                                </select>
                            </td>
                            <td>
                                <%if(t.getRoleID()==1){%>
                                Student
                                <%}else{%>
                                <select name="roleClass" class="form-select bg-transparent border-0">
                                    <%if(t.getRoleID()==0){%>
                                    <option value="2">Teacher</option>
                                    <option value="0" selected="">Admin</option>
                                    <%}else{%>
                                    <option value="2" selected="">Teacher</option>
                                    <option value="0">Teacher</option>
                                    <%}%>
                                </select>
                                <%}%>
                            </td>
                            <td>
                                <%if(t.getRoleID()!=0){%>
                                <select name="class" class="form-select bg-transparent">
                                    <%
                                                    List<Classroom> listClass=(List<Classroom>) session.getAttribute("listClass");
                                                    if(listClass!=null){
                                                        for(Classroom c : listClass){
                                    %>
                                    <option value="<%=c.getName()%>"><%=c.getName()%></option>
                                    <%
                                            }
                                        }
                                    %>
                                </select>
                                <%}%>
                            </td>
                            <td>
                                <%if(t.getRoleID()==2){%>
                                <select name="roleID" class="form-select bg-transparent">
                                    <%
                                        List<Teacher> listSubject=(List<Teacher>) session.getAttribute("listSubject");
                                        if(listSubject!=null){
                                        for(Teacher c : listSubject){
                                            if(c.getSubjectID()==t.getSubjectID()){
                                    %>
                                    <option value="<%=c.getSubjectID()%>" selected><%=c.getSubjectName()%></option>
                                    <%}else{%>
                                    <option value="<%=c.getSubjectID()%>"><%=c.getSubjectName()%></option>
                                    <%}}}%>
                                </select>
                                <%}%>
                            </td>
                            <td></td>
                        </tr>
                        <%}%>
                    </form>
                    </tbody>
                </table>
            </nav>
        </div>
        <script>
            function showPassword(item) {
                var inputPW = item.parentElement.children[0];
                var eye = item.parentElement.getElementsByClassName('fa-solid')[0];
                if (inputPW.type === 'text') {
                    inputPW.type = 'password';
                    eye.classList = "fa-solid fa-eye";
                } else {
                    inputPW.type = 'text';
                    eye.classList = "fa-solid fa-eye-slash";
                }
            }
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
        </script>
    </body>
</html>
