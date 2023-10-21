<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<html lang="ko">

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

<%
String clientId = "9RxQ23yL8KY_JLTWkrxt";//애플리케이션 클라이언트 아이디값";
String redirectURI = URLEncoder.encode("http://localhost:9006/member/naver_callback", "UTF-8");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString();
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code" + "&client_id=" + clientId
		+ "&redirect_uri=" + redirectURI + "&state=" + state;
session.setAttribute("state", state);
%>


<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 화면 샘플 Bootstrap</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="../../resources/css/home.css">
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
</head>

<body style="background-color: 71C9CE">



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
			<p style="color: var(--danger); font-weight: bold">
				아이디(로그인 전용 아이디) 또는 비밀번호를 잘못 입력했습니다.
			</p>
		</c:if>

		<div class="input-container" style="flex-direction: row">
			<a id="naverIdLogin_loginButton" href="<%=apiURL%>">
				<button class="naver-login">Naver Login</button>
			</a> <a onclick="kakaoLogin();" href="javascript:void(0)">
				<button class="kakao-login">kakao Login</button>
			</a>
		</div>

		

	</div>

	<div class="weather">
		<span id="city"></span> <span id="temp"></span>
	</div>

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

	<script src="../../resources/js/home.js?1"></script>
</body>