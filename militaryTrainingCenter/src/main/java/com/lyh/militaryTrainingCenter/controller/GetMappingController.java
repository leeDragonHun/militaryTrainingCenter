package com.lyh.militaryTrainingCenter.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class GetMappingController {
	// 겟매핑
	@GetMapping("/signup")
	public String signup() {
		return "signup";
	}
	// 겟매핑
	@GetMapping("/training")
	public String training() {
		return "training";
	}
}
