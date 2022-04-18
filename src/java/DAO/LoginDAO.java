/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import entity.User;
import connectDB.ConnectJDBC;
import entity.Classroom;
import entity.Teacher;
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
public class LoginDAO {

    public List<Teacher> getTeacherRoleList() throws SQLException {
        List<Teacher> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from teacher_role";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int id = rs.getInt(1);
                    String name = rs.getString(2);
                    list.add(new Teacher(id, name));
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

    public List<Classroom> getClassList(int id) throws SQLException {
        List<Classroom> list = new ArrayList<>();
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = id != 1 ? "select * from classroom order by id" : "select classroom.id from classroom,classroom_detail where classroom.id=classroom_detail.id and userid=" + id + "  order by id";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString(1);
                    list.add(new Classroom(name));
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

    public User login(int userID, String password) throws SQLException {
        User login = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from [User] where id = ? AND password = ?";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, userID);
                stm.setString(2, password);
                rs = stm.executeQuery();
                while (rs.next()) {
                    String name = rs.getString(2);
                    boolean gender = rs.getBoolean(3);
                    int roleID = rs.getInt(4);
//                    (int id, String name, boolean gender, String password, int roleID)
                    login = new User(userID, name, gender, password, roleID);
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
}
