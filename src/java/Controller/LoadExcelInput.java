/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package Controller;

import DAO.AddDAO;
import entity.Classroom;
import entity.Teacher;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.FileInputStream;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.Iterator;
import java.util.List;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

/**
 *
 * @author Tran Trang
 */
@MultipartConfig
public class LoadExcelInput extends HttpServlet {

    private static final String ERROR = "invalid.jsp";

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
            Part filePart = request.getPart("excel");
            String fileName = filePart.getSubmittedFileName();
            for (Part part : request.getParts()) {
                String applicationPath = getServletContext().getRealPath("");
                part.write(applicationPath + File.separator + fileName);
                File file = new File(applicationPath + File.separator + fileName); // creating a new file instance
                FileInputStream fis = new FileInputStream(file); // obtaining bytes from the file
                if (fileName.endsWith(".xlsx")) {
                    XSSFWorkbook wb = new XSSFWorkbook(fis);
                    XSSFSheet sheet = wb.getSheetAt(0);
                    int rowNo = sheet.getPhysicalNumberOfRows();
                    for (int i = 1; i < rowNo; i++) {
                        Row row = sheet.getRow(i); // returns the logical row
                        int id = Integer.parseInt(row.getCell(1).getStringCellValue());
                        String name = row.getCell(2).getStringCellValue();
                        boolean gender = row.getCell(3).getNumericCellValue() == 1;
                        String classid = row.getCell(4).getStringCellValue();
                        String password = row.getCell(6).getStringCellValue();
                        try {
                            addStudent(id, name, gender, password, classid, out);
                        } catch (Exception e) {
                        }
                    }
                } else if (fileName.endsWith(".xls")) {
                    HSSFWorkbook wb = new HSSFWorkbook(fis);
                    HSSFSheet sheet = wb.getSheetAt(0);
                    int rowNo = sheet.getPhysicalNumberOfRows();
                    for (int i = 1; i < rowNo; i++) {
                        Row row = sheet.getRow(i); // returns the logical row
                        int id = Integer.parseInt(row.getCell(1).getStringCellValue());
                        String name = row.getCell(2).getStringCellValue();
                        boolean gender = row.getCell(3).getStringCellValue().equals("1");
                        String classid = row.getCell(4).getStringCellValue();
                        String password = row.getCell(6).getStringCellValue();
                        try {
                            addStudent(id, name, gender, password, classid, out);
                        } catch (Exception e) {
                        }
                    }
                }
                file.delete();
                response.sendRedirect("detail");
            }
        } catch (Exception e) {
            response.sendRedirect("detail");
        }
    }

    public boolean addStudent(int id, String name, boolean gender, String password, String classid, PrintWriter out) throws SQLException {
        if (classid.length() <= 5) {
            AddDAO dao = new AddDAO();
            Teacher user = new Teacher(id, name, gender, password, 1);
            if (dao.addUser(user)) {
                if (!dao.addUserClass(classid, id)) {
                    dao.addClass(classid);
                    out.print("<script>alert('Add class " + classid + "!');</script>");
                    if (!dao.addUserClass(classid, id)) {
                        return false;
                    }
                }
                return true;
            }
        }
        return false;
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
