/**
 *
 */
var labels = [];

const selectedDate = document.getElementById("selectedDate");
const today = new Date().toISOString().split("T")[0];
selectedDate.value = today;

function parseXML(xmlString) {
  var parser = new DOMParser();
  var xmlDoc = parser.parseFromString(xmlString, "text/xml");

  var items = xmlDoc.getElementsByTagName("item");
  var data = [];
  // 각 item에서 필요한 정보를 추출하여 객체로 만들어 배열에 추가
  for (var i = 0; i < items.length; i++) {
    var item = items[i];
    var hour = item.getElementsByTagName("hour")[0].textContent;
    var temperature = parseFloat(
      item.getElementsByTagName("temperature")[0].textContent
    );
    var humidity = parseFloat(
      item.getElementsByTagName("humidity")[0].textContent
    );
    var formattedTimestamp =
      item.getElementsByTagName("formattedTimestamp")[0].textContent;

    data.push({
      hour: parseInt(hour),
      temperature: temperature,
      humidity: humidity,
      formattedTimestamp: formattedTimestamp,
    });
  }

  return data;
}

function drawTemperatureChart(data) {
  var ctx = document.getElementById("myChart").getContext("2d");
  var ctx2 = document.getElementById("myChart2").getContext("2d");

  var labels = [];
  var temperatureData = [];
  var humidityData = [];
  var existingHours = data.map((item) => item.hour);

  // 00:00부터 23:00까지의 시간대를 가진 데이터 배열 생성
  for (var i = 0; i < 24; i++) {
    labels.push(i.toString().padStart(2, "0") + ":00");

    // 만약 해당 시간대에 데이터가 있다면 온습도 값을 가져오고, 없다면 0으로 설정
    var tempIndex = existingHours.indexOf(i);

    if (tempIndex !== -1) {
      temperatureData.push(data[tempIndex].temperature);
    } else {
      temperatureData.push(0);
    }

    var humiIndex = existingHours.indexOf(i);

    if (tempIndex !== -1) {
      humidityData.push(data[humiIndex].humidity);
    } else {
      humidityData.push(0);
    }
  }

  var chart = new Chart(ctx, {
    // 챠트 종류를 선택
    type: "line",

    // 챠트를 그릴 데이터
    data: {
      labels: labels,
      datasets: [
        {
          label: "온도",
          backgroundColor: "transparent",
          borderColor: "red",
          data: temperatureData,
        },
      ],
    },
    // 옵션
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
    },
  });

  var chart2 = new Chart(ctx2, {
    // 챠트 종류를 선택
    type: "line",

    // 챠트를 그릴 데이터
    data: {
      labels: labels,
      datasets: [
        {
          label: "습도",
          backgroundColor: "transparent",
          borderColor: "blue",
          data: humidityData,
        },
      ],
    },
    // 옵션
    options: {
      scales: {
        y: {
          beginAtZero: true,
        },
      },
    },
  });
}

function handleDateInput(event) {
  let currentDate = null;
  if (!event) {
    currentDate = new Date().toISOString().slice(0, 10);
  }
  $.ajax({
    url: "/iot/smarthome/hourlyTemperatureData",
    type: "POST",
    contentType: "application/json",
    data: event ? event.target.value : currentDate,
    success: function (data) {
      // 데이터를 받아와서 그래프 그리는 함수 호출

      // 주어진 XML 데이터 String으로 변환
      var xmlData = new XMLSerializer().serializeToString(data);

      // XML 데이터를 파싱하여 JavaScript 객체로 변환
      var parsedData = parseXML(xmlData);

      drawTemperatureChart(parsedData);
    },
    error: function (error) {
      console.log("Error:", error);
    },
  });
}
handleDateInput();
selectedDate.addEventListener("input", handleDateInput);
