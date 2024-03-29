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
        <link rel="stylesheet" href="assests/css/style.css">
    </head>
    <body>
        <%
            DetailDAO dao = new DetailDAO();
            List<Teacher> listUser = (List<Teacher>) session.getAttribute("listUser");
            String[] roleName = (String[]) request.getAttribute("roleName");
            String[] roleList = (String[]) request.getAttribute("roleList");
            String[] roleSearch = (String[]) request.getAttribute("roleSearch");
            List<Classroom> listClass=(List<Classroom>) session.getAttribute("listClass");
            List<Teacher> listSubject=(List<Teacher>) session.getAttribute("listSubject");
            int thisPage = (int)session.getAttribute("thisPage");
            int pages = (int) session.getAttribute("pages");
            int k =0;
            String searchWords = request.getAttribute("searchWords")==null?"":(String) request.getAttribute("searchWords");
        %>
        <jsp:include page="included/modal.jsp"/>
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container container-fluid">
                <h2>Hi ${sessionScope.loginUser.isGender()?"Mr.":"Mrs."} <i>${sessionScope.loginUser.getName()}</i>!</h2>
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
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPerson">
                <i class="fa-solid fa-plus"></i>
                <span>Add Student/Teacher</span>
            </button>
        </nav>
        <nav class="container d-flex justify-content-end">
            <a href="detail?action=return" class="more float-end">
                <span>Return list classes<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
        </nav>
        <div class="container" style="overflow: hidden;">
            <header class="d-flex justify-content-between align-items-center">
                <nav class="" aria-label="">
                    <form action="detail">
                        <ul id="pagination" class="pagination">
                            <%
                            k=0;
                            for(int i =0;i<3;i++){
                                if(roleSearch[k].equals(roleList[i])){
                            %>
                            <input type="checkbox" hidden="" class="btn-check" checked onchange="this.parentNode.submit()" name="roleSearch" value="<%=roleList[i]%>">
                            <%
                                    if(k<roleSearch.length-1){
                                        k++;
                                    }
                                }
                            }
                            if(thisPage>1){
                            %>
                            <li class="page-item page-pagination"><button class="page-link" name="page" value="<%=1%>" type="submit">First</button></li>
                                <%}
                                    if(thisPage>3){
                                %>
                            <li class="page-item page-pagination"><button class="page-link" name="page" value="<%=thisPage-3%>" type="submit">«</button></li>
                                <%}  if(thisPage>1){
                                %>
                            <li class="page-item page-pagination"><button class="page-link" name="page" value="<%=thisPage-1%>" type="submit">❮</button></li>
                                <%
                                    }
                                    for(int c = 1;c<=pages;c++){
                                    if(thisPage==c){%>
                            <li class="page-item page-pagination page-normal active"><button class="page-link" name="page" value="<%=c%>" type="submit"><%=c%></button></li>
                                <%
                            }else{%>
                            <li class="page-item page-pagination page-normal"><button class="page-link" name="page" value="<%=c%>" type="submit"><%=c%></button></li>
                                <%
                                    }
                                }%>
                            <input hidden="" type="text" name="" id="thisPage" value="<%=thisPage%>">
                            <input class="form-control search-form border-0 border-bottom" hidden="" name="search" type="search" placeholder="Search" value="<%=searchWords%>" aria-label="Search">
                            <%
                              if(thisPage<pages){
                            %>
                            <li class="page-item page-pagination"><button class="page-link" name="page" value="<%=thisPage+1%>" type="submit">❯</button></li>
                                <%} 
                                      if(thisPage<pages-3){
                                %>
                            <li class="page-item page-pagination"><button class="page-link" name="page" value="<%=thisPage+3%>" type="submit">»</button></li>
                                <%
                                    } if(thisPage<pages){
                                %>
                            <li class="page-item page-pagination"><button class="page-link" name="page" value="<%=pages%>" type="submit">Last</button></li>
                                <%
                            }%>
                        </ul>
                    </form>
                </nav>  
                <div class="d-flex justify-content-between">
                    <form action="detail" class="btn-group" role="group">
                        <%
                            k = 0;
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
                <div class="d-flex">
                    <form class="form-group input-group" action="detail">
                        <button class="btn input-group-text bg-transparent"><i class="fa-solid fa-magnifying-glass"></i></button>
                            <%
                            k=0;
                            for(int i =0;i<3;i++){
                                if(roleSearch[k].equals(roleList[i])){
                            %>
                        <input type="checkbox" hidden="" class="btn-check" checked onchange="this.parentNode.submit()" name="roleSearch" value="<%=roleList[i]%>">
                        <%
                                if(k<roleSearch.length-1){
                                    k++;
                                }
                            }
                        }%>
                        <input class="form-control search-form border-0 border-bottom" name="search" type="search" placeholder="Search" value="<%=searchWords%>" aria-label="Search">
                    </form>
                </div>
            </header>
            <nav>
                <table class="table table-hover" border="1">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>No</th>
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
                            int stt=(thisPage-1)*25;
                            for(Teacher t:listUser){
                        %>
                    <form method="POST">
                        <tr>
                            <td><%=++stt%></td>
                            <td><%=t.getId()%></td>
                            <td class="w-25"><%=t.getName()%></td>
                            <td>
                                <div class="form-group d-flex bg-transparent border-bottom justify-content-between">
                                    <input type="password" disabled="" class="input-password input-group bg-transparent" value="<%=t.getPassword()%>" name="password">
                                    <input type="radio" hidden="" id="password<%=t.getId()%>" onclick="showPassword(this)">
                                    <label for="password<%=t.getId()%>">
                                        <i class="fa-solid fa-eye"></i>
                                    </label>
                                </div>
                            </td>
                            <td class="w-10"><%=t.isGender()?"Male":"Female"%></td>
                            <td class="w-10">
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
                                <%if(t.getRoleID()==1){
                                out.print(dao.getClassByID(t.getId()).get(0));
                                }else if(t.getRoleID()==2){%>
                                <div class="d-flex flex-wrap flex-5 justify-content-between">
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
                            <td class="w-10 text-center">
                                <%if(t.getRoleID()==2){out.print(dao.getRoleTeacher(t.getId()).getSubjectName());}%>
                            </td>
                            <td><a href="edit?action=editPerson&user=<%=t.getId()%>" class="btn btn-outline-primary">Edit</a></td>
                            <td><a href="delete?action=deleteUser&user=<%=t.getId()%>" class="btn btn-outline-danger">Delete</a></td>
                        </tr>
                        <%}%>
                    </form>
                    </tbody>
                </table>
            </nav>
        </div>
        <script>
            var pagePagnation = document.querySelectorAll('.page-pagination');
            var pageNormal = document.querySelectorAll('.page-normal');
            var k = 9 - Number(pagePagnation.length - pageNormal.length);
            var thisPage = Number(document.querySelectorAll('#thisPage')[0].value);
            for (var i = 0, max = pageNormal.length; i < max; i++) {
                if (k === 6) {
                    if (i > thisPage + k - 2 || i < thisPage - k) {
                        pageNormal[i].classList.add('fade');
                    }
                } else {
                    if (i < thisPage - Math.floor(k / 2) - 1 || i > thisPage + Math.floor(k / 2) - 1) {
                        pageNormal[i].classList.add('fade');
                    }
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
