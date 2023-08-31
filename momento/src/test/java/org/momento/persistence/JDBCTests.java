package org.momento.persistence;

import static org.junit.Assert.fail;

import java.sql.Connection;
import java.sql.DriverManager;

import org.junit.Test;

import lombok.extern.log4j.Log4j;

@Log4j
public class JDBCTests {
	
	static {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
		}catch (Exception e) {
			
			// TODO: handle exception
			e.printStackTrace();
		}
	}
	
	@Test
	public void testConnection() {
		try(Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/cookdb?serverTimezone=UTC",
				"root","root")){
			log.info(con);
		}catch (Exception e) {
			// TODO: handle exception
			fail(e.getMessage());
		}
	}

}
