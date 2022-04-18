<%-- 
    Document   : teacher_header
    Created on : Apr 14, 2022, 10:21:13 AM
    Author     : Tran Trang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.List, java.text.*" %>
<%@page import="entity.*" %>
<%@page import="DAO.*" %>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.1.1/css/all.min.css">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.2/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/js/bootstrap.min.js"></script>
<script src="assests/js/script.js"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<link rel="preconnect" href="https://fonts.googleapis.com" />
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@300;400;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="assests/image/logo.png" />
<link rel="stylesheet" href="assests/css/style.css">
<script src="assests/js/moment.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    DetailDAO dao = new DetailDAO();
    List<Teacher> listSubject=(List<Teacher>) session.getAttribute("listSubject");
    List<Classroom> listClass=(List<Classroom>) session.getAttribute("listClass");
%>
<div id="preloader">
    <div class="loader">
        <div class="spinner">
            <div class="spinner-container">
                <div class="spinner-rotator">
                    <div class="spinner-left">
                        <div class="spinner-circle"></div>
                    </div>
                    <div class="spinner-right">
                        <div class="spinner-circle"></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="fileOpenStudent" tabindex="-1" role="dialog" aria-labelledby="fileOpen"
     aria-hidden="true" style="">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Task của Phạm Tường</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body row">
                <div class="col-2 d-flex flex-column justify-content-between">
                    <div class="list-group list-group-flush" id="listFile">
                        <a class="list-group-item active" data-toggle="list" onclick="changeValue(this)"
                           href="#guide">Guide</a>
                        <label class="list-group-item" data-toggle="list" for="addImgHW">
                            <i class="fa-solid fa-plus"></i>
                            <span>Add Image</span>
                        </label>
                        <label class="list-group-item" data-toggle="list" for="addPDFHW">
                            <i class="fa-solid fa-plus"></i>
                            <span>Add PDF</span>
                        </label>
                        <input hidden type="file" name="" id="addImgHW" accept="image/*">
                        <input hidden type="file" name="" id="addPDFHW" accept=".pdf">
                    </div>
                    <div class="comment">
                        <label for="status">Status</label>
                        <div id="status" class="text-success fw-bold">On Time</div>
                        <label for="mark">Mark Task</label>
                        <div class="d-flex justify-content-start align-items-center" id="mark">
                            <span>6/10</span>
                        </div>
                        <label for="comment">Comment Task</label>
                        <textarea name="comment" disabled id="comment" rows="10"></textarea>
                    </div>
                </div>
                <div class="col-10 h-100">
                    <div class="tab-content h-100" id="outputFile">
                        <div class="tab-pane fade active show h-100" id="guide">
                            <embed src="homework/Guid.pdf" type="application/pdf" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                        aria-label="Close">Cancel</button>
                <button class="btn btn-primary" name="action" value="Save">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addPersonHand" tabindex="-1" role="dialog" aria-labelledby="addPersonHand" aria-hidden="true" style="overflow-y: scroll;">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Student/Teacher</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="add" method="POST">
                <div class="modal-body">
                    <div class="row d-flex justify-content-around align-items-start" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">ID</label>
                                    <input type="text" name="id" pattern="\d*" class="form-control mb-1 bg-transparent">
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Name</label>
                                    <input type="text" name="name" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">Gender</label>
                                    <select name="gender" class="form-select bg-transparent">
                                        <option value="1">Male</option>
                                        <option value="0">Female</option>
                                    </select>
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Pasword</label>
                                    <input type="text" name="password" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group fade col" id="teacherRole">
                                    <label class="form-label">Role</label>
                                    <select name="roleID" class="form-select bg-transparent">
                                        <%
                                            if(listSubject!=null){
                                                for(Teacher c : listSubject){
                                        %>
                                        <option value="<%=c.getSubjectID()%>"><%=c.getSubjectName()%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 ">
                            <div class="d-flex justify-content-end">
                                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    <input type="radio" class="btn-check" name="role" id="roleStudent" value="1"
                                           autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="roleStudent">Student</label>
                                    <input type="radio" class="btn-check" name="role" id="roleTeacher" value="2"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleTeacher">Teacher</label>
                                    <input type="radio" class="btn-check" name="role" id="roleAdmin" value="0"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleAdmin">Admin</label>
                                </div>
                            </div>
                            <div class="" id="studentClass">
                                <div class="form-group">
                                    <label class="form-label">Class</label>
                                    <select name="class" class="form-select bg-transparent">
                                        <%
                                            if(listClass!=null){
                                                for(Classroom c : listClass){
                                        %>
                                        <option value="<%=c.getName()%>"><%=c.getName()%></option>
                                        <%
                                                }
                                            }
                                        %>
                                    </select>
                                </div>
                            </div>
                            <div class="fade d-flex flex-wrap justify-content-around" id="teacherClasses">
                                <%
                                    if(listClass!=null){
                                        for(Classroom c : listClass){
                                %>
                                <input type="checkbox" class="btn-check" name="class" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-outline-primary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%
                                        }
                                    }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                            aria-label="Close">Cancel</button>
                    <button class="btn btn-primary" name="action" value="addPerson">Save</button>
                </div>
            </form>

        </div>
    </div>
</div>
<div class="modal fade" id="viewTaskDetail" tabindex="-1" role="dialog" aria-labelledby="viewTaskDetail"
     aria-hidden="true" style="">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mark Task #1 - Class 7C</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body table-mark row">
                <div class="col-8">
                    <table class="table table-hover" id="taskDetail">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Gender</th>
                                <th>Mark</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td><a href="" class="">1</a></td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>4</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam
                                    laborum? Tempora modi omnis similique totam dolorum provident eveniet
                                    consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis minus
                                    officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td><a href="" class="">1</a></td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>4</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam laborum? Tempora modi omnis similique totam dolorum provident
                                    eveniet consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis
                                    minus officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td><a href="" class="">1</a></td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>4</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam laborum? Tempora modi omnis similique totam dolorum provident
                                    eveniet consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis
                                    minus officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td><a href="" class="">1</a></td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>4</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam laborum? Tempora modi omnis similique totam dolorum provident
                                    eveniet consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis
                                    minus officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td><a href="" class="">1</a></td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>4</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam laborum? Tempora modi omnis similique totam dolorum provident
                                    eveniet consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis
                                    minus officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td><a href="" class="">1</a></td>
                                <td>Otto</td>
                                <td>@mdo</td>
                                <td>4</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam laborum? Tempora modi omnis similique totam dolorum provident
                                    eveniet consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis
                                    minus officia praesentium expedita labore?</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-4 d-flex flex-column">
                    <canvas id="pieChart"></canvas>
                    <div class="final d-flex flex-column">
                        <label for="average" class="fw-bold">Average Mark:</label>
                        <input type="text" disabled class="bg-transparent border-0 text-dark" value="7.5">
                        <label for="highest" class="fw-bold">Student has highest Mark (9.5):</label>
                        <button type="submit" id="highest"
                                class="text-start bg-transparent border-0 text-dark more">
                            <span>Phạm Tường<i class="fas fa-long-arrow-alt-right"></i></span>
                        </button>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="viewStudentDetail" tabindex="-1" role="dialog" aria-labelledby="viewStudentDetail"
     aria-hidden="true" style="">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mark Task #1 - Class 7C</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body table-mark row">
                <div class="col-8">
                    <table class="table table-hover" id="studentDetail">
                        <thead class="table-primary text-center">
                            <tr>
                                <th> Task</th>
                                <th>Time finished Task</th>
                                <th>Mark</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Computer Project</td>
                                <td>23/01 23:10</td>
                                <td>9.5</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam
                                    laborum? Tempora modi omnis similique totam dolorum provident eveniet
                                    consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis minus
                                    officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td>Computer Project</td>
                                <td>23/01 23:10</td>
                                <td>4.5</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam
                                    laborum? Tempora modi omnis similique totam dolorum provident eveniet
                                    consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis minus
                                    officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td>Computer Project</td>
                                <td>23/01 23:10</td>
                                <td>5.5</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam
                                    laborum? Tempora modi omnis similique totam dolorum provident eveniet
                                    consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis minus
                                    officia praesentium expedita labore?</td>
                            </tr>
                            <tr>
                                <td>Computer Project</td>
                                <td>23/01 23:10</td>
                                <td>9.5</td>
                                <td class="line-5">Lorem ipsum dolor sit amet consectetur adipisicing elit. Voluptas
                                    minus aliquam
                                    laborum? Tempora modi omnis similique totam dolorum provident eveniet
                                    consectetur voluptates! Ipsum culpa exercitationem doloremque, facilis minus
                                    officia praesentium expedita labore?</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="col-4 d-flex flex-column">
                    <canvas id="lineChart"></canvas>
                    <div class="final d-flex flex-column">
                        <label for="average" class="fw-bold">Average Mark:</label>
                        <input type="text" disabled id="averageStudent" class="bg-transparent border-0 text-dark">
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addClass" tabindex="-1" role="dialog" aria-labelledby="addClass"
     aria-hidden="true" style="">
    <form action="add" method="POST">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Add Class</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <div class="form-group col">
                        <label class="form-label">Name</label>
                        <input type="text" maxlength="5" name="name" class="form-control mb-1">
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                            aria-label="Close">Cancel</button>
                    <button class="btn btn-danger" name="action" value="addClass">Save</button>
                </div>
            </div>
        </div>
    </form>
</div>
<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="logoutModal"
     aria-hidden="true" style="">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Logout?</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">Select "Logout" below if you are ready to end your current session.
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                        aria-label="Close">Cancel</button>
                <form action="login" method="POST">
                    <button class="btn btn-danger" type="submit" name="action" value="Logout">Logout</button>
                </form>
            </div>
        </div>
    </div>
</div>
<%if(request.getAttribute("choosenPerson")!=null){%>
<div class="modal" id="editPerson" style="">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Student/Teacher</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="add" method="POST">
                <div class="modal-body">
                    <div class="row d-flex justify-content-around align-items-start" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">ID</label>
                                    <input type="text" name="id" pattern="\d*" class="form-control mb-1 bg-transparent">
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Name</label>
                                    <input type="text" name="name" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">Gender</label>
                                    <select name="gender" class="form-select bg-transparent">
                                        <option value="1">Male</option>
                                        <option value="0">Female</option>
                                    </select>
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Pasword</label>
                                    <input type="text" name="class" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group fade col" id="teacherRole">
                                    <label class="form-label">Role</label>
                                    <select name="roleID" class="form-select bg-transparent">
                                        <%
                                                    
        if(listSubject!=null){
        for(Teacher c : listSubject){
                                        %>
                                        <option value="<%=c.getSubjectID()%>"><%=c.getSubjectName()%></option>
                                        <%}}%>
                                    </select>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 ">
                            <div class="d-flex justify-content-end">
                                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    <input type="radio" class="btn-check" name="role" id="roleStudent" value="1"
                                           autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="roleStudent">Student</label>
                                    <input type="radio" class="btn-check" name="role" id="roleTeacher" value="2"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleTeacher">Teacher</label>
                                    <input type="radio" class="btn-check" name="role" id="roleAdmin" value="0"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleAdmin">Admin</label>
                                </div>
                            </div>
                            <div class="" id="studentClass">
                                <div class="form-group">
                                    <label class="form-label">Class</label>
                                    <select name="class" class="form-select bg-transparent">
                                        <%
        if(listClass!=null){
        for(Classroom c : listClass){
                                        %>
                                        <option value="<%=c.getName()%>"><%=c.getName()%></option>
                                        <%}}%>
                                    </select>
                                </div>
                            </div>
                            <div class="fade d-flex flex-wrap justify-content-around" id="teacherClasses">
                                <%
    if(listClass!=null){
    for(Classroom c : listClass){
                                %>
                                <input type="checkbox" class="btn-check" name="class" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-outline-primary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%}}%>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                            aria-label="Close">Cancel</button>
                    <button class="btn btn-primary" name="action" value="addPerson">Save</button>
                </div>
            </form>

        </div>
    </div>
</div>
<%}%>
<div class="modal fade" id="addPerson" tabindex="-1" role="dialog" aria-labelledby="addPerson" aria-hidden="true" style="">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Student / Teacher</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="d-flex flex-column justify-content-around">
                    <form action="loadExcel" method="POST" enctype="multipart/form-data">
                        <input type="file" name="excel" hidden accept=".csv, application/vnd.openxmlformats-officedocument.spreadsheetml.sheet, application/vnd.ms-excel"
                               onchange="this.parentNode.submit()" id="inputExcel" />
                    </form>
                    <div class="w-100 d-flex justify-content-around">
                        <label for="inputExcel" class="btn padding-0 icon rounded-circle bg-primary">
                            <i class="text-white fa-solid fa-file-excel center"></i>
                        </label>
                        <button type="button" class="btn icon rounded-circle bg-primary padding-0"  data-bs-dismiss="modal" aria-label="Close" data-bs-toggle="modal" data-bs-target="#addPersonHand">
                            <i class="fa-solid fa-keyboard text-white center"></i>
                        </button>
                    </div>
                    <div>
                        <h2>Guide insert Excel</h2>
                        <i class="text-muted">If you do not follow this guide you cannot insert <strong>Student</strong> into data</i>
                        <img class="w-100" src="assests/image/guid.png" alt="alt"/>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="addNotice" tabindex="-1" role="dialog" aria-labelledby="addNotice" aria-hidden="true"
     style="">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Notice/Task </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="add" method="POST">
                <div class="modal-body">
                    <div class="row" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="form-group">
                                <label class="form-label">Title</label>
                                <input type="text" required name="title" class="form-control mb-1" value="">
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 d-flex justify-content-end">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <input type="radio" class="btn-check" name="notice" id="noticeEx" value="1"
                                       autocomplete="off">
                                <label class="btn btn-outline-primary" for="noticeEx">Task</label>
                                <input type="radio" class="btn-check" name="notice" id="noticeNo" value="0"
                                       autocomplete="off" checked>
                                <label class="btn btn-outline-primary" for="noticeNo">Notice</label>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12 row" style="margin: 0;padding: 0;">
                            <div class="form-group col">
                                <label class="form-label">Author</label>
                                <input type="number" name="author" hidden class="form-control mb-1" value="${sessionScope.loginUser.getId()}">
                                <input type="text" name="author" class="form-control mb-1 bg-transparent"
                                       value="<%=dao.getUser(loginUser.getId()).getName()%>" disabled>
                            </div>
                            <div class="form-group col">
                                <label class="form-label">Class</label>
                                <input type="text" name="classid" hidden class="form-control mb-1" value="${sessionScope.classChoose.getName()}">
                                <input type="text" name="classid" class="form-control mb-1 bg-transparent" value="${sessionScope.classChoose.getName()}"
                                       disabled>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 row row-cols-2">
                            <div class="col form-group fade" id="deadline">
                                <label class="form-label">Deadline</label>
                                <input required type="datetime-local" id="dateInput" name="deadline"
                                       class="form-control mb-1" min="">
                            </div>
                            <div class="col form-group">
                                <label class="form-label">Published At</label>
                                <input required type="datetime-local" id="datePublished" name="publish"
                                       class="form-control mb-1" min="">
                            </div>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">content</label>
                        <textarea id="postAdd" class="form-control mb-1" name="content"></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                            aria-label="Close">Cancel</button>
                    <button class="btn btn-primary" name="action" value="addNotice">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="addNoticeTeacher" tabindex="-1" role="dialog" aria-labelledby="addNoticeTeacher" aria-hidden="true"
     style="overflow-y: scroll;">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Notice/Task </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="add" method="POST">
                <div class="modal-body">
                    <div class="d-flex justify-content-around align-items-center" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="form-group">
                                <label class="form-label">Title</label>
                                <input type="text" required name="title" class="form-control mb-1" value="">
                            </div>
                            <div class="form-group col">
                                <label class="form-label">Author</label>
                                <input type="number" name="author" hidden class="form-control mb-1" value="${sessionScope.loginUser.getId()}">
                                <input type="text" name="author" class="form-control mb-1 bg-transparent"
                                       value="<%=dao.getUser(loginUser.getId()).getName()%>" disabled>
                            </div>
                            <div class="form-group col d-flex justify-content-between align-items-center">
                                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    <input type="radio" class="btn-check" name="notice" id="noticeExAll" value="1"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="noticeExAll">Task</label>
                                    <input type="radio" class="btn-check" name="notice" id="noticeNoAll" value="0"
                                           autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="noticeNoAll">Notice</label>
                                </div>
                                <div class="btn-group" role="group">
                                    <input type="checkbox" class="btn-check" name="selectAll" id="selectAll" value="1" onclick="toggle(this)"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" id="selectAllLabel" for="selectAll">Select All Classes</label>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col form-group">
                                    <label class="form-label">Published At</label>
                                    <input required type="datetime-local" id="datePublishedAll" name="publish"
                                           class="form-control mb-1" min="">
                                </div>
                                <div class="col form-group fade" id="deadlineAll">
                                    <label class="form-label">Deadline</label>
                                    <input required type="datetime-local" id="dateInputAll" name="deadline"
                                           class="form-control mb-1" min="">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label">content</label>
                                <textarea id="postAddAll" class="form-control mb-1" name="content"></textarea>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 d-flex flex-wrap justify-content-end" id="noticeFast">
                            <%
                                
                                if(listClass!=null){
                                    for(Classroom c : listClass){
                            %>
                            <input type="checkbox" class="btn-check" name="classid" value="<%=c.getName()%>" id="classid<%=c.getName()%>">
                            <label class="btn btn-outline-primary" for="classid<%=c.getName()%>"><%=c.getName()%></label>
                            <%
                                    }
                                }
                            %>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                            aria-label="Close">Cancel</button>
                    <button class="btn btn-primary" name="action" value="addNotice">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<div class="modal fade" id="fileOpenTeacher" tabindex="-1" role="dialog" aria-labelledby="fileOpenTeacher"
     aria-hidden="true" style="">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Phạm Tường's Task </h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body row">
                <div class="col-2 d-flex flex-column justify-content-between">
                    <div class="list-group list-group-flush">
                        <a class="list-group-item active" data-toggle="list" onclick="changeValue(this)"
                           href="#file1">An item</a>
                        <a class="list-group-item" data-toggle="list" onclick="changeValue(this)" href="#file2">A
                            second item</a>
                        <a class="list-group-item" data-toggle="list" onclick="changeValue(this)" href="#file3">A
                            third item</a>
                    </div>
                    <div class="comment">
                        <label for="status">Status</label>
                        <div id="status" class="text-success fw-bold">On Time</div>
                        <label for="mark">Mark Task</label>
                        <div class="d-flex justify-content-start align-items-center" id="mark">
                            <input type="number" class="mark bg-transparent">
                            <span>/10</span>
                        </div>
                        <label for="comment">Comment Task</label>
                        <textarea name="comment" id="comment" rows="10"></textarea>
                    </div>
                </div>
                <div class="col-10">
                    <div class="tab-content h-100">
                        <div class="tab-pane fade active show h-100" id="file1">
                            <embed src="homework/Guid.pdf" type="application/pdf" />
                        </div>
                        <div class="tab-pane fade h-100" id="file2">
                            <img src="assests/image/JS.png" alt="">
                        </div>
                        <div class="tab-pane fade h-100" id="file3">
                            <embed src="homework/Guid.pdf" type="application/pdf" />
                            <div id="docPreview"></div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                        aria-label="Close">Cancel</button>
                <button class="btn btn-primary" name="action" value="Save">Save</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="editNotice" tabindex="-1" role="dialog" aria-labelledby="editNotice" aria-hidden="true"
     style="">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Notice/Task</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <div class="row" style="margin: 0;padding: 0;">
                    <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                        <div class="form-group">
                            <label class="form-label">Title</label>
                            <input type="text" name="title" class="form-control mb-1" value="">
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-12 d-flex justify-content-end">
                        <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                            <input type="radio" class="btn-check" name="noticeEdit" id="editEx" value="excercise"
                                   autocomplete="off" checked>
                            <label class="btn btn-outline-primary" for="editEx">Task</label>
                            <input type="radio" class="btn-check" name="noticeEdit" id="editNo" value="notice"
                                   autocomplete="off">
                            <label class="btn btn-outline-primary" for="editNo">Notice</label>
                        </div>
                    </div>
                </div>
                <div class="row" style="margin: 0;padding: 0;">
                    <div class="col-lg-6 col-sm-12 row" style="margin: 0;padding: 0;">
                        <div class="form-group col">
                            <label class="form-label">Author</label>
                            <input type="number" name="author" hidden class="form-control mb-1" value="">
                            <input type="text" name="author" class="form-control mb-1 bg-transparent"
                                   value="Phạm Thu Hương" disabled>
                        </div>
                        <div class="form-group col">
                            <label class="form-label">Class</label>
                            <input type="number" name="class" hidden class="form-control mb-1" value="">
                            <input type="text" name="class" class="form-control mb-1 bg-transparent" value="7C"
                                   disabled>
                        </div>
                    </div>
                    <div class="col-lg-6 col-sm-12" id="deadlineEdit">
                        <div class="form-group">
                            <label class="form-label">Deadline</label>
                            <input type="text" id="valueDate" value="" hidden="">
                            <input type="datetime-local" id="dateUpdate" name="dayPublished"
                                   class="form-control mb-1">
                        </div>
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label">content</label>
                    <textarea id="postEdit" class="form-control mb-1" name="content"></textarea>
                </div>
            </div>
            <div class="modal-footer">
                <button class="btn btn-light" type="button" data-bs-dismiss="modal"
                        aria-label="Close">Cancel</button>
                <button class="btn btn-primary" name="action" value="Logout">Delete</button>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="viewMark" tabindex="-1" role="dialog" aria-labelledby="viewMark" aria-hidden="true" style="">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mark Class ${sessionScope.classChoose.getName()}</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body table-mark">
                <table class="table table-hover center" id="tableMark">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                                <%
                                    List<Notice> classNoticeView=(List<Notice>) request.getAttribute("classNotice");
                                    if(classNoticeView!=null){
                                        for(Notice c : classNoticeView){
                                        if(c.isTask()){
                                %>
                            <th><%=c.getTitle()%></th>
                                <%}}}%>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                        Classroom choosenClass = (Classroom)session.getAttribute("classChoose");
                                        if(choosenClass!=null){
                                        for(User user : choosenClass.getList()){
                                        if(user.getRoleID()==1){
                        %>
                        <tr>
                            <td><a href="" class=""><%=user.getId()%></a></td>
                            <td><%=user.getName()%></td>
                            <%
                                if(classNoticeView!=null){
                                    for(Notice c : classNoticeView){
                                        if(c.isTask()){%>
                            <td><%=dao.getWork(c.getId(),user.getId())!=null?dao.getWork(c.getId(),user.getId()).getMark():"Not Done"%></td>
                            <%}}}%>
                        </tr>
                        <%}}}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<div class="modal fade" id="viewStudent" tabindex="-1" role="dialog" aria-labelledby="viewStudent" aria-hidden="true"
     style="">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Student Class 7C</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body table-mark">
                <table class="table table-hover center" id="tableViewClassStudent">
                    <thead class="table-primary text-center">
                        <tr>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Gender</th>
                            <th>Role</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                                        if(choosenClass!=null){
                                        for(User user : choosenClass.getList()){
                        %>
                        <tr>
                            <td><a href="" class=""><%=user.getId()%></a></td>
                            <td><%=user.getName()%></td>
                            <td><%=user.isGender()?"Male":"Female"%></td>
                            <td><%=user.getRoleID()!=1?"Teacher":"Student"%></td>
                        </tr>
                        <%}}%>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
        $('#tableViewClassStudent').DataTable();
        $("#preloader").hide();
    });
</script>
