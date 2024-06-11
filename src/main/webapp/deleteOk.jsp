<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="java.sql.*"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원탈퇴처리</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String mnum = request.getParameter("memberNum");
				
		String sql = "DELETE FROM member_tbl WHERE member_num='"+mnum+"'";
				
		// mySQL과 연결에 필요한 4개의 변수 선언
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username ="root";
		String password ="12345";
		
		Connection conn = null; // db와의 커넥션 생성
		Statement stmt = null; // sql문을 실행시켜주는 객체
	
		try {
			// DB와 연동하는 코드 부분
			Class.forName(driverName); // mySQL 드라이브 불러오기
			conn = DriverManager.getConnection(url, username, password); //DB와의 커넥션 생성
			stmt = conn.createStatement(); //sql을 실행시켜주는 객체
			
			int resultNum = stmt.executeUpdate(sql); //sql문을 DB에 실행시킴(insert, update, delete --> 성공하면 1 반환)
			if (resultNum == 1) {
				out.println(mnum + "님 회원탈퇴 sql명령 실행 성공");
			} else {
				out.println(mnum + "님 회원탈퇴 sql명령 실행 실패");
			}
		} catch(Exception e) {
			out.println("DB연동 실패!!");
			e.printStackTrace();
		} finally {
			try {
				if(stmt != null) {
					stmt.close();
				}
				if(conn != null) {
					conn.close();
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	%>
	<hr>
	<a href="list.jsp">회원리스트보기</a>

</body>
</html>