package com.aselcni.lhs.controller;

import java.io.IOException;
import java.util.Base64;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.aselcni.lhs.model.Compmst;
import com.aselcni.lhs.service.CompmstService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
public class CompmstController {
	
	private final CompmstService compmstService;
	
	@GetMapping("compmst")
	public String compmst(Model model) {
		Compmst compmst = compmstService.compmstSelect();
		if(compmst != null) {
			model.addAttribute("compmst", compmst);
			if(compmst.getComp_image() != null) {
				model.addAttribute("compImage", "data:image/png;base64,"+ new String(Base64.getEncoder().encodeToString(compmst.getComp_image())));
			}
		}
		return "lhs/compmst";
	}
	
	@PostMapping("compmstUpdate")
	public String compmstUpdate(Compmst compmst,@RequestParam("image_file")MultipartFile file) {
		try {
			if(file.getBytes().length != 0) {
				compmst.setComp_image(file.getBytes());
			}
		} catch (IOException e) {
			e.printStackTrace();
		}
		int result = compmstService.compmstUpdate(compmst);
		return "redirect:/compmst";
	}
	
}
