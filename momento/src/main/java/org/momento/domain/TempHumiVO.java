package org.momento.domain;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class TempHumiVO {
    private int id;
    private float temperature;
    private float humidity;
    private Timestamp timestamp;
    private String userId;
}


