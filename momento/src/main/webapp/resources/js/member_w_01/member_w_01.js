let str = "";

//폼 태그
const inputForm = document.getElementById("inputForm");

//폼 태그 내부 인풋
const userId = document.querySelector("#id");
const userPw = document.querySelector("#pw");
const userPw2 = document.querySelector("#pw2");
const userName = document.querySelector("#name");
const phoneNumber = document.querySelector("#phoneNumber");
const qAnswer = document.querySelector("#qAnswer");
const zipcode = document.querySelector("#zipcode");
const address1 = document.querySelector("#address1");
const address2 = document.querySelector("#address2");
const addressDetail = document.querySelector("#addressDetail");
const agreement = document.querySelector("#agreement");
const phone = document.querySelector("#phone");
const addr = document.querySelector("#addr");

// 폼 태그 외부 버튼
const sbmtBtn = document.querySelector("#submitBtn");

const regex = {
  idReg: /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,20}$/,
  pwReg:
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*#?&])(?=.*\d)[A-Za-z\d$@$!%*#?&]{8,20}$/,
  nameReg: /^[가-힣]{2,50}$/,
  phoneReg: /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/,
};

const checkFunctions = {
  namecheck: function () {
    let nameValue = userName.value;
    let message = document.querySelector("#nameMessage");
    if (nameValue === str) {
      message.innerText = `*이름을 입력해주세요`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userName.classList.remove("border-green");
      userName.classList.add("border-red");
      userName.focus();
    } else if (regex.nameReg.test(nameValue) && nameValue !== str) {
      message.innerText = `${nameValue}는(은) 사용할 수 있는 이름입니다.`;
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      userName.classList.remove("border-red");
      userName.classList.add("border-green");
      checkFunctions.idCheck();
    } else if (!regex.nameReg.test(nameValue)) {
      message.innerText = `*${nameValue}는(은) 잘못된 형식의 이름입니다. (한글2자 이상)`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userName.classList.remove("border-green");
      userName.classList.add("border-red");
      userName.focus();
    } else {
    }
  },
  //아이디 체크 함수(중복 체크 로직 추가해야됨)
  idCheck: function () {
    let userIdValue = userId.value;
    let message = document.querySelector("#userIdMessage");
    if (userIdValue === str) {
      message.innerText = `*아이디를 입력해주세요`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userId.classList.remove("border-green");
      userId.classList.add("border-red");
      userId.focus();
    } else if (regex.idReg.test(userIdValue) && userIdValue !== str) {
      message.innerText = `${userIdValue}는(은) 사용할 수 있는 아이디입니다.`;
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      userId.classList.remove("border-red");
      userId.classList.add("border-green");
      checkFunctions.pwCheck();
    } else if (!regex.idReg.test(userIdValue)) {
      message.innerText = `*${userIdValue}는(은) 잘못된 형식의 아이디입니다. (소문자, 숫자 조합 4~20)`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userId.classList.remove("border-green");
      userId.classList.add("border-red");
      userId.focus();
      // } else if() {
      //   message.innerText = `*${userIdValue}는(은) 이미 사용중인 아이디입니다.`;
      //   message.classList.remove("valid-feedback");
      //   message.classList.add("invalid-feedback");
      //   userId.classList.remove("border-green");
      //   userId.classList.add("border-red");
      // }
    } else {
    }
  },
  pwCheck: function () {
    let userPwValue = userPw.value;
    let message = document.querySelector("#userPwMessage");
    if (userPwValue === str) {
      message.innerText = `*비밀번호를 입력해주세요.`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userPw.classList.remove("border-green");
      userPw.classList.add("border-red");
    } else if (regex.pwReg.test(userPwValue) && userPwValue !== str) {
      message.innerText = `사용할 수 있는 비밀번호입니다.`;
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      userPw.classList.remove("border-red");
      userPw.classList.add("border-green");
      checkFunctions.pwDoubleCheck();
    } else if (!regex.pwReg.test(userPwValue)) {
      message.innerText = `*잘못된 형식의 비밀번호입니다. (대소문자, 특수문자, 숫자 조합 8~20)`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userPw.classList.remove("border-green");
      userPw.classList.add("border-red");
    } else {
    }
  }, //비밀번호 재입력 체크 함수
  pwDoubleCheck: function () {
    let userPwValue = userPw.value;
    let userPwValue2 = userPw2.value;
    let message = document.querySelector("#userPwMessage2");

    if (userPwValue2 === str) {
      message.innerText = `*비밀번호를 입력해주세요.`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userPw2.classList.remove("border-green");
      userPw2.classList.add("border-red");
    } else if (userPwValue2 !== userPwValue) {
      message.innerText = `*비밀번호가 다릅니다.`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userPw2.classList.remove("border-green");
      userPw2.classList.add("border-red");
    } else if (
      userPwValue2 !== str &&
      userPwValue2 === userPwValue &&
      regex.pwReg.test(userPwValue2)
    ) {
      message.innerText = `비밀번호 설정 완료`;
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      userPw2.classList.remove("border-red");
      userPw2.classList.add("border-green");
      checkFunctions.phoneCheck();
    } else if (!regex.pwReg.test(userPwValue)) {
      message.innerText = `*잘못된 형식의 비밀번호입니다. (대소문자, 특수문자, 숫자 조합 8~20)`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userPw2.classList.remove("border-green");
      userPw2.classList.add("border-red");
    } else {
    }
  },
  phoneCheck: function () {
    let phoneNumbervalue = phoneNumber.value;
    let message = document.querySelector("#phoneMessage");
    if (!regex.phoneReg.test(phoneNumbervalue)) {
      message.innerText = `*잘못된 형식의 전화번호입니다.`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      userPw2.classList.remove("border-green");
      userPw2.classList.add("border-red");
    } else {
      checkFunctions.addressCheck();
    }
  },

  addressCheck: function () {
    let zipcodeValue = zipcode.value;
    let message = document.querySelector("#addressMessage");

    if (zipcodeValue === str) {
      message.innerText = `*주소를 선택해 주세요`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
    } else if (zipcodeValue !== str) {
      message.innerText = "";
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      checkFunctions.qAnswerCheck();
    } else {
    }
  },
  qAnswerCheck: function () {
    let message = document.querySelector("#qAnswerMessage");
    if (qAnswer.value === str) {
      message.innerText = `*질문 답변을 입력해주세요.`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
      qAnswer.classList.remove("border-green");
      qAnswer.classList.add("border-red");
    } else if (qAnswer.value !== str) {
      message.innerText = "";
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      qAnswer.classList.remove("border-red");
      qAnswer.classList.add("border-green");
      checkFunctions.agreementCheck();
    } else {
    }
  },
  agreementCheck: function () {
    let message = document.querySelector("#agreementMessage");
    if (!agreement.checked) {
      message.innerText = `*이용 약관에 동의하셔야합니다.`;
      message.classList.remove("valid-feedback");
      message.classList.add("invalid-feedback");
    } else if (agreement.checked) {
      message.innerText = "";
      message.classList.remove("invalid-feedback");
      message.classList.add("valid-feedback");
      test();
    } else {
    }
  },
};

