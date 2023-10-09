package org.momento.domain;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

import lombok.Data;

@Data
public class TempHumiVO {
	private int id;
	private long hour;
	private float temperature;
	private float humidity;
	private Timestamp timestamp;
	private String userId;

	public String getFormattedTimestamp() {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss z");
		long timeInMillis = this.timestamp.getTime() - (9 * 60 * 60 * 1000); // 9 hours in milliseconds

		return sdf.format(new Date(timeInMillis));

	}
}
