package com.lyh.militaryTrainingCenter.controller;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lyh.militaryTrainingCenter.mapper.TrainingMapper;

import lombok.extern.slf4j.Slf4j;

@RestController
@Transactional
@Slf4j
public class TrainingController {
	
	@Autowired TrainingMapper trainingMapper;
	
	// 대분류 [장병기본훈련 과목] 선택
	@PostMapping("/soldierBasicTraining")
	public List<String> soldierBasicTraining(){
		return trainingMapper.selectSoldierBasicTraining();
	}
	
	// 중분류 [단계] 출력
	@PostMapping("/level")
	public List<Map<String, Object>> level(@RequestParam(name="subjectName")String subjectName){
		log.debug("subjectName : " + subjectName);
		return trainingMapper.selectLevel(subjectName);
	}
	
	// 소분류 [술기] 출력
	@PostMapping("/process")
	public List<Map<String, Object>> process(@RequestParam(name="levelName")String levelName){
		log.debug("levelName : " + levelName);
		return trainingMapper.selectProcess(levelName);
	}
	
	// [상세내용] 출력
	@PostMapping("/details")
	public String details(@RequestParam(name="processName")String processName){
		log.debug("processName : " + processName);
		return trainingMapper.selectDetails(processName);
	}
}
