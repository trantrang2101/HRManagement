/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package DAO;

import connectDB.ConnectJDBC;
import entity.Notice;
import entity.Teacher;
import entity.User;
import entity.Work;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 *
 * @author Tran Trang
 */
public class AddDAO {

    public boolean checkWorkDetailDuplicate(int work,String name) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "select * from work_detail where workid = " + work + " and work='" + name+"'";
                stm = conn.prepareStatement(sql);
                rs = stm.executeQuery();
                while (rs.next()) {
                    check=true;
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
    
    public boolean addWorkDetail(int work,String name) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("INSERT INTO work_detail VALUES (?,?)");
                stm.setInt(1, work);
                stm.setString(2, name);
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
    
    public boolean addClass(String name) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("INSERT INTO Classroom (id) VALUES (?)");
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
    
    public boolean addClass(String name,String building,int room) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("INSERT INTO Classroom VALUES (?,?,?)");
                stm.setString(1, name);
                stm.setString(2, building);
                stm.setInt(3, room);
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

    public boolean addUserClass(String classid, int userid) throws SQLException {
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

    public boolean addUser(Teacher user) throws SQLException {
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
                if (stm.executeUpdate() > 0) {
                    if (user.getRoleID() == 2) {
                        sql = "INSERT INTO [teacher] VALUES (?,?)";
                        stm = conn.prepareStatement(sql);
                        stm.setInt(1, user.getId());
                        stm.setInt(2, user.getSubjectID());
                        check = stm.executeUpdate() > 0;
                    } else {
                        check = true;
                    }
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
    
    public boolean addWork(int task,int user) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String sql = "INSERT INTO task_work (id,userid,doneAt) VALUES (?,?,null)";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, task);
                stm.setInt(2, user);
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
    
    public int addNotice(Notice noti) throws SQLException {
        int check = -1;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String deadline = noti.getDeadline() == null ? "null" : "(CONVERT(datetime,'" + noti.getDeadline() + "',120))";
                String sql = "INSERT INTO Notice (createdBy,title,describe,classid,publicAt,isTask,deadline) VALUES (?,?,?,?,(CONVERT(datetime,'" + noti.getPublicAt() + "',120)),?," + deadline + ")";
                stm = conn.prepareStatement(sql);
                stm.setInt(1, noti.getCreateBy());
                stm.setNString(2, noti.getTitle());
                stm.setNString(3, noti.getDescribe());
                stm.setString(4, noti.getClassroom());
                stm.setBoolean(5, noti.isTask());
                if (stm.executeUpdate() > 0) {
                    stm = conn.prepareStatement("select * from notice");
                    rs=stm.executeQuery();
                    while(rs.next()){
                        check = rs.getInt(1);
                    }
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
}
