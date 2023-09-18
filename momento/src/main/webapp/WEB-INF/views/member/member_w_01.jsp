<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<title>회원가입 페이지</title>


<!-- Bootstrap CSS -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x" crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/member_w_01/member_w_01.css" />
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<body>
	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">회원가입</h4>
				<form class="validation-form" id="inputForm" method="post"
					action="/member/member_w_01" name="signupform" novalidate>
					<input type="hidden" name="${_csrf.parameterName}"
						value="${_csrf.token}" />
					<div class="row">
						<div class="col-md-4 mb-3">
							<label for="name">이름</label> <input type="text"
								class="form-control" id="name" placeholder="이름을 입력하세요."
								name="userName" required />
							<div id="nameMessage"></div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-6 mb-3">
							<label for="id">ID</label> <input type="text"
								class="form-control" id="id" placeholder="id" name="userid"
								required />
							<div id="userIdMessage"></div>
						</div>
					</div>

					<div class="mb-3">
						<label for="pw">비밀번호</label> <input type="password"
							class="form-control" id="pw" name="userpw" required />
						<div id="userPwMessage"></div>
					</div>

					<div class="mb-3">
						<label for="pw2">비밀번호 재입력</label> <input type="password"
							class="form-control" id="pw2" name="userpw2" required />
						<div id="userPwMessage2"></div>
					</div>

					<div class="row">
						<div class="col-md-2 mb-3">
							<label for="phone">전화번호</label> <input class="form-control"
								type='text' id='phoneNumber' name='phoneNumber' required
								style="width: 15em;" />
							<div id="phoneMessage"></div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-4 mb-3">
							<label for="addressBtn">주소</label> <input type="text"
								class="form-control" id="zipcode" placeholder="우편 번호"
								name="zipCode" readonly required value="" />
						</div>

						<div class="col-md-3 mb-3">
							<label for="address" style="visibility: hidden">d</label> <input
								type="button" class="form-control" value="우편 번호 찾기"
								id="addressBtn" onclick="findAddr()" />
						</div>
					</div>

					<div class="col-md-8 mb-3">
						<label for="name"></label> <input type="text" class="form-control"
							id="address1" placeholder="도로명 주소" name="address1" value=""
							required readonly />
					</div>

					<div class="col-md-8 mb-3">
						<label for="name"></label> <input type="text" class="form-control"
							id="address2" placeholder="지번 주소" name="address2" value=""
							required readonly />
						<div id="addressMessage"></div>
					</div>

					<div class="col-md-3 mb-3">
						<label for="address2">상세주소<span class="text-muted">&nbsp;(선택)</span></label>
						<input type="text" class="form-control" id="addressDetail"
							placeholder="상세주소 입력." name="addressDetail" />
					</div>

					<div class="row">
						<div class="col-md-8 mb-3">
							<label for="identification">본인 인증 질문</label> <select
								class="custom-select d-block w-100 form-control"
								id="identification" required name="question_code">
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
								name="question_answer"  required />
							<div id="qAnswerMessage"></div>
						</div>
					</div>
					<hr class="mb-4" />
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="agreement"
							name="formCheckbox" required /> <label
							class="custom-control-label" for="agreement">개인정보 수집 및
							이용에 동의합니다.</label>
					</div>
					<div class="mb-4">
						<div id="agreementMessage"></div>
					</div>
					<button type='button' class="btn btn-primary btn-lg btn-block"
						id="submitBtn">가입 완료</button>
						<input type='hidden' name="phone" id="phone"/>
					<input type='hidden' name="addr" id="addr" />
				</form>
			</div>
		</div>
	</div>
	<script src="/resources/js/member_w_01/member_w_01.js"></script>
</body>
</html>
