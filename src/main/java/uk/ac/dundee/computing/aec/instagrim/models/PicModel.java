package uk.ac.dundee.computing.aec.instagrim.models;

/*
 * Expects a cassandra columnfamily defined as
 * use keyspace2;
 CREATE TABLE Tweets (
 user varchar,
 interaction_time timeuuid,
 tweet varchar,
 PRIMARY KEY (user,interaction_time)
 ) WITH CLUSTERING ORDER BY (interaction_time DESC);
 * To manually generate a UUID use:
 * http://www.famkruithof.net/uuid/uuidgen
 */
import com.datastax.driver.core.BoundStatement;
import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.PreparedStatement;
import com.datastax.driver.core.ResultSet;
import com.datastax.driver.core.Row;
import com.datastax.driver.core.Session;
import com.datastax.driver.core.utils.Bytes;
import java.awt.image.BufferedImage;
import java.io.ByteArrayOutputStream;
import java.io.File;

import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.ByteBuffer;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedList;
import java.util.UUID;
import javax.imageio.ImageIO;
import static org.imgscalr.Scalr.*;
import org.imgscalr.Scalr.Method;

import uk.ac.dundee.computing.aec.instagrim.lib.*;
import uk.ac.dundee.computing.aec.instagrim.stores.Avatar;
import uk.ac.dundee.computing.aec.instagrim.stores.Comment;
import uk.ac.dundee.computing.aec.instagrim.stores.Pic;
//import uk.ac.dundee.computing.aec.stores.TweetStore;

public class PicModel {

    Cluster cluster;

    public void PicModel() {

    }

    public void setCluster(Cluster cluster) {
        this.cluster = cluster;
    }

    public void insertPic(byte[] b, String type, String name, String user) {
        try {
            Convertors convertor = new Convertors();

            String types[]=Convertors.SplitFiletype(type);
            ByteBuffer buffer = ByteBuffer.wrap(b);
            int length = b.length;
            java.util.UUID picid = convertor.getTimeUUID();
            
            //The following is a quick and dirty way of doing this, will fill the disk quickly !
            Boolean success = (new File("/var/tmp/instagrim/")).mkdirs();
            FileOutputStream output = new FileOutputStream(new File("/var/tmp/instagrim/" + picid));

            output.write(b);
            byte []  thumbb = picresize(picid.toString(),types[1], "");
            int thumblength= thumbb.length;
            ByteBuffer thumbbuf=ByteBuffer.wrap(thumbb);
            byte[] processedb = picdecolour(picid.toString(),types[1], "");
            ByteBuffer processedbuf=ByteBuffer.wrap(processedb);
            int processedlength=processedb.length;
            Session session = cluster.connect("instagrim");

            PreparedStatement psInsertPic = session.prepare("insert into pics ( picid, image,thumb,processed, user, interaction_time,imagelength,thumblength,processedlength,type,name) values(?,?,?,?,?,?,?,?,?,?,?)");
            PreparedStatement psInsertPicToUser = session.prepare("insert into userpiclist ( picid, user, pic_added) values(?,?,?)");
            BoundStatement bsInsertPic = new BoundStatement(psInsertPic);
            BoundStatement bsInsertPicToUser = new BoundStatement(psInsertPicToUser);

            Date DateAdded = new Date();
            session.execute(bsInsertPic.bind(picid, buffer, thumbbuf,processedbuf, user, DateAdded, length,thumblength,processedlength, type, name));
            session.execute(bsInsertPicToUser.bind(picid, user, DateAdded));
            session.close();

        } catch (IOException ex) {
            System.out.println("Error --> " + ex);
        }
    }
    
