package com.lyh.militaryTrainingCenter.mapper;

import java.util.List;
import java.util.Map;

import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface SoldierMapper {
	String selectSoldierByArmyNumber(String armyNumber); // 군번 중복조회
	int addSoldier(Map<String, Object> params); // 군인 추가
}
