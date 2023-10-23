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
      invalid2: "*중복된 ID 입니다.",
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
  let isIdDuplValid = false;
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
        // 서버로 데이터를 보내는 AJAX 요청
        $.ajax({
          type: "POST",
          url: "/member/idDuplCheck",
          contentType: "application/json",
          data: JSON.stringify({ id: fields.id.value }),
          success: function (response) {
            // 성공적으로 응답을 받았을 때의 동작

            const messageDiv = document.querySelector("#userIdMessage");
            const message = messages["id"];
            isIdDuplValid =
              response.childNodes[0].textContent == "true" ? true : false;

            if (isIdDuplValid) {
              messageDiv.innerText = message.invalid2;
              messageDiv.classList.remove("valid-feedback");
              messageDiv.classList.add("invalid-feedback");
              isIdDuplValid = false;
            } else {
              messageDiv.innerText = message.valid;
              messageDiv.classList.add("valid-feedback");
              messageDiv.classList.remove("invalid-feedback");
              isIdDuplValid = true;
            }
          },
          error: function (xhr, status, error) {
            // 요청이 실패했을 때의 동작
            console.error("Request failed with status " + xhr.status);
          },
        });
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
      isPasswordConfirmValid = fields.password.value == fields.password2.value;
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
          phoneNumber.value = areaCode + "-" + firstPart + "-" + secondPart;
        }

        // 전화번호가 11자리일 때
        if (phoneNumber2.length === 11) {
          const areaCode = phoneNumber2.slice(0, 3);
          const firstPart = phoneNumber2.slice(3, 7);
          const secondPart = phoneNumber2.slice(7);
          phoneNumber.value = areaCode + "-" + firstPart + "-" + secondPart;
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
    }else if(!isAgreementChecked){
    	checkFunctions.agreementCheck();
    } 
    
    else {
      alert("모든 항목을 올바르게 입력해주세요.");
    }
  }

  sbmtBtn.addEventListener("click", submitForm);
