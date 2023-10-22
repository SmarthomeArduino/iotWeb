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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">
<link rel="stylesheet" href="/resources/css/member_w_01/member_w_01.css" />
<link rel="stylesheet"
	href="/resources/css/member_u_01/member_u_01_modal.css" />
<script
	src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

</head>

<body>
	<div class="container">
		<a href="/member/home"> </a>
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
						<div class="col-md-4 mb-3">
							<label for="id">ID</label> <input type="text"
								class="form-control" id="id" placeholder="id" name="userid"
								required />
							<div id="userIdMessage"></div>
						</div>

						<div class="col-md-4 mb-3">
							<span style="visibility: hidden">hidden_for_space</span>
							<button class="btn btn-dark btn-block" type="button"
								id="modifyIdBtn">중복체크</button>
						</div>
					</div>

					<div class="mb-3">
						<label for="pw">비밀번호</label> <input type="password"
							class="form-control" id="pw" name="userpw" required
							style="width: 50%" />
						<div id="userPwMessage"></div>
					</div>

					<div class="mb-3">
						<label for="pw2">비밀번호 재입력</label> <input type="password"
							class="form-control" id="pw2" name="userpw2" required
							style="width: 50%" />
						<div id="userPwMessage2"></div>
					</div>

					<div class="row">
						<div class="col-md-2 mb-3">
							<label for="phone">전화번호</label> <input class="form-control"
								type="text" id="phoneNumber" name="phone" required
								style="width: 15em" />
							<div id="phoneMessage" style="width: 30em"></div>
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
						<div id="phoneMessage" style="width: 30em"></div>
					</div>

					<div class="col-md-8 mb-3">
						<label for="name"></label> <input type="text" class="form-control"
							id="address1" placeholder="도로명 주소" name="address1" value=""
							readonly />
					</div>

					<div class="col-md-8 mb-3">
						<label for="name"></label> <input type="text" class="form-control"
							id="address2" placeholder="지번 주소" name="address2" value=""
							readonly />
						<div id="zipcodeMessage"></div>
					</div>

					<div class="col-md-3 mb-3">
						<label for="address2">상세주소<span
							class="text-muted">&nbsp;(선택)</span></label> <input type="text"
							class="form-control" id="addressDetail" placeholder="상세주소 입력."
							name="addressDetail" />
					</div>

					<div class="row">
						<div class="col-md-7 mb-3">
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
								name="question_answer" required />
							<div id="qAnswerMessage" style="width: 15rem"></div>
						</div>
					</div>
					<hr class="mb-4" />
					<div class="custom-control custom-checkbox">
						<input type="checkbox" class="custom-control-input" id="agreement"
							name="formCheckbox" required /> <label
							class="custom-control-label" for="agreement">개인정보
							수집 및 이용에 동의합니다.</label>
					</div>
					<div class="mb-4">
						<div id="agreementMessage"></div>
					</div>
					<button type="button" class="btn btn-primary btn-lg btn-block"
						id="submitBtn">가입 완료</button>
					<input type="hidden" name="addr" id="addr" />
				</form>
			</div>
		</div>
	</div>
	<script>
	 // 폼 태그 외부 버튼
    const sbmtBtn = document.querySelector("#submitBtn");

    const fields = {
      name: document.querySelector("#name"),
      id: document.querySelector("#id"),
      password: document.querySelector("#pw"),
      password2: document.querySelector("#pw2"),
      phone: document.querySelector("#phoneNumber"),
      zipcode: document.querySelector("#zipcode"),
      address1: document.querySelector("#address1"),
      address2: document.querySelector("#address2"),
      addressDetail: document.querySelector("#addressDetail"),
      qAnswer: document.querySelector("#qAnswer"),
      agreement: document.querySelector("#agreement"),
      addr: document.querySelector("#addr"),
    };

    const regexPatterns = {
      name: /^[가-힣]{2,50}$/,
      id: /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,20}$/,
      password:
        /^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*#?&])(?=.*\d)[A-Za-z\d$@$!%*#?&]{8,20}$/,
      phone: /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/,
    };

    const messages = {
      name: {
        empty: "*이름을 입력해주세요",
        invalid: "*잘못된 형식의 이름입니다. (한글 2자 이상)",
        valid: "*사용가능한 이름입니다.",
      },
      id: {
        empty: "*아이디를 입력해주세요",
        invalid: "*잘못된 형식의 아이디입니다. (소문자, 숫자 조합 4~20)",
        valid: "*사용가능한 아이디입니다.",
      },
      password: {
        empty: "*비밀번호를 입력해주세요.",
        invalid:
          "*잘못된 형식의 비밀번호입니다. (대소문자, 특수문자, 숫자 조합 8~20)",
        valid: "*사용가능한 패스워드입니다.",
      },
      password2: {
        empty: "*비밀번호를 입력해주세요.",
        invalid: "*비밀번호가 일치하지 않습니다.",
        valid: "*비밀번호가 일치합니다.",
      },
      phone: {
        empty: "*전화번호를 입력해주세요.",
        invalid: "*잘못된 형식의 전화번호입니다.(ex 01022223333)",
        valid: "*사용가능한 전화번호입니다.",
      },

      zipcode: {
        invalid: "*우편번호를 선택해주세요.",
      },
      qAnswer: {
        invalid: "*본인확인 질문을 입력해주세요.",
      },
    };

    const validateField = (fieldName, regexPattern, messageDiv) => {
      const value = fields[fieldName].value;
      const message = messages[fieldName];

      if (value === "") {
        messageDiv.innerText = message.empty;
        messageDiv.classList.remove("valid-feedback");
        messageDiv.classList.add("invalid-feedback");
        return false;
      }

      if (!regexPattern.test(value)) {
        messageDiv.innerText = message.invalid;
        messageDiv.classList.remove("valid-feedback");
        messageDiv.classList.add("invalid-feedback");
        return false;
      }

      // 유효성 검증 통과
      messageDiv.innerText = message.valid;
      messageDiv.classList.add("valid-feedback");
      messageDiv.classList.remove("invalid-feedback");

      return true;
    };

    let isNameValid = false;
    let isIdValid = false;
    let isPasswordValid = false;
    let isPasswordConfirmValid = false;
    let isPhoneValid = false;
    let isZipcodeValid = false;
    let isQAnswerValid = false;
    let isAgreementChecked = false;

    const checkFunctions = {
      nameCheck: function () {
        isNameValid = validateField(
          "name",
          regexPatterns.name,
          document.querySelector("#nameMessage")
        );
        if (isNameValid) {
        } else {
        }
      },

      idCheck: function () {
        isIdValid = validateField(
          "id",
          regexPatterns.id,
          document.querySelector("#userIdMessage")
        );
        if (isIdValid) {
        } else {
        }
      },

      passwordCheck: function () {
        isPasswordValid = validateField(
          "password",
          regexPatterns.password,
          document.querySelector("#userPwMessage")
        );
        if (isPasswordValid) {
        } else {
        }
      },
      passwordConfirmCheck: function () {
        isPasswordConfirmValid =
          fields.password.value == fields.password2.value;
        const messageDiv = document.querySelector("#userPwMessage2");
        const message = messages["password2"];

        if (isPasswordConfirmValid) {
          messageDiv.innerText = message.valid;
          messageDiv.classList.remove("invalid-feedback");
          messageDiv.classList.add("valid-feedback");
        } else {
          messageDiv.innerText = message.invalid;
          messageDiv.classList.remove("valid-feedback");
          messageDiv.classList.add("invalid-feedback");
        }
      },

      phoneNumberCheck: function () {
        isPhoneValid = validateField(
          "phone",
          regexPatterns.phone,
          document.querySelector("#phoneMessage")
        );

        const phoneNumber2 = phoneNumber.value;
        if (isPhoneValid) {
        	
          // 전화번호가 10자리일 때
          if (phoneNumber2.length === 10) {
            const areaCode = phoneNumber2.slice(0, 3);
            const firstPart = phoneNumber2.slice(3, 6);
            const secondPart = phoneNumber2.slice(6);
            phoneNumber.value = areaCode + '-' + firstPart + '-'  + secondPart;
          }

          // 전화번호가 11자리일 때
          if (phoneNumber2.length === 11) {
            const areaCode = phoneNumber2.slice(0, 3);
            const firstPart = phoneNumber2.slice(3, 7);
            const secondPart = phoneNumber2.slice(7);
            phoneNumber.value = areaCode + '-' + firstPart + '-'  + secondPart;
          }
        } else {
        }
      },
      zipcodeCheck: function () {
        isZipcodeValid = fields.zipcode.value != "";
        const messageDiv = document.querySelector("#zipcodeMessage");
        const message = messages["zipcode"];

        if (isZipcodeValid) {
          messageDiv.innerText = "";
          messageDiv.classList.add("valid-feedback");
          messageDiv.classList.remove("invalid-feedback");
        } else {
          messageDiv.innerText = message.invalid;
          messageDiv.classList.remove("valid-feedback");
          messageDiv.classList.add("invalid-feedback");
        }
      },

      qAnswerCheck: function () {
        isQAnswerValid = fields.qAnswer.value != "";
        const messageDiv = document.querySelector("#qAnswerMessage");
        const message = messages["qAnswer"];

        if (isQAnswerValid) {
          messageDiv.innerText = "";
          messageDiv.classList.add("valid-feedback");
          messageDiv.classList.remove("invalid-feedback");
        } else {
          messageDiv.innerText = message.invalid;
          messageDiv.classList.remove("valid-feedback");
          messageDiv.classList.add("invalid-feedback");
        }
      },

      agreementCheck: function () {
        const message = document.querySelector("#agreementMessage");
        isAgreementChecked = agreement.checked;
        if (!isAgreementChecked) {
          message.innerText = `*이용 약관에 동의하셔야합니다.`;
          message.classList.remove("valid-feedback");
          message.classList.add("invalid-feedback");
        } else {
          message.innerText = "";
          message.classList.remove("invalid-feedback");
          message.classList.add("valid-feedback");
        }
      },
    };

    // 주소 api
    function findAddr() {
      new daum.Postcode({
        oncomplete: function (data) {
          console.log(data);

          // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
          // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
          // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
          var roadAddr = data.roadAddress; // 도로명 주소 변수
          var jibunAddr = data.jibunAddress; // 지번 주소 변수
          // 우편번호와 주소 정보를 해당 필드에 넣는다.

          fields.zipcode.value = data.zonecode;
          if (roadAddr !== "") {
            fields.address1.value = roadAddr;
            fields.address2.value = jibunAddr;
          } else if (jibunAddr !== "") {
            fields.address1.value = roadAddr;
            fields.address2.value = jibunAddr;
          }

          fields.addr.value = fields.zipcode.value
            .concat("/")
            .concat(fields.address1.value)
            .concat("/")
            .concat(fields.address2.value)
            .concat("/")
            .concat(fields.addressDetail.value);
        },

        onclose: function () {
          const messageDiv = document.querySelector("#zipcodeMessage");
          const message = messages["zipcode"];

          if (!fields.zipcode.value) {
            messageDiv.innerText = message.invalid;
            messageDiv.classList.remove("valid-feedback");
            messageDiv.classList.add("invalid-feedback");
            isZipcodeValid = false;
          } else {
            messageDiv.innerText = "";
            messageDiv.classList.add("valid-feedback");
            messageDiv.classList.remove("invalid-feedback");
            isZipcodeValid = true;
          }
        },
      }).open();
    }

    // 이벤트 리스너 등록
    fields.name.addEventListener("blur", checkFunctions.nameCheck);
    fields.id.addEventListener("blur", checkFunctions.idCheck);
    fields.password.addEventListener("blur", checkFunctions.passwordCheck);
    fields.password2.addEventListener(
      "blur",
      checkFunctions.passwordConfirmCheck
    );
    fields.phone.addEventListener("blur", checkFunctions.phoneNumberCheck);
    // fields.zipcode.addEventListener("blur", checkFunctions.zipcodeCheck);
    fields.qAnswer.addEventListener("blur", checkFunctions.qAnswerCheck);
    fields.agreement.addEventListener("input", checkFunctions.agreementCheck);

    function submitForm() {
      console.log(
        isNameValid,
        isIdValid,
        isPasswordValid,
        isPasswordConfirmValid,
        isPhoneValid,
        isZipcodeValid,
        isQAnswerValid,
        isAgreementChecked
      );
      if (
        isNameValid &&
        isIdValid &&
        isPasswordValid &&
        isPasswordConfirmValid &&
        isPhoneValid &&
        isZipcodeValid &&
        isQAnswerValid &&
        isAgreementChecked
      ) {
        alert("회원가입이 완료되었습니다.");
        document.querySelector("#inputForm").submit();
      } else {
        alert("모든 항목을 올바르게 입력해주세요.");
      }
    }

    sbmtBtn.addEventListener("click", submitForm);
	</script>
	<!-- <script src="/resources/js/member_w_01/member_w_01.js"></script> -->
</body>
</html>
