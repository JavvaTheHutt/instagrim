/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;

import java.util.UUID;


/**
 *
 * @author MatthewLang
 */

public class Comment {
    private String comment;
    private String username;
    private UUID picid = null;

    /**
     * @return the comment
     */
    public String getComment() {
        return comment;
    }

    /**
     * @return the username
     */
    public String getUsername() {
        return username;
    }

    /**
     * @return the picid
     */
    public UUID getPicid() {
        return picid;
    }

    /**
     * @param comment the comment to set
     */
    public void setComment(String comment) {
        this.comment = comment;
    }

    /**
     * @param username the username to set
     */
    public void setUsername(String username) {
        this.username = username;
    }

    /**
     * @param picid the picid to set
     */
    public void setPicid(UUID picid) {
        this.picid = picid;
    }
}
