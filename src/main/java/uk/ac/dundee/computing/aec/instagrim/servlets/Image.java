package uk.ac.dundee.computing.aec.InstaGeezAnA.servlets;

import com.datastax.driver.core.Cluster;
import java.io.BufferedInputStream;
import java.io.ByteArrayInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.UUID;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;
import org.apache.commons.fileupload.FileItemIterator;
import org.apache.commons.fileupload.FileItemStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;
import org.apache.commons.fileupload.util.Streams;
import uk.ac.dundee.computing.aec.InstaGeezAnA.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.InstaGeezAnA.lib.Convertors;
import uk.ac.dundee.computing.aec.InstaGeezAnA.models.PicModel;
import uk.ac.dundee.computing.aec.InstaGeezAnA.stores.Avatar;
import uk.ac.dundee.computing.aec.InstaGeezAnA.stores.Comment;
import uk.ac.dundee.computing.aec.InstaGeezAnA.stores.LoggedIn;
import uk.ac.dundee.computing.aec.InstaGeezAnA.stores.Pic;
import uk.ac.dundee.computing.aec.InstaGeezAnA.stores.ProfileBean;

/**
 * Servlet implementation class Image
 */
@WebServlet(urlPatterns = {
    "/Image",
    "/Image/*",
    "/Thumb/*",
    "/Images",
    "/Images/*"
})
@MultipartConfig

public class Image extends HttpServlet {

    private static final long serialVersionUID = 1L;
    private Cluster cluster;
    private HashMap CommandsMap = new HashMap();
    
    

    /**
     * @see HttpServlet#HttpServlet()
     */
    public Image() {
        super();
        // TODO Auto-generated constructor stub
        CommandsMap.put("Image", 1);
        CommandsMap.put("Images", 2);
        CommandsMap.put("Thumb", 3);

    }

    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    /**
     * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
     * response)
     */
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // TODO Auto-generated method stub
        String args[] = Convertors.SplitRequestPath(request);
        int command;
        try {
            command = (Integer) CommandsMap.get(args[1]);
        } catch (Exception et) {
            error("Bad Operator", response);
            return;
        }
        switch (command) {
            case 1:
                DisplayImage(Convertors.DISPLAY_PROCESSED,args[2], response);
                break;
            case 2:
                DisplayImageList(args[2], request, response);
                break;
            case 3:
                DisplayImage(Convertors.DISPLAY_THUMB,args[2],  response);
                break;
            default:
                error("Bad Operator", response);
        }
    }

    private void DisplayImageList(String User, HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
        java.util.LinkedList<Pic> lsPics = tm.getPicsForUser(User);
        java.util.LinkedList<Comment> lsComment = tm.getComments();
        HttpSession session = request.getSession();
        LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
        if(lg.getUsername().equals(User));
        {
            session.setAttribute("Owner", true);
        }
        RequestDispatcher rd = request.getRequestDispatcher("/UsersPics.jsp");
        request.setAttribute("Pics", lsPics);
        request.setAttribute("Comments", lsComment);
        rd.forward(request, response);

    }

    private void DisplayImage(int type,String Image, HttpServletResponse response) throws ServletException, IOException {
        PicModel tm = new PicModel();
        tm.setCluster(cluster);
  
        
        Pic p = tm.getPic(type,java.util.UUID.fromString(Image));
        
        OutputStream out = response.getOutputStream();

        response.setContentType(p.getType());
        response.setContentLength(p.getLength());
        //out.write(Image);
        InputStream is = new ByteArrayInputStream(p.getBytes());
        BufferedInputStream input = new BufferedInputStream(is);
        byte[] buffer = new byte[8192];
        for (int length = 0; (length = input.read(buffer)) > 0;) {
            out.write(buffer, 0, length);
        }
        out.close();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String cameFrom = request.getParameter("cameFrom");
        if(cameFrom.equals("aComment"))
        {
            String args[] = Convertors.SplitRequestPath(request);
            String comment = request.getParameter("comment");
            String username = request.getParameter("username");
            String picid = request.getParameter("picid");
            PicModel pm = new PicModel();
            pm.setCluster(cluster);
            if(comment.isEmpty())
            {
                response.sendRedirect("/InstaGeezAnA/Images/" + args[2]);
            }else{
                pm.addComment(comment, picid, username);
                response.sendRedirect("/InstaGeezAnA/Images/" + args[2]);
            }
        }
        else if(cameFrom.equals("DeletePhoto"))
        {
            String args[] = Convertors.SplitRequestPath(request);
            HttpSession session = request.getSession();
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            ProfileBean pb = (ProfileBean) session.getAttribute("ProfileBean");
            String username = lg.getUsername();
            String picid = request.getParameter("picid");
            PicModel pm = new PicModel();
            pm.setCluster(cluster);
            System.out.println("THE PROFILE BEAN AVATAR " +  pb.getAvatar().getSUUID());
            if(picid.equals(pb.getAvatar().getSUUID()))
            {
                pb.setAvatar(null);
                pm.removeAvatar(username);
            }
            pm.DeletePic(username, picid);
            session.setAttribute("ProfileBean", pb);
            response.sendRedirect("/InstaGeezAnA/Images/" + args[2]);
        }
        else
        {
        HttpSession session=request.getSession();
        LoggedIn lg= (LoggedIn)session.getAttribute("LoggedIn");
        Part part = request.getPart("upfile");
            System.out.println("Part Name " + part.getName());

            String type = part.getContentType();
            String filename = part.getSubmittedFileName();
            
            InputStream is = request.getPart(part.getName()).getInputStream();
            int i = is.available();
            String username="majed";
            if (lg.getlogedin()){
                username=lg.getUsername();
            }
            if (i > 0) {
                byte[] b = new byte[i + 1];
                is.read(b);
                System.out.println("Length : " + b.length);
                PicModel tm = new PicModel();
                tm.setCluster(cluster);
                if(session.getAttribute("uploadProfile").equals(false))
                {
                    System.out.println("entered the first condition");
                    tm.insertPic(b, type, filename, username);
                    is.close();
                    response.sendRedirect("/InstaGeezAnA/Images/" + lg.getUsername());
                }
                else
                {
                    System.out.println("entered the second condition");
                    Avatar av = new Avatar();
                    av= tm.insertProfilePic(b, type, type, username, av);
                    is.close();
                    session.setAttribute("Avatar", av);
                    ProfileBean pb = (ProfileBean) session.getAttribute("ProfileBean");
                    pb.setAvatar(av);
                    session.setAttribute("uploadProfile", false);
                    session.setAttribute("ProfileBean", pb);
                    response.sendRedirect("/InstaGeezAnA/Profile/" + lg.getUsername());
                }
            }
     
        }
    }

    private void error(String mess, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = null;
        out = new PrintWriter(response.getOutputStream());
        out.println("<h1>You have a na error in your input</h1>");
        out.println("<h2>" + mess + "</h2>");
        out.close();
        return;
    }
}
