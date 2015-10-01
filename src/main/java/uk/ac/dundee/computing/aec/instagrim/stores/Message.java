/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.stores;

/**
 *
 * @author MatthewLang
 */
public class Message {
    
    boolean messageStatus = false;
    String theMessage = null;
    
    public void Message(){
        
    }
    
    public void setMessage(String message){
        this.theMessage=message;
    }
    public String getMessage(){
        return theMessage;
    }
    public void setMessageStatus(boolean state)
    {
        messageStatus = state;
    }
    public boolean getMessageStatus()
    {
        return messageStatus;
    }
    
}