    public Avatar insertProfilePic(byte[] b, String type, String name, String user, Avatar av) {
        try {
            Convertors convertor = new Convertors();

            String types[]=Convertors.SplitFiletype(type);
            ByteBuffer buffer = ByteBuffer.wrap(b);
            int length = b.length;
            java.util.UUID picid = convertor.getTimeUUID();
            
            //The following is a quick and dirty way of doing this, will fill the disk quickly !
            Boolean success = (new File("/var/tmp/instagrim/")).mkdirs();
            FileOutputStream output = new FileOutputStream(new File("/var/tmp/instagrim/" + picid));

            output.write(b);
            byte []  thumbb = picresize(picid.toString(),types[1], "original");
            int thumblength= thumbb.length;
            ByteBuffer thumbbuf=ByteBuffer.wrap(thumbb);
            byte[] processedb = picdecolour(picid.toString(),types[1], "original");
            ByteBuffer processedbuf=ByteBuffer.wrap(processedb);
            int processedlength=processedb.length;
            Session session = cluster.connect("instagrim");

            PreparedStatement psInsertPic = session.prepare("insert into pics ( picid, image,thumb,processed, user, interaction_time,imagelength,thumblength,processedlength,type,name) values(?,?,?,?,?,?,?,?,?,?,?)");
            PreparedStatement psInsertPicToUser = session.prepare("insert into userpiclist ( picid, user, pic_added) values(?,?,?)");
            PreparedStatement psInsertProfilePic = session.prepare("update userprofiles set avatar=? where login= ?");
            
            BoundStatement bsInsertPic = new BoundStatement(psInsertPic);
            BoundStatement bsInsertPicToUser = new BoundStatement(psInsertPicToUser);
            BoundStatement bsInsertProfilePic = new BoundStatement(psInsertProfilePic);

            Date DateAdded = new Date();
            session.execute(bsInsertPic.bind(picid, buffer, thumbbuf,processedbuf, user, DateAdded, length,thumblength,processedlength, type, name));
            session.execute(bsInsertPicToUser.bind(picid, user, DateAdded));
            session.execute(bsInsertProfilePic.bind(picid, user));
            session.close();
            
            av.setPic(buffer, length, type);
            av.setUUID(picid);
            return av;

        } catch (IOException ex) {
            System.out.println("Error --> " + ex);
        }
        return av;
    }

    public byte[] picresize(String picid,String type, String filter) {
        try {
            BufferedImage BI = ImageIO.read(new File("/var/tmp/instagrim/" + picid));
            BufferedImage thumbnail = createThumbnail(BI, filter);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(thumbnail, type, baos);
            baos.flush();
            
            byte[] imageInByte = baos.toByteArray();
            baos.close();
            return imageInByte;
        } catch (IOException et) {

        }
        return null;
    }
    
    public byte[] picdecolour(String picid,String type, String filter) {
        try {
            BufferedImage BI = ImageIO.read(new File("/var/tmp/instagrim/" + picid));
            BufferedImage processed = createProcessed(BI, filter);
            ByteArrayOutputStream baos = new ByteArrayOutputStream();
            ImageIO.write(processed, type, baos);
            baos.flush();
            byte[] imageInByte = baos.toByteArray();
            baos.close();
            return imageInByte;
        } catch (IOException et) {

        }
        return null;
    }

    public static BufferedImage createThumbnail(BufferedImage img, String filter) {
        switch(filter)
        {
            case "original": 
            {
                img = resize(img, Method.SPEED, 250);
                // Let's add a little border before we return result.
                return pad(img, 2);
            }
            default:
            {
                img = resize(img, Method.SPEED, 250, OP_ANTIALIAS, OP_GRAYSCALE);
                // Let's add a little border before we return result.
                return pad(img, 2);
            }
                
        }
        
    }
    
   public static BufferedImage createProcessed(BufferedImage img, String filter) {
       switch(filter)
        {
            case "original": 
            {
                int Width=img.getWidth()-1;
                img = resize(img, Method.SPEED, Width);
                return pad(img, 4);
            }
            default:
            {
                int Width=img.getWidth()-1;
                img = resize(img, Method.SPEED, Width, OP_ANTIALIAS, OP_GRAYSCALE);
                return pad(img, 4);
            }
       }
    }
   
