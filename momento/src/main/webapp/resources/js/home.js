// <!-- 날씨 데이터 불러오기 -->
// const city = document.getElementById("city");
// const temp = document.getElementById("temp");

// const API_KEY = "3a0ed8afaa00341237e17da7715c7566";
// function getGeoInfoSuccess(position) {
//   const lat = position.coords.latitude;
//   const lon = position.coords.longitude;
//   const url =
//     "https://api.openweathermap.org/data/2.5/weather?lat=" +
//     lat +
//     "&lon=" +
//     lon +
//     "&appid=" +
//     API_KEY;

//   fetch(url)
//     .then((response) => response.json())
//     .then((data) => {
//       city.innerText = data.name;
//       temp.innerText = (data.main.temp - 273.15).toFixed(1) + "°C";
//     });
// }
// function getGeoInfoFail() {
//   alert("Cannot get the weather..!!");
// }
// navigator.geolocation.getCurrentPosition(getGeoInfoSuccess, getGeoInfoFail);

// 명언 배열
var quotes = [
  "The only way to do great work is to love what you do. - Steve Jobs",
  "Don't watch the clock; do what it does. Keep going. - Sam Levenson",
  "Believe you can and you're halfway there. - Theodore Roosevelt",
  "The secret of getting ahead is getting started. - Mark Twain",
  "The best way to predict the future is to create it. - Peter Drucker",
  "You miss 100% of the shots you don't take. - Wayne Gretzky",
];

//시계
function printClock() {
  var clock = document.getElementById("clock");
  var currentDate = new Date();
  var currentHours = currentDate.getHours() % 12 || 12;
  var currentMinute = addZeros(currentDate.getMinutes(), 2);
  var amPm = currentDate.getHours() >= 12 ? "PM" : "AM"; // AM/PM 설정

  var formattedTime =
    currentHours +
    ":" +
    currentMinute +
    "<span style='font-size: medium;'>" +
    amPm +
    "</span>"; // 시간과 AM/PM 표시를 포맷에 맞게 조합

  clock.innerHTML = formattedTime; // 시간을 출력해 줌

  setTimeout(printClock, 1000); // 1초마다 printClock() 함수 호출
}

function addZeros(num, digit) {
  var zero = "";
  num = num.toString();
  if (num.length < digit) {
    for (i = 0; i < digit - num.length; i++) {
      zero += "0";
    }
  }
  return zero + num;
}

function getRandomQuote() {
  var quoteElement = document.getElementById("quote");
  var randomIndex = Math.floor(Math.random() * quotes.length);
  var randomQuote = quotes[randomIndex];
  quoteElement.innerHTML = randomQuote;
}

printClock();
getRandomQuote();

//메뉴 버튼

function toggleContent() {
  var toggleContainer = document.querySelector(".toggle-container");
  toggleContainer.classList.toggle("active");

  var toggleIcon = document.querySelector(".toggle-icon");
  toggleIcon.classList.toggle("active");
}
