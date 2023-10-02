<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<title>Document</title>
</head>
<body>

	<h1>스마트홈 제어 시스템</h1>
	<hr>
	<div>
		<h2>LED 제어</h2>
		<button data-led="R1" onclick="toggleLED(this)">R1</button>
		<button data-led="G1" onclick="toggleLED(this)">G1</button>
		<button data-led="B1" onclick="toggleLED(this)">B1</button>
		<button data-led="R2" onclick="toggleLED(this)">R2</button>
		<button data-led="G2" onclick="toggleLED(this)">G2</button>
		<button data-led="B2" onclick="toggleLED(this)">B2</button>
	</div>

	<!-- JavaScript 코드를 포함하는 부분 -->
	<script>
		function toggleLED(event) {
			const selectedLed = event.dataset.led;
			console.log(event.dataset.led);
			// 보낼 데이터 생성
			const data = {
				led : selectedLed
			};

			// 서버로 데이터를 보내는 AJAX 요청
			$.ajax({
				type : "POST",
				url : "/iot/smarthome/led",
				contentType : "application/json",
				data : JSON.stringify(data),
				success : function(response) {
					// 성공적으로 응답을 받았을 때의 동작
					console.log(response);
				},
				error : function(xhr, status, error) {
					// 요청이 실패했을 때의 동작
					console.error('Request failed with status ' + xhr.status);
				}
			});
		}
	</script>
</body>
</html>
