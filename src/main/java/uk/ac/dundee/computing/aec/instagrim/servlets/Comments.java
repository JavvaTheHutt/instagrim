/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package uk.ac.dundee.computing.aec.InstaGeezAnA.servlets;

import com.datastax.driver.core.Cluster;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import uk.ac.dundee.computing.aec.InstaGeezAnA.lib.CassandraHosts;
import uk.ac.dundee.computing.aec.InstaGeezAnA.lib.Convertors;
import uk.ac.dundee.computing.aec.InstaGeezAnA.models.PicModel;

/**
 *
 * @author MatthewLang
 */
@WebServlet(name = "Comments", urlPatterns = {"/Comments"})
public class Comments extends HttpServlet {
    
    Cluster cluster=null;
    public void init(ServletConfig config) throws ServletException {
        // TODO Auto-generated method stub
        cluster = CassandraHosts.getCluster();
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
