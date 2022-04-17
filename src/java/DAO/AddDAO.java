/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connectDB.ConnectJDBC;
import entity.Notice;
import entity.User;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

/**
 *
 * @author Tran Trang
 */
public class AddDAO {

    public boolean addClass(String name) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("INSERT INTO Classroom VALUES (?)");
                stm.setString(1, name);
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean addUserClass(String classid,int userid) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO [classroom_detail] VALUES (?,?)";
                stm = conn.prepareStatement(sql);
                stm.setString(1, classid);
                stm.setInt(2, userid);
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
    
    public boolean addUser(User user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO [user] VALUES (?,?,?,?,?)";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, user.getId());
                stm.setNString(2, user.getName());
                stm.setBoolean(3, user.isGender());
                stm.setInt(4, user.getRoleID());
                stm.setString(5, user.getPassword());
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }

    public boolean addNotice(Notice noti) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String deadline=noti.getDeadline()==null? "null" : "(CONVERT(datetime,'"+noti.getDeadline()+"',120))";
                String sql = "INSERT INTO Notice (createdBy,title,describe,classid,publicAt,isTask,deadline) VALUES (?,?,?,?,(CONVERT(datetime,'"+noti.getPublicAt()+"',120)),?,"+deadline+")";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, noti.getCreateBy());
                stm.setNString(2, noti.getTitle());
                stm.setNString(3, noti.getDescribe());
                stm.setString(4, noti.getClassroom());
                stm.setBoolean(5, noti.isTask());
                check = stm.executeUpdate() > 0;
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (conn != null) {
                conn.close();
            }
        }
        return check;
    }
}
