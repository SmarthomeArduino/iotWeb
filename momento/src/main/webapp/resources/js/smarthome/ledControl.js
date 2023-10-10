/**
 *
 */
function toggleLED(event) {
  const selectedLed = event.dataset.led;
  console.log(event.dataset.led);
  // 보낼 데이터 생성
  const data = {
    led: selectedLed,
  };

  // 서버로 데이터를 보내는 AJAX 요청
  $.ajax({
    type: "POST",
    url: "/iot/smarthome/led",
    contentType: "application/json",
    data: JSON.stringify(data),
    success: function (response) {
      // 성공적으로 응답을 받았을 때의 동작
      console.log(response);
    },
    error: function (xhr, status, error) {
      // 요청이 실패했을 때의 동작
      console.error("Request failed with status " + xhr.status);
    },
  });
}
