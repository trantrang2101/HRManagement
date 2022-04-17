<%-- 
    Document   : student_task
    Created on : Apr 14, 2022, 10:25:30 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="vi">

    <head>
        <title>Student - Task</title>
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
        <div class="container center">
            <a href="student_classroom.jsp" class="more float-end">
                <span>Return Class<i class="fas fa-long-arrow-alt-right"></i></span>
            </a>
            <nav class="container row">
                <div class="col-8 d-flex flex-column">
                    <div class="d-flex justify-content-start">
                        <div class="icon rounded-circle bg-primary">
                            <i class="fa-solid fa-list-check text-white"></i>
                        </div>
                        <div class="card-text d-flex flex-column justify-content-between">
                            <h5 class="carrd-title">Task về nhà</h5>
                            <span class="card-subtitle mb-2 text-danger fw-bold text-start">Còn 2:30</span>
                            <span class="card-subtitle mb-2 text-muted text-start">Phạm Thu Hương · 4 Nov 2021</span>
                        </div>
                    </div>
                    <div>
                        <strong>This is the first item's accordion body.</strong> It is shown by default, until the
                        collapse plugin adds the appropriate classes that we use to style each element. These classes
                        control the overall appearance, as well as the showing and hiding via CSS transitions. You can
                        modify any of this with custom CSS or overriding our default variables. It's also worth noting
                        that just about any HTML can go within the <code>.accordion-body</code>, though the transition
                        does limit overflow.
                    </div>
                </div>
                <nav class="col-4 d-flex flex-column justify-content-around">
                    <button class="btn btn-primary float-end" data-bs-toggle="modal" data-bs-target="#fileOpenStudent" style="margin: 0;">
                        <i class="fa-solid fa-plus"></i>
                        <span> Task</span>
                    </button>
                    <div class="text-success text-center row fw-bold">
                        <span class="col border-end">Done </span>
                        <span class="col d-flex flex-column justify-content-between">
                            <span>Mark</span>
                            <span> __ / 10</span>
                        </span>
                    </div>
                </nav>
            </nav>
        </div>
    </body>

</html>