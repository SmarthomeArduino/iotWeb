<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Document</title>
  </head>
  <body>
    <button>블루투스 연결</button>
    <div id="data-container"></div>
    <button id="getDataButton">데이터 받기</button>
    <div id="ledToggleButtonBox">
      <button id="R1toggleLedButton">R1토글 버튼</button>
      <button id="G1toggleLedButton">G1토글 버튼</button>
      <button id="B1toggleLedButton">B1토글 버튼</button>
      <button id="R2toggleLedButton">R2토글 버튼</button>
      <button id="G2toggleLedButton">G2토글 버튼</button>
      <button id="B2toggleLedButton">B2토글 버튼</button>
      <div>${_csrf.parameterName}</div>
    </div>

    <script>
      class PlaybulbCandle {
        constructor() {
          this.device = null;
          this.onDisconnected = this.onDisconnected.bind(this);
        }

        async request() {
          let options = {
            filters: [
              {
                services: ["6e400001-b5a3-f393-e0a9-e50e24dcca9e"],
              },
            ],
            optionalServices: ["6e400003-b5a3-f393-e0a9-e50e24dcca9e"],
          };
          
          
          this.device = await navigator.bluetooth.requestDevice(options);
          if (!this.device) {
            throw "No device selected";
          }
          this.device.addEventListener(
            "gattserverdisconnected",
            this.onDisconnected
          );
        }

        async connect() {
          if (!this.device) {
            return Promise.reject("Device is not connected.");
          }
          await this.device.gatt.connect();
        }

        async readColor() {
          console.log("readColor...");
          const service = await this.device.gatt.getPrimaryService(
            "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
          );

          const characteristic = await service.getCharacteristic(
            "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
          );
          // console.log(characteristic);
          // const value = await characteristic.getDescriptor();
          // console.log("Received value:", value);
        }

        async readData() {
          console.log("readData...");
          const service = await this.device.gatt.getPrimaryService(
            "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
          );

          const characteristic = await service.getCharacteristic(
            "6e400003-b5a3-f393-e0a9-e50e24dcca9e"
          );
          await characteristic.startNotifications();
          console.log(characteristic.properties);
          console.log(characteristic.properties.notify);

          if (characteristic.properties.notify) {
            characteristic.addEventListener(
              "characteristicvaluechanged",
              (event) => {
                const value = event.target.value;
                const decoder = new TextDecoder("utf-8");
                const data = decoder.decode(value);
                console.log(data);

                // Display temperature and humidity data on the web page
                const dataContainer = document.getElementById("data-container");
                dataContainer.textContent = data;
              }
            );
          } else {
            console.log("Notifications not supported for this characteristic.");
          }
        }

        async toggleLed(event) {
          console.log("toggleLed...");
          const service = await this.device.gatt.getPrimaryService(
            "6e400001-b5a3-f393-e0a9-e50e24dcca9e"
          );

          const characteristic = await service.getCharacteristic(
            "6e400002-b5a3-f393-e0a9-e50e24dcca9e"
          );

          // 토글 LED 값을 전송 (a encoding)

          let value = "";
          const selectedButton = event.target.id.substr(0, 2);
          switch (selectedButton) {
            case "R1":
              value = new TextEncoder().encode("r");
              break;

            case "G1":
              value = new TextEncoder().encode("g");
              break;

            case "B1":
              value = new TextEncoder().encode("b");
              break;

            case "R2":
              value = new TextEncoder().encode("R");
              break;

            case "G2":
              value = new TextEncoder().encode("G");
              break;

            case "B2":
              value = new TextEncoder().encode("B");
              break;

            default:
              break;
          }
          await characteristic.writeValue(value);
        }

        disconnect() {
          if (!this.device) {
            return Promise.reject("Device is not connected.");
          }
          return this.device.gatt.disconnect();
        }

        onDisconnected() {
          console.log("Device is disconnected.");
        }
      }

      var playbulbCandle = new PlaybulbCandle();

      document
        .querySelector("button")
        .addEventListener("click", async (event) => {
          try {
            await playbulbCandle.request();
            await playbulbCandle.connect();
            // await playbulbCandle.readColor();
            await playbulbCandle.readData();
          } catch (error) {
            console.log(error);
          }
        });

      document
        .querySelectorAll("#ledToggleButtonBox button")
        .forEach((element) => {
          element.addEventListener("click", async (event) => {
            try {
              await playbulbCandle.toggleLed(event);
            } catch (error) {
              console.log(error);
            }
          });
        });
    </script>
  </body>
</html>
