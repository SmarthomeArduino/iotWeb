const str = "";

// 첫 번째, 두 번째 비밀번호 인풋
const firstPw = document.getElementById("newPw");
const secondPw = document.getElementById("newPw2");

// 각각 메시지를 띄우기 위한 영역
const firstPwMessage = document.getElementById("userNewPwMessage");
const secondPwMessage = document.getElementById("userNewPwMessage2");

// 폼
const resetPwForm = document.getElementById("resetPwForm");

const pwReg =
  /^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*#?&])(?=.*\d)[A-Za-z\d$@$!%*#?&]{8,20}$/;

// 첫 번째 비밀번호 체크
let pwCheck = () => {
  let firstPwValue = firstPw.value;

  if (firstPwValue === str) {
    firstPw.focus();
    firstPwMessage.innerText = `*비밀번호를 입력해주세요.`;
    firstPwMessage.classList.remove("valid-feedback");
    firstPwMessage.classList.add("invalid-feedback");
    firstPw.classList.remove("border-green");
    firstPw.classList.add("border-red");
  } else if (pwReg.test(firstPwValue) && firstPwValue !== str) {
    firstPwMessage.innerText = "";
    firstPwMessage.classList.remove("invalid-feedback");
    firstPwMessage.classList.add("valid-feedback");
    firstPw.classList.remove("border-red");
    firstPw.classList.add("border-green");
    secondPw.focus();
    secondPwCheck();
  } else if (!pwReg.test(firstPwValue)) {
    firstPwMessage.innerText = `*잘못된 형식의 비밀번호입니다. (대소문자, 특수문자, 숫자 조합 8~20)`;
    firstPwMessage.classList.remove("valid-feedback");
    firstPwMessage.classList.add("invalid-feedback");
    firstPw.classList.remove("border-green");
    firstPw.classList.add("border-red");
  }
};

// 두 번째 비밀번호 체크
let secondPwCheck = () => {
  let firstPwValue = firstPw.value;
  let secondPwValue = secondPw.value;

  if (secondPwValue === str) {
    console.log(secondPwValue);
    secondPwMessage.innerText = `*비밀번호를 입력해주세요.`;
    secondPwMessage.classList.remove("valid-feedback");
    secondPwMessage.classList.add("invalid-feedback");
    secondPw.classList.remove("border-green");
    secondPw.classList.add("border-red");
  } else if (firstPwValue === secondPwValue) {
    secondPwMessage.innerText = "";
    secondPwMessage.classList.remove("invalid-feedback");
    secondPwMessage.classList.add("valid-feedback");
    secondPw.classList.remove("border-red");
    secondPw.classList.add("border-green");
    resetPwForm.submit();
  } else if (firstPwValue !== secondPwValue) {
    secondPwMessage.innerText = `*비밀번호가 일치하지 않습니다.`;
    secondPwMessage.classList.remove("valid-feedback");
    secondPwMessage.classList.add("invalid-feedback");
    secondPw.classList.remove("border-green");
    secondPw.classList.add("border-red");
  }
};

document.getElementById("submitBtn").addEventListener("click", pwCheck);

// 아이콘 조작 관련
const icon = document.querySelector("#icon");
const icon2 = document.querySelector("#icon2");

const eye = `<i class="fa-regular fa-eye"></i>`;
const slashEye = `<i class="fa-regular fa-eye-slash"></i>`;

let toggleIcon = () => {
  if (icon.innerHTML === eye) {
    icon.innerHTML = slashEye;
    newPw.type = "text";
  } else {
    icon.innerHTML = eye;
    newPw.type = "password";
  }
};

let toggleIcon2 = () => {
  if (icon2.innerHTML === eye) {
    icon2.innerHTML = slashEye;
    newPw2.type = "text";
  } else {
    icon2.innerHTML = eye;
    newPw2.type = "password";
  }
};

icon.addEventListener("click", toggleIcon);
icon2.addEventListener("click", toggleIcon2);

// console.dir(icon);
