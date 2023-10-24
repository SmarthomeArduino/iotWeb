<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />

<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/member_u_01/member_u_01.css" />
<link rel="stylesheet"
	href="/resources/css/member_u_01/member_u_01_modal.css" />
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
</head>

<body>
	<div id="modalWrap" style="display: none">
		<div id="modalContent">
			<div id="modalBody">
				<span class="closeBtn" style="color: #000000" id="closeBtn">&times;</span>
				<h3>ID 변경</h3>

				<hr class="mb-4" />
				<!-- ID 변경 모달 폼 -->
				<form name="modifyIdForm" class="validation-form" method="post"
					id="modalIdInputForm" novalidate>
					<div class="col-md-7 mb-3">
						<input type="text" class="form-control" id="modalId"
							placeholder="변경할 아이디를 입력해주세요." name="modalModifyId" required />
						<input type="text" name="" id="" style="display: none" />
						<div id="modalIdMessage"></div>
					</div>
				</form>
				<hr class="mb-4" />
				<button class="btn btn-success" id="modalIdModifyBtn">변경하기
				</button>
				<a href="mainTest.html"><button class="btn btn-primary"
						style="float: right">메인으로 돌아가기</button></a>
			</div>
		</div>
	</div>

	<div id="modalWrap2" style="display: none">
		<div id="modalContent2">
			<div id="modalBody2">
				<span class="closeBtn" style="color: #000000" id="closeBtn2">&times;</span>
				<h3>비밀번호 변경 인증</h3>

				<hr class="mb-4" />
				<!-- 비밀번호 변경 모달 폼 -->
				<form name="modifyPwForm" class="validation-form" method="post"
					id="modalPwInputForm" novalidate>
					<div class="col-md-7 mb-3">
						<input type="password" class="form-control" id="modalPw"
							placeholder="현재 비밀번호를 입력해주세요." name="modifyModalFirstPw" required />
						<div id="modalPwMessage"></div>
					</div>
				</form>
				<hr class="mb-4" />
				<button class="btn btn-success" id="modalPwModifyBtn">인증하기
				</button>
				<a href="mainTest.html"><button class="btn btn-primary"
						style="float: right">메인으로</button></a>
			</div>
		</div>
	</div>

	<div class="container">
		<div class="input-form-backgroud row">
			<div class="input-form col-md-12 mx-auto">
				<h4 class="mb-3">기본 정보 조회/변경</h4>
				<form class="validation-form" id="inputForm" method="post"
					name="modifyform" novalidate>
					<div class="row">
						<div class="col-md-5 mb-3">
							<label for="formName">이름</label> <input type="text"
								class="form-control" id="formName"
								value="${member.getUserName() }" name="modifyName" required />
							<div id="userNameMessage"></div>
						</div>
					</div>

					<div class="row">
						<div class="col-md-5 mb-3">
							<label for="formId">ID</label> <input type="text"
								class="form-control" id="formId" placeholder="id"
								value="${member.getUserid()}" name="modifyId" required disabled />
							<div id="userIdMessage"></div>
						</div>


					</div>

					<!-- 			<div class="row">
						<div class="col-md-5 mb-3">
							<label for="formPw">비밀번호</label> <input type="password"
								class="form-control" id="formPw" placeholder="***********"
								name="modifyPw" required disabled />
							<div id="userPwMessage"></div>
						</div>

						<div class="col-md-2 mb-3">
							<span class="hidden-span">hidden_for_space</span>
							<button class="btn btn-dark btn-block" type="button"
								id="modifyPwBtn">변경</button>
						</div>
					</div> -->

					<div class="col-md-5 mb-3">
						<label for="pNum">휴대폰 번호</label> <input type="text"
							class="form-control" id="pNum" placeholder="휴대폰 번호를 입력하세요."
							name="modifyNum" required value="${member.getPhone()}" />
						<div id="pNumMessage"></div>
					</div>

					<div class="row">
						<div class="col-md-4 mb-3">
							<label for="addressBtn">주소</label> <input type="text"
								class="form-control" id="zipcode" placeholder="우편 번호"
								name="modifyZipcode" readonly required
								value="${member.getAddr().split('/')[0]}" />
						</div>

						<div class="col-md-3 mb-3">
							<label for="address" style="visibility: hidden">d</label> <input
								type="button" class="form-control" value="우편 번호 찾기"
								id="addressBtn" onclick="findAddr()" />
						</div>
					</div>

					<div class="col-md-8 mb-3">
						<input type="text" class="form-control" id="doromyung"
							placeholder="도로명 주소" name="modifyDoromyungAddress"
							value="${member.getAddr().split('/')[1]}" required readonly />
					</div>

					<div class="col-md-8 mb-3">
						<input type="text" class="form-control" id="jibeon"
							placeholder="지번 주소" name="modifyJibeonAddress"
							value="${member.getAddr().split('/')[2]}" required readonly />
						<div id="addressMessage"></div>
					</div>

					<div class="col-md-3 mb-3">
						<label for="address2">상세주소<span class="text-muted">&nbsp;(선택)</span></label>
						<input type="text" class="form-control" id="sangse"
							value="${member.getAddr().split('/')[3]}" placeholder="상세주소 입력."
							name="modifySangseAddress" />
					</div>

					<hr class="mb-4" />
				</form>
				<div class="row">
					<div class="col-md-3">
						<button class="btn btn-success btn-lg btn-block" id="submitBtn"
							disabled="disabled">변경 완료</button>
					</div>

					<div class="col-md-3">
						<button class="btn btn-danger btn-lg btn-block" id="dBtn"
							onClick="location.href='/member/member_d_01'">회원 탈퇴</button>
					</div>

					<div class="col-md-6">
						<a href="/member/home"><button class="btn btn-primary btn-lg"
								style="float: right">메인으로 돌아가기</button></a>
					</div>
				</div>
			</div>
		</div>
	</div>
	<script src="/resources/js/member_u_01/member_u_01.js"></script>

</body>
</html>
