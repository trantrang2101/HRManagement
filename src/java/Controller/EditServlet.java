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
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Random;

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
            } else if (action.equals("changePW")) {
                String current = request.getParameter("current");
                edit = true;
                if (!user.getPassword().equals(current)) {
                    edit = false;
                }
                String password = request.getParameter("password");
                String repassword = request.getParameter("repw");
                if (!password.equals(repassword)) {
                    edit = false;
                } else {
                    if (!dao.changePW(user.getId(), password)) {
                        edit = false;
                    } else {
                        out.print("<script>window.history.back();</script>");
                    }
                }
            } else if (action.equals("submitTask")) {
                String id = request.getParameter("id");
                double mark = request.getParameter("mark") == null ? -1 : Double.parseDouble(request.getParameter("mark"));
                String comment = request.getParameter("comment") != null ? request.getParameter("comment") : "";
                int work = Integer.parseInt(request.getParameter("work"));
                dao.updateMark(work, comment, mark);
                response.sendRedirect("detail?task=" + id);
            } else if (action.equals("forgot")) {
                int id = Integer.parseInt(request.getParameter("id"));
                edit = true;
                String name = request.getParameter("name");
                String[] classL = request.getParameterValues("classTeacher");
                List<String> classList = new ArrayList<>(Arrays.asList(classL));
                if (classList.size() == 3 && classList.get(1).isEmpty() && classList.get(2).isEmpty() && classList.get(0).isEmpty()) {
                    classList = new ArrayList<>();
                    classList.add(request.getParameter("class"));
                }
                if (classList.size() == 3) {
                    out.print("<script>alert('If you are teacher please insert at least 3 class you're teaching!')</script>");
                    request.getRequestDispatcher("forgot.html").include(request, response);
                } else {
                    boolean check = true;
                    Teacher get = detail.getUser(id);
                    if (get == null) {
                        check = false;
                    } else {
                        if (!get.getName().equals(name)) {
                            check = false;
                        }
                    }
                    List<String> classroom = detail.getClassByID(id);
                    for (String string : classList) {
                        if (!classroom.contains(string)) {
                            check = false;
                            break;
                        }
                    }
                    if (!check) {
                        out.print("<script>alert('Information wrong! Input again!');</script>");
                        request.getRequestDispatcher("forgot.html").include(request, response);
                    } else {
                        Random rand = new Random();
                        int value = rand.nextInt(999999);
                        if (dao.changePW(id, Integer.toString(value))) {
                            out.print("<script>alert('Your new password is:  '" + value + ");</script>");
                            response.sendRedirect("login?action=Login&id=" + id + "&password=" + value);
                        } else {
                            edit = false;
                        }
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
                                            } else {
                                                edit = true;
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
