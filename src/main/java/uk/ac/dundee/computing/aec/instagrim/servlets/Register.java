/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package uk.ac.dundee.computing.aec.instagrim.servlets;

import com.datastax.driver.core.Cluster;
import com.datastax.driver.core.Session;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import uk.ac.dundee.computing.aec.instagrim.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.instagrim.models.User;
import uk.ac.dundee.computing.aec.instagrim.stores.*;

/**
 *
 * @author Administrator
 */
@WebServlet(name = "Register", urlPatterns = {"/Register"})
public class Register extends HttpServlet {
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
    }

    @Override
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException
    {
        RequestDispatcher rd = request.getRequestDispatcher("register.jsp");
        rd.forward(request, response);
    }


    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        String username=request.getParameter("username");
        String password=request.getParameter("password");
        String firstname=request.getParameter("firstname");
        String lastname=request.getParameter("lastname");
        String email=request.getParameter("email");
        String street=request.getParameter("street");
        String city=request.getParameter("city");
        String about=request.getParameter("about");
        int postcode=Integer.parseInt(request.getParameter("postcode"));
        
        ProfileBean profile = new ProfileBean();
        profile.setFirstName(firstname);
        profile.setLastName(lastname);
        profile.setEmail(email);
        profile.setAbout(about);
        profile.setAddress(street, city, postcode);
        
        //makes sure that the fields are not emtpy to avoid database registering a blank user
        if(password.isEmpty() || username.isEmpty() || firstname.isEmpty() || lastname.isEmpty() || email.isEmpty() || street.isEmpty() || city.isEmpty() || about.isEmpty())
        {
            response.sendRedirect("/Instagrim/Register");
        }
        else
        {
            User us= new User();
            us.setCluster(cluster);
            //sets boolean to result of register user
            String result= us.RegisterUser(username, password, profile);
            //if the result was true user was registered and directed to home page and logged in automatically
            if(result.equals("Success"))
            {
                session.setAttribute("ProfileBean", profile);
                RequestDispatcher rd = request.getRequestDispatcher("/Login");
                rd.forward(request, response); 
            }else{
                System.out.println(result);
                response.sendRedirect("/Instagrim/Register");
            }
        }
        
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
