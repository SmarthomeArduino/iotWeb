<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>회원가입 화면 샘플 - Bootstrap</title>

<!-- Bootstrap CSS -->
<link rel="stylesheet" href="/resources/css/member_in_05/member_in_05.css" />
</head>

<script src="https://kit.fontawesome.com/c22cf359ff.js"
	crossorigin="anonymous"></script>

<body>
	<div class="container">
		<a href="/customLogin"><img src="/resources/img/test_logo.png"
			width="150px" height="150px" alt="" style="text-align: center;" /> </a>
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">비밀번호 재설정</h4>
				<form class="validation-form" id="resetPwForm" method="post"
					name="resetPwForm" action="/member/member_in_05" novalidate>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />

					<input type="hidden" name="findPwId" value="${sessionScope.findPwId}" />
					<div class="col-md-5 mb-3" style="position: relative">
						<label for="newPw">새로운 비밀번호</label> <input type="password"
							class="form-control pw-position" id="newPw"
							placeholder="***********" name="newPw" required /> <span
							id="icon"><i class="fa-regular fa-eye"></i></span>
					</div>
					<span id="userNewPwMessage"></span>

					<div class="col-md-5 mb-3" style="position: relative">
						<label for="newPw2">새로운 비밀번호 재입력</label> <input type="password"
							class="form-control pw-position" id="newPw2"
							placeholder="***********" name="newPw2" required /> <span
							id="icon2"><i class="fa-regular fa-eye"></i></span>
					</div>
					<span id="userNewPwMessage2"></span>
					<hr class="mb-4" />
					<div id="btnWrap"></div>
				</form>
				<button class="btn btn-primary btn-lg btn-block" id="submitBtn">
					비밀번호 재설정</button>
			</div>
		</div>
	</div>
	<script src="/resources/js/member_in_05/member_in_05.js"></script>
</body>
</html>
