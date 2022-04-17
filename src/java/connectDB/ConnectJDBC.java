/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package connectDB;

import java.sql.Connection;
import java.sql.DriverManager;

/**
 *q
 * @author AD
 */
public class ConnectJDBC {

    private static String DB_URL = "jdbc:sqlserver://KOUTAHARA\\SQLEXPRESS:1433;databaseName=QHVinh;encrypt=true;trustServerCertificate=true;";
    private static String USER_NAME = "sa";
    private static String PASSWORD = "1234";

    /**
     * create connection
     *
     * @param dbURL: database's url
     * @param userName: username is used to login
     * @param password: password is used to login
     * @return connection
     */
    public static Connection getConnection() {
        Connection conn = null;
        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
            conn = DriverManager.getConnection(DB_URL, USER_NAME, PASSWORD);
        } catch (Exception ex) {
            ex.printStackTrace();
        }
        return conn;
    }
}
