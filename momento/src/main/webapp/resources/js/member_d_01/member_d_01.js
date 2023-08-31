const str1 = "";

/** 회원 탈퇴 버튼 */
const dBtn = document.getElementById("dBtn");

/** 체크 박스 관련 */
const agreement = document.getElementById("agreement");
const agreementMessage = document.getElementById("agreementMessage");

/** textarea */
const textarea = document.getElementById("deleteTextarea");

/** 비밀번호 */
const pw = document.getElementById("pwCheck");

// 정규식
const reg =
  /^(?=.*[a-z])(?=.*[A-Z])(?=.*[$@$!%*#?&])(?=.*\d)[A-Za-z\d$@$!%*#?&]{8,20}$/;

// 회원 탈퇴 안내
textarea.innerHTML = `1. 회원 탈퇴와 함께 등록된 회원님의 모든 개인정보는 삭제, 폐기 처리되며 복구되지 않습니다.

2. 탈퇴 이후 회원님의 개인 정보는 더이상 보관되거나 관리되지 않습니다.

3. 게시판형 서비스에 등록한 게시물과 댓글은 탈퇴 후에도 남아 있습니다. 
글이 남아 있는 것을 원치 않는다면 비공개 또는 삭제 후 탈퇴하세요.`;

/** 이용 안내 체크 유무에 따라 회원 탈퇴 버튼을 활성화, 비활성화 해주는 함수 */
let btnDisabled = () => {
  if (agreement.checked) {
    dBtn.disabled = false;
    agreementMessage.innerText = "";
  } else if (!agreement.checked) {
    dBtn.disabled = true;
    agreementMessage.innerText = `*회원 탈퇴 안내를 읽고 체크해주세요.`;
    agreementMessage.classList.remove("valid-feedback");
    agreementMessage.classList.add("invalid-feedback");
  } else {
  }
};

/* 어그리먼트 메시지에 최초 스타일 적용 */
agreementMessage.classList.remove("valid-feedback");
agreementMessage.classList.add("invalid-feedback");

// 버튼 체크 감지 함수
agreement.addEventListener("click", btnDisabled);

/** 비밀번호를 검증하고 회원 탈퇴를 위한 입력값을 전달해주는 함수 */
let deleteUser = () => {
  let message = document.getElementById("userDeletePwMessage");
  if (pw.value === str1) {
    message.innerText = `*비밀번호를 입력해주세요.`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    pw.classList.remove("border-green");
    pw.classList.add("border-red");
  } else if (!reg.test(pw.value)) {
    message.innerText = `*잘못된 형식의 비밀번호입니다. (대소문자, 특수문자, 숫자 조합 8~20)`;
    message.classList.remove("valid-feedback");
    message.classList.add("invalid-feedback");
    pw.classList.remove("border-green");
    pw.classList.add("border-red");
  } else if (reg.test(pw.value)) {
    message.innerText = "";
    message.classList.remove("invalid-feedback");
    message.classList.add("valid-feedback");
    pw.classList.remove("border-red");
    pw.classList.add("border-green");
    document.getElementById("deleteUserForm").submit();
  } else {
  }
};

// 회원 탈퇴 버튼 클릭 시, 검증 함수 실행
dBtn.addEventListener("click", deleteUser);
