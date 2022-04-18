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
        <title>Report ${sessionScope.classChoose.getName()}</title>
    </head>
    <body>
        <jsp:include page="included/modal.jsp"/>
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
                                <td><%=dao.getWorkList(c.getId()).size()%></td>
                                <td><%= choosenClass.getList().size()-dao.getWorkList(c.getId()).size()%></td>
                                <td><%=average%></td>
                                <td>
                                    <button type="button" class="more btn bg-transparent" data-bs-toggle="modal"
                                            data-bs-target="#viewTaskDetail" style="margin: 0;">
                                        <span> Task<i class="fas fa-long-arrow-alt-right"></i></span>
                                    </button>
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
                                <td><%=average[0]%></td>
                                <td><%=(double)task-average[0]%></td>
                                <td><%=average[2]%></td>
                                <td>
                                    <button type="button" class="more btn bg-transparent" data-bs-toggle="modal"
                                            data-bs-target="#viewStudentDetail" onclick="getMarkAverage()" style="margin: 0;">
                                        <span> Task<i class="fas fa-long-arrow-alt-right"></i></span>
                                    </button>
                                </td>
                            </tr>
                            <%}}%>
                        </tbody>
                    </table>
                </div>
            </div>
        </main>
        <script>
            $(document).ready(function () {
                $('#taskTable').DataTable();
                $('#studentTable').DataTable();
                $('#taskDetail').DataTable();
                $('#studentDetail').DataTable();
            });
            function getColumn(table_id, col) {
                var tab = document.getElementById(table_id),
                        n = tab.rows.length,
                        arr = [],
                        row;
                if (col < 0) {
                    return arr; // Return empty Array.
                }
                for (row = 1; row < n; ++row) {
                    if (tab.rows[row].cells.length > col) {
                        arr.push(tab.rows[row].cells[col].innerText);
                    }
                }
                return arr;
            }
            var markAvg = 0, count = 0;
            function sortClass() {
                var mark = [...getColumn('taskDetail', 3)];
                var g = 0,
                        kha = 0,
                        k = 0;
                mark.forEach((item) => {
                    if (item < 5) {
                        k += 1;
                    } else if (item < 8) {
                        kha += 1;
                    } else {
                        gioi += 1;
                    }
                    count += 1;
                    markAvg += Number(item);
                });
                var arr = [k, kha, g];
                console.log(arr);
                return arr;
            }
            function getMarkAverage() {
                document.querySelector('#averageStudent').value = markAvg / count;
            }
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
                            text: 'Mark của Phạm Tường'
                        }
                    },
                    scales: {
                        y: {
                            min: 0,
                            max: 10,
                        },
                        x: {
                            ticks: {
                                display: false
                            }
                        }
                    }
                }
            });
        </script>

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