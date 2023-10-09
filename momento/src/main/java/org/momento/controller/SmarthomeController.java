package org.momento.controller;

import java.io.IOException;

import java.io.OutputStream;

import java.net.HttpURLConnection;
import java.net.URL;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.momento.domain.TempHumiVO;

import org.momento.mapper.TempHumiMapper;
import org.springframework.beans.factory.annotation.Autowired;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
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

	@Autowired
	private TempHumiMapper tempHumiMapper;

	@GetMapping("/iot/smarthome")
	public void logoutGET(Model model) {

		TempHumiVO temp = tempHumiMapper.getLastTemperatureHumidityData();
		model.addAttribute("tempHumi", temp);
		log.info("최근 온습도 데이터: " + temp);

		log.info("스마트홈 접속");
	}

	@PostMapping("/iot/smarthome/hourlyTemperatureData")
	@ResponseBody
	public List<TempHumiVO> getHourlyTemperatureData(@RequestBody String data, Model model) throws IOException {

		data = data.replaceAll("\"", ""); // 이 부분 추가
		log.info("data:" + data);
		Timestamp timestamp = null;

		try {
			SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			java.util.Date parsedDate = dateFormat.parse(data); // 문자열을 Date 객체로 파싱

			Date sqlDate = new Date(parsedDate.getTime()); // Date 객체를 java.sql.Date로 변환
			timestamp = new Timestamp(sqlDate.getTime()); // java.sql.Date를 Timestamp로 변환

			System.out.println("변환된 Timestamp: " + timestamp);
		} catch (ParseException e) {
			e.printStackTrace();
		}

		Timestamp timestamp2 = new Timestamp(0);
		List<TempHumiVO> dataList = tempHumiMapper.getHourlyTemperatureData(timestamp.toString(), "dltndns2");
		dataList.forEach(data2 -> {
			data2.setTimestamp(timestamp2);

		});
		log.info(dataList);

		return dataList;

	}

	@PostMapping("/iot/smarthome/tempHumi")
	@ResponseBody
	public void getTempHumi(@RequestBody String data)
			throws UnsupportedEncodingException, JsonMappingException, JsonProcessingException {
		String encodedString = data;
		String decodedString = URLDecoder.decode(encodedString, "UTF-8");

		// '=' 문자의 인덱스를 찾습니다.
		int equalsIndex = decodedString.indexOf('=');

		// '=' 문자 다음의 데이터를 자릅니다.
		decodedString = decodedString.substring(0, equalsIndex).trim();

		log.info(decodedString);

		ObjectMapper objectMapper = new ObjectMapper();
		JsonNode jsonNode = objectMapper.readTree(decodedString);

		String temp = jsonNode.get("temp").asText();
		String humi = jsonNode.get("humi").asText();

		log.info("temp: " + temp);
		log.info("humi: " + humi);

		TempHumiVO tempHumiVO = new TempHumiVO();
		;

		tempHumiVO.setTemperature(Float.parseFloat(temp));
		tempHumiVO.setHumidity(Float.parseFloat(humi));
		tempHumiVO.setUserId("dltndns2");

		try {
			tempHumiMapper.insert(tempHumiVO);
		} catch (Exception e) {
			// TODO: handle exception
		}

		// 데이터를 Map에 담아서 반환

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
