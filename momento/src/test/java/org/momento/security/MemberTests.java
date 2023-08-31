package org.momento.security;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import lombok.Setter;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({ "file:src/main/webapp/WEB-INF/spring/root-context.xml",
		"file:src/main/webapp/WEB-INF/spring/security-context.xml" })
public class MemberTests {

	@Setter(onMethod_ = @Autowired)
	private PasswordEncoder pwencoder;

	@Setter(onMethod_ = @Autowired)
	private DataSource ds;

	@Test
	public void testInsertMember() {
		String sql = "INSERT INTO member_tbl (USER_ID, USER_NAME, PASSWORD, ADDR, QUESTION_CODE, QUESTION_ANSWER, REGDATE, UPDATEDATE, PHONE) VALUES (?,?,?,?,?,?,?,?,?)";

		for (int i = 0; i < 10; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);

				pstmt.setString(3, pwencoder.encode("pw" + i));

				if (i < 5) {
					pstmt.setString(1, "test" + i);
					pstmt.setString(2, "사용자" + i);
					pstmt.setString(4, "테스트 주소" + i);
					pstmt.setInt(5, 100);
					pstmt.setString(6, "아버지");
					pstmt.setString(9, "010-0000-0000");
				} else {
					pstmt.setString(1, "admin" + i);
					pstmt.setString(2, "관리자" + i);
					pstmt.setString(4, "테스트 주소" + i);
					pstmt.setInt(5, 100);
					pstmt.setString(6, "아버지");
					pstmt.setString(9, "010-0000-0000");
				}

				// Set REGDATE and UPDATEDATE using current date
				java.util.Date currentDate = new java.util.Date();
				java.sql.Date sqlDate = new java.sql.Date(currentDate.getTime());
				pstmt.setDate(7, sqlDate);
				pstmt.setDate(8, sqlDate);
				pstmt.executeUpdate();

			} catch (SQLException e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (SQLException e) {
						e.printStackTrace();
					}
				}
			}
		}
	}

	@Test
	public void testInsertAuth() {

		String sql = "INSERT INTO member_tbl_auth (USER_ID, AUTH) VALUES (?,?)";

		for (int i = 0; i < 10; i++) {
			Connection con = null;
			PreparedStatement pstmt = null;

			try {
				con = ds.getConnection();
				pstmt = con.prepareStatement(sql);

				if (i < 5) {
					pstmt.setString(1, "test" + i);
					pstmt.setString(2, "ROLE_USER");
				} else {
					pstmt.setString(1, "admin" + i);
					pstmt.setString(2, "ROLE_ADMIN");
				}

				pstmt.executeUpdate();

			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) {
					try {
						pstmt.close();
					} catch (Exception e) {
					}
				}
				if (con != null) {
					try {
						con.close();
					} catch (Exception e) {
					}
				}
			}
		}
	}
}
