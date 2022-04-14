<%-- 
    Document   : teacher_classroom
    Created on : Apr 14, 2022, 10:26:18 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">
    <head>
        <title>Teacher - Class 8A</title>
        <script src="assests/js/moment.js"></script>
        <script src="assests/ckeditor/ckeditor.js"></script>
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
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNotice">
                <i class="fa-solid fa-plus"></i>
                <span>Add Notice</span>
            </button>
            <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewMark">
                <i class="fa-solid fa-eye"></i>
                <span>Mark Report</span>
            </button>
            <a class="btn btn-primary" href="report.jsp">
                <i class="fa-solid fa-eye"></i>
                <span> Báo Cáo</span>
            </a>
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
            <div class="accordion-item rounded-3 shadow-sm">
                <div class="accordion-header notice rounded-top rounded-3" id="heading1">
                    <a class="w-100" type="button" data-bs-toggle="collapse" href="#notice1" aria-expanded="true"
                       aria-controls="panelsStayOpen-collapseOne">
                        <div class="d-flex justify-content-between">
                            <div class="d-flex justify-content-start">
                                <div class="icon rounded-circle bg-primary">
                                    <i class="fa-solid fa-list-check text-white"></i>
                                </div>
                                <div class="card-text d-flex flex-column justify-content-between">
                                    <h5 class="carrd-title">Phạm Thu Hương post a task: Task về nhà</h5>
                                    <span class="card-subtitle mb-2 text-muted text-start">4 Nov 2021</span>
                                </div>
                            </div>
                            <div class="dropdown">
                                <a class="btn bg-transparent" type="button" href="#dropdownMenuButton1"
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" id="dropdownMenuButton1">
                                    <li><button class="dropdown-item" href="#" data-bs-toggle="modal"
                                                data-bs-target="#editNotice">Edit</button></li>
                                    <li><button class="dropdown-item" href="#" data-bs-toggle="modal"
                                                data-bs-target="#deleteNotice">Delete</button></li>
                                </ul>
                            </div>
                        </div>
                    </a>
                </div>
                <div id="notice1" class="accordion-collapse collapse" aria-labelledby="heading1">
                    <div class="accordion-body row">
                        <div class="col-10">
                            <strong>This is the first item's accordion body.</strong> It is shown by default, until the
                            collapse
                            plugin adds the appropriate classes that we use to style each element. These classes control the
                            overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of
                            this with custom CSS or overriding our default variables. It's also worth noting that just about
                            any
                            HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                        </div>
                        <div class="col-2 row row-cols-2">
                            <div class="col d-flex flex-column">
                                <h2>4</h2>
                                <p>Done</p>
                            </div>
                            <div class="col d-flex flex-column">
                                <h2>30</h2>
                                <p>Not Done</p>
                            </div>
                        </div>
                    </div>
                    <div class="accordion-footer">
                        <a href="teacher_task.jsp" class="more"><span> More detail<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </div>
                </div>
            </div>
            <div class="accordion-item rounded-3 shadow-sm">
                <div class="accordion-header notice rounded-top rounded-3" id="heading2">
                    <a class="w-100" type="button" data-bs-toggle="collapse" href="#notice2" aria-expanded="true"
                       aria-controls="panelsStayOpen-collapseOne">
                        <div class="d-flex justify-content-between">
                            <div class="d-flex justify-content-start">
                                <div class="icon rounded-circle bg-primary">
                                    <i class="fa-solid fa-note-sticky text-white"></i>
                                </div>
                                <div class="card-text d-flex flex-column justify-content-between">
                                    <h5 class="carrd-title">Phạm Thu Hương post a  Notice: Ngày 20/4 kiểm tra 1 tiết
                                    </h5>
                                    <span class="card-subtitle mb-2 text-muted text-start">4 Nov 2021</span>
                                </div>
                            </div>
                            <div class="dropdown">
                                <a class="btn bg-transparent" type="button" href="#dropdownMenuButton1"
                                   data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-ellipsis-vertical"></i>
                                </a>
                                <ul class="dropdown-menu dropdown-menu-end" id="dropdownMenuButton1">
                                    <li><button class="dropdown-item" href="#" data-bs-toggle="modal"
                                                data-bs-target="#editNotice">Edit</button></li>
                                    <li><button class="dropdown-item" href="#" data-bs-toggle="modal"
                                                data-bs-target="#deleteNotice">Delete</button></li>
                                </ul>
                            </div>
                        </div>
                    </a>
                </div>
                <div id="notice2" class="accordion-collapse collapse" aria-labelledby="heading2">
                    <div class="accordion-body">
                        Các em chú ý có assignment 2. Deadline là 23h59 CN tuần sau. Quy
                        định vẫn như lần trước, ngoại trừ hai  đã làm cùng nhau lần trước thì
                        không được làm cùng nhau lần này. Các em hãy làm sớm nhất có thể nhé,
                        đừng để đến
                        cuối.
                    </div>
                </div>
            </div>
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
            window.addEventListener('DOMContentLoaded', event => {
                CKEDITOR.replace('postAdd');
                CKEDITOR.replace('postEdit');
            });
            var newDateInput = document.querySelector('#dateInput');
            newDateInput.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
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