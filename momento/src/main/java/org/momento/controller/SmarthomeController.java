package org.momento.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseBody;
import org.momento.security.CustomCsrfToken;
import org.springframework.ui.Model;

import lombok.extern.log4j.Log4j;

@Controller
@Log4j
public class SmarthomeController {
    @GetMapping("/iot/smarthome")
    public void logoutGET() {
        log.info("스마트홈 접속");
    }

    @GetMapping("/csrf-token")
    @ResponseBody
    public String getCsrfToken(CustomCsrfToken token) {
        return token.getToken();
    }

    @PostMapping("/iot/smarthome")
    @ResponseBody
    public String receiveData(@RequestBody String data) {
        log.info("Received data: " + data);
        return "Data received successfully!";
    }
}
