/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.EditDeleteDAO;
import DAO.LoginDAO;
import entity.Classroom;
import entity.Notice;
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
public class DeleteSeverlet extends HttpServlet {

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
            User user = (User)session.getAttribute("loginUser");
            EditDeleteDAO dao = new EditDeleteDAO();
            if (action.equals("deleteNotice")) {
                int notice = Integer.parseInt(request.getParameter("notice"));
                if (!dao.deleteNotice(notice)) {
                    out.print("<script>alert('Delete failed!');window.history.back()</script>");
                } else {
                    Classroom cl = (Classroom) session.getAttribute("classChoose");
                    response.sendRedirect("detail?class=" + cl.getName());
                }
            } else if (action.equals("deleteClass")) {
                String classid = request.getParameter("class");
                if (!dao.deleteClass(classid)) {
                    out.print("<script>alert('Delete failed!');window.history.back()</script>");
                }else{
                    LoginDAO daoLogin = new LoginDAO();
                    List<Classroom> list = daoLogin.getClassList(user.getId());
                    session.setAttribute("listClass", list);
                    response.sendRedirect("teacher_home.jsp");
                }
            }else if (action.equals("deleteUser")) {
                int getUser = Integer.parseInt(request.getParameter("user"));
                if (!dao.deleteUser(getUser)) {
                    out.print("<script>alert('Delete failed!');window.history.back()</script>");
                } else {
                    response.sendRedirect("detail");
                }
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
