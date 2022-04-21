/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AddDAO;
import DAO.EditDeleteDAO;
import entity.Classroom;
import entity.Notice;
import entity.User;
import entity.Work;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.sql.SQLException;
import java.util.Collection;

/**
 *
 * @author hanhu
 */
@MultipartConfig
public class FileUpload extends HttpServlet {

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
        HttpSession session = request.getSession();
        Work taskHW = (Work) session.getAttribute("taskHW");
        String action = request.getParameter("action");
        String applicationPath = getServletContext().getRealPath("");
        User loginUser = (User) session.getAttribute("loginUser");
        String uploadPath = applicationPath.replace("build\\", "") + "homework" + File.separator + taskHW.getTaskid() + File.separator + loginUser.getId();
        try {
            if (action.equals("upfile")) {
                File fileUploadDirectory = new File(uploadPath);
                if (!fileUploadDirectory.exists()) {
                    fileUploadDirectory.mkdirs();
                }
                AddDAO dao = new AddDAO();
                EditDeleteDAO edit = new EditDeleteDAO();
                Part filePart = request.getPart("file");
                String fileName = filePart.getSubmittedFileName();
                for (Part part : request.getParts()) {
                    part.write(uploadPath + File.separator + fileName);
                    if (!dao.checkWorkDetailDuplicate(taskHW.getWork(), fileName)) {
                        dao.addWorkDetail(taskHW.getWork(), fileName);
                        edit.updateTimeDone(taskHW.getWork());
                    }
                }
            } else {
                String work = request.getParameter("work");
                EditDeleteDAO dao = new EditDeleteDAO();
                dao.deleteWorkDetail(taskHW.getWork(), work);
                File file = new File(uploadPath + File.separator + work);
                if (file.exists()) {
                    file.delete();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            response.sendRedirect("detail?id=" + taskHW.getTaskid());
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
