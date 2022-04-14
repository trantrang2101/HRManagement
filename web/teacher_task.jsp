<%-- 
    Document   : teacher_task
    Created on : Apr 14, 2022, 10:28:25 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Teacher - Task</title>
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
        <a href="teacher_classroom.jsp" class="more float-end">
            <span>Return Class<i class="fas fa-long-arrow-alt-right"></i></span>
        </a>
    </nav>
    <div class="row">
        <div class="col-2 student-mark-list">
            <select class="form-select border-0" aria-label="Default select example">
                <option selected value="0">Sắp xếp theo trạng thái</option>
                <option value="1">Sắp xếp theo Name</option>
                <option value="2">Sắp xếp theo mã số Student</option>
            </select>
            <table class="table table-hover">
                <tr>
                    <th colspan="3">Done</th>
                </tr>
                <tr class="">
                    <th>1</th>
                    <td class="d-flex flex-column">
                        <span>Tường Phạm</span>
                        <a href="" class="more"><span>More details<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </td>
                    <td class="text-danger text-center">__/10
                    </td>
                </tr>
                <tr>
                    <th>1</th>
                    <td class="d-flex flex-column">
                        <span>Tường Phạm</span>
                        <a href="" class="more"><span>More details<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </td>
                    <td class="text-success text-center">5/10
                    </td>
                </tr>
                <tr class="">
                    <th>1</th>
                    <td class="d-flex flex-column">
                        <span>Tường Phạm</span>
                        <a href="" class="more"><span>More details<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </td>
                    <td class="text-danger text-center">__/10
                    </td>
                </tr>
                <tr>
                    <th>1</th>
                    <td class="d-flex flex-column">
                        <span>Tường Phạm</span>
                        <a href="" class="more"><span>More details<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </td>
                    <td class="text-success text-center">5/10
                    </td>
                </tr>
                <tr class="">
                    <th>1</th>
                    <td class="d-flex flex-column">
                        <span>Tường Phạm</span>
                        <a href="" class="more"><span>More details<i class="fas fa-long-arrow-alt-right"></i></span></a>
                    </td>
                    <td class="text-danger text-center">__/10
                    </td>
                </tr>
                <tr>
                    <th colspan="3">Not Done</th>
                </tr>
                <tr>
                    <th>1</th>
                    <td>Tường Phạm</td>
                    <td class="text-danger text-center">Thiếu</td>
                </tr>
                <tr>
                    <th>1</th>
                    <td>Tường Phạm</td>
                    <td class="text-danger text-center">Thiếu</td>
                </tr>
                <tr>
                    <th>1</th>
                    <td>Tường Phạm</td>
                    <td class="text-danger text-center">Thiếu</td>
                </tr>
                <tr>
                    <th>1</th>
                    <td>Tường Phạm</td>
                    <td class="text-danger text-center">Thiếu</td>
                </tr>
            </table>
        </div>
        <div class="col-10">
            <nav class="container">
                <div class="d-flex justify-content-between">
                    <div class="d-flex justify-content-start">
                        <div class="icon rounded-circle bg-primary">
                            <i class="fa-solid fa-list-check text-white"></i>
                        </div>
                        <div class="card-text d-flex flex-column justify-content-between">
                            <h5 class="carrd-title">Task về nhà</h5>
                            <span class="card-subtitle mb-2 text-muted text-start">Phạm Thu Hương · 4 Nov
                                2021</span>
                        </div>
                    </div>
                    <div class="dropdown">
                        <a class="btn bg-transparent" href="#dropdownMenuButton1" data-bs-toggle="dropdown"
                           aria-expanded="false">
                            <i class="fa-solid fa-ellipsis-vertical"></i>
                        </a>
                        <ul class="dropdown-menu dropdown-menu-end" id="dropdownMenuButton1">
                            <li><button class="dropdown-item" data-bs-toggle="modal"
                                        data-bs-target="#editNotice">Edit</button></li>
                            <li><button class="dropdown-item" data-bs-toggle="modal"
                                        data-bs-target="#deleteNotice">Delete</button></li>
                        </ul>
                    </div>
                </div>
                <div class="row">
                    <div class="col-10">
                        <strong>This is the first item's accordion body.</strong> It is shown by default, until the
                        collapse plugin adds the appropriate classes that we use to style each element. These classes
                        control the overall appearance, as well as the showing and hiding via CSS transitions. You can
                        modify any of this with custom CSS or overriding our default variables. It's also worth noting
                        that just about any HTML can go within the <code>.accordion-body</code>, though the transition
                        does limit overflow.
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
            </nav>
            <div class="container">
                <select class="form-select border-0 w-25" aria-label="Default select example">
                    <option selected value="0">Tất cả</option>
                    <option value="1">Done</option>
                    <option value="2">Not Done</option>
                    <option value="3">Mark</option>
                </select>
                <div class="d-flex flex-wrap justify-content-start submit-list">
                    <div class="shadow-sm rounded-2">
                        <h6>Tường Phạm</h6>
                        <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#fileOpenTeacher">
                            <i class="fa-solid fa-folder"></i>
                            <span>abxcuz-dhalkshdfl</span>
                        </button>
                        <p class="text-success">Done on time</p>
                    </div>
                    <div class="shadow-sm rounded-2">
                        <h6>Tường Phạm</h6>
                        <button class="btn btn-light" data-bs-toggle="modal" data-bs-target="#fileOpenTeacher">
                            <i class="fa-solid fa-folder"></i>
                            <span>abxcuz-dhalkshdfl</span>
                        </button>
                        <p class="text-warning">Done late</p>
                    </div>
                    <div class="shadow-sm rounded-2">
                        <h6>Tường Phạm</h6>
                        <button class="btn btn-light">
                            <i class="fa-solid fa-folder-open"></i>
                            <span class="text-muted">Not submitted</span>
                        </button>
                        <p class="text-danger">Not Done</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="assests/js/script.js"></script>
    <script>
        var inputDate = document.querySelectorAll('#dateUpdate')[0];
        var date = document.querySelectorAll('#valueDate')[0];
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