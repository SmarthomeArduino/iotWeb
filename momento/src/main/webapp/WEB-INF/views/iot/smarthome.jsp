<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous">

<!-- 차트 링크 -->
<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
<title>Document</title>
</head>
<body style="background-color: #71C9CE">

	<h1>스마트홈 제어 시스템</h1>
	<hr>
	<div>
		<h2>LED 제어</h2>

		<button type='button' data-bs-toggle="button" autocomplete="off"
			class="btn btn-danger btn-lg btn-block" data-led="R1"
			onclick="toggleLED(this)">R1</button>
		<button type='button' data-bs-toggle="button" autocomplete="off"
			class="btn btn-success btn-lg btn-block" data-led="G1"
			onclick="toggleLED(this)">G1</button>
		<button type='button' data-bs-toggle="button" autocomplete="off"
			class="btn btn-primary btn-lg btn-block" data-led="B1"
			onclick="toggleLED(this)">B1</button>
		<button type='button' data-bs-toggle="button" autocomplete="off"
			class="btn btn-danger btn-lg btn-block" data-led="R2"
			onclick="toggleLED(this)">R2</button>
		<button type='button' data-bs-toggle="button" autocomplete="off"
			class="btn btn-success btn-lg btn-block" data-led="G2"
			onclick="toggleLED(this)">G2</button>
		<button type='button' data-bs-toggle="button" autocomplete="off"
			class="btn btn-primary btn-lg btn-block" data-led="B2"
			onclick="toggleLED(this)">B2</button>
	</div>

	<hr>


	<h1>온습도 데이터 ${tempHumi.formattedTimestamp}</h1>
	<p>온도: ${tempHumi.temperature} ℃</p>
	<p>습도: ${tempHumi.humidity} %</p>
	<p>data: ${dateTempHumi[0].temperature}</p>
	


	<input type="date" id="selectedDate" name="timestamp" class="form-control"
		style="width: 150px">


	<div style="display: flex">
		<div class="container">
			<canvas id="myChart"></canvas>
		</div>

		<div class="container">
			<canvas id="myChart2"></canvas>
		</div>
	</div>

	<script>
	var labels = [];
	var temperatureData = [];

	
	 const selectedDate = document.getElementById("selectedDate");
	
    // Get current date in the format "yyyy-mm-dd"
    const today = new Date().toISOString().split('T')[0];

    // Set the default value of the date input to today's date
    selectedDate.value = today;
    
    
    function handleDateInput(event){
    	console.log(event.target.value);
    	
        $.ajax({
            url: "/iot/smarthome/hourlyTemperatureData",
            type: "POST",
			contentType : "application/json",
			data : event.target.value,
            success: function(data) {
                // 데이터를 받아와서 그래프 그리는 함수 호출
                /* drawTemperatureChart(data); */
                console.log(data);
            },
            error: function(error) {
                console.log("Error:", error);
            }
        });
    }
    
    
    selectedDate.addEventListener("input", handleDateInput);
	
		var ctx = document.getElementById('myChart').getContext('2d');
		
		var labels = [];
		
		for(let i =0; i<24; i++){
			labels[i] = i +':00';
		}
	
		
		
		var chart = new Chart(ctx, {
			// 챠트 종류를 선택
			type : 'line',

			// 챠트를 그릴 데이타
			data : {
				labels,
				datasets : [ {
					label : '온도',
					backgroundColor : 'transparent',
					borderColor : 'red',
					data : [ 0, 10, 5, 2, 20, 30, 45 ]
				} ]
			},
			// 옵션
			options : {}
		}); 
		
		var ctx2 = document.getElementById('myChart2').getContext('2d');
		var chart = new Chart(ctx2, {
			// 챠트 종류를 선택
			type : 'line',

			// 챠트를 그릴 데이타
			data : {
				labels,
				datasets : [ {
					label : '습도',
					backgroundColor : 'transparent',
					borderColor : 'blue',
					data : [ 0, 10, 5, 2, 20, 30, 45 ]
				} ]
			},
			// 옵션
			options : {}
		});
		
	</script>


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
	<!-- Bootstrap JS CDN -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
		crossorigin="anonymous">
		
	</script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>
</body>

</html>
