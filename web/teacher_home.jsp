<%-- 
    Document   : teacher_home
    Created on : Apr 14, 2022, 10:27:37 PM
    Author     : Tran Trang
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<head>
    <title>Teacher - Homepage</title>
    <script src="assests/ckeditor/ckeditor.js"></script>
    <script src="assests/js/moment.js"></script>
</head>

<body>
    <jsp:include page="included/modal.jsp"/>
    <nav class="navbar navbar-expand-lg navbar-light bg-transparent">
        <div class="container container-fluid">
            <h2>Hi cô <i>Phạm Thu Hương</i>!</h2>
            <button class="d-flex btn btn-danger" data-bs-toggle="modal" data-bs-target="#logoutModal">Logout</button>
        </div>
    </nav>
    <nav class="container d-flex justify-content-end">
        <button type="button" class="btn btn-primary">
            <i class="fa-solid fa-plus"></i>
            <span>Add Class</span>
        </button>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addNotice">
            <i class="fa-solid fa-plus"></i>
            <span>Add Notice</span>
        </button>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#addPerson">
            <i class="fa-solid fa-plus"></i>
            <span>Add Student/Teacher</span>
        </button>
    </nav>
    <div class="container class-list center d-flex flex-wrap justify-content-between">
        <div class="col rounded-2 shadow-sm card">
            <div class="card-body">
                <div class="card-title d-flex justify-content-between">
                    <h4>8A</h4>
                    <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#deleteClass"
                            aria-label="Close"></button>
                </div>
                <a href="teacher_classroom.jsp" class="more float-end">
                    <span>More details<i class="fas fa-long-arrow-alt-right"></i></span>
                </a>
            </div>
        </div>
        <div class="col rounded-2 shadow-sm card">
            <div class="card-body">
                <div class="card-title d-flex justify-content-between">
                    <h4>8A</h4>
                    <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#deleteClass"
                            aria-label="Close"></button>
                </div>
                <a href="teacher_classroom.jsp" class="more float-end">
                    <span>More details<i class="fas fa-long-arrow-alt-right"></i></span>
                </a>
            </div>
        </div>
        <div class="col rounded-2 shadow-sm card">
            <div class="card-body">
                <div class="card-title d-flex justify-content-between">
                    <h4>8A</h4>
                    <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#deleteClass"
                            aria-label="Close"></button>
                </div>
                <a href="teacher_classroom.jsp" class="more float-end">
                    <span>More details<i class="fas fa-long-arrow-alt-right"></i></span>
                </a>
            </div>
        </div>
        <div class="col rounded-2 shadow-sm card">
            <div class="card-body">
                <div class="card-title d-flex justify-content-between">
                    <h4>8A</h4>
                    <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#deleteClass"
                            aria-label="Close"></button>
                </div>
                <a href="teacher_classroom.jsp" class="more float-end">
                    <span>More details<i class="fas fa-long-arrow-alt-right"></i></span>
                </a>
            </div>
        </div>
        <div class="col rounded-2 shadow-sm card">
            <div class="card-body">
                <div class="card-title d-flex justify-content-between">
                    <h4>8A</h4>
                    <button type="button" class="btn-close" data-bs-toggle="modal" data-bs-target="#deleteClass"
                            aria-label="Close"></button>
                </div>
                <a href="teacher_classroom.jsp" class="more float-end">
                    <span>More details<i class="fas fa-long-arrow-alt-right"></i></span>
                </a>
            </div>
        </div>
    </div>
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
            })
        })
        var newDateInput = document.querySelector('#dateInput');
        newDateInput.min = moment(new Date()).format('YYYY-MM-DDTHH:mm');
        window.addEventListener('DOMContentLoaded', event => {
            CKEDITOR.replace('postAdd');
        });
    </script>
</body>

</html>