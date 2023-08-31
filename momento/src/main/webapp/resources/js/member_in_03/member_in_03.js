const str = "";

// 인풋 폼
const inputForm = document.querySelector("#inputForm");

// 페이지 내 인풋
const userName = document.querySelector("#userName");
const phone = document.querySelector("#phone");

// 정규식 (이름)
const nameReg = /^[가-힣]{2,50}$/;
// 정규식(전화번호)
const phoneReg = /^01([0|1|6|7|8|9])-?([0-9]{3,4})-?([0-9]{4})$/;

// 이름 검증
let nameCheck = (e) => {
  e.preventDefault();
  let nameValue = userName.value;
  let message = document.querySelector("#nameMessage");

  if (nameValue === str) {
    message.innerText = `*이름을 입력해주세요`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    userName.classList.remove("border-green");
    userName.classList.add("border-red");
    userName.focus();
  } else if (nameReg.test(nameValue) && nameValue !== str) {
    message.innerText = "";
    message.classList.remove("invalid-feedback");
    message.classList.add("valid-feedback");
    userName.classList.remove("border-red");
    userName.classList.add("border-green");
    phone.focus();
    phoneCheck();
  } else if (!nameReg.test(nameValue)) {
    message.innerText = `*${nameValue}는(은) 잘못된 형식의 이름입니다. (한글2자 이상)`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    userName.classList.remove("border-green");
    userName.classList.add("border-red");
    userName.focus();
  } else {
  }
};

let phoneCheck = () => {
  let phonevalue = phone.value;
  let message = document.querySelector("#phoneMessage");
  if (!phoneReg.test(phonevalue)) {
    message.innerText = `*잘못된 형식의 전화번호입니다.`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    phone.classList.remove("border-green");
    phone.classList.add("border-red");
  } else {
  	inputForm.submit();
  }
};

// 메인 함수 실행 이벤트
inputForm.addEventListener("submit", nameCheck);
