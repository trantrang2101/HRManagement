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
        try ( PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            User user = (User) session.getAttribute("loginUser");
            EditDeleteDAO dao = new EditDeleteDAO();
            boolean edit = false;
            DetailDAO detail = new DetailDAO();
            if (action.equals("editNotice")) {
                if (request.getParameter("submit") == null) {
                    int taskid = Integer.parseInt(request.getParameter("id"));
                    request.setAttribute("chooseNotice", dao.getNotice(taskid));
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
                if (request.getParameter("submit") == null) {
                    int userid = Integer.parseInt(request.getParameter("user"));
                    request.setAttribute("choosePerson", detail.getUser(userid));
                    edit = true;
                    request.getRequestDispatcher("classroom.jsp").forward(request, response);
                } else {
                    if (request.getParameter("teacherRole") != null) {
                        int teacherRole = Integer.parseInt(request.getParameter("teacherRole"));
                        request.setAttribute("subjectClassList", detail.getClassByRole(teacherRole));
                        edit = true;
                        request.getRequestDispatcher("detail").forward(request, response);
                    } else {
                        int id = Integer.parseInt(request.getParameter("id"));
                            String name = request.getParameter("name");
                            boolean gender = request.getParameter("gender").equals("1");
                            String password = request.getParameter("password");
                            int role = Integer.parseInt(request.getParameter("role"));
                            String[] classList = request.getParameterValues("class");
                            int roleID = request.getParameter("roleID") != null
                                    ? Integer.parseInt(request.getParameter("roleID"))
                                    : 0;
                            Teacher userGet = new Teacher(id, name, gender, password, role, roleID);
                            if (dao.editUser(userGet)) {
                                if (classList != null && classList.length > 0) {
                                    for (String c : classList) {
                                        if (!dao.editUserClass(c, id)) {
                                            edit=false;
                                        }else{
                                            edit = true;
                                        }
                                    }
                                }
                                if (edit) {
                                    response.sendRedirect("detail");
                                }
                            }
                    }
                }
            }
            if (!edit) {
                out.print("<script>alert('Edit failed!');window.history.back()</script>");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("error.html");
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
