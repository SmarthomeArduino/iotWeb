const str = "";

// 폼
const inputForm = document.getElementById("inputForm");

// 버튼
const submitBtn = document.getElementById("submitBtn");

// 입력 사항
const userId = document.getElementById("id");
const secondNum = document.getElementById("pNum");
const thirdNum = document.getElementById("pNum2");
const qAnswer = document.getElementById("qAnswer");

// 안내 메시지
const userIdMessage = document.getElementById("userIdMessage");
const pNumMessage = document.getElementById("pNumMessage");
const pNumMessage2 = document.getElementById("pNumMessage2");
const qAnswerMessage = document.getElementById("qAnswerMessage");

// 정규식
const regex = {
  // 아이디
  idReg: /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,20}$/,

  // 전화번호1
  pNumReg: /^\d{3,4}$/,

  // 전화번호2
  pNumReg2: /^\d{4}$/,
};

let idCheck = () => {
  let userIdValue = userId.value;

  if (userIdValue === str) {
    userIdMessage.innerText = `*아이디를 입력해주세요`;
    userIdMessage.classList.remove("valid-feedback");
    userIdMessage.classList.add("invalid-feedback");
    userId.classList.remove("border-green");
    userId.classList.add("border-red");
  } else if (regex.idReg.test(userIdValue) && userIdValue !== str) {
    userIdMessage.innerText = "";
    userIdMessage.classList.remove("invalid-feedback");
    userIdMessage.classList.add("valid-feedback");
    userId.classList.remove("border-red");
    userId.classList.add("border-green");
    secondNum.focus();
    secondNumCheck();
  } else if (!regex.idReg.test(userIdValue)) {
    userIdMessage.innerText = `*${userIdValue}는(은) 잘못된 형식의 아이디입니다. (소문자, 숫자 조합 4~20)`;
    userIdMessage.classList.remove("valid-feedback");
    userIdMessage.classList.add("invalid-feedback");
    userId.classList.remove("border-green");
    userId.classList.add("border-red");
  } else {
  }
};

let secondNumCheck = () => {
  let secondNumValue = secondNum.value;

  if (secondNumValue === str) {
    pNumMessage.innerText = `*전화번호를 입력해주세요.`;
    pNumMessage.classList.remove("valid-feedback");
    pNumMessage.classList.add("invalid-feedback");
    secondNum.classList.remove("border-green");
    secondNum.classList.add("border-red");
  } else if (isNaN(secondNumValue)) {
    pNumMessage.innerText = `*숫자만 입력가능합니다.`;
    pNumMessage.classList.remove("valid-feedback");
    pNumMessage.classList.add("invalid-feedback");
    secondNum.classList.remove("border-green");
    secondNum.classList.add("border-red");
  } else if (!regex.pNumReg.test(secondNumValue)) {
    pNumMessage.innerText = `*올바른 형식이 아닙니다(3~4자리).`;
    pNumMessage.classList.remove("valid-feedback");
    pNumMessage.classList.add("invalid-feedback");
    secondNum.classList.remove("border-green");
    secondNum.classList.add("border-red");
  } else if (regex.pNumReg.test(secondNumValue) && secondNumValue !== str) {
    pNumMessage.innerText = "";
    pNumMessage.classList.remove("invalid-feedback");
    pNumMessage.classList.add("valid-feedback");
    secondNum.classList.remove("border-red");
    secondNum.classList.add("border-green");
    thirdNum.focus();
    thirdNumCheck();
  } else {
  }
};

let thirdNumCheck = () => {
  let thirdNumValue = thirdNum.value;

  if (thirdNumValue === str) {
    pNumMessage2.innerText = `*전화번호를 입력해주세요.`;
    pNumMessage2.classList.remove("valid-feedback");
    pNumMessage2.classList.add("invalid-feedback");
    thirdNum.classList.remove("border-green");
    thirdNum.classList.add("border-red");
  } else if (isNaN(thirdNumValue)) {
    pNumMessage2.innerText = `*숫자만 입력가능합니다.`;
    pNumMessage2.classList.remove("valid-feedback");
    pNumMessage2.classList.add("invalid-feedback");
    thirdNum.classList.remove("border-green");
    thirdNum.classList.add("border-red");
  } else if (!regex.pNumReg.test(thirdNumValue)) {
    pNumMessage2.innerText = `*올바른 형식이 아닙니다(4자리).`;
    pNumMessage2.classList.remove("valid-feedback");
    pNumMessage2.classList.add("invalid-feedback");
    thirdNum.classList.remove("border-green");
    thirdNum.classList.add("border-red");
  } else if (regex.pNumReg.test(thirdNumValue) && thirdNumValue !== str) {
    pNumMessage2.innerText = "";
    pNumMessage2.classList.remove("invalid-feedback");
    pNumMessage2.classList.add("valid-feedback");
    thirdNum.classList.remove("border-red");
    thirdNum.classList.add("border-green");
    qAnswer.focus();
    qAnswerCheck();
  } else {
  }
};

let qAnswerCheck = () => {
  if (qAnswer.value === str) {
    qAnswerMessage.innerText = `*질문 답변을 입력해주세요.`;
    qAnswerMessage.classList.remove("valid-feedback");
    qAnswerMessage.classList.add("invalid-feedback");
    qAnswer.classList.remove("border-green");
    qAnswer.classList.add("border-red");
  } else if (qAnswer.value !== str) {
    qAnswerMessage.innerText = "";
    qAnswerMessage.classList.remove("invalid-feedback");
    qAnswerMessage.classList.add("valid-feedback");
    qAnswer.classList.remove("border-red");
    qAnswer.classList.add("border-green");
    inputForm.submit();
    // location.href = "/pwReset.html";
  } else {
  }
};

// 최종적으로는 값을 비교해서 일치하면 비밀번호 재설정 페이지와 연결시켜주면 됩니다.

submitBtn.addEventListener("click", idCheck);
