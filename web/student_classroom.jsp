<%-- 
    Document   : student_classroom
    Created on : Apr 14, 2022, 10:24:11 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

<head>
    <title>Student - Class 8A</title>
</head>

<body>
    <jsp:include page="included/modal.jsp"/>
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
        <div class="container container-fluid">
            <div class="d-flex flex-column">
                <h1>Class 8A</h1>
                <h2>Hi <i>${sessionScope.loginUser.getName()}</i>!</h2>
            </div>
            <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
        </div>
    </nav>
    <nav class="container d-flex justify-content-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#viewMark">
            <i class="fa-solid fa-eye"></i>
            <span>Mark Report</span>
        </button>
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
        <div class="btn-group float-end fade" id="optionMore" role="group"
            aria-label="Basic checkbox toggle button group">

            <input type="checkbox" class="btn-check" name="optionMore" id="option2" autocomplete="off" checked>
            <label class="btn btn-outline-primary" for="option2">Finish Task</label>

            <input type="checkbox" class="btn-check" name="optionMore" id="option3" autocomplete="off" checked>
            <label class="btn btn-outline-primary" for="option3">Not Finish Task</label>
        </div>
    </div>
    <div class="accordion container" id="notice-list">
        <div class="accordion-item rounded-3 shadow-sm">
            <div class="accordion-header notice rounded-top rounded-3" id="heading1">
                <a class="w-100" type="button" data-bs-toggle="collapse" href="#notice1" aria-expanded="true"
                    aria-controls="panelsStayOpen-collapseOne">
                    <div class="d-flex justify-content-start">
                        <div class="icon rounded-circle bg-primary">
                            <i class="fa-solid fa-list-check text-white"></i>
                        </div>
                        <div class="card-text d-flex flex-column justify-content-between">
                            <h5 class="carrd-title">Phạm Thu Hương post a task: Task về nhà</h5>
                            <span class="card-subtitle mb-2 text-muted text-start">4 Nov 2021</span>
                        </div>
                    </div>
                </a>
            </div>
            <div id="notice1" class="accordion-collapse collapse" aria-labelledby="heading1">
                <div class="accordion-body ">
                    <div class="">
                        <strong>This is the first item's accordion body.</strong> It is shown by default, until the
                        collapse
                        plugin adds the appropriate classes that we use to style each element. These classes control the
                        overall appearance, as well as the showing and hiding via CSS transitions. You can modify any of
                        this with custom CSS or overriding our default variables. It's also worth noting that just about
                        any
                        HTML can go within the <code>.accordion-body</code>, though the transition does limit overflow.
                    </div>
                </div>
                <div class="accordion-footer">
                    <a href="student_task.jsp" class="more"><span> Task<i
                                class="fas fa-long-arrow-alt-right"></i></span></a>
                </div>
            </div>
        </div>
        <div class="accordion-item rounded-3 shadow-sm">
            <div class="accordion-header notice rounded-top rounded-3" id="heading2">
                <a class="w-100" type="button" data-bs-toggle="collapse" href="#notice2" aria-expanded="true"
                    aria-controls="panelsStayOpen-collapseOne">
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
</body>

</html>