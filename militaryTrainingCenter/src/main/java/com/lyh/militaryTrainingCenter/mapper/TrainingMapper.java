package com.lyh.militaryTrainingCenter.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface TrainingMapper {
	List<String> selectSoldierBasicTraining(); // 대분류 [장병기본훈련 과목] 선택
	List<Map<String, Object>> selectLevel(String subjectName);// 중분류 [단계] 출력
	List<Map<String, Object>> selectProcess(String levelName);// 소분류 [술기] 출력
	String selectDetails(String processName);// [상세내용] 출력
	
}
