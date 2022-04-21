/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.*;
import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class EditServlet extends HttpServlet {

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
        PrintWriter out = response.getWriter();
        try {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loginUser");
            EditDeleteDAO dao = new EditDeleteDAO();
            boolean edit = false;
            DetailDAO detail = new DetailDAO();
            if (action.equals("editNotice")) {
                if (request.getParameter("submit") == null) {
                    int taskid = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("editNotice", detail.getNotice(taskid));
                    edit = true;
                    request.getRequestDispatcher("classroom.jsp").forward(request, response);
                } else {
                    int id = Integer.parseInt(request.getParameter("id"));
                    String name = request.getParameter("title");
                    int authorid = Integer.parseInt(request.getParameter("author"));
                    String classls = request.getParameter("classid");
                    boolean isTask = request.getParameter("noticeEdit").equals("1");
                    String content = request.getParameter("content");
                    String deadline = !isTask ? null : request.getParameter("deadline").replace("T", " ");
                    String publish = request.getParameter("publish").replace("T", " ");
                    Notice noti = new Notice(id, authorid, name, content, classls, publish, isTask, deadline);
                    if (dao.updateNotice(noti)) {
                        edit = true;
                        Classroom cl = (Classroom) session.getAttribute("classChoose");
                        response.sendRedirect("detail?class=" + cl.getName());
                    } else {
                        edit = false;
                    }
                }
            } else if (action.equals("editPerson")) {
                int userid = Integer.parseInt(request.getParameter("user"));
                Teacher previous = detail.getUser(userid);
                if (request.getParameter("submit") == null) {
                    request.setAttribute("editPerson", previous);
                    edit = true;
                    if (previous.getRoleID() == 2) {
                        request.setAttribute("subjectClassList", detail.getClassByRole(previous.getSubjectID()));
                    } else {
                        request.setAttribute("subjectClassList", detail.getClassByRole(1));
                    }
                    request.getRequestDispatcher("detail").forward(request, response);
                } else {
                    int role = request.getParameter("roleEdit") == null ? 2 : Integer.parseInt(request.getParameter("roleEdit"));
                    if (request.getParameter("teacherRole") == null || role != 2) {
                        String name = request.getParameter("name");
                        boolean gender = request.getParameter("gender").equals("1");
                        String password = request.getParameter("password");
                        String[] classList = role == 1 ? request.getParameterValues("class") : request.getParameterValues("classTeacher");
                        int roleID = request.getParameter("roleID") != null
                                ? Integer.parseInt(request.getParameter("roleID"))
                                : 0;
                        Teacher userGet = new Teacher(userid, name, gender, password, role, roleID);
                        if (previous.getRoleID() == 2 && userGet.getRoleID() != 2) {
                            dao.deleteTeacher(userid);
                        }
                        if (role == 2 && classList == null) {
                            out.print("<script>alert('Must choose class for teacher!');window.history.back()</script>");
                        } else {
                            try {
                                if (dao.editUser(userGet)) {
                                    dao.deleteAllClass(userGet.getId());
                                    if (classList != null && classList.length > 0) {
                                        for (String c : classList) {
                                            AddDAO add = new AddDAO();
                                            if (!add.addUserClass(c, userid)) {
                                                edit = false;
                                                break;
                                            }else{
                                                edit=true;
                                            }
                                        }
                                    }
                                    if (edit) {
                                        response.sendRedirect("detail");
                                    }
                                }
                            } catch (Exception e) {
                                e.printStackTrace();
                            }
                        }
                    } else {
                        int teacherRole = Integer.parseInt(request.getParameter("teacherRole"));
                        request.setAttribute("subjectClassList", detail.getClassByRole(teacherRole));
                        edit = true;
                        previous.setRoleID(2);
                        previous.setSubjectID(teacherRole);
                        request.setAttribute("editPerson", previous);
                        request.getRequestDispatcher("detail").forward(request, response);
                    }
                }
            }
            if (!edit) {
                out.print("<script>alert('Edit failed!');window.history.back()</script>");
            }
        } catch (Exception e) {
            out.print("<script>window.history.back()</script>");
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
