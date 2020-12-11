/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package ejb.controller;

import com.google.gson.Gson;
import ejb.NewsEntity;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;

/**
 *
 * @author Roshan
 */
public class DatabaseHelper {
    private Connection conn;
    
    public DatabaseHelper() throws ClassNotFoundException, SQLException{
         Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            // connection to db 
      String dbURL1 = "jdbc:derby://localhost:1527/sample;create=true";
      this.conn  = DriverManager.getConnection(dbURL1);
    }
    
   public int delete_item(String id){
     
    
    try {
            //register the driver
           
            
            if (this.conn != null) {
                //prepared Statement to prevent SQLI
                          
                PreparedStatement prep = this.conn.prepareStatement("DELETE FROM APP.NEWSENTITY where UUID=?");
                prep.setString(1, id);
                prep.execute();
                
                this.conn.close();
                
                return 200;
            }else
            {
                return 400;
            }
         }catch (SQLException ex) {
//             ex.printStackTrace();
             return 500;
            
        }
    
     }
   
   public int update_item(String id,String title,String body){
       try {
          
            
            if (this.conn != null) {
                
                PreparedStatement prep = this.conn.prepareStatement("UPDATE APP.NEWSENTITY set title=? , body=? where uuid=?");
                prep.setString(1, title);
                prep.setString(2,body);
                prep.setString(3,id);
                prep.execute();
                this.conn.close();
                return 200;
                
            }
            else{
                return 400;
            }
         }catch (SQLException ex) {
//              ex.printStackTrace();
             return 500;
        }
   }
   
   
   public String all_data_dump(){
       ArrayList<NewsEntity> items = new ArrayList<NewsEntity>();
        try {
           
            if (this.conn != null) {
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
                
                this.conn.close();
                return json;
            }
        }catch (SQLException ex) {
            return "Database Error";
    }
        return null;
   }
}
