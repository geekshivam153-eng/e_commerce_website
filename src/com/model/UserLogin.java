package com.model;

import java.sql.ResultSet;
import java.sql.SQLException;

import com.bean.User;
import com.jcg.jdbc.connection.pooling.DBAgent;

public class UserLogin {

	public User login(String email, String password){
		
		DBAgent dba = new DBAgent("/SQL/DB.xml","/SQL/sqlquery2.xml");
		String parameter[] = {email,password};
		ResultSet rs = dba.getResults(2, parameter);
		
		try {
			if (!rs.next()) {
				  dba.closeConnection();
				  return null;
				} else {
					User accountInfo = new User();
				   accountInfo.setUserid(Integer.toString(rs.getInt("userid")));
				   accountInfo.setFirstname(rs.getString("FirstName"));
				   accountInfo.setLastname(rs.getString("LastName"));
				   accountInfo.setEmail(rs.getString("email"));
				   accountInfo.setPassword(rs.getString("password"));
				   accountInfo.setPhoneno(rs.getString("phoneno"));
				   accountInfo.setPayment(rs.getString("paymentmode"));
				   
				   dba.closeConnection();
				   
				  return accountInfo; 
				}
		} catch (SQLException e) {
			dba.closeConnection();
			e.printStackTrace();
		}
		return null;		
	}
	
public User checkoutlogin(String email, String password){
		return login(email, password);
}
}