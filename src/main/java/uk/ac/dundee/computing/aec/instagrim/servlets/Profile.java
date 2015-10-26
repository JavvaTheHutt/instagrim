/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.lib.Convertors;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.*;

/**
 *
 * @author MatthewLang
 */
@WebServlet(name = "Profile", urlPatterns = {"/Profile", "/Profile/*", "/Update/*"})
public class Profile extends HttpServlet {
    
    private Cluster cluster = null;
    private HashMap CommandsMap = new HashMap();
    
    public Profile()
    {
        super();
        // TODO Auto-generated constructor stub
        CommandsMap.put("Profile", 1);
        CommandsMap.put("Update", 2);        
    }
    
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
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
                DisplayProfile(request, response);
                break;
            case 2:
                DisplayUpdate(request, response);
                break;
            default:
                error("Bad Operator", response);
        }
    }
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String action = request.getParameter("page");
        if("Update".equals(action))
        {
            String firstname = request.getParameter("firstname");
            String lastname = request.getParameter("lastname");
            String email = request.getParameter("email");
            String street = request.getParameter("street");
            String city = request.getParameter("city");
            int postcode = Integer.parseInt(request.getParameter("postcode"));
            String about= request.getParameter("about");
            
            User us = new User();
            us.setCluster(cluster);
            HttpSession session = request.getSession();
            ProfileBean pb = (ProfileBean) session.getAttribute("ProfileBean");
            LoggedIn lg = (LoggedIn) session.getAttribute("LoggedIn");
            pb = us.UpdateProfile(pb, lg.getUsername(), firstname, lastname, email, street, city, postcode, about);
            session.setAttribute("ProfileBean", pb);
            response.sendRedirect("/Instagrim/Profile/" + lg.getUsername());
        }else{
            
        }
    }
    
    protected void DisplayProfile(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String args[] = Convertors.SplitRequestPath(request);
        HttpSession session = request.getSession();
        User us = new User();
        us.setCluster(cluster);
        ProfileBean profile = new ProfileBean();
        Avatar av = new Avatar();
        profile = us.getProfile(profile,args[2], av);
        RequestDispatcher rd = request.getRequestDispatcher("/profile.jsp");
        session.setAttribute("ProfileBean", profile);
        rd.forward(request, response);
    }
    
    protected void DisplayUpdate(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        String args[] = Convertors.SplitRequestPath(request);
        HttpSession session = request.getSession();
        User us = new User();
        us.setCluster(cluster);
        ProfileBean profile = new ProfileBean();
        Avatar av = new Avatar();
        profile = us.getProfile(profile,args[2], av);
        RequestDispatcher rd = request.getRequestDispatcher("/updateProfile.jsp");
        session.setAttribute("ProfileBean", profile);
        rd.forward(request, response);
    }
    
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

    private void error(String mess, HttpServletResponse response) throws ServletException, IOException {

        PrintWriter out = null;
        out = new PrintWriter(response.getOutputStream());
        out.println("<h1>You have a na error in your input</h1>");
        out.println("<h2>" + mess + "</h2>");
        out.close();
        return;
    }
}
