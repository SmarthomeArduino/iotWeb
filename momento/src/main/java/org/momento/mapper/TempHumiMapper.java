package org.momento.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.momento.domain.TempHumiVO;

public interface TempHumiMapper {

	// 온습도 데이터 insert
	public void insert(TempHumiVO tempHumiData);

	// 마지막 온습도 데이터 select
	public TempHumiVO getLastTemperatureHumidityData();

	public List<TempHumiVO> getHourlyTemperatureData(@Param("timestamp") String timestamp, @Param("name") String name);

}
