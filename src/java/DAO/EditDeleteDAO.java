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
    public boolean changePW(int id,String password) throws SQLException{
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update [user] set password=? where id=?");
                stm.setString(1, password);
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
    public boolean updateMark(int work,String comment,  double mark) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update task_work set mark=?,comment=? where work = "+work);
                stm.setDouble(1, mark);
                stm.setNString(2, comment);
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
    public boolean updateClassroom(String id,String building,int room) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update classroom set building=?,room=? where id = ?");
                stm.setString(1, building);
                stm.setInt(2, room);
                stm.setString(3, id);
                
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
    
    public boolean updateTimeDone(int work) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("update task_work set doneAt=getDate() where work = "+work);
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
    
    public boolean updateNotice(Notice noti) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                String deadline = noti.getDeadline() == null ? "" : ",deadline=(CONVERT(datetime,'" + noti.getDeadline() + "',120))";
                stm = conn.prepareStatement("update notice set createdBy=?,Title=?,describe=?,classid=?,isTask=?,publicAt= (CONVERT(datetime,'" + noti.getPublicAt() + "',120))" + deadline + " where id = ?");
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
    
    public boolean deleteWorkDetail(int id,String name) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from work_detail where workid=" + id +" and work like '"+name+"'");
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

    public boolean deleteAllClass(int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from classroom_detail where userid=" + id);
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

    public boolean deleteTeacher(int id) throws SQLException {
        boolean check = false;
        Connection conn = null;
        PreparedStatement stm = null;
        try {
            conn = ConnectJDBC.getConnection();
            if (conn != null) {
                stm = conn.prepareStatement("delete from teacher where userid=" + id);
                if (stm.executeUpdate() > 0) {
                    check=deleteAllClass(id);
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
                check = stm.executeUpdate() > 0;
                if (user.getRoleID() == 2) {
                    stm = conn.prepareStatement("select * from [teacher] where userid = ?");
                    stm.setInt(1, user.getId());
                    rs = stm.executeQuery();
                    if (rs!=null) {
                        stm = conn.prepareStatement("update [teacher] set roleid=? where userid = ?");
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
