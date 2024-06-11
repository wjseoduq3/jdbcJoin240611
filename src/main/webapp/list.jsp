<%@page import="com.jdy.dto.MemberDto"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.*"%>
<%@page import="java.sql.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>가입회원리스트</title>
</head>
<body>
	<%
		request.setCharacterEncoding("utf-8");
		
		String sql = "SELECT * FROM member_tbl";
			
		// mySQL과 연결에 필요한 4개의 변수 선언
		String driverName = "com.mysql.jdbc.Driver";
		String url = "jdbc:mysql://localhost:3306/member_db";
		String username ="root";
		String password ="12345";
		
		Connection conn = null; // db와의 커넥션 생성
		Statement stmt = null; // sql문을 실행시켜주는 객체
		ResultSet rs = null; // select를 쓸 때 결과값받는 자료 타입 선언
		
		try {
			Class.forName(driverName); // mySQL 드라이브 불러오기
			conn = DriverManager.getConnection(url, username, password); //DB와의 커넥션 생성
			stmt = conn.createStatement(); //sql을 실행시켜주는 객체
			
			rs = stmt.executeQuery(sql);
			
			List<MemberDto> members = new ArrayList<MemberDto>();
		
			// rs안의 자료를 하나씩 끄집어 내는 과정
			while(rs.next()) {
				int mnum = rs.getInt("member_num");
				String mname = rs.getString("member_name");
				String memail = rs.getString("memevr_email");
				String mdate = rs.getString("member_signuptime");
				
				MemberDto memberDto = new MemberDto();
				memberDto.setMember_num(mnum);
				memberDto.setMember_name(mname);
				memberDto.setMember_email(memail);
				memberDto.setMember_signuptime(mdate);
				
				members.add(memberDto);				
			}
			for(int i=0;i<members.size();i++) {
				out.println(members.get(i).getMember_num()+"/");
				out.println(members.get(i).getMember_name()+"/");
				out.println(members.get(i).getMember_email()+"/");
				out.println(members.get(i).getMember_signuptime()+"<br>");
			}
			
		} catch(Exception e) {
			out.println("회원목록 불러오기 실패!!");
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

</body>
</html>