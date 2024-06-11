<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>회원가입처리</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
	
		String mname = request.getParameter("memberName");
		String memail = request.getParameter("memberEmail");
		
		String sql = "INSERT INTO member_tbl(member_name, member_email) VALUES (?,?)"; // ?는 pstmt에 대응
		
		// mySQL과 연결에 필요한 4개의 변수 선언
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username ="root";
		String password ="12345";
		
		Connection conn = null; // db와의 커넥션 생성
		// Statement stmt = null; sql문을 실행시켜주는 객체 
		// --> (콤비) String sql = "INSERT INTO member_tbl(member_name, member_email) VALUES ('"+mname+"', '"+memail+"')";
		PreparedStatement pstmt = null;
	
		try {
			// DB와 연동하는 코드 부분
			Class.forName(driverName); // mySQL 드라이브 불러오기
			conn = DriverManager.getConnection(url, username, password); //DB와의 커넥션 생성
			// stmt = conn.createStatement(); //sql을 실행시켜주는 객체
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, mname);
			pstmt.setString(2, memail);
			
			int resultNum = pstmt.executeUpdate(); //sql문을 DB에 실행시킴(insert, update, delete --> 성공하면 1 반환)
			
			if (resultNum == 1) {
				out.println(mname + "님 회원가입 sql명령 실행 성공");
			} else {
				out.println(mname + "님 회원가입 sql명령 실행 실패");
			}
		} catch(Exception e) {
			out.println("DB연동 실패!!");
			e.printStackTrace();
		} finally {
			try {
				if(pstmt != null) {
					pstmt.close();
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