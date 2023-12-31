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

//메뉴 버튼
function toggleContent() {
  var toggleContainer = document.querySelector(".toggle-container");
  toggleContainer.classList.toggle("active");

  var toggleIcon = document.querySelector(".toggle-icon");
  toggleIcon.classList.toggle("active");
}

printClock();

// 명언 배열
const quotes = [
  {
    quote: "The way to get started is to quit talking and begin doing.",
    author: "Walt Disney",
  },
  {
    quote: "Life is what happens when you're busy making other plans.",
    author: "John Lennon",
  },
  {
    quote:
      "The world is a book and those who do not travel read only one page.",
    author: "Saint Augustine",
  },
  {
    quote: "Life is either a daring adventure or nothing at all.",
    author: "Helen Keller",
  },
  {
    quote: "To Travel is to Live",
    author: "Hans Christian Andersen",
  },
  {
    quote: "Only a life lived for others is a life worthwhile.",
    author: "Albert Einstein",
  },
  {
    quote: "You only live once, but if you do it right, once is enough.",
    author: "Mae West",
  },
  {
    quote: "Never go on trips with anyone you do not love.",
    author: "Hemmingway",
  },
  {
    quote: "We wander for distraction, but we travel for fulfilment.",
    author: "Hilaire Belloc",
  },
  {
    quote: "Travel expands the mind and fills the gap.",
    author: "Sheda Savage",
  },
];

const quote = document.querySelector("#quote span:first-child");
const author = document.querySelector("#quote span:last-child");
const todaysQuote = quotes[Math.floor(Math.random() * quotes.length)];

quote.innerText = todaysQuote.quote;
author.innerText = todaysQuote.author;

// todoList 버튼
document.getElementById("toggleTodoBtn").addEventListener("click", function () {
  var todoDiv = document.querySelector(".todo");
  todoDiv.style.display =
    todoDiv.style.display === "none" || todoDiv.style.display === ""
      ? "block"
      : "none";
});

// toDoList
const toDoForm = document.querySelector("#todo-form");
const toDoInput = toDoForm.querySelector("input");
const toDoList = document.querySelector("#todo-list");

const TODOS_KEY = "toDos";
let toDos = [];

function deleteToDo(toDo) {
  const li = toDo.target.parentNode;
  toDoList.removeChild(li);

  toDos = toDos.filter((toDo) => parseInt(li.id) !== toDo.id);
  saveTodos();
}

function saveTodos() {
  localStorage.setItem(TODOS_KEY, JSON.stringify(toDos));
}

function paintToDos(newToDosObj) {
  const li = document.createElement("li");
  const span = document.createElement("span");
  const button = document.createElement("button");

  button.innerText = "❌";
  span.innerText = newToDosObj.text;

  li.id = newToDosObj.id;
  li.appendChild(span);
  li.appendChild(button);
  toDoList.appendChild(li);

  button.addEventListener("click", deleteToDo);
}

function toDoHandleSubmit(event) {
  event.preventDefault();
  const newToDo = toDoInput.value;
  toDoInput.value = "";

  const newToDosObj = {
    text: newToDo,
    id: Date.now(),
  };

  toDos.push(newToDosObj);
  paintToDos(newToDosObj);
  saveTodos();

  fetch("/testAjax", {
    method: "POST",
    body: JSON.stringify({ key: "hi" }),
    headers: {
      "Content-Type": "application/json",
      "X-CSRF-TOKEN": '<c:out value="${_csrf.token}" />',
    },
  })
    .then(function (response) {
      if (response.ok) {
        console.log(response);
        return response.json();
      } else {
        throw new Error("Network response was not ok.");
      }
    })
    .then(function (data) {
      console.log("ajax success");
    })
    .catch(function (error) {
      console.error("Error:", error);
    });
}

const savedToDos = localStorage.getItem(TODOS_KEY);

if (savedToDos !== null) {
  const parseToDos = JSON.parse(savedToDos);

  toDos = parseToDos;
  parseToDos.forEach(paintToDos);
} else {
}

toDoForm.addEventListener("submit", toDoHandleSubmit);
