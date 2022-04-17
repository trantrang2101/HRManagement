/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package entity;

/**
 *
 * @author Tran Trang
 */
public class Notice {
    private int id;
    private int createBy;
    private String title, describe;
    private String classroom;
    private String publicAt;
    private boolean task;
    private String deadline;

    public Notice() {
    }

    public Notice(int id, int createBy, String title, String describe, String classroom, String publicAt, boolean task,
            String deadline) {
        this.id = id;
        this.createBy = createBy;
        this.title = title;
        this.describe = describe;
        this.classroom = classroom;
        this.publicAt = publicAt;
        this.task = task;
        this.deadline = deadline;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCreateBy() {
        return createBy;
    }

    public void setCreateBy(int createBy) {
        this.createBy = createBy;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getDescribe() {
        return describe;
    }

    public void setDescribe(String describe) {
        this.describe = describe;
    }

    public String getClassroom() {
        return classroom;
    }

    public void setClassroom(String classroom) {
        this.classroom = classroom;
    }

    public String getPublicAt() {
        return publicAt;
    }

    public void setPublicAt(String publicAt) {
        this.publicAt = publicAt;
    }

    public boolean isTask() {
        return task;
    }

    public void setTask(boolean task) {
        this.task = task;
    }

    public String getDeadline() {
        return deadline;
    }

    public void setDeadline(String deadline) {
        this.deadline = deadline;
    }

}
