/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package web;

import com.google.gson.Gson;
import ejb.NewsEntity;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


/**
 *
 * @author aceva
 */
@WebServlet(name = "directdb", urlPatterns = {"/directdb"})
public class directdb extends HttpServlet {
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ClassNotFoundException, SQLException {
        response.setContentType("application/json");
        String sid=request.getParameter("id");  
        PrintWriter out = response.getWriter();
        ArrayList<NewsEntity> items = new ArrayList<NewsEntity>();
        try {
            //register the driver
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            // connection to db 
            String dbURL1 = "jdbc:derby://localhost:1527/sample;create=true";
            Connection conn = DriverManager.getConnection(dbURL1);
            if (conn != null) {
                //out.println("Connected to database ");
                Statement statement = conn.createStatement();
                String sql;
                sql = "SELECT * FROM APP.NEWSENTITY"  ;
                
                ResultSet result= statement.executeQuery(sql);
                while(result.next()){
                        NewsEntity newData = new NewsEntity();
                        newData.setUuid(result.getString("uuid"));
                        newData.setTitle(result.getString("title"));
                        newData.setBody(result.getString("body"));
                        items.add(newData);
                }
             
                Gson  gson = new Gson();
                String json = gson.toJson(items);
                out.println(json);
              //  out.println("<a href='PostMessage'>Add new message</a>");
                conn.close();
            }
        }catch (SQLException ex) {
            ex.printStackTrace();
    }
    }
    
   

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(directdb.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(directdb.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(directdb.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(directdb.class.getName()).log(Level.SEVERE, null, ex);
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
