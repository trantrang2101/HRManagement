/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

import java.util.List;

/**
 *
 * @author Tran Trang
 */
public class Work {
    private int taskid,userid, work;
    private double mark;
    private String comment,doneAt;
    private List<String> workAddress;

    public Work() {
    }

    public Work(int taskid, int userid, int work, double mark, String comment, String doneAt, List<String> workAddress) {
        this.taskid = taskid;
        this.userid = userid;
        this.work = work;
        this.mark = mark;
        this.comment = comment;
        this.doneAt = doneAt;
        this.workAddress = workAddress;
    }

    public int getTaskid() {
        return taskid;
    }

    public void setTaskid(int taskid) {
        this.taskid = taskid;
    }

    public List<String> getWorkAddress() {
        return workAddress;
    }

    public void setWorkAddress(List<String> workAddress) {
        this.workAddress = workAddress;
    }

    public int getUserid() {
        return userid;
    }

    public void setUserid(int userid) {
        this.userid = userid;
    }

    public int getWork() {
        return work;
    }

    public void setWork(int work) {
        this.work = work;
    }

    public double getMark() {
        return mark;
    }

    public void setMark(double mark) {
        this.mark = mark;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    public String getDoneAt() {
        return doneAt;
    }

    public void setDoneAt(String doneAt) {
        this.doneAt = doneAt;
    }
    
}
