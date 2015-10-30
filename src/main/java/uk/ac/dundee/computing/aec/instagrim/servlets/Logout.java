/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.InstaGeezAnA.servlets;

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
import uk.ac.dundee.computing.aec.InstaGeezAnA.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.InstaGeezAnA.stores.LoggedIn;

/**
 *
 * @author MatthewLang
 */
@WebServlet(name = "Logout", urlPatterns = {"/Logout"})
public class Logout extends HttpServlet {
    
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {      
                String message= "Logout was successful";
                HttpSession session= request.getSession();
                session.setAttribute("DisplayMessage", message);
                //request.getRequestDispatcher("login.jsp").forward(request, response);
                session.setAttribute("LoggedIn", null);
                response.sendRedirect("/InstaGeezAnA");
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
