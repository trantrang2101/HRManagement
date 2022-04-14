<%-- 
    Document   : report
    Created on : Apr 14, 2022, 10:23:19 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html lang="vi">

    <head>
        <title>Teacher - </title>
    </head>
    <body>
        <jsp:include page="included/modal.jsp"/>
        <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
            <div class="container container-fluid">
                <div class="d-flex flex-column">
                    <h1>Class 8A</h1>
                    <h2>Hi cô <i>Phạm Thu Hương</i>!</h2>
                </div>
                <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
            </div>
        </nav>
        <nav class="container d-flex justify-content-end">
            <a href="teacher_classroom.jsp" class="more float-end">
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
                            <tr>
                                <td>Rhona Davidson</td>
                                <td>Integration Specialist</td>
                                <td>Tokyo</td>
                                <td>55</td>
                                <td>2010/10/14</td>
                                <td>
                                    <button type="button" class="more btn bg-transparent" data-bs-toggle="modal"
                                            data-bs-target="#viewTaskDetail" style="margin: 0;">
                                        <span>Xem Task<i class="fas fa-long-arrow-alt-right"></i></span>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>Colleen Hurst</td>
                                <td>Javascript Developer</td>
                                <td>San Francisco</td>
                                <td>39</td>
                                <td>2009/09/15</td>
                                <td>$205,500</td>
                            </tr>
                            <tr>
                                <td>Sonya Frost</td>
                                <td>Software Engineer</td>
                                <td>Edinburgh</td>
                                <td>23</td>
                                <td>2008/12/13</td>
                                <td>$103,600</td>
                            </tr>
                            <tr>
                                <td>Jena Gaines</td>
                                <td>Office Manager</td>
                                <td>London</td>
                                <td>30</td>
                                <td>2008/12/19</td>
                                <td>$90,560</td>
                            </tr>
                            <tr>
                                <td>Quinn Flynn</td>
                                <td>Support Lead</td>
                                <td>Edinburgh</td>
                                <td>22</td>
                                <td>2013/03/03</td>
                                <td>$342,000</td>
                            </tr>
                            <tr>
                                <td>Charde Marshall</td>
                                <td>Regional Director</td>
                                <td>San Francisco</td>
                                <td>36</td>
                                <td>2008/10/16</td>
                                <td>$470,600</td>
                            </tr>
                            <tr>
                                <td>Haley Kennedy</td>
                                <td>Senior Marketing Designer</td>
                                <td>London</td>
                                <td>43</td>
                                <td>2012/12/18</td>
                                <td>$313,500</td>
                            </tr>
                            <tr>
                                <td>Tatyana Fitzpatrick</td>
                                <td>Regional Director</td>
                                <td>London</td>
                                <td>19</td>
                                <td>2010/03/17</td>
                                <td>$385,750</td>
                            </tr>
                            <tr>
                                <td>Michael Silva</td>
                                <td>Marketing Designer</td>
                                <td>London</td>
                                <td>66</td>
                                <td>2012/11/27</td>
                                <td>$198,500</td>
                            </tr>
                            <tr>
                                <td>Paul Byrd</td>
                                <td>Chief Financial Officer (CFO)</td>
                                <td>New York</td>
                                <td>64</td>
                                <td>2010/06/09</td>
                                <td>$725,000</td>
                            </tr>
                            <tr>
                                <td>Gloria Little</td>
                                <td>Systems Administrator</td>
                                <td>New York</td>
                                <td>59</td>
                                <td>2009/04/10</td>
                                <td>$237,500</td>
                            </tr>
                            <tr>
                                <td>Bradley Greer</td>
                                <td>Software Engineer</td>
                                <td>London</td>
                                <td>41</td>
                                <td>2012/10/13</td>
                                <td>$132,000</td>
                            </tr>
                            <tr>
                                <td>Dai Rios</td>
                                <td>Personnel Lead</td>
                                <td>Edinburgh</td>
                                <td>35</td>
                                <td>2012/09/26</td>
                                <td>$217,500</td>
                            </tr>
                            <tr>
                                <td>Jenette Caldwell</td>
                                <td>Development Lead</td>
                                <td>New York</td>
                                <td>30</td>
                                <td>2011/09/03</td>
                                <td>$345,000</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
                <div class="cover-body fade" id="studentTableCover">
                    <table id="studentTable" class="cover-body table table-hover w-100">
                        <thead class="table-primary text-center">
                            <tr>
                                <th>Mã Student</th>
                                <th>Name</th>
                                <th>Done</th>
                                <th>Not Done</th>
                                <th>Average Mark</th>
                                <th>Detail</th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>Herrod Chandler</td>
                                <td>Sales Assistant</td>
                                <td>San Francisco</td>
                                <td>59</td>
                                <td>2012/08/06</td>
                                <td>
                                    <button type="button" class="more btn bg-transparent" data-bs-toggle="modal"
                                            data-bs-target="#viewStudentDetail" style="margin: 0;">
                                        <span>Xem Task<i class="fas fa-long-arrow-alt-right"></i></span>
                                    </button>
                                </td>
                            </tr>
                            <tr>
                                <td>Rhona Davidson</td>
                                <td>Integration Specialist</td>
                                <td>Tokyo</td>
                                <td>55</td>
                                <td>2010/10/14</td>
                                <td>$327,900</td>
                            </tr>
                            <tr>
                                <td>Colleen Hurst</td>
                                <td>Javascript Developer</td>
                                <td>San Francisco</td>
                                <td>39</td>
                                <td>2009/09/15</td>
                                <td>$205,500</td>
                            </tr>
                            <tr>
                                <td>Sonya Frost</td>
                                <td>Software Engineer</td>
                                <td>Edinburgh</td>
                                <td>23</td>
                                <td>2008/12/13</td>
                                <td>$103,600</td>
                            </tr>
                            <tr>
                                <td>Jena Gaines</td>
                                <td>Office Manager</td>
                                <td>London</td>
                                <td>30</td>
                                <td>2008/12/19</td>
                                <td>$90,560</td>
                            </tr>
                            <tr>
                                <td>Quinn Flynn</td>
                                <td>Support Lead</td>
                                <td>Edinburgh</td>
                                <td>22</td>
                                <td>2013/03/03</td>
                                <td>$342,000</td>
                            </tr>
                            <tr>
                                <td>Charde Marshall</td>
                                <td>Regional Director</td>
                                <td>San Francisco</td>
                                <td>36</td>
                                <td>2008/10/16</td>
                                <td>$470,600</td>
                            </tr>
                            <tr>
                                <td>Haley Kennedy</td>
                                <td>Senior Marketing Designer</td>
                                <td>London</td>
                                <td>43</td>
                                <td>2012/12/18</td>
                                <td>$313,500</td>
                            </tr>
                            <tr>
                                <td>Tatyana Fitzpatrick</td>
                                <td>Regional Director</td>
                                <td>London</td>
                                <td>19</td>
                                <td>2010/03/17</td>
                                <td>$385,750</td>
                            </tr>
                            <tr>
                                <td>Michael Silva</td>
                                <td>Marketing Designer</td>
                                <td>London</td>
                                <td>66</td>
                                <td>2012/11/27</td>
                                <td>$198,500</td>
                            </tr>
                            <tr>
                                <td>Paul Byrd</td>
                                <td>Chief Financial Officer (CFO)</td>
                                <td>New York</td>
                                <td>64</td>
                                <td>2010/06/09</td>
                                <td>$725,000</td>
                            </tr>
                            <tr>
                                <td>Gloria Little</td>
                                <td>Systems Administrator</td>
                                <td>New York</td>
                                <td>59</td>
                                <td>2009/04/10</td>
                                <td>$237,500</td>
                            </tr>
                            <tr>
                                <td>Bradley Greer</td>
                                <td>Software Engineer</td>
                                <td>London</td>
                                <td>41</td>
                                <td>2012/10/13</td>
                                <td>$132,000</td>
                            </tr>
                            <tr>
                                <td>Dai Rios</td>
                                <td>Personnel Lead</td>
                                <td>Edinburgh</td>
                                <td>35</td>
                                <td>2012/09/26</td>
                                <td>$217,500</td>
                            </tr>
                            <tr>
                                <td>Jenette Caldwell</td>
                                <td>Development Lead</td>
                                <td>New York</td>
                                <td>30</td>
                                <td>2011/09/03</td>
                                <td>$345,000</td>
                            </tr>
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
                })
                var arr = [k, kha, g];
                console.log(arr);
                return arr;
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