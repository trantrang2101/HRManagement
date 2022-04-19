/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connectDB.ConnectJDBC;
import entity.*;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.SimpleDateFormat;

/**
 *
 * @author Tran Trang
 */
public class EditDeleteDAO {

    public boolean updateNotice(Notice noti) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String deadline = noti.getDeadline() == null ? "" : ",deadline=select * from (CONVERT(datetime,'" + noti.getDeadline() + "',120))";
                stm = conn.prepareStatement("update Blogs set createBy=?,Title=?,describe=?,classid=?,isTask=?,publicAt= select * from (CONVERT(datetime,'" + noti.getPublicAt() + "',120)" + deadline + ") where id = ?");
                stm.setInt(1, noti.getCreateBy());
                stm.setNString(2, noti.getTitle());
                stm.setNString(3, noti.getDescribe());
                stm.setString(4, noti.getClassroom());
                stm.setBoolean(5, noti.isTask());
                stm.setInt(6, noti.getId());
                check = stm.executeUpdate() > 0;
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
        return check;
    }

    public boolean deleteClass(String id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from classroom_detail where id='" + id + "'");
                if (stm.executeUpdate() > 0) {
                    stm = conn.prepareStatement("delete from classroom where id='" + id + "'");
                    check = stm.executeUpdate() > 0;
                }
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

    public boolean deleteNotice(String id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from notice where classid='" + id + "'");
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

    public boolean deleteUser(int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from [user] where id=" + id);
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

    public boolean deleteNotice(int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from notice where id=" + id);
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

    public Notice getNotice(int id) throws SQLException {
        Notice noti = null;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from notice where id=" + id;
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    int author = rs.getInt(2);
                    String title = rs.getString(3);
                    String describe = rs.getString(4);
                    String classid = rs.getString(5);
                    String publicAt = rs.getString(6);
                    boolean task = rs.getBoolean(7);
                    String deadline = rs.getString(8);
                    noti = new Notice(id, author, title, describe, classid, publicAt, task, deadline);
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
        return noti;
    }

    public boolean editUser(Teacher user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update [user] set name=?,gender=?,roleid=?,password=? where id = ?");
                stm.setNString(1, user.getName());
                stm.setBoolean(2, user.isGender());
                stm.setInt(3, user.getRoleID());
                stm.setString(4, user.getPassword());
                stm.setInt(5, user.getId());
                if (stm.executeUpdate() > 0) {
                    stm = conn.prepareStatement("select * from [teacher] where userid = ?");
                    stm.setInt(1, user.getId());
                    if (stm.executeUpdate() > 0) {
                        stm = conn.prepareStatement("update from [teacher] set roleid=? where userid = ?");
                        stm.setInt(1, user.getSubjectID());
                        stm.setInt(2, user.getId());
                    } else {
                        stm = conn.prepareStatement("insert into [teacher] values (?,?)");
                        stm.setInt(1, user.getId());
                        stm.setInt(2, user.getSubjectID());
                    }
                    check = stm.executeUpdate() > 0;
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
        return check;
    }

    public boolean editUserClass(String c, int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update classroom_detail set id=? where userid = ?");
                stm.setString(1, c);
                stm.setInt(2, id);
                check = stm.executeUpdate() > 0;
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
        return check;
    }
}
