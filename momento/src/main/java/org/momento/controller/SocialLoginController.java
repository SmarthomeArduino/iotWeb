package org.momento.controller;


import org.springframework.web.servlet.ModelAndView;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import org.apache.http.HttpEntity;
import org.apache.http.HttpResponse;
import org.apache.http.client.HttpClient;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.impl.client.HttpClientBuilder;
import org.apache.http.util.EntityUtils;
import org.json.JSONObject;
import org.momento.mapper.MemberMapper;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
@RequestMapping("/member/*")
public class SocialLoginController {
	@Setter(onMethod_ = { @Autowired })
	private MemberMapper memberMapper;

    @GetMapping("/naver_callback")
    public ModelAndView naverGET(@RequestParam("code") String Code, @RequestParam("state") String State)
            throws UnsupportedEncodingException {
        log.info("네이버(get)");

        String clientId = "9RxQ23yL8KY_JLTWkrxt";// 애플리케이션 클라이언트 아이디값";
        String clientSecret = "umJ_HengmH";// 애플리케이션 클라이언트 시크릿값";
        String code = Code;
        String state = State;
        String redirectURI = URLEncoder.encode("/customLogin", "UTF-8");
        String apiURL = "https://nid.naver.com/oauth2.0/token?grant_type=authorization_code" + "&client_id=" + clientId
                + "&client_secret=" + clientSecret + "&redirect_uri=" + redirectURI + "&code=" + code + "&state="
                + state;
        String access_token = "";
        String refresh_token = "";
        StringBuilder res = null;
        
        ModelAndView mav = null;

        try {
            URL url = new URL(apiURL);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            int responseCode = con.getResponseCode();
            BufferedReader br;
            if (responseCode == 200) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }
            String inputLine;
            res = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                res.append(inputLine);
            }
            br.close();
            if (responseCode == 200) {

                String jsonString = res.toString();
                JSONObject jsonObject = new JSONObject(jsonString);

                access_token = jsonObject.getString("access_token");
                refresh_token = jsonObject.getString("refresh_token");
                log.info(res.toString());
                log.info("access_token: " + access_token);
                log.info("refresh_token: " + refresh_token);

                String apiUrl = "https://openapi.naver.com/v1/nid/me";

                HttpClient httpClient = HttpClientBuilder.create().build();
                HttpGet request = new HttpGet(apiUrl);
                request.addHeader("Authorization", "Bearer " + access_token);

                try {
                    HttpResponse response = httpClient.execute(request);
                    HttpEntity entity = response.getEntity();
                    String responseBody = EntityUtils.toString(entity);
                    log.info(responseBody);
                    
           
                    mav = new ModelAndView("/member/naver_callback");
                    mav.addObject("responseBody", responseBody);
                    return mav;
                    
                } catch (Exception e) {
                    e.printStackTrace();
                }

            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return mav;
    }

}