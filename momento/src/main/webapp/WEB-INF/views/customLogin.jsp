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
<title>로그인 페이지</title>

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

	<!-- <img alt="#" src="/resources/img/iot-5255494_1280.png" width="150px" height=70px> -->

	<header>
		<!-- 구글 검색창 -->
		<div class="search">
			<form name=fsearch method=get style="margin: 0px;"
				action="http://www.google.co.kr/search" target="_blank">
				<input type=hidden name=where value="nexteach"> <input
					name=query itemname="검색어" required value="" size="33"
					placeholder="">
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





	<footer
		style="display: flex; padding: 1rem; width: 100%; justify-content: space-between; position: fixed; bottom: 10px; z-index: 9999;">
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
		<div id="quote"
			style="display: flex; flex-direction: column; align-items: center; justify-content: center;">
			<span></span> <span></span>
		</div>
		<button class="btn" id="toggleTodoBtn">Todo</button>

		<!-- 투두 리스트 -->
		<div class="todo"
			style="display: none; position: fixed; right: 10px; bottom: 10rem; border-radius: 1rem">

			<form id="todo-form" class="todo-form">
				<input required type="text" placeholder="Write a to do...." />
			</form>
			<ul id="todo-list" class="todo-list"></ul>
		</div>
	</footer>
	<script>
    // Todo 버튼 클릭 시 투두 리스트 토글
    document.getElementById('toggleTodoBtn').addEventListener('click', function() {
      var todoDiv = document.querySelector('.todo');
      todoDiv.style.display = (todoDiv.style.display === 'none' || todoDiv.style.display === '') ? 'block' : 'none';
    });
	</script>

	<!-- 투두 리스트 -->
	<script>
	const toDoForm = document.querySelector("#todo-form");
	const toDoInput = toDoForm.querySelector("input");
	const toDoList = document.querySelector("#todo-list");

	const TODOS_KEY = "toDos";
	let toDos = [];

	function deleteToDo(toDo) {
	  const li = toDo.target.parentNode;
	  toDoList.removeChild(li);

	  toDos = toDos.filter((toDo) => parseInt(li.id) !== toDo.id);
	  saveTodos();
	}

	function saveTodos() {
	  localStorage.setItem(TODOS_KEY, JSON.stringify(toDos));
	}

	function paintToDos(newToDosObj) {
	  const li = document.createElement("li");
	  const span = document.createElement("span");
	  const button = document.createElement("button");

	  button.innerText = "❌";
	  span.innerText = newToDosObj.text;

	  li.id = newToDosObj.id;
	  li.appendChild(span);
	  li.appendChild(button);
	  toDoList.appendChild(li);

	  button.addEventListener("click", deleteToDo);
	}

	function toDoHandleSubmit(event) {
	  event.preventDefault();
	  const newToDo = toDoInput.value;
	  toDoInput.value = "";

	  const newToDosObj = {
	    text: newToDo,
	    id: Date.now(),
	  };

	  toDos.push(newToDosObj);
	  paintToDos(newToDosObj);
	  saveTodos();

	  fetch("/testAjax", {
	    method: "POST",
	    body: JSON.stringify({ key: "hi" }),
	    headers: {
	      "Content-Type": "application/json",
	      "X-CSRF-TOKEN": '<c:out value="${_csrf.token}" />',
	    },
	  })
	    .then(function (response) {
	      if (response.ok) {
	        console.log(response);
	        return response.json();
	      } else {
	        throw new Error("Network response was not ok.");
	      }
	    })
	    .then(function (data) {
	      console.log("ajax success");
	    })
	    .catch(function (error) {
	      console.error("Error:", error);
	    });
	}

	const savedToDos = localStorage.getItem(TODOS_KEY);

	if (savedToDos !== null) {
	  const parseToDos = JSON.parse(savedToDos);

	  toDos = parseToDos;
	  parseToDos.forEach(paintToDos);
	} else {
	}

	toDoForm.addEventListener("submit", toDoHandleSubmit);
	</script>

	<script type="text/javascript">
		const quotes = [
				{
					quote : "The way to get started is to quit talking and begin doing.",
					author : "Walt Disney",
				},
				{
					quote : "Life is what happens when you're busy making other plans.",
					author : "John Lennon",
				},
				{
					quote : "The world is a book and those who do not travel read only one page.",
					author : "Saint Augustine",
				},
				{
					quote : "Life is either a daring adventure or nothing at all.",
					author : "Helen Keller",
				},
				{
					quote : "To Travel is to Live",
					author : "Hans Christian Andersen",
				},
				{
					quote : "Only a life lived for others is a life worthwhile.",
					author : "Albert Einstein",
				},
				{
					quote : "You only live once, but if you do it right, once is enough.",
					author : "Mae West",
				},
				{
					quote : "Never go on trips with anyone you do not love.",
					author : "Hemmingway",
				},
				{
					quote : "We wander for distraction, but we travel for fulfilment.",
					author : "Hilaire Belloc",
				}, {
					quote : "Travel expands the mind and fills the gap.",
					author : "Sheda Savage",
				}, ];

		const quote = document.querySelector("#quote span:first-child");
		const author = document.querySelector("#quote span:last-child");
		const todaysQuote = quotes[Math.floor(Math.random() * quotes.length)];

		quote.innerText = todaysQuote.quote;
		author.innerText = todaysQuote.author;
	</script>

	<script src="../../resources/js/home.js?1"></script>
</body>