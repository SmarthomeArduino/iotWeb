<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
Cookie[] cookies = request.getCookies();
if (cookies != null) {
	for (Cookie cookie : cookies) {
		if (cookie.getName().equals("remember-me")) {
	String autoLogin = cookie.getValue();
	System.out.println(autoLogin);
	response.sendRedirect("/member/home");
	return;
		}
	}
}
%>

<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>로그인 페이지</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/resources/css/home.css">
<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet" href="/resources/css/fonts/notosans.css">

</head>

<body class="body">
	<header>
		<!-- 구글 검색창 -->
		<div class="search">
			<form name=fsearch method=get action="http://www.google.co.kr/search"
				target="_blank">
				<input type=hidden name=where value="nexteach"> <input
					name=query required value="" size="33" placeholder="">
			</form>
		</div>

		<div class="weather">
			<span id="city"></span> <span id="temp"></span>
		</div>
	</header>


	<div class="container">
		<!-- 화면 중앙 시계 -->
		<div class="clock" id="clock"></div>

		<form method='post' action='/login'>
			<!-- 자동로그인 -->
			<div class="auto-login">
				자동로그인 <input type="checkbox" name="remember-me">
			</div>
			<div class="input-container" style="padding-bottom: 0px">
				<input type="text" placeholder="ID" name="username"> <input
					type="password" placeholder="Password" name="password"> <input
					type="submit" value="Login" id="button"> <input
					type="hidden" name="${_csrf.parameterName}" value="${_csrf.token}" />
			</div>
		</form>
		<!-- 로그인 실패 메시지 표시 -->
		<c:if test="${param.error ne null}">
			<p style="color: var(- -danger); font-weight: bold">아이디 또는 비밀번호를
				잘못 입력했습니다.</p>
		</c:if>

		<div class="input-container" style="flex-direction: row">
			<%-- <a id="naverIdLogin_loginButton" href="<%=apiURL%>"> --%>
			<a id="naverIdLogin_loginButton" href="#">
				<button class="naver-login">Naver Login</button>
			</a> <a onclick="kakaoLogin();" href="javascript:void(0)">
				<button class="kakao-login">kakao Login</button>
			</a>
		</div>
	</div>

	<footer class="footer">
		<!-- 화면 죄측 하단 메뉴 -->
		<div class="toggle-container">
			<div id="toggle-icon" class="toggle-icon" onclick="toggleContent()"></div>
			<div class="toggle-content">
				<a href="/member/member_w_01">회원가입</a>
				<hr>
				<a href="/member/member_in_03">아이디 찾기</a>
				<hr>
				<a href="/member/member_in_04">비밀번호 찾기</a>
			</div>

		</div>
		<div id="quote">
			<span></span> <span></span>
		</div>
		<button class="btn" id="toggleTodoBtn">Todo</button>

		<!-- 투두 리스트 -->
		<div class="todo">

			<form id="todo-form" class="todo-form">
				<input required type="text" placeholder="Write a to do...." />
			</form>
			<ul id="todo-list" class="todo-list"></ul>
		</div>
	</footer>


	<script src="/resources/js/home.js?1"></script>
</body>
</html>