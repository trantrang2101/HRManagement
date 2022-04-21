<%-- 
    Document   : teacher_header
    Created on : Apr 14, 2022, 10:21:13 AM
    Author     : Tran Trang
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.text.*" %>
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
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
<script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
<link href="https://fonts.googleapis.com/css2?family=Roboto+Condensed:wght@300;400;700&family=Roboto:wght@300;400;500;700&display=swap" rel="stylesheet" />
<link rel="icon" type="image/x-icon" href="assests/image/logo.png" />
<link rel="stylesheet" href="assests/css/style.css">
<script src="assests/js/moment.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.28.0/feather.min.js" crossorigin="anonymous"></script>
<script src="assests/ckeditor/ckeditor.js"></script>
<script>
    CKEDITOR.config.pasteFromWordPromptCleanup = true;
    CKEDITOR.config.pasteFromWordRemoveFontStyles = false;
    CKEDITOR.config.pasteFromWordRemoveStyles = false;
    CKEDITOR.config.htmlEncodeOutput = false;
    CKEDITOR.config.ProcessHTML = false;
    CKEDITOR.config.entities = false;
    CKEDITOR.config.entities_latin = false;
    CKEDITOR.config.ForceSimpleAmpersand = true;
</script>
<%
    User loginUser = (User) session.getAttribute("loginUser");
    DetailDAO dao = new DetailDAO();
    List<Teacher> listSubject=(List<Teacher>) session.getAttribute("listSubject");
    List<Classroom> listClass=(List<Classroom>) session.getAttribute("listClass");
    Classroom choosenClass = (Classroom)session.getAttribute("classChoose");
    List<Notice> classNoticeView=(List<Notice>) session.getAttribute("classNotice");
    Integer taskid = (Integer) request.getAttribute("taskChoose");
    Integer userChoose = (Integer) request.getAttribute("userChoose");
    List<String> subjectClassList = (List<String>)request.getAttribute("subjectClassList");
    Notice editNotice = (Notice) request.getAttribute("editNotice");
    Teacher editPerson = (Teacher) request.getAttribute("editPerson");
    Teacher deletePerson = (Teacher) session.getAttribute("deletePerson");
    Notice deleteNotice = (Notice) session.getAttribute("deleteNotice");
    Integer teacherRole =(Integer) request.getAttribute("teacherRole");
    String deleteClass = (String) session.getAttribute("deleteClass");
    Work taskHW = (Work) session.getAttribute("taskHW");
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
<%if(taskHW!=null){
    Notice thisNotice = dao.getNotice(taskHW.getTaskid());
%>
<div class="modal" tabindex="-1" id="fileOpenStudent" style="display:block; background: rgba(0,0,0,0.5);;">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Task của <%=loginUser.getName()%></h5>
                <a type="button" class="btn-close" href="detail?action=close&id=<%=taskHW.getTaskid()%>"></a>
            </div>
            <div class="modal-body row">
                <input type="text" name="studentid" hidden="" value="<%=taskHW.getUserid()%>"/>
                <input type="text" name="task" hidden="" value="<%=taskHW.getTaskid()%>"/>
                <div class="col-2 d-flex flex-column justify-content-between">
                    <div class="list-group list-group-flush" id="listFile">
                        <a class="list-group-item active" data-toggle="list" onclick="changeValue(this)"
                           href="#guide">Guide</a>
                        <label class="list-group-item" data-toggle="list" for="addImgPDFHW">
                            <i class="fa-solid fa-plus"></i>
                            <span>Add Image/PDF</span>
                        </label>
                        <form action="file" method="POST" enctype="multipart/form-data">
                            <input hidden type="text" name="action" value="upfile">
                            <input hidden type="file" name="file" id="addImgPDFHW" accept="image/*, .pdf">
                        </form>
                        <%for(int p = 0; p<taskHW.getWorkAddress().size();p++){%>
                        <a class="list-group-item" data-toggle="list" href="#file<%=p%>" onclick="changeValue(this)">
                            <form class="d-flex justify-content-between" action="file" method="POST" enctype="multipart/form-data">
                                <span>Task homework <%=p%></span>
                                <input type="text" hidden="" name="work" value="<%=taskHW.getWorkAddress().get(p)%>"/>
                                <input hidden type="text" name="action" value="deleteFile">
                                <button class="btn-close" aria-label="Close" onclick="deleteURL(this.parentNode)"></button>
                            </form>
                        </a>
                        <%}%>
                    </div>
                    <div class="comment">
                        <label for="status">Status</label>
                        <%if(taskHW.getWorkAddress().size()==0){%>
                        <div id="status" class="text-danger fw-bold">Not Done</div>
                        <%}else{%>
                        <%if(taskHW.getDoneAt().compareTo(thisNotice.getDeadline())>0){%>
                        <div id="status" class="text-warning fw-bold">Done Late</div>
                        <%}else{%>
                        <div id="status" class="text-success fw-bold">Done on Time</div>
                        <%}%>
                        <label for="mark">Mark Task</label>
                        <div class="d-flex justify-content-start align-items-center fw-bold" id="mark">
                            <span><%=taskHW.getMark()==-1?"Not Marked Yet":(taskHW.getMark()+"/10")%></span>
                        </div>
                        <label for="comment">Comment Task</label>
                        <textarea name="comment" disabled="" id="comment" rows="10"><%=taskHW.getComment()!=null?taskHW.getComment():"No Comment"%></textarea>
                        <%}%>
                    </div>
                </div>
                <div class="col-10 h-100">
                    <div class="tab-content h-100" id="outputFile">
                        <div class="tab-pane fade active show h-100" id="guide">
                            <embed src="homework/Guid.pdf" type="application/pdf" />
                        </div>
                        <%for(int p = 0; p<taskHW.getWorkAddress().size();p++){%>
                        <div class="tab-content fade h-100" id="file<%=p%>">
                            <%if(taskHW.getWorkAddress().get(p).endsWith(".pdf")){%>
                            <embed class="w-100" src="homework/<%=taskHW.getTaskid()%>/<%=taskHW.getUserid()%>/<%=taskHW.getWorkAddress().get(p)%>" type="application/pdf" />
                            <%}else{%>
                            <img class="w-100" src="homework/<%=taskHW.getTaskid()%>/<%=taskHW.getUserid()%>/<%=taskHW.getWorkAddress().get(p)%>" alt="">
                            <%}%>
                        </div>
                        <%}%>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
<%}%>
<%if(taskid!=null){%>
<div class="modal" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mark Task <%=taskid%> - Class 7C</h5>
                <a type="button" class="btn-close" href="javascript:window.history.back()"></a>
            </div>
            <div class="modal-body table-mark row">
                <div class="col-8">
                    <table class="table table-hover" id="taskDetail">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>ID</th>
                                <th>Name</th>
                                <th>Mark</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                if(choosenClass!=null){
                                    for(User user : choosenClass.getList()){
                                        if(user.getRoleID()==1){
                            %>
                            <tr>
                                <td><%=user.getId()%></td>
                                <td><%=user.getName()%></td>
                                <%
                                            Work studentWork = dao.getWork(taskid,user.getId());
                                            if(studentWork.getWorkAddress().size()>0){
                                %>
                                <td><%=studentWork.getMark()%></td>
                                <td><%=studentWork.getComment()%></td>
                                <%}else{%>
                                <td class="text-danger">0</td>
                                <td class="text-danger fw-bold">Not Done</td>
                                <%
                                            }
                                %>
                            </tr>
                            <%}}}%>
                        </tbody>
                    </table>
                </div>
                <div class="col-4 d-flex flex-column">
                    <canvas id="pieChart"></canvas>
                    <div class="final d-flex flex-column">
                        <label for="average" class="fw-bold">Average Mark:</label>
                        <input type="number" disabled id="averageStudent" class="bg-transparent border-0 text-dark">
                        <label for="highest" class="fw-bold">Student has highest Mark (<span id="highestMark"></span>):</label>
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
<%}%>
<%if(userChoose!=null){%>
<div class="modal" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Mark Task <%=dao.getUser(userChoose).getName()%> - Class <%=dao.getClassByID(userChoose).get(0)%></h5>
                <a type="button" class="btn-close" href="javascript:window.history.back()"></a>
            </div>
            <div class="modal-body table-mark row">
                <div class="col-8">
                    <table class="table table-hover" id="studentDetail">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>Task</th>
                                <th>Time finished Task</th>
                                <th>Mark</th>
                                <th>Comment</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                for(Notice c : classNoticeView){
                                    if(c.isTask()){
                                        Work workUser = dao.getWork(c.getId(),userChoose);
                                        if(workUser.getWorkAddress().size()>0){
                            %>
                            <tr>
                                <td><%=c.getTitle()%></td>
                                <td><%=workUser.getDoneAt()%></td>
                                <td><%=workUser.getMark()%></td>
                                <td class="line-5"><%=workUser.getComment()%></td>
                            </tr>
                            <%}else{%>
                            <tr class="text-danger">
                                <td class="text-dark"><%=c.getTitle()%></td>
                                <td class="fw-bold">Not Done</td>
                                <td class="fw-bold">0</td>
                                <td class="line-5 fw-bold">Not Done</td>
                            </tr>
                            <%}}}%>
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
<%}%>
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
<%if(deleteClass!=null){%>
<div class="modal" id="deleteClass" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;">
    <form action="delete" method="POST">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete class <%=deleteClass%></h5>
                    <a type="button" class="btn-close" href="detail?action=return&submit=deleteClass"></a>
                </div>
                <div class="modal-body">Select "Delete" to delete class <%=deleteClass%></div>
                <input type="text" name="class" hidden="" value="<%=deleteClass%>">
                <input type="text" name="submit" hidden="" value="<%=deleteClass%>">
                <div class="modal-footer">
                    <a class="btn btn-light" type="button"  href="detail?action=return&submit=deleteClass">Cancel</a>
                    <button class="btn btn-danger" type="submit" name="action" value="deleteClass">Delete</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%}%>
