/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Tran Trang
 */
public class Teacher extends User {

    private int subjectID;
    private String subjectName;

    public Teacher() {
    }

    public Teacher(int id, String name, boolean gender, String password, int roleID,int subjectID) {
        super(id, name, gender, password, roleID);
        this.subjectID = subjectID;
    }

    public Teacher(int subjectID, String subjectName, int id, String name, boolean gender, String password, int roleID) {
        super(id, name, gender, password, roleID);
        this.subjectID = subjectID;
        this.subjectName = subjectName;
    }

    public Teacher(int subjectID, String subjectName) {
        this.subjectID = subjectID;
        this.subjectName = subjectName;
    }

    public int getSubjectID() {
        return subjectID;
    }

    public void setSubjectID(int subjectID) {
        this.subjectID = subjectID;
    }

    public String getSubjectName() {
        return subjectName;
    }

    public void setSubjectName(String subjectName) {
        this.subjectName = subjectName;
    }

}
