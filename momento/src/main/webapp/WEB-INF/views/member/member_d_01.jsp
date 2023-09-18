<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/member_d_01/member_d_01.css" />
</head>

<body>
	<div class="container">
		<a href="/member/home"><img
			src="/resources/img/test_logo.png" width="150px" height="150px"
			style="text-align: center" /> </a>
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원 탈퇴</h4>
				<form class="validation-form" id="deleteUserForm" method="post"
					name="deleteUserForm" action="/member/member_d_01" novalidate>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div class="col-md-5 mb-3" style="position: relative">
						<label for="pw">비밀번호</label> <input type="password"
							class="form-control pw-position" id="pwCheck"
							placeholder="현재 비밀번호를 입력해주세요." name="userDeletePw" required />
					</div>
					<span id="userDeletePwMessage"></span>
					<hr class="mb-4" />
					<div class="col-md-6">
						<textarea id="deleteTextarea" cols="50" rows="10"
							class="form-control" style="resize: none" readonly></textarea>
						<br />
					</div>
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="agreement"
							required /> <label class="custom-control-label"
							for="agreement">위 내용을 모두 숙지하였으며, 이에
							동의하고 회원 탈퇴를 진행합니다.</label>
					</div>
					<div class="mb-4">
						<div id="agreementMessage">*회원 탈퇴 안내를 읽고 체크해주세요.</div>
					</div>
				</form>
				<div class="col-md-3">
					<button class="btn btn-danger btn-lg btn-block" id="dBtn">
						회원 탈퇴</button>
				</div>
			</div>
		</div>
	</div>
	<script src="/resources/js/member_d_01/member_d_01.js"></script>
</body>
</html>

