const str = "";

// Form
const inputForm = document.querySelector("#inputForm");
const modalIdInputForm = document.querySelector("#modalIdInputForm");
const modalPwInputForm = document.querySelector("#modalPwInputForm");

// Input
const formName = document.getElementById("formName");
const formId = document.getElementById("modalId");
const modalPw = document.getElementById("modalPw");
const modalPw2 = document.getElementById("modalPw2");
const pNum = document.getElementById("pNum");

/**  서브밋 버튼*/
const submitBtn = document.querySelector("#submitBtn");
const modalIdModifyBtn = document.querySelector("#modalIdModifyBtn");
const modalPwModifyBtn = document.querySelector("#modalPwModifyBtn");

// 정규식 관련 오브젝트
const regex = {
  // 아이디
  idReg: /^(?=.*[a-z])(?=.*\d)[a-z\d]{4,20}$/,

  // 패스워드
  pwReg:
    /^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*#?&])(?=.*\d)[A-Za-z\d$@$!%*#?&]{8,20}$/,

  // 이름
  nameReg: /^[가-힣]{2,50}$/,

  // 전화번호1
  pNumReg: /^\d{10,11}$/,
};

// 입력 사항 검증 함수들

/**  이름 검증 함수*/
let nameCheck = () => {
  let nameValue = formName.value;
  let message = document.querySelector("#userNameMessage");

  if (nameValue === str) {
    message.innerText = `*이름을 입력해주세요`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    formName.classList.remove("border-green");
    formName.classList.add("border-red");
    formName.focus();
  } else if (regex.nameReg.test(nameValue) && nameValue !== str) {
    message.innerText = "";
    message.classList.remove("invalid-feedback");
    message.classList.add("valid-feedback");
    formName.classList.remove("border-red");
    formName.classList.add("border-green");
    numCheck();
  } else if (!regex.nameReg.test(nameValue)) {
    message.innerText = `*${nameValue}는(은) 잘못된 형식의 이름입니다. (한글2자 이상)`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    formName.classList.remove("border-green");
    formName.classList.add("border-red");
  } else {
  }
};

// 휴대폰 번호 검증 함수
let numCheck = () => {
  let numValue = pNum.value;
  let pNumMessage = document.getElementById("pNumMessage");

  if (numValue === str) {
    pNumMessage.innerText = `*휴대폰 번호를 입력해주세요.`;
    pNumMessage.classList.remove("valid-feedback");
    pNumMessage.classList.add("invalid-feedback");
    pNum.classList.remove("border-green");
    pNum.classList.add("border-red");
    pNum.focus();
  } else if (isNaN(numValue)) {
    pNumMessage.innerText = `*숫자만 입력할 수 있습니다.`;
    pNumMessage.classList.remove("valid-feedback");
    pNumMessage.classList.add("invalid-feedback");
    pNum.classList.remove("border-green");
    pNum.classList.add("border-red");
  } else if (!regex.pNumReg.test(numValue)) {
    pNumMessage.innerText = `*올바른 형식이 아닙니다(10~11자리).`;
    pNumMessage.classList.remove("valid-feedback");
    pNumMessage.classList.add("invalid-feedback");
    pNum.classList.remove("border-green");
    pNum.classList.add("border-red");
  } else if (regex.pNumReg.test(numValue) && numValue !== str) {
    pNumMessage.innerText = "";
    pNumMessage.classList.remove("invalid-feedback");
    pNumMessage.classList.add("valid-feedback");
    pNum.classList.remove("border-red");
    pNum.classList.add("border-green");
    inputForm.submit();
  } else {
  }
};

// 아이디 검증 함수
let idCheck = () => {
  let userIdValue = formId.value;
  let message = document.querySelector("#modalIdMessage");

  if (userIdValue === str) {
    message.innerText = `*아이디를 입력해주세요`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    formId.classList.remove("border-green");
    formId.classList.add("border-red");
    formId.focus();
  } else if (regex.idReg.test(userIdValue) && userIdValue !== str) {
    message.innerText = "";
    message.classList.remove("invalid-feedback");
    message.classList.add("valid-feedback");
    formId.classList.remove("border-red");
    formId.classList.add("border-green");
    if (
      confirm(
        `${userIdValue}는(은) 사용할 수 있는 아이디입니다. 해당 아이디로 변경하시겠습니까?`
      ) === true
    ) {
      modalIdInputForm.submit();
      message.innerText = "";
      message.classList.remove("invalid-feedback");
      message.classList.remove("valid-feedback");
      formId.classList.remove("border-red");
      formId.classList.remove("border-green");
      modalIdInputForm.reset();
    }
  } else if (!regex.idReg.test(userIdValue)) {
    message.innerText = `*${userIdValue}는(은) 잘못된 형식의 아이디입니다. (소문자, 숫자 조합 4~20)`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    formId.classList.remove("border-green");
    formId.classList.add("border-red");
    // } else if() {
    //   message.innerText = `*${userIdValue}는(은) 이미 사용중인 아이디입니다.`;
    //   message.classList.remove("valid-feedback");
    //   message.classList.add("invalid-feedback");
    //   formId.classList.remove("border-green");
    //   formId.classList.add("border-red");
    // }
  } else {
  }
};