    public java.util.LinkedList<Pic> getPicsForUser(String User) {
        java.util.LinkedList<Pic> Pics = new java.util.LinkedList<>();
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select picid from userpiclist where user =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        User));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
                Pic pic = new Pic();
                java.util.UUID UUID = row.getUUID("picid");
                System.out.println("UUID" + UUID.toString());
                pic.setUUID(UUID);
                Pics.add(pic);

            }
            
            
        }
        return Pics;
    }
    
    public java.util.LinkedList<Pic> getPicsForProfile(String User) {
        int count = 0;
        java.util.LinkedList<Pic> Pics = new java.util.LinkedList<>();
        java.util.LinkedList<Pic> lsPics = new java.util.LinkedList<>();
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select picid from userpiclist where user =?");
        ResultSet rs = null;
        BoundStatement boundStatement = new BoundStatement(ps);
        rs = session.execute( // this is where the query is executed
                boundStatement.bind( // here you are binding the 'boundStatement'
                        User));
        if (rs.isExhausted()) {
            System.out.println("No Images returned");
            return null;
        } else {
            for (Row row : rs) {
                Pic pic = new Pic();
                java.util.UUID UUID = row.getUUID("picid");
                System.out.println("UUID" + UUID.toString());
                pic.setUUID(UUID);
                Pics.add(pic);
            } 
            Iterator<Pic> iterator;
            iterator = Pics.iterator();
            while (iterator.hasNext() && count<3) {
                    count++;
                    Pic pic = (Pic) iterator.next();
                    lsPics.add(pic);
            }
        }
        return lsPics;
    }
    
    public java.util.LinkedList<Comment> getComments(){
        LinkedList<Comment> comments = new LinkedList<>();
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("select * from piccomments");
        ResultSet rs = null;
        BoundStatement bs = new BoundStatement(ps);
        rs = session.execute(bs);
        if(rs.isExhausted())
        {
            return null;
        }else{
            for(Row row : rs)
            {
                Comment c = new Comment();
                c.setComment(row.getString("comment"));
                c.setPicid(row.getUUID("picid"));
                c.setUsername(row.getString("user"));
                comments.add(c);
            }
        }
        return comments;
    }

    public Pic getPic(int image_type, java.util.UUID picid) {
        Session session = cluster.connect("instagrim");
        ByteBuffer bImage = null;
        String type = null;
        int length = 0;
        try {
            Convertors convertor = new Convertors();
            ResultSet rs = null;
            PreparedStatement ps = null;
         
            if (image_type == Convertors.DISPLAY_IMAGE) {
                
                ps = session.prepare("select image,imagelength,type from pics where picid =?");
            } else if (image_type == Convertors.DISPLAY_THUMB) {
                ps = session.prepare("select thumb,imagelength,thumblength,type from pics where picid =?");
            } else if (image_type == Convertors.DISPLAY_PROCESSED) {
                ps = session.prepare("select processed,processedlength,type from pics where picid =?");
            }
            BoundStatement boundStatement = new BoundStatement(ps);
            rs = session.execute( // this is where the query is executed
                    boundStatement.bind( // here you are binding the 'boundStatement'
                            picid));

            if (rs.isExhausted()) {
                System.out.println("No Images returned");
                return null;
            } else {
                for (Row row : rs) {
                    if (image_type == Convertors.DISPLAY_IMAGE) {
                        bImage = row.getBytes("image");
                        length = row.getInt("imagelength");
                    } else if (image_type == Convertors.DISPLAY_THUMB) {
                        bImage = row.getBytes("thumb");
                        length = row.getInt("thumblength");
                
                    } else if (image_type == Convertors.DISPLAY_PROCESSED) {
                        bImage = row.getBytes("processed");
                        length = row.getInt("processedlength");
                    }
                    
                    type = row.getString("type");

                }
            }
        } catch (Exception et) {
            System.out.println("Can't get Pic" + et);
            return null;
        }
        session.close();
        Pic p = new Pic();
        p.setPic(bImage, length, type);

        return p;

    }
    
    public void addComment(String comment, String picid, String username)
    {
        Session session = cluster.connect("instagrim");
        Convertors convertor = new Convertors();
        UUID commentid = convertor.getTimeUUID();
        UUID pictureID = UUID.fromString(picid);
        PreparedStatement ps = session.prepare("insert into piccomments (commentid, comment, picid, user) values(?,?,?,?)");
        BoundStatement bs = new BoundStatement(ps);
        session.execute(bs.bind(commentid,comment,pictureID,username));    
    }
    
    public void DeletePic(String username, String picid)
    {
        Session session = cluster.connect("instagrim");
        Convertors convertor = new Convertors();
        UUID pictureID = UUID.fromString(picid);
        ResultSet rs = null;
        PreparedStatement ps = session.prepare("delete from Pics where picid=?");
        BoundStatement bs = new BoundStatement(ps);
        session.execute(bs.bind(pictureID));
        ps = session.prepare("select * from userpiclist");
        bs = new BoundStatement(ps);
        rs =session.execute(bs);
        for(Row row:rs)
        {
            if(row.getUUID("picid").equals(pictureID))
            {
                ps = session.prepare("delete from userpiclist where user=? and pic_added=?");
                bs = new BoundStatement(ps);
                session.execute(bs.bind(username, row.getDate("pic_added")));
            }
        }
        ps = session.prepare("select * from piccomments");
        bs = new BoundStatement(ps);
        rs =session.execute(bs);
        for(Row row:rs)
        {
            if(row.getUUID("picid").equals(pictureID))
            {
                ps = session.prepare("delete from piccomments where commentid=?");
                bs = new BoundStatement(ps);
                session.execute(bs.bind(row.getUUID("commentid")));
            }
        }
    }
    
    public void removeAvatar(String username)
    {
        Session session = cluster.connect("instagrim");
        PreparedStatement ps = session.prepare("update userprofiles set avatar=? where login=?");
        BoundStatement bs = new BoundStatement(ps);
        session.execute(bs.bind(null, username));
    }

}
