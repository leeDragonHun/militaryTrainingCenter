package com.lyh.militaryTrainingCenter.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.lyh.militaryTrainingCenter.mapper.SoldierMapper;

import lombok.extern.slf4j.Slf4j;

// 클라이언트에 데이터를 직접 전송할 때 용이하다.
// JSON 또는 XML형태의 형식을 반환한다.
// Controller때와 달리 @ResponseBody가 모든 메서드에 자동 적용된다.
@RestController
@Transactional
@Slf4j
public class SoldierController {

	@Autowired SoldierMapper soldierMapper;
	
	// 군번 중복확인 
	// 요청 주소는 armyNumberCheck이다. $.ajax에서 url:''에 쓸때에는 당연히 properties에서 설정해준 context-path 까지 합쳐서 써줘야 한다.
	@PostMapping("/armyNumberCheck")
	public int armyNumberCheck(@RequestParam(name="armyNumber") String armyNumber) {
		String result = soldierMapper.selectSoldierByArmyNumber(armyNumber);
		// null이 나오면 DB에서 이 군번이 조회되지 않기 때문에 이 군번으로 입교신청이 가능하다.
		if(result == null) {
			return 0;
		}
		return 1;
	}
	
	// 입교신청
	@PostMapping("/signup")
	public String signup(@RequestParam Map<String, Object> params) {
		// 회원가입 정보를 받아왔고 디버깅.
	    log.debug("hiddenArmyNumber : " + params.get("hiddenArmyNumber"));
	    log.debug("passwordCheck : " + params.get("passwordCheck"));
	    log.debug("militaryRank : " + params.get("militaryRank"));
	    log.debug("name : " + params.get("name"));
	    
	    // 이 매퍼가 실행되면 int값을 반환하고 성공하면 1을 반환한다.
	    int result = soldierMapper.addSoldier(params);
	    log.debug("result : " + result);
	    
	    // 성공했으면 sucess라는 스트링을 반환할 것이다.
	    if (result > 0) {
	        return "success";
	    } else {
	        return "fail";
	    }
	}
}