<%if(deletePerson!=null){%>
<div class="modal" id="deletePerson" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;">
    <form action="delete" method="POST">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete <%=deletePerson.getName()%></h5>
                    <a type="button" class="btn-close" href="detail?submit=deleteUser"></a>
                </div>
                <div class="modal-body">Select "Delete" to delete <%=deletePerson.getRoleID()==1?"Student":(deletePerson.isGender()?"Mrs":"Mr")%> <%=deletePerson.getName()%></div>
                <input type="text" name="user" hidden="" value="<%=deletePerson.getId()%>">
                <input type="text" name="submit" hidden="" value="<%=deletePerson.getId()%>">
                <div class="modal-footer">
                    <a class="btn btn-light" type="button"  href="detail?submit=deleteUser">Cancel</a>
                    <button class="btn btn-danger" type="submit" name="action" value="deleteUser">Delete</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%}%>
<%if(deleteNotice!=null){%>
<div class="modal" id="deletePerson" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;">
    <form action="delete" method="POST">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="exampleModalLabel">Delete <%=deleteNotice.getTitle()%></h5>
                    <a type="button" class="btn-close" href="detail?submit=deleteNotice&class=<%=choosenClass.getName()%>"></a>
                </div>
                <div class="modal-body">Select "Delete" to delete <%=deleteNotice.getTitle()%></div>
                <input type="text" name="noticeDelete" hidden="" value="<%=deleteNotice.getId()%>">
                <input type="text" name="submit" hidden="" value="<%=deleteNotice.getId()%>">
                <div class="modal-footer">
                    <a class="btn btn-light" type="button"  href="detail?submit=deleteNotice&class=<%=choosenClass.getName()%>">Cancel</a>
                    <button class="btn btn-danger" type="submit" name="action" value="deleteNotice">Delete</button>
                </div>
            </div>
        </div>
    </form>
</div>
<%}%>
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
<%if(editPerson!=null){%>
<div class="modal" id="editPerson" style="display: block;background: rgba(0,0,0,0.5)">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Student/Teacher</h5>
                <a type="button" class="btn-close" href="detail"></a>
            </div>
            <form action="edit" method="POST">
                <input type="text" hidden="" name="submit" value="editPerson">
                <div class="modal-body">
                    <div class="row d-flex justify-content-around align-items-start" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">ID</label>
                                    <input type="text" name="user" pattern="\d*" value="<%=editPerson.getId()%>" class="form-control mb-1 bg-transparent" hidden="">
                                    <input type="text" name="user" pattern="\d*" value="<%=editPerson.getId()%>" disabled="" class="form-control mb-1 bg-transparent">
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Name</label>
                                    <input type="text" name="name" value="<%=editPerson.getName()%>" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">Gender</label>
                                    <select name="gender" class="form-select bg-transparent">
                                        <%if(editPerson.isGender()){%>
                                        <option value="1" selected="">Male</option>
                                        <option value="0">Female</option>
                                        <%}else{%>
                                        <option value="1">Male</option>
                                        <option value="0" selected="">Female</option>
                                        <%}%>
                                    </select>
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Pasword</label>
                                    <input type="text" name="password" value="<%=editPerson.getPassword()%>" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group fade col" id="teacherRoleEdit">
                                    <label class="form-label">Role</label>
                                    <select name="roleID" class="form-select bg-transparent" onchange="window.location.href = 'edit?submit=editPerson&action=editPerson&user=<%=editPerson.getId()%>&teacherRole=' + this.value" class="form-select bg-transparent">
                                        <%
                                        if(listSubject!=null){
                                            for(Teacher c : listSubject){
                                                if(editPerson.getRoleID()==2&&editPerson.getSubjectID()==c.getSubjectID()){
                                        %>
                                        <option selected="" value="<%=c.getSubjectID()%>"><%=c.getSubjectName()%></option>
                                        <%}else{%>
                                        <option value="<%=c.getSubjectID()%>"><%=c.getSubjectName()%></option>
                                        <%}}}%>
                                    </select>
                                    <span class="text-danger"><strong>Note:</strong> <span id="Notice" class=""><%=subjectClassList!=null?subjectClassList.toString():""%>&nbsp;has been signed</span></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 ">
                            <div class="d-flex justify-content-end">
                                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    <%switch(editPerson.getRoleID()){
                                        case 1:
                                    %>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleTeacher" value="2" autocomplete="off" disabled="">
                                    <label class="btn btn-secondary" for="roleTeacher">Teacher</label>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleStudent" value="1" autocomplete="off" checked="">
                                    <label class="btn btn-primary" for="roleStudent">Student</label>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleAdmin" value="0" autocomplete="off" disabled="">
                                    <label class="btn btn-secondary" for="roleAdmin">Admin</label>
                                    <%
                                    break;
                                case 2:
                                    %>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleTeacher" value="2" autocomplete="off" checked="">
                                    <label class="btn btn-outline-primary" for="roleTeacher">Teacher</label>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleStudent" value="1" autocomplete="off">
                                    <label class="btn btn-secondary" for="roleStudent">Student</label>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleAdmin" value="0" autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleAdmin">Admin</label>
                                    <%
                                        break;
                                    case 0:
                                    %>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleTeacher" value="2" autocomplete="off"/>
                                    <label class="btn btn-outline-primary" for="roleTeacher">Teacher</label>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleStudent" value="1" hidden>
                                    <input type="radio" class="btn-check" id="roleStudent" autocomplete="off" disabled="">
                                    <label class="btn btn-secondary" for="roleStudent">Student</label>
                                    <input type="radio" class="btn-check" name="roleEdit" id="roleAdmin" value="0" autocomplete="off" checked="">
                                    <label class="btn btn-outline-primary" for="roleAdmin">Admin</label>
                                    <%
                                        break;
                                }%>
                                </div>
                            </div>
                            <div class="fade" id="studentClassEdit">
                                <div class="form-group">
                                    <label class="form-label">Class</label>
                                    <select name="class" class="form-select bg-transparent">
                                        <%
                                            if(listClass!=null){
                                                for(Classroom c : listClass){
                                                    if(editPerson.getRoleID()==1&&dao.getClassByID(editPerson.getId()).get(0).equals(c.getName())){
                                        %>
                                        <option selected value="<%=c.getName()%>"><%=c.getName()%></option>
                                        <%}else{%>
                                        <option value="<%=c.getName()%>"><%=c.getName()%></option>
                                        <%}}}%>
                                    </select>
                                </div>
                            </div>
                            <div class="d-flex flex-wrap justify-content-around fade" id="teacherClassesEdit">
                                <%
                                    if(listClass!=null){
                                        int count  = 0,getCount=0;
                                        if(subjectClassList==null){
                                            subjectClassList=new ArrayList<>();
                                        }
                                        List<String> listClassForTeacher = dao.getClassByID(editPerson.getId());
                                        for(Classroom c : listClass){
                                            if(listClassForTeacher.size()>0&&listClassForTeacher.get(getCount).equals(c.getName())){
                                %>
                                <input checked="" type="checkbox" class="btn-check" name="classTeacher" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-outline-primary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%
                                            if(getCount<listClassForTeacher.size()-1){
                                                getCount++;
                                            }
                                }else if(subjectClassList.size()>0&&c.getName().equals(subjectClassList.get(count))){
                                %>
                                <input disabled type="checkbox" class="btn-check" name="classTeacher" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-secondary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%
                                            if(count<subjectClassList.size()-1){
                                                count++;
                                            }
                                        }else{
                                %>
                                <input type="checkbox" class="btn-check" name="classTeacher" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-outline-primary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%
                                }
                            }
                        }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <a class="btn btn-light" type="button"  href="javascript:window.history.back()">Cancel</a>
                    <button class="btn btn-primary" name="action" value="editPerson">Save</button>
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
                        <a href="add?action=addPerson" class="btn icon rounded-circle bg-primary padding-0">
                            <i class="fa-solid fa-keyboard text-white center"></i>
                        </a>
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
                                    <input type="checkbox" class="btn-check" name="selectAll" id="selectAll" value="1" onclick="toggle(this, 'classid')"
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
<%if(editNotice!=null){%>
<div class="modal" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;overflow-y: scroll;">
    <div class="modal-dialog modal-xl" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Edit Notice/Task </h5>
                <a type="button" class="btn-close" href="javascript:window.history.back()"></a>
            </div>
            <form action="edit" method="POST">
                <div class="modal-body">
                    <div class="row" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="form-group">
                                <label class="form-label">Title</label>
                                <input type="text" required name="title" class="form-control mb-1" value="<%=editNotice.getTitle()%>">
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 d-flex justify-content-end">
                            <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                <%if(editNotice.isTask()){%>
                                <input type="radio" class="btn-check" name="noticeEdit" id="noticeEditEx" value="1" checked="">
                                <label class="btn btn-outline-primary" for="noticeEx">Task</label>
                                <input type="radio" class="btn-check" name="noticeEdit" id="noticeEditNo" value="0" disabled/>
                                <label class="btn btn-secondary" for="noticeNo">Notice</label>
                                <%}else{%>
                                <input type="radio" class="btn-check" name="noticeEdit" id="noticeEditEx" value="1" autocomplete="off">
                                <label class="btn btn-outline-primary" for="noticeEditEx">Task</label>
                                <input type="radio" class="btn-check" name="noticeEdit" id="noticeEditNo" value="0" autocomplete="off" checked>
                                <label class="btn btn-outline-primary" for="noticeEditNo">Notice</label>
                                <%}%>
                            </div>
                        </div>
                    </div>
                    <div class="row" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12 row" style="margin: 0;padding: 0;">
                            <div class="form-group col">
                                <label class="form-label">Author</label>
                                <input type="number" name="author" hidden class="form-control mb-1" value="${sessionScope.loginUser.getId()}">
                                <input type="text" name="author" class="form-control mb-1 bg-transparent"
                                       value="<%=dao.getUser(editNotice.getCreateBy()).getName()%>" disabled>
                            </div>
                            <div class="form-group col">
                                <label class="form-label">Class</label>
                                <select name="classid" class="form-select bg-transparent">
                                    <%
                                        if(listClass!=null){
                                            for(Classroom c : listClass){
                                                if(editNotice.getClassroom()==c.getName()){
                                    %>
                                    <option value="<%=c.getName()%>" selected=""><%=c.getName()%></option>
                                    <%}else{%>
                                    <option value="<%=c.getName()%>"><%=c.getName()%></option>
                                    <%}}}%>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 row row-cols-2">
                            <div class="col form-group">
                                <label class="form-label">Published At</label>
                                <input type="text" id="valueDatePublic" value="<%=editNotice.getPublicAt()%>" hidden="">
                                <input type="datetime-local" id="dateInputPublic" name="publish" class="form-control mb-1">                    
                            </div>
                            <%if(editNotice.isTask()){%>
                            <div class="col form-group" id="deadlineEdit">
                                <label class="form-label">Deadline</label>
                                <input type="text" id="valueDateDeadline" value="<%=editNotice.getDeadline()%>" hidden="">
                                <input type="datetime-local" id="dateInputDeadline" name="deadline" class="form-control mb-1">
                            </div>
                            <%}else{%>
                            <div class="col form-group fade" id="deadlineEdit">
                                <label class="form-label">Deadline</label>
                                <input required type="datetime-local" id="dateInputDeadline" name="deadline" class="form-control mb-1" min="">
                            </div>
                            <%}%>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="form-label">content</label>
                        <textarea id="postEdit" class="form-control mb-1" name="content"><%=editNotice.getDescribe()%></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <input name="id" value="<%=editNotice.getId()%>" hidden="">
                    <input name="submit" value="edit" hidden="">
                    <a class="btn btn-light" type="button"  href="javascript:window.history.back()">Cancel</a>
                    <button class="btn btn-primary" name="action" value="editNotice">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%}%>
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
                                if(choosenClass!=null){
                                    for(User user : choosenClass.getList()){
                                        if(user.getRoleID()==1){
                        %>
                        <tr>
                            <td><%=user.getId()%></td>
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
<%
String submit = (String)request.getAttribute("submit");
if(submit!=null){
%>
<div class="modal" tabindex="-1" style="display:block; background: rgba(0,0,0,0.5);;overflow-y: scroll;">
    <div class="modal-dialog modal-fullscreen" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="exampleModalLabel">Add Student/Teacher</h5>
                <a type="button" class="btn-close" href="detail"></a>
            </div>
            <form action="add" method="POST">
                <div class="modal-body">
                    <div class="row d-flex justify-content-around align-items-start" style="margin: 0;padding: 0;">
                        <div class="col-lg-6 col-sm-12" style="margin: 0;padding: 0;">
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">ID</label>
                                    <input type="text" required="" name="id" pattern="\d*" class="form-control mb-1 bg-transparent">
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Name</label>
                                    <input type="text" name="name" required="" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col">
                                    <label class="form-label">Gender</label>
                                    <select name="gender" required="" class="form-select bg-transparent">
                                        <option value="1">Male</option>
                                        <option value="0">Female</option>
                                    </select>
                                </div>
                                <div class="form-group col">
                                    <label class="form-label">Pasword</label>
                                    <input type="text" required="" name="password" class="form-control mb-1">
                                </div>
                            </div>
                            <div class="row">
                                <div class="form-group col" id="teacherRole">
                                    <label class="form-label">Role</label>
                                    <select name="roleID" class="form-select bg-transparent" onchange="window.location.href = 'add?action=addPerson&submit=add&teacherRole=' + this.value" class="form-select bg-transparent">
                                        <%
                                            if(listSubject!=null){
                                                for(Teacher c : listSubject){
                                                if(teacherRole!=null&&teacherRole==c.getSubjectID()){
                                        %>
                                        <option value="<%=c.getSubjectID()%>" selected=""><%=c.getSubjectName()%></option>
                                        <%
                                            }else{
                                        %>
                                        <option value="<%=c.getSubjectID()%>"><%=c.getSubjectName()%></option>
                                        <%
                                        }
                                                                                        }
                                                                                    }
                                        %>
                                    </select>
                                    <br>
                                    <span class="text-danger"><strong>Note:</strong> <span id="Notice" class=""><%=subjectClassList.toString()%>&nbsp;has been signed</span></span>
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-sm-12 ">
                            <div class="d-flex justify-content-end">
                                <div class="btn-group" role="group" aria-label="Basic checkbox toggle button group">
                                    <input type="radio" class="btn-check" name="role" id="roleTeacher" value="2"
                                           autocomplete="off" checked>
                                    <label class="btn btn-outline-primary" for="roleTeacher">Teacher</label>
                                    <input type="radio" class="btn-check" name="role" id="roleStudent" value="1"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleStudent">Student</label>
                                    <input type="radio" class="btn-check" name="role" id="roleAdmin" value="0"
                                           autocomplete="off">
                                    <label class="btn btn-outline-primary" for="roleAdmin">Admin</label>
                                </div>
                            </div>
                            <div class="fade" id="studentClass">
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
                            <div class="d-flex flex-wrap justify-content-around" id="teacherClasses">
                                <%
                                    if(listClass!=null){
                                        int count  = 0;
                                        if(subjectClassList==null){
                                            subjectClassList=new ArrayList<>();
                                        }
                                        for(Classroom c : listClass){
                                            if(subjectClassList.size()>0&&c.getName().equals(subjectClassList.get(count))){
                                %>
                                <input disabled type="checkbox" class="btn-check" name="classTeacher" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-secondary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%
                                            if(count<subjectClassList.size()-1){
                                                count++;
                                            }
                                        }else{
                                %>
                                <input type="checkbox" class="btn-check" name="classTeacher" value="<%=c.getName()%>" id="<%=c.getName()%>" autocomplete="off">
                                <label class="btn btn-outline-primary" for="<%=c.getName()%>"><%=c.getName()%></label>
                                <%
                                }
                            }
                        }
                                %>
                            </div>
                        </div>
                    </div>
                </div>
                <input type="text" name="submit" value="add" hidden="">
                <div class="modal-footer">
                    <a class="btn btn-light" type="button"  href="javascript:window.history.back()">Cancel</a>
                    <button class="btn btn-primary" name="action" value="addPerson">Save</button>
                </div>
            </form>
        </div>
    </div>
</div>
<%}%>
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
                            <td><%=user.getId()%></td>
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
    function getColumn(table_id, col) {
        var tab = document.getElementById(table_id),
                n = tab.rows.length,
                arr = [],
                row;
        if (col < 0) {
            return arr;
        }
        for (row = 1; row < n; ++row) {
            if (tab.rows[row].cells.length > col) {
                arr.push(tab.rows[row].cells[col].innerText);
            }
        }
        return arr;
    }
    var markAvg = 0, count = 0, highest = 0;
    function sortClass() {
        var mark = getColumn('taskDetail', 2);
        var g = 0, kha = 0, k = 0;
        highest = mark[0];
        mark.forEach((item) => {
            if (item < 5) {
                k++;
            } else if (item < 8) {
                kha++;
            } else {
                g++;
            }
            highest = highest < item ? item : highest;
            count += 1;
            markAvg += Number(item);
        });
        var arr = [k, kha, g];
        console.log(arr);
        return arr;
    }

    document.addEventListener('DOMContentLoaded', function () {
        $("#preloader").hide();
        $('#tableViewClassStudent').DataTable();
        $('#taskTable').DataTable();
        $('#studentTable').DataTable();
        CKEDITOR.replace('postEdit');
        CKEDITOR.replace('postAdd');
        CKEDITOR.replace('postAddAll');

        if (document.getElementById('pieChart') !== null) {
            const pieChart = new Chart(document.getElementById('pieChart').getContext('2d'), {
                type: 'doughnut',
                data: {
                    labels: [
                        'Yếu (0-5)',
                        'Trung bình - Khá (5-8)',
                        'Giỏi (8-10)'
                    ],
                    datasets: [{
                            label: 'Mark Task #1',
                            data: sortClass(),
                            backgroundColor: [
                                'rgb(246,151,125)',
                                'rgb(255,243,121)',
                                'rgb(150,205,138)'
                            ],
                            hoverOffset: 4
                        }]
                }
            });
        }
        if (document.getElementById('lineChart') !== null) {
            const lineChart = new Chart(document.getElementById('lineChart').getContext('2d'), {
                type: 'line',
                data: {
                    labels: getColumn('studentDetail', 0),
                    datasets: [{
                            label: '',
                            data: getColumn('studentDetail', 2),
                            fill: false,
                            backgroundColor: 'rgb(246,151,121)',
                            borderColor: 'rgb(246,151,125)',
                            tension: 0.1
                        }]
                },
                options: {
                    responsive: true,
                    plugins: {
                        title: {
                            display: true,
                            text: 'Mark Details'
                        }
                    },
                    scales: {
                        y: {
                            min: 0,
                            max: 10
                        },
                        x: {
                            ticks: {
                                display: false
                            }
                        }
                    }
                }
            });
        }
        var datePublishedNo = document.querySelector('#datePublished');
        datePublishedNo.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        datePublishedNo.value = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        var newDateInputNo = document.querySelector('#dateInput');
        newDateInputNo.min = datePublishedNo.value;
        newDateInputNo.value = datePublishedNo.value;
        var newDateInput = document.querySelector('#dateInputAll');
        newDateInput.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        newDateInput.value = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        var datePublished = document.querySelector('#datePublishedAll');
        datePublished.min = newDateInput.value;
        datePublished.value = newDateInput.value;
        var inputDatePublic = document.querySelectorAll('#dateInputPublic')[0];
        var datePublic = document.querySelectorAll('#valueDatePublic')[0];
        var inputDateDeadline = document.querySelectorAll('#dateInputDeadline')[0];
        var dateDeadline = document.querySelectorAll('#valueDateDeadline')[0];
        if (datePublic !== undefined) {
            var day = datePublic.value.split(' ')[0].split('-');
            var time = datePublic.value.split(' ')[1].split(':');
            inputDatePublic.value = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            if (new Date().getTime() < new Date(day[0], day[1] - 1, day[2], time[0], time[1]).getTime()) {
                inputDatePublic.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
            } else {
                inputDatePublic.min = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            }
            if (dateDeadline !== undefined) {
                day = dateDeadline.value.split(' ')[0].split('-');
                time = dateDeadline.value.split(' ')[1].split(':');
                inputDateDeadline.value = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
                if (new Date().getTime() < new Date(day[0], day[1] - 1, day[2], time[0], time[1]).getTime()) {
                    inputDateDeadline.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
                } else {
                    inputDateDeadline.min = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
                }
            } else {
                inputDateDeadline.min = inputDatePublic.value;
                inputDateDeadline.value = inputDatePublic.value;
            }
        }
        var roleEdit = document.getElementsByName('roleEdit');
        if (roleEdit !== undefined) {
            if (roleEdit[0].checked) {
                document.querySelector('#teacherClassesEdit').classList.remove('fade');
                document.querySelector('#teacherRoleEdit').classList.remove('fade');
            } else if (roleEdit[1].checked) {
                document.querySelector('#studentClassEdit').classList.remove('fade');
            } else {
                document.querySelector('#teacherRoleEdit').classList.add('fade');
                document.querySelector('#teacherClassesEdit').classList.add('fade');
                document.querySelector('#studentClassEdit').classList.add('fade');
            }
        }
        if (document.querySelector('#highestMark') !== null) {
            document.querySelector('#highestMark').innerHTML = highest;
        }
        if (document.querySelector('#averageStudent') !== null) {
            document.querySelector('#averageStudent').value = markAvg / count;
        }
    });
    var option = document.getElementsByName('notice');
    option = [...option];
    option.forEach((item) => {
        item.addEventListener('click', () => {
            if (option[0].checked || option[2].checked) {
                document.querySelector('#deadlineAll').classList.remove('fade');
                document.querySelector('#deadline').classList.remove('fade');
            } else {
                document.querySelector('#deadlineAll').classList.add('fade');
                document.querySelector('#deadline').classList.add('fade');
            }
        });
    });
    var optionEdit = document.getElementsByName('noticeEdit');
    optionEdit = [...optionEdit];
    optionEdit.forEach((item) => {
        item.addEventListener('click', () => {
            if (optionEdit[1].checked) {
                document.querySelector('#deadlineEdit').classList.add('fade');
            } else {
                document.querySelector('#deadlineEdit').classList.remove('fade');
            }
        });
    });
    var roleEdit = document.getElementsByName('roleEdit');
    roleEdit = [...roleEdit];
    roleEdit.forEach((item) => {
        item.addEventListener('click', () => {
            if (roleEdit[0].checked) {
                console.log(roleEdit[0]);
                document.querySelector('#teacherClassesEdit').classList.remove('fade');
                document.querySelector('#teacherRoleEdit').classList.remove('fade');
                document.querySelector('#studentClassEdit').classList.add('fade');
            } else if (roleEdit[1].checked) {
                console.log(roleEdit[1]);
                document.querySelector('#teacherClassesEdit').classList.add('fade');
                document.querySelector('#teacherRoleEdit').classList.add('fade');
                document.querySelector('#studentClassEdit').classList.remove('fade');
            } else {
                console.log(roleEdit[2]);
                document.querySelector('#teacherRoleEdit').classList.add('fade');
                document.querySelector('#teacherClassesEdit').classList.add('fade');
                document.querySelector('#studentClassEdit').classList.add('fade');
            }
            console.log(item);
        });
    });
    if (document.querySelector('#datePublished') === undefined) {
        document.querySelector('#datePublished').oninput(function () {
            var day = this.value.split('T')[0].split('-');
            var time = this.value.split('T')[1].split(':');
            document.querySelector('#datePublished').min = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            document.querySelector('#datePublished').value = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
        });
    }
    if (document.querySelector('#datePublishedAll') === undefined) {
        document.querySelector('#datePublishedAll').oninput(function () {
            var day = this.value.split('T')[0].split('-');
            var time = this.value.split('T')[1].split(':');
            document.querySelector('#dateInputAll').min = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            document.querySelector('#dateInputAll').value = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
        });
    }
    if (document.querySelector('#dateInputPublic') === undefined) {
        document.querySelector('#dateInputPublic').onblur(function () {
            var day = this.value.split('T')[0].split('-');
            var time = this.value.split('T')[1].split(':');
            document.querySelector('#dateInputDeadline').min = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
            document.querySelector('#dateInputDeadline').value = moment(new Date(day[0], day[1] - 1, day[2], time[0], time[1])).format('YYYY-MM-DDTHH:mm');
        });
    }
</script>