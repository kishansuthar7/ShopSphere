package com.shopsphere.dao;
import com.shopsphere.model.User; import com.shopsphere.util.DB; import java.sql.*;
public class UserDAO {
 public User findByEmail(String email)throws SQLException {String q="SELECT user_id,name,email,password_hash,role,status FROM users WHERE email=?";try(Connection c=DB.getConnection();PreparedStatement p=c.prepareStatement(q)){p.setString(1,email);try(ResultSet r=p.executeQuery()){if(r.next()&&r.getBoolean("status")){return new User(r.getLong("user_id"),r.getString("name"),r.getString("email"),r.getString("role"));}}}return null;}
 public String passwordHash(String email)throws SQLException {try(Connection c=DB.getConnection();PreparedStatement p=c.prepareStatement("SELECT password_hash FROM users WHERE email=? AND status=TRUE")){p.setString(1,email);try(ResultSet r=p.executeQuery()){return r.next()?r.getString(1):null;}}}
 public boolean create(String name,String email,String hash,String mobile)throws SQLException {try(Connection c=DB.getConnection();PreparedStatement p=c.prepareStatement("INSERT INTO users(name,email,password_hash,mobile) VALUES(?,?,?,?)")){p.setString(1,name);p.setString(2,email);p.setString(3,hash);p.setString(4,mobile);return p.executeUpdate()==1;}}
}
