/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.LoginDAO;
import entity.*;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
@MultipartConfig
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
            LoginDAO dao = new LoginDAO();
            String action = request.getParameter("action");
            if (action != null) {
                if (action.equals("Login")) {
                    String userid = request.getParameter("id");
                    String password = request.getParameter("password");
                    int id = -1000;
                    User user = (User) session.getAttribute("loginUser");
                    if (user != null) {
                        id = user.getId();
                        password = user.getPassword();
                    } else {
                        id = Integer.parseInt(userid);
                        user = dao.login(id, password);
                    }
                    if (user != null) {
                        session.setAttribute("loginUser", user);
                        if (Boolean.parseBoolean(request.getParameter("remember"))) {
                            Cookie cookie = new Cookie("id", Integer.toString(id));
                            cookie.setMaxAge(3600 * 24 * 30);
                            Cookie pcookie = new Cookie("password", password);
                            cookie.setMaxAge(3600 * 24 * 30);
                            response.addCookie(cookie);
                            response.addCookie(pcookie);
                        }
                        if (user.getRoleID() == 1) {
                            List<Classroom> list = dao.getClassList(id, user.getRoleID());
                            response.sendRedirect("detail?class=" + list.get(0).getName());
                        } else {
                            response.sendRedirect("detail?action=return");
                        }
                    } else {
                        out.print("<script>alert('Wrong id or password');</script>");
                        request.getRequestDispatcher("index.html").include(request, response);
                    }
                } else if (action.equals("Logout")) {
                    session.invalidate();
                    Cookie[] cookies = request.getCookies();
                    if (cookies != null) {
                        for (Cookie cookie : cookies) {
                            if (cookie.getName().equals("id") || cookie.getName().equals("password")) {
                                cookie.setValue("");
                                cookie.setMaxAge(0);
                                response.addCookie(cookie);
                            }
                        }
                    }
                    response.sendRedirect("index.html");
                }
            } else {
                int id = -1;
                String password = "";
                Cookie[] cookies = request.getCookies();
                if (cookies != null) {
                    for (Cookie cooky : cookies) {
                        if (cooky.getName().equals("id")) {
                            id = Integer.parseInt(cooky.getValue());
                        } else if (cooky.getName().equals("password")) {
                            password = cooky.getValue();
                        }
                    }
                }
                if (password.isEmpty() || id == -1) {
                    request.getRequestDispatcher("index.html").forward(request, response);
                } else {
                    session.setAttribute("loginUser", dao.login(id, password));
                    response.sendRedirect("login?action=Login&id=" + id + "&password=" + password);
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
