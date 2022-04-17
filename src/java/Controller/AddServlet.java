/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AddDAO;
import com.sun.org.apache.bcel.internal.generic.AALOAD;
import entity.Classroom;
import entity.Notice;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.SimpleDateFormat;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class AddServlet extends HttpServlet {

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
            AddDAO dao = new AddDAO();
            HttpSession session = request.getSession();
            String action = request.getParameter("action");
            if (action.equals("addClass")) {
                String name = request.getParameter("name");
                if (dao.addClass(name)) {
                    List<Classroom> list = (List<Classroom>) session.getAttribute("listClass");
                    list.add(new Classroom(name));
                    session.setAttribute("listClass", list); 
                    request.getRequestDispatcher("teacher_home.jsp").include(request, response);
                } else {
                    out.print("<script>alert('Add failed!');window.history.back()</script>");
                }
            }else if (action.equals("addNotice")) {
                String name = request.getParameter("title");
                int authorid=Integer.parseInt(request.getParameter("author"));
                String classid = request.getParameter("classid");
                boolean isTask =request.getParameter("notice").equals("1");
                String deadline=!isTask?null:request.getParameter("deadline").replace("T", " ");
                String publish=request.getParameter("publish").replace("T", " ");
                String content = request.getParameter("content");
                Notice noti = new Notice(0, authorid, name, content, classid, publish, isTask, deadline);
                if (dao.addNotice(noti)) {
                    response.sendRedirect("detail?class="+classid);
                } else {
                    out.print("<script>alert('Add failed!');window.history.back()</script>");
                }
            }else if (action.equals("addPerson")) {
                
            }
        } catch (Exception e) {
            e.printStackTrace();
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
