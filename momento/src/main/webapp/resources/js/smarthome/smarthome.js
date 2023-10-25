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
