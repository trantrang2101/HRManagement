/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connectDB.ConnectJDBC;
import entity.Classroom;
import entity.Notice;
import entity.User;
import entity.Work;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class DetailDAO {

    public User getUser(int id) throws SQLException {
        User login = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from [user] where id = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, id);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString(2);
                    boolean gender = rs.getBoolean(3);
                    String password = "***";
                    int roleID = rs.getInt(4);
                    login = new User(id, name, gender, password, roleID);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return login;
    }

    public Classroom getClass(String id) throws SQLException {
        Classroom login = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                List<User> list = new ArrayList<>();
                String sql = "select * from [classroom_detail],[user] where classroom_detail.id = ? and userid=[user].id";
                stm = conn.prepareStatement(sql);
                stm.setString(1, id);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int userid = rs.getInt(3);
                    String name = rs.getString(4);
                    boolean gender = rs.getBoolean(5);
                    String password = "***";
                    int roleID = rs.getInt(7);
                    list.add(new User(userid, name, gender, password, roleID));
                }
                login = new Classroom(id, list);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return login;
    }

    public Work getWork(int taskid, int userid) throws SQLException {
        Work workDone = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from task_work where id = " + taskid + " and userid=" + userid;
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String work = rs.getString(3);
                    double mark = rs.getInt(4);
                    String comment = rs.getString(5);
                    String doneAt = rs.getString(6);
                    workDone = new Work(taskid, userid, work, mark, comment, doneAt);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return workDone;
    }
    
    public List<Work> getWorkList(int taskid) throws SQLException {
        List<Work> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from task_work where id=" + taskid;
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int userid = rs.getInt(2);
                    String work = rs.getString(3);
                    double mark = rs.getDouble(4);
                    String comment =rs.getString(5);
                    String doneAt = rs.getString(6);
                    list.add(new Work(taskid, userid, work, mark, comment, doneAt));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
    
    public List<Notice> getNoticeList(User user, String classid) throws SQLException {
        List<Notice> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = user.getRoleID() != 2 ? "select * from notice where classid='" + classid + "' order by publicAt desc" : "select * from notice where classid='" + classid + "' and createdBy=" + user.getId() + " order by publicAt desc";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt(1);
                    String title = rs.getString(3);
                    String describe = rs.getString(4);
                    String publicAt = rs.getString(6);
                    boolean isTask = rs.getBoolean(7);
                    String deadline = rs.getString(8);
                    list.add(new Notice(id, user.getId(), title, describe, classid, publicAt, isTask, deadline));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return list;
    }
}
