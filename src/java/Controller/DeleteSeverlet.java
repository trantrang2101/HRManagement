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
            DetailDAO detail = new DetailDAO();
            User user = (User) session.getAttribute("loginUser");
            Classroom cl = (Classroom) session.getAttribute("classChoose");
            EditDeleteDAO dao = new EditDeleteDAO();
            if (action.equals("deleteNotice")) {
                int notice = Integer.parseInt(request.getParameter("noticeDelete"));
                if (request.getParameter("submit") != null) {
                    if (!dao.deleteNotice(notice)) {
                        out.print("<script>window.history.back()</script>");
                    } else {
                        response.sendRedirect("detail?submit=deleteNotice&class=" + cl.getName());
                    }
                } else {
                    session.setAttribute("deleteNotice", dao.getNotice(notice));
                    response.sendRedirect("detail?class=" + cl.getName());
                }
            } else if (action.equals("deleteClass")) {
                String classid = request.getParameter("class");
                if (request.getParameter("submit") != null) {
                    if (!dao.deleteClass(classid)) {
                        out.print("<script>window.history.back()</script>");
                    } else {
                        response.sendRedirect("detail?action=return&submit=deleteClass");
                    }
                } else {
                    session.setAttribute("deleteClass", classid);
                    response.sendRedirect("detail?action=return");
                }
            } else if (action.equals("deleteUser")) {
                int getUser = Integer.parseInt(request.getParameter("user"));
                if (request.getParameter("submit") != null) {
                    if (!dao.deleteUser(getUser)) {
                        out.print("<script>window.history.back()</script>");
                    } else {
                        response.sendRedirect("detail?submit=deleteUser");
                    }
                } else {
                    Teacher get = detail.getUser(getUser);
                    if (user.getId() == get.getId()) {
                        out.print("<script>alert('You cannot delete yourself!');window.history.back()</script>");
                    } else {
                        session.setAttribute("deletePerson", get);
                        response.sendRedirect("detail");
                    }
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
