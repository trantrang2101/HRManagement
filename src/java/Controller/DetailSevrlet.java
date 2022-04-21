/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AddDAO;
import DAO.DetailDAO;
import DAO.LoginDAO;
import entity.Classroom;
import entity.Notice;
import entity.Teacher;
import entity.User;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class DetailSevrlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        DetailDAO dao = new DetailDAO();
        HttpSession session = request.getSession();
        PrintWriter out = response.getWriter();
        try {
            String classname = request.getParameter("class");
            String task = request.getParameter("task");
            String id = request.getParameter("id");
            String action = request.getParameter("action");
            String submit = request.getParameter("submit");
            Integer userid = request.getParameter("userid") != null ? Integer.parseInt(request.getParameter("userid")) : null;
            Integer taskid = request.getParameter("taskid") != null ? Integer.parseInt(request.getParameter("taskid")) : null;
            User user = (User) session.getAttribute("loginUser");
            if (classname != null) {
                if (submit != null && submit.equals("deleteNotice")) {
                    session.removeAttribute("deleteNotice");
                }
                String search = request.getParameter("search");
                if (search == null) {
                    search = "";
                } else {
                    request.setAttribute("searchWords", search);
                }
                String[] value = request.getParameterValues("option");
                if (value == null || value.length == 0) {
                    value = new String[2];
                }
                if (value.length == 1) {
                    request.setAttribute("optionChoose", value[0]);
                }
                session.setAttribute("classChoose", dao.getClass(classname));
                session.setAttribute("classNotice", dao.getNoticeList(user, classname, value, search));
                request.getRequestDispatcher("classroom.jsp").forward(request, response);
            } else if (action != null) {
                if (submit != null && submit.equals("deleteClass")) {
                    session.removeAttribute("deleteClass");
                }
                LoginDAO login = new LoginDAO();
                List<Classroom> list = login.getClassList(user.getId(), user.getRoleID());
                session.setAttribute("listClass", list);
                List<Teacher> listSubject = login.getTeacherRoleList();
                session.setAttribute("listSubject", listSubject);
                request.getRequestDispatcher("teacher_home.jsp").forward(request, response);
            } else if (userid != null) {
                request.setAttribute("userChoose", userid);
                request.getRequestDispatcher("report.jsp").forward(request, response);
            } else if (taskid != null) {
                request.setAttribute("taskChoose", taskid);
                request.getRequestDispatcher("report.jsp").forward(request, response);
            } else if (task != null) {
                Notice taskDetail = dao.getTask(Integer.parseInt(task));
                request.setAttribute("task", Integer.parseInt(task));
                request.setAttribute("choosenTask", taskDetail);
                if (user.getRoleID() == 1) {
                    request.getRequestDispatcher("student_task.jsp").forward(request, response);
                } else {
                    request.setAttribute("choosenTask", taskDetail);
                    request.setAttribute("taskWorkChoosen", dao.getWorkList(Integer.parseInt(task)));
                    request.getRequestDispatcher("teacher_task.jsp").forward(request, response);
                }
            } else if (id != null) {
                Integer studentid = request.getParameter("studentid") == null ? -1 : Integer.parseInt(request.getParameter("studentid"));
                User loginUser = (User) session.getAttribute("loginUser");
                Notice noti = dao.getTask(Integer.parseInt(id));
                if (studentid < 0) {
                    session.setAttribute("taskHW", noti);
                    if (loginUser.getRoleID() == 1) {
                        request.getRequestDispatcher("detail?task=" + id).forward(request, response);
                    } else {
                    }
                } else {
                }
            } else {
                if (submit != null && submit.equals("deleteUser")) {
                    session.removeAttribute("deletePerson");
                }
                String search = request.getParameter("search");
                String[] roleList = {"1", "2", "0"};
                String[] roleName = {"Student", "Teacher", "Admin"};
                String[] roleSearch = request.getParameterValues("roleSearch");
                int page = 1;
                int recordsPerPage = 25;
                if (request.getParameter("page") != null && !request.getParameter("page").isEmpty()) {
                    page = Integer.parseInt(request.getParameter("page"));
                }
                if (search == null) {
                    search = "";
                }
                if (roleSearch == null || roleSearch.length == 0) {
                    roleSearch = roleList;
                }
                List<Teacher> listUser = dao.getUserList((page - 1) * recordsPerPage, recordsPerPage, roleSearch, search);
                int noPages = (int) Math.ceil(dao.getTotal(roleSearch, search) * 1.0 / recordsPerPage);
                session.setAttribute("listUser", listUser);
                request.setAttribute("roleList", roleList);
                request.setAttribute("roleName", roleName);
                request.setAttribute("roleSearch", roleSearch);
                request.setAttribute("searchWords", search);
                session.setAttribute("thisPage", page);
                session.setAttribute("pages", noPages);
                request.getRequestDispatcher("view_people.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the    // + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
