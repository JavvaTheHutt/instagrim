/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.models;

import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.UDTValue;
import com.datastax.driver.core.UserType;
import java.io.UnsupportedEncodingException;
import java.security.NoSuchAlgorithmException;
import java.util.HashMap;
import java.util.HashSet;
import java.util.LinkedList;
import java.util.Map;
import java.util.Set;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.AeSimpleSHA1;
import uk.ac.dundee.computing.aec.instagrim.stores.Avatar;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;
import uk.ac.dundee.computing.aec.instagrim.stores.ProfileBean;

/**
 *
 * @author Administrator
 */
public class User {
    Cluster cluster;
    public User(){
        
    }
    
    public String RegisterUser(String username, String Password, ProfileBean profile){
        boolean emailValidation = true;
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't encrypt your password");
            return "PasswordFail";
        }
        //connecting to the keyspace in cassandra so we know which database to reference
        Session session = cluster.connect("instagrim");
        //selecting all userprofiles from the database that have the login provided by the user
        PreparedStatement ps = session.prepare("select * from userprofiles where login =?");
        //selecting all userprofiles from the database that have the email provided by the user
        PreparedStatement ps1 = session.prepare("select * from userprofiles");
        //two result sets for the two different statements
        ResultSet rs = null;
        ResultSet rs1 = null;
        //exeuting the boundstatement to check if the login is already in use
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        //executing the boundstatement to check if the email is already in use
       BoundStatement boundStatement1 = new BoundStatement(ps1);
       rs1 = session.execute(boundStatement1);
       if(rs1.isExhausted()== false)
       {
          for(Row row : rs1) {
               
                String email = row.getString("email");
                if (email.equalsIgnoreCase(profile.getEmail())){
                    emailValidation = false;
                }
            } 
       }
        //if statement to check that the username and password checks came back as empty to insert the new user
        if(rs.isExhausted() && emailValidation==true)
        {
            UserType addressType = cluster.getMetadata().getKeyspace("instagrim").getUserType("address");
            UDTValue address = addressType.newValue()
                                          .setString("street", profile.getStreet())
                                          .setString("city", profile.getCity())
                                          .setInt("zip", profile.getPostCode());
            HashMap addressMap = new HashMap();
            addressMap.put("Home", address);
            ps = session.prepare("insert into userprofiles (login,password,first_name,last_name,email,addresses,about) Values(?,?,?,?,?,?,?)");
            boundStatement = new BoundStatement(ps);
            session.execute( // this is where the query is executed
                    boundStatement.bind( // here you are binding the 'boundStatement'
                            username,EncodedPassword,profile.getFirstName(),profile.getLastName(),profile.getEmail(), addressMap, profile.getAbout()));
            //We are assuming this always works.  Also a transaction would be good here !
            return "Success";
        }
        //if the checks came back with results allerting the user to the problem
        else{
            if(rs.isExhausted()==false)
            {
                return "UsernameFail";
            }
            if(emailValidation == false)
            {
                return "EmailFail";
            }
            return "False";
        }
    }
    
    public boolean IsValidUser(String username, String Password){
        AeSimpleSHA1 sha1handler=  new AeSimpleSHA1();
        String EncodedPassword=null;
        try {
            EncodedPassword= sha1handler.SHA1(Password);
        }catch (UnsupportedEncodingException | NoSuchAlgorithmException et){
            System.out.println("Can't check your password");
            return false;
        }
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select * from userprofiles where login =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        username));
        if (rs.isExhausted()) {
            System.out.println("That username does not exisit");
            return false;
        } else {
            for (Row row : rs) {
               
                String StoredPass = row.getString("password");
                if (StoredPass.compareTo(EncodedPassword) == 0)
                    return true;
            }
        }
        return false;
    }
        
    public ProfileBean getProfile(ProfileBean profile, String user, Avatar av) //throws Exception
    {
//       try{
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select * from userprofiles where login=?");
        ResultSet rs = null;
        ResultSet rs1 = null;
        BoundStatement bs = new BoundStatement(ps);
        rs = session.execute(bs.bind(user));
        for(Row row : rs){
            if(row.getUUID("avatar")!= null)
            {
            ps = session.prepare("select image,imagelength,type from pics where picid =?");
            bs = new BoundStatement(ps);
            rs1 = session.execute(bs.bind(row.getUUID("avatar")));
            }
            else{
                rs1 = null;
            }
            profile.setFirstName(row.getString("first_name"));
            profile.setLastName(row.getString("last_name"));
            profile.setEmail(row.getString("email"));
            profile.setAbout(row.getString("about"));
            profile.setUsername(user);
            Object[] objAddress = row.getMap("addresses", String.class, UDTValue.class).values().toArray();
            String[] strAddress = new String[2];
            int zip =0;
        
            try {
                UDTValue address = (UDTValue)objAddress[0];
                strAddress[0] = address.getString("street");
                strAddress[1] = address.getString("city");
                zip = address.getInt("zip");
            }
            catch (ArrayIndexOutOfBoundsException e) {
            
            }
        
            profile.setAddress(strAddress[0], strAddress[1], zip);
        
            if(rs1==null)
            {
                profile.setAvatar(null);
            }
            else
            {
            for(Row row1 : rs1)
            {
                av.setPic(row1.getBytes("image"), row1.getInt("imageLength"), row1.getString("type"));
                av.setUUID(row.getUUID("avatar"));
                profile.setAvatar(av);
            }
            }
       }
//       }
//       catch(Exception e)
//       {
//           e.printStackTrace();
//       }
        System.out.println(profile.getUsername());
        System.out.println(profile.getFirstName());
        return profile;
    }
    
    public ProfileBean UpdateProfile(ProfileBean profile, String user, String firstname, String lastname, String email, String street, String city, int postcode, String about) //throws Exception
    {
//       try{
        Session session = cluster.connect("instagrim");

        PreparedStatement ps = session.prepare("update userprofiles set first_name= ? where login= ?");
        BoundStatement bs = new BoundStatement(ps);
        session.execute(bs.bind(firstname, user));
        ps = session.prepare("update userprofiles set last_name= ? where login= ?");
        bs = new BoundStatement(ps);
        session.execute(bs.bind(lastname, user));
        ps = session.prepare("update userprofiles set email= ? where login= ?");
        bs = new BoundStatement(ps);
        session.execute(bs.bind(email, user));
        UserType addressType = cluster.getMetadata().getKeyspace("instagrim").getUserType("address");
        UDTValue address = addressType.newValue()
                                      .setString("street", street)
                                      .setString("city", city)
                                      .setInt("zip", postcode);
        HashMap addressMap = new HashMap();
        addressMap.put("Home", address);
        ps = session.prepare("update userprofiles set addresses= ? where login= ?");
        bs = new BoundStatement(ps);
        session.execute(bs.bind(addressMap, user));
        ps = session.prepare("update userprofiles set about= ? where login= ?");
        bs = new BoundStatement(ps);
        session.execute(bs.bind(about, user));
        profile.setFirstName(firstname);
        profile.setLastName(lastname);
        profile.setEmail(email);
        profile.setAddress(street, city, postcode);
        profile.setAbout(about);
        return profile;
    }
    
    
    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }
    
    public LinkedList<ProfileBean> searchProfiles(String searchFor)
    {
        LinkedList<ProfileBean> lsProfiles = new LinkedList<>();
        Session session = cluster.connect("instagrim");
        ResultSet rs= null;
        ResultSet rs1 = null;
        PreparedStatement ps = session.prepare("select * from userprofiles");
        BoundStatement bs = new BoundStatement(ps);
        rs = session.execute(bs);
        if(rs.isExhausted())
        {
            return lsProfiles;
        }
        else
        {
            for(Row row: rs)
            {
                ProfileBean profile = new ProfileBean();
                profile.setUsername(row.getString("login"));
                profile.setFirstName(row.getString("first_name"));
                profile.setLastName(row.getString("last_name"));
                profile.setEmail(row.getString("email"));
                Object[] objAddress = row.getMap("addresses", String.class, UDTValue.class).values().toArray();
                String[] strAddress = new String[2];
                int zip =0;

                try {
                    UDTValue address = (UDTValue)objAddress[0];
                    strAddress[0] = address.getString("street");
                    strAddress[1] = address.getString("city");
                    zip = address.getInt("zip");
                }
                catch (ArrayIndexOutOfBoundsException e) {

                }

                profile.setAddress(strAddress[0], strAddress[1], zip);
                Avatar av = new Avatar();
                System.out.println(row.getUUID("avatar"));
                if(row.getUUID("avatar")!= null)
                {
                    ps = session.prepare("select image,imagelength,type from pics where picid =?");
                    bs = new BoundStatement(ps);
                    rs1 = session.execute(bs.bind(row.getUUID("avatar")));
                }else{
                    rs1 = null;
                }
                
                if(rs1==null)
                {
                    profile.setAvatar(null);
                }
                else
                {
                    Row row1 = rs1.one();
                    av.setPic(row1.getBytes("image"), row1.getInt("imageLength"), row1.getString("type"));
                    av.setUUID(row.getUUID("avatar"));
                    profile.setAvatar(av);    
                }
                
                if(row.getString("login").equalsIgnoreCase(searchFor))
                {
                    lsProfiles.add(profile);
                    break;
                }
                
                if(row.getString("first_name").equalsIgnoreCase(searchFor))
                {
                    lsProfiles.add(profile);
                    break;
                }
                
                if(row.getString("last_name").equalsIgnoreCase(searchFor))
                {
                    lsProfiles.add(profile);
                    break;
                }
                
                if((row.getString("first_name")+ " " + row.getString("last_name")).equalsIgnoreCase(searchFor))
                {
                    lsProfiles.add(profile);
                    break;
                }
                
            }
            return lsProfiles;
        }
    }

    
}
