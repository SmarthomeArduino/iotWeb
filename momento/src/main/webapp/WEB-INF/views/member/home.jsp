<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://www.springframework.org/security/tags"
	prefix="sec"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<html lang="ko">

<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>회원가입 화면 샘플 - Bootstrap</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"
	integrity="sha384-ggOyR0iXCbMQv3Xipma34MD+dH/1fQ784/j6cY/iJTQUOhcWr7x9JvoRxT2MZw1T"
	crossorigin="anonymous">
<link rel="stylesheet" href="../../resources/css/home.css">
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Noto+Sans+KR:wght@100;300;400;500;700;900&display=swap"
	rel="stylesheet">
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>


</head>

<body>
	<div class="container">
		<!-- 화면 중앙 시계 -->
		<div class="clock" id="clock"></div>

		<!-- 구글 검색창 -->
		<div class="search">
			<form name=fsearch method=get style="margin: 0px;"
				action="http://www.google.co.kr/search" target="_blank">
				<input type=hidden name=where value="nexteach"> <input
					name=query itemname="검색어" required value="" size="33"
					placeholder="">
			</form>
		</div>

		<!-- 투두 리스트 -->


		<div class="todo">
			<form id="todo-form" class="todo-form">
				<input required type="text" placeholder="Write a to do...." />
			</form>
			<ul id="todo-list" class="todo-list"></ul>
		</div>


	</div>


	<!-- 우측 상단 날씨 표시  -->
	<div class="weather">
		<span id="city"></span> <span id="temp"></span>
	</div>

	<!-- 화면 죄측 하단 메뉴 -->
	<div class="toggle-container">
		<div class="toggle-icon" onclick="toggleContent()"></div>
		<div class="toggle-content">
			<a href="/board/list">Board</a>
			<hr>
			<a href="#">Diary</a>
			<hr>
			<a href="./member_u_01">My page</a>
			<hr>
			<a href="/customLogout">Log-out</a>

		</div>
	</div>


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
	<!-- 스크립트 -->
	<script
		src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js"
		charset="utf-8"></script>
	<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
	<script type="text/javascript" src="../../resources/js/home.js"></script>
</body>