<%-- 
    Document   : view_people
    Created on : Apr 15, 2022, 5:05:58 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="entity.*" %>
<%@page import="DAO.*" %>
<%@ page import="java.util.List, java.text.*" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>View Students/Teacher</title>
    </head>
    <body>
        <script>
            var currentpage = document.querySelector('.page-item.active').querySelector('a').innerHTML;
            var pageItem = document.querySelector('.page-item.page-normal');
            for (var i = 0; i < pageItem){

            }
        </script>
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
        </nav>
        <nav class="container d-flex justify-content-end">
            <a href="teacher_home.jsp" class="more float-end">
                <span>Return list classes<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
        </nav>
        <div class="container">
            <header class="d-flex justify-content-between">
                <div class="d-flex justify-content-between">
                    <div class="btn-group" role="group">
                        <form action="detail">
                            <%
                                String[] roleName = (String[]) request.getAttribute("roleName");
                                String[] roleList = (String[]) request.getAttribute("roleList");
                                String[] roleSearch = (String[]) request.getAttribute("roleSearch");
                                int k = 0;
                                for(int i =0;i<3;i++){
                                if(roleSearch[k].equals(roleList[i])){
                            %>
                            <input type="checkbox" class="btn-check" checked onchange="this.parentNode.submit()" name="roleSearch" value="<%=roleList[i]%>" id="role<%=roleList[i]%>">
                            <label class="btn btn-primary" for="role<%=roleList[i]%>"><%=roleName[i]%></label>
                            <%
                                if(k<roleSearch.length-1){
                                    k++;
                                }
                                }else{
                            %>
                            <input type="checkbox" class="btn-check" onchange="this.parentNode.submit()" name="roleSearch" value="<%=roleList[i]%>" id="role<%=roleList[i]%>">
                            <label class="btn btn-outline-primary" for="role<%=roleList[i]%>"><%=roleName[i]%></label>
                            <%}}%>
                        </form>
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
                            DetailDAO dao = new DetailDAO();
                            List<Teacher> listUser = (List<Teacher>) session.getAttribute("listUser");
                            for(Teacher t:listUser){
                        %>
                    <form method="POST">
                        <tr>
                            <td><%=t.getId()%></td>
                            <td class="w-25"><input class="w-100 bg-transparent" type="text" name="name" value="<%=t.getName()%>"></td>
                            <td>
                                <div class="form-group d-flex bg-transparent border-bottom justify-content-between">
                                    <input type="password" class="input-password input-group bg-transparent" value="<%=t.getPassword()%>" name="password">
                                    <input type="radio" hidden="" id="password<%=t.getId()%>" onclick="showPassword(this)">
                                    <label for="password<%=t.getId()%>">
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
                                    <option value="0">Admin</option>
                                    <%}%>
                                </select>
                                <%}%>
                            </td>
                            <td>
                                <%if(t.getRoleID()==1){%>
                                <select name="class" class="form-select bg-transparent">
                                    <%
                                                    List<Classroom> listClass=(List<Classroom>) session.getAttribute("listClass");
                                                    if(listClass!=null){
                                                        for(Classroom c : listClass){
                                                        if(dao.getClassByID(t.getId()).get(0).equals(c.getName())){
                                    %>
                                    <option value="<%=c.getName()%>" selected=""><%=c.getName()%></option>
                                    <%}else{%>
                                    <option value="<%=c.getName()%>"><%=c.getName()%></option>
                                    <%
                                                }
                                            }
                                        }
                                    %>
                                </select>
                                <%}else if(t.getRoleID()==2){%>
                                <div class="d-flex flex-wrap flex-5 justify-content-around">
                                <%
                                    List<String> teacherClass = dao.getClassByID(t.getId());
                                    for(int i =0 ;i<teacherClass.size();i++){
                                %>
                                <span><%=teacherClass.get(i)%></span>
                                <%
                                    }%>
                                </div>
                                <%  }%>
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
            <nav class="mt-4" aria-label="">
                <ul id="pagination" class="pagination">
                    <%
                        int thisPage = (int)session.getAttribute("thisPage");
                        int pages = (int) session.getAttribute("pages");
                        if(thisPage>1){
                    %>
                    <li class="page-item first"><a class="page-link" href="detail?page=1">First</a></li>
                        <%}
                            if(thisPage>3){
                        %>
                    <li class="page-item previous"><a class="page-link" href="detail?page=<%=thisPage+3%>">«</a></li>
                        <%}  if(thisPage>1){
                        %>
                    <li class="page-item next"><a class="page-link" href="detail?page=<%=thisPage+1%>">❮</a></li>
                        <%
                            }
                            for(int i = 1;i<=pages;i++){
                            if(thisPage==i){%>
                    <li class="page-item page-normal active"><a class="page-link" href="detail?page=<%=i%>"><%=i%></a></li>
                        <%
                            }else{%>
                    <li class="page-item page-normal"><a class="page-link" href="detail?page=<%=i%>"><%=i%></a></li>
                        <%
                            }
                        }
                          if(thisPage<pages){
                        %>
                    <li class="page-item next"><a class="page-link" href="detail?page=<%=thisPage-1%>">❯</a></li>
                        <%} 
                              if(thisPage<pages-3){
                        %>
                    <li class="page-item following"><a class="page-link" href="detail?page=<%=thisPage-3%>">»</a></li>
                        <%
                            } if(thisPage<pages){
                        %>
                    <li class="page-item last"><a class="page-link" href="detail?page=<%=pages%>">Last</a></li>
                        <%
                            }%>
                </ul>
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
