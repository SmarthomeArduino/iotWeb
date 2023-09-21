<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>아이디 찾기 페이지</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/member_in_03/member_in_03.css" />
<link rel="stylesheet" href="/resources/css/member_in_03/member_in_03_modal.css" />
</head>

<body>

	<div class="container">
		<a href="/customLogin"><img src="/resources/img/test_logo.png"
			width="150px" height="150px" alt="" style="text-align: center;">
		</a>
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">아이디 찾기</h4>
				<form class="validation-form" id="inputForm" method="post"
					name="findIdform" novalidate action="/member/findIdProc">
					<div class="col-md-4 mb-3">
						<label for="name">이름</label> <input type="text"
							class="form-control" id="userName" name="userName" 
							required />
						<div id="nameMessage"></div>
					</div>
					<div class="col-md-2 mb-3">
						<label for="phone">전화번호</label> <input class="form-control"
							type='text' id='phone' name='phone' required 
							style="width: 15em;" />
						<div id="phoneMessage"></div>
					</div>
					<hr class="mb-4" />
					<div id="btnWrap">
						<button class="btn btn-primary btn-lg btn-block">아이디 찾기</button>
					</div>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
				</form>
			</div>
		</div>
	</div>
	<script src="/resources/js/member_in_03/member_in_03.js"></script>
</body>
</html>
