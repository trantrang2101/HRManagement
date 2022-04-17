/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.LoginDAO;
import entity.Classroom;
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
public class LoginSeverlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
            if (action.equals("Login")) {
                int id = Integer.parseInt(request.getParameter("id"));
                String password = request.getParameter("password");
                LoginDAO dao = new LoginDAO();
                User user = dao.login(id, password);
                if (user != null) {
                    session.setAttribute("loginUser", user);
                    List<Classroom> list = dao.getClassList(id);
                    if (user.getRoleID() == 1) {
                        response.sendRedirect("detail?class=" + list.get(0).getName());
                    } else {
                        session.setAttribute("listClass", list);
                        List<Teacher> listSubject = dao.getTeacherRoleList();
                        session.setAttribute("listSubject", listSubject);
                        request.getRequestDispatcher("teacher_home.jsp").forward(request, response);
                    }
                } else {
                    out.print("<script>alert('Wrong id or password');</script>");
                    request.getRequestDispatcher("index.html").include(request, response);
                }
            } else if (action.equals("Logout")) {
                session.invalidate();
                response.sendRedirect("index.html");
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
