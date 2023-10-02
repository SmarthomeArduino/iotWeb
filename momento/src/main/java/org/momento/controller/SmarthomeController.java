package org.momento.controller;

import java.io.OutputStream;

import java.net.HttpURLConnection;
import java.net.URL;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.JsonMappingException;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class SmarthomeController {
	@GetMapping("/iot/smarthome")
	public void logoutGET() {
		log.info("스마트홈 접속");
	}

	@PostMapping("/iot/smarthome/led")
	@ResponseBody
	public void receiveData(@RequestBody String data) throws JsonMappingException, JsonProcessingException {
        
        
        ObjectMapper objectMapper = new ObjectMapper();
        JsonNode jsonNode = objectMapper.readTree(data);
        
        log.info(jsonNode);

        // 파싱된 JSON 객체에서 필요한 데이터 추출
        String ledValue = jsonNode.get("led").asText();
        System.out.println("Received LED Value: " + ledValue);


		try {
			// 톰캣 서버에 보낼 URL 설정
			String url = "http://192.168.0.84:80/receive";
			URL obj = new URL(url);
			HttpURLConnection con = (HttpURLConnection) obj.openConnection();

			// HTTP POST 메소드 설정
			con.setRequestMethod("POST");
			con.setDoOutput(true);

			// 데이터 설정 (예: JSON 형식의 데이터)
			String sendData = "toggleLED:".concat(ledValue);

			// 데이터를 OutputStream을 이용하여 전송
			OutputStream os = con.getOutputStream();
			os.write(sendData.getBytes());
			os.flush();
			os.close();

			// HTTP 응답 코드 받기
			int responseCode = con.getResponseCode();
			System.out.println("HTTP Response Code: " + responseCode);

		} catch (Exception e) {
			e.printStackTrace();
		}

	}

}
