<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />



<!-- Bootstrap CSS -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.1/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-+0n0xVW2eSR5OomGNYDnhzAbDsOXxcvSN1TPprVMTNDbiYZCxYbOOl7+AMvyTG2x"
	crossorigin="anonymous" />

<link href="/resources/css/smarthome/smarthome.css" rel="stylesheet">

<title>스마트홈</title>
</head>
<body>
	<div class="wrapper">
		<header>
			<h1>스마트홈 모니터링 시스템</h1>
		</header>
		<hr />
		<div>
			<h3>LED 제어</h3>

			<button type="button" data-bs-toggle="button" autocomplete="off"
				class="btn btn-danger btn-lg btn-block" data-led="R1"
				onclick="toggleLED(this)">R1</button>
			<button type="button" data-bs-toggle="button" autocomplete="off"
				class="btn btn-success btn-lg btn-block" data-led="G1"
				onclick="toggleLED(this)">G1</button>
			<button type="button" data-bs-toggle="button" autocomplete="off"
				class="btn btn-primary btn-lg btn-block" data-led="B1"
				onclick="toggleLED(this)">B1</button>
			<button type="button" data-bs-toggle="button" autocomplete="off"
				class="btn btn-danger btn-lg btn-block" data-led="R2"
				onclick="toggleLED(this)">R2</button>
			<button type="button" data-bs-toggle="button" autocomplete="off"
				class="btn btn-success btn-lg btn-block" data-led="G2"
				onclick="toggleLED(this)">G2</button>
			<button type="button" data-bs-toggle="button" autocomplete="off"
				class="btn btn-primary btn-lg btn-block" data-led="B2"
				onclick="toggleLED(this)">B2</button>
		</div>

		<hr />

		<div style="margin-bottom: 10px;">
			<h3>온습도 차트 ${tempHumi.formattedTimestamp}</h3>
			<div>온도: ${tempHumi.temperature} ℃</div>
			<div>습도: ${tempHumi.humidity} %</div>
		</div>

		<input type="date" id="selectedDate" name="timestamp"
			class="form-control" style="width: 150px" />

		<div style="display: flex">
			<div class="container">
				<canvas id="myChart"></canvas>
			</div>

			<div class="container">
				<canvas id="myChart2"></canvas>
			</div>
		</div>

	</div>


	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
	<!-- Bootstrap JS CDN -->
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.0/dist/js/bootstrap.bundle.min.js"
		integrity="sha384-U1DAWAznBHeqEIlVSCgzq+c9gqGAJn5c/t99JyeKa9xxaYpSvHU5awsuZVVFIhvj"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.7/umd/popper.min.js"
		integrity="sha384-UO2eT0CpHqdSJQ6hJty5KVphtPhzWj9WO1clHTMGa3JDZwrnQq4sF86dIHNDz0W1"
		crossorigin="anonymous"></script>
	<script
		src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"
		integrity="sha384-JjSmVgyd0p3pXB1rRibZUAYoIIy6OrQ6VrjIEaFf/nJGzIxFDsf4x0xIM+B07jRM"
		crossorigin="anonymous"></script>

	<!-- 차트 링크 -->
	<script src="https://cdn.jsdelivr.net/npm/chart.js@2.8.0"></script>
	<!-- 스마트홈 온습도 Chart -->
	<script src="/resources/js/smarthome/tempHumiChart.js"></script>
	<!-- 스마트홈 Led Control -->
	<script src="/resources/js/smarthome/ledControl.js"></script>

</body>
</html>
