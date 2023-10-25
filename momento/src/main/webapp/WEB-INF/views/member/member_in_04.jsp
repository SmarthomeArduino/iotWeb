<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />


<link rel="stylesheet" href="/resources/css/bootstrap.min.css">
<link rel="stylesheet"
	href="/resources/css/member_in_04/member_in_04.css" />
</head>

<body>
	<div class="container">
		<a href="/customLogin"><img src="/resources/img/test_logo.png"
			width="150px" height="150px" alt="" style="text-align: center;">
		</a>
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">비밀번호 찾기 인증 단계</h4>
				<form class="validation-form" id="inputForm" method="post"
					name="findPwForm" action="/member/findPwProc" novalidate>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div class="col-md-6 mb-3">
						<label for="id">ID</label> <input type="text" class="form-control"
							id="id" placeholder="회원님의 ID를 입력해주세요." name="findPwId" required />
						<div id="userIdMessage"></div>
					</div>

					<div class="row">
						<div class="col-md-2 mb-3">
							<label for="selectedNum">번호(선택)</label> <select id="selectedNum"
								class="form-control" name="findPwSelectedNum">
								<option value="010" selected>010</option>
								<option value="011">011</option>
							</select>
						</div>

						<div class="col-md-3 mb-3">
							<label for="pNum">앞자리</label> <input type="text"
								class="form-control" id="pNum" name="findPwNum"
								placeholder="앞자리 입력" value="" required maxlength="4" />
							<div id="pNumMessage"></div>
						</div>

						<div class="col-md-3 mb-3">
							<label for="pNum2">뒷자리</label> <input type="text"
								class="form-control" id="pNum2" placeholder="뒷자리 입력"
								name="findPwNum2" value="" required maxlength="4" />
							<div id="pNumMessage2"></div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-8 mb-3">
							<label for="identification">본인 인증 질문</label> <select
								class="custom-select d-block w-100 form-control"
								id="identification" required name="findPwQuestions">
								<optgroup label="질문을 선택해주세요">
									<option value="1" selected>아버지의 성함은?</option>
									<option value="2">어머니의 성함은?</option>
									<option value="3">자신의 보물 1호는?</option>
								</optgroup>
							</select>
						</div>
						<div class="col-md-4 mb-3">
							<label for="qAnswer">질문 답변</label> <input type="text"
								class="form-control" id="qAnswer" placeholder="홍길동"
								name="findPwAnswer" required />
							<div id="qAnswerMessage"></div>
						</div>
					</div>
					<hr class="mb-4" />
					<button type="button" class="btn btn-primary btn-lg btn-block"
						id="submitBtn">인증 완료</button>
				</form>
			</div>
		</div>
	</div>
	<script src="/resources/js/member_in_04/member_in_04.js"></script>
</body>
</html>
