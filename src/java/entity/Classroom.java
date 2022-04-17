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
public class Classroom {
    private String id;
    private List<User> list;

    public Classroom() {
    }

    public Classroom(String id, List<User> list) {
        this.id = id;
        this.list = list;
    }

    public Classroom(String id) {
        this.id = id;
        this.list = null;
    }

    public String getName() {
        return id;
    }

    public void setName(String name) {
        this.id = name;
    }

    public List<User> getList() {
        return list;
    }

    public void setList(List<User> list) {
        this.list = list;
    }
    
}