// 비밀번호 검증 함수
let pwCheck = () => {
  let userPwValue = modalPw.value;
  let message = document.querySelector("#modalPwMessage");

  if (userPwValue === str) {
    message.innerText = `*비밀번호를 입력해주세요.`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    modalPw.classList.remove("border-green");
    modalPw.classList.add("border-red");
    modalPw.focus();
  } else if (regex.pwReg.test(userPwValue) && userPwValue !== str) {
    message.innerText = "";
    message.classList.remove("invalid-feedback");
    message.classList.add("valid-feedback");
    modalPw.classList.remove("border-red");
    modalPw.classList.add("border-green");
    alert("성공/ 원래는 서버에서 입력값을 비교하고 이동시켜야함.");
    location.href = "/pwReset.html";

    modalPwInputForm.reset();

    message.innerText = "";
    message.classList.remove("invalid-feedback");
    message.classList.remove("valid-feedback");
    modalPw.classList.remove("border-red");
    modalPw.classList.remove("border-green");
    modalPw2.classList.remove("border-red");
    modalPw2.classList.remove("border-green");
  } else if (!regex.pwReg.test(userPwValue)) {
    message.innerText = `*잘못된 형식의 비밀번호입니다. (대소문자, 특수문자, 숫자 조합 8~20)`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    modalPw.classList.remove("border-green");
    modalPw.classList.add("border-red");
  } else {
  }
};

// 두 번째 비밀번호 검증 함수
let secondPwCheck = () => {
  let firstPwValue = modalPw.value;
  let secondPwValue = modalPw2.value;
  let firstPwMessage = document.querySelector("#modalPwMessage");
  let secondPwMessage = document.querySelector("#modalPwMessage2");

  if (secondPwValue === str) {
    secondPwMessage.innerText = `*비밀번호를 입력해주세요.`;
    secondPwMessage.classList.remove("valid-feedback");
    secondPwMessage.classList.add("invalid-feedback");
    modalPw2.classList.remove("border-green");
    modalPw2.classList.add("border-red");
    modalPw2.focus();
  } else if (firstPwValue === secondPwValue) {
    secondPwMessage.innerText = "";
    secondPwMessage.classList.remove("invalid-feedback");
    secondPwMessage.classList.add("valid-feedback");
    modalPw2.classList.remove("border-red");
    modalPw2.classList.add("border-green");
    alert("성공/ 원래는 서버에서 입력값을 비교하고 이동시켜야함.");
    location.href = "/pwReset.html";

    modalPwInputForm.reset();

    firstPwMessage.innerText = "";
    secondPwMessage.innerText = "";
    firstPwMessage.classList.remove("invalid-feedback");
    firstPwMessage.classList.remove("valid-feedback");
    secondPwMessage.classList.remove("invalid-feedback");
    secondPwMessage.classList.remove("valid-feedback");
    modalPw.classList.remove("border-red");
    modalPw.classList.remove("border-green");
    modalPw2.classList.remove("border-red");
    modalPw2.classList.remove("border-green");
  } else if (firstPwValue !== secondPwValue) {
    secondPwMessage.innerText = `*비밀번호가 일치하지 않습니다.`;
    secondPwMessage.classList.remove("valid-feedback");
    secondPwMessage.classList.add("invalid-feedback");
    modalPw2.classList.remove("border-green");
    modalPw2.classList.add("border-red");
  } else {
  }
};

// 우편번호 찾기
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
        document.getElementById("doromyung").value = roadAddr;
        document.getElementById("jibeon").value = jibunAddr;
      } else if (jibunAddr !== "") {
        document.getElementById("doromyung").value = roadAddr;
        document.getElementById("jibeon").value = jibunAddr;
      }
    },
  }).open();
}

// 모달 관련
const modal = document.querySelector("#modalWrap");
const modal2 = document.querySelector("#modalWrap2");
const closeBtn = document.querySelector("#closeBtn");
const closeBtn2 = document.querySelector("#closeBtn2");

// 아이디 변경 모달
document.getElementById("modifyIdBtn").onclick = () => openModal();

// 비밀번호 변경 모달
document.getElementById("modifyPwBtn").onclick = () => openModal2();

// 모달
let openModal = () => {
  modal.style.display = "block";

  closeBtn.addEventListener("click", closeModal);
};

let openModal2 = () => {
  modal2.style.display = "block";

  closeBtn2.addEventListener("click", closeModal2);
};

let closeModal = () => {
  let message = document.querySelector("#modalIdMessage");

  modal.style.display = "none";
  modalIdInputForm.reset();
  message.innerText = "";

  message.classList.remove("invalid-feedback");
  message.classList.remove("valid-feedback");
  formId.classList.remove("border-red");
  formId.classList.remove("border-green");
};

let closeModal2 = () => {
  let firstPwMessage = document.querySelector("#modalPwMessage");

  modal2.style.display = "none";
  modalPwInputForm.reset();

  firstPwMessage.innerText = "";
  firstPwMessage.classList.remove("invalid-feedback");
  firstPwMessage.classList.remove("valid-feedback");
  modalPw.classList.remove("border-red");
  modalPw.classList.remove("border-green");
};

// 입력 사항 검증 함수 실행
submitBtn.addEventListener("click", nameCheck);
modalIdModifyBtn.addEventListener("click", idCheck);
modalPwModifyBtn.addEventListener("click", pwCheck);