function test() {
  let phoneNumber2 = phoneNumber.value;
  // 전화번호가 10자리일 때
  if (phoneNumber2.length === 10) {
    const areaCode = phoneNumber2.slice(0, 3);
    const firstPart = phoneNumber2.slice(3, 6);
    const secondPart = phoneNumber2.slice(6);

    phone.value = `${areaCode}-${firstPart}-${secondPart}`;
  }

  // 전화번호가 11자리일 때

  if (phoneNumber2.length === 11) {
    const areaCode = phoneNumber2.slice(0, 3);
    const firstPart = phoneNumber2.slice(3, 7);
    const secondPart = phoneNumber2.slice(7);
    phone.value = `${areaCode}-${firstPart}-${secondPart}`;
    alert(phone.value);
  }
  addr.value =
    zipcode.value +
    "/" +
    address1.value +
    "/" +
    address2.value +
    "/" +
    addressDetail.value;
  inputForm.submit();
}

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
      document.getElementById("zipcode").value = data.zonecode;
      if (roadAddr !== "") {
        document.getElementById("address1").value = roadAddr;
        document.getElementById("address2").value = jibunAddr;
      } else if (jibunAddr !== "") {
        document.getElementById("address1").value = roadAddr;
        document.getElementById("address2").value = jibunAddr;
      }
    },
  }).open();
}

sbmtBtn.addEventListener("click", checkFunctions.namecheck);
