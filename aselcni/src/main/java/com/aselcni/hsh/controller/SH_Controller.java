package com.aselcni.hsh.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.aselcni.hsh.model.Procmst;
import com.aselcni.hsh.service.SH_Service;



@Controller
@RequiredArgsConstructor
@Slf4j

public class SH_Controller {
	private final SH_Service sh;

	//공정관리 페이지 넘어가기
	@RequestMapping("/procmst")
	public String requestMethodName(Procmst procmst, Model model) {
		System.out.println("SH_Controller requestMethodName start...");
		List<Procmst> procmsts = sh.getProcmst();
		model.addAttribute("processList", procmsts);
		System.out.println("SH_Controller requestMethodName procmsts->"+" "+procmsts);

		
		return "hsh/procmst";
	}
	
	//공정상세정보
	@ResponseBody
	@RequestMapping("procmstDetails")
	public Procmst procmstDetails(@RequestParam("id") String id) {
		System.out.println("SH_Controller procmstDetails start...");
		System.out.println("SH_Controller procmstDetails id->"+" "+id);

		Procmst procmst = sh.GetprocmstDetails(id);
		System.out.println("SH_Controller procmstDetails procmst->"+" "+procmst);

		return procmst;
	}
	//공정 수정
	@ResponseBody
	@PostMapping("updateProc")
	public String updateProc (@ModelAttribute Procmst procmst) {
		System.out.println("SH_Controller updateProc start...================");
		String empId = procmst.getProc_Emp_Id();
		System.out.println("SH_Controller updateProc empId->"+" "+empId);
		System.out.println("SH_Controller updateProc procmst->"+" "+procmst);
		if(sh.same_Emp_Id(empId) == true) {
			sh.updateProc(procmst);
			String status = "success";
			return status;
		}else {
			String status = "error";
			return status;
		}

	}
	//공정 삭제
	@ResponseBody
	@PostMapping("DelDateProc")
	public String DelDateProc (@ModelAttribute Procmst procmst) {
		System.out.println("SH_Controller updateProc start...");
			sh.DelDateProc(procmst);
			String status = "success";
			return status;
	}
	
	//공정 추가
		@ResponseBody
		@PostMapping("NewProc")
		public String NewProc (@ModelAttribute Procmst procmst) {
			System.out.println("SH_Controller NewProc start...================");
			
			String empId = procmst.getProc_Emp_Id();
			if(sh.same_Emp_Id(empId) == true) {
				sh.NewProc(procmst);
				String status = "success";
				return status;
			}else {
				String status = "error";
				return status;
			}

		}
	
	
	//창고관리 페이지 넘어가기
	@RequestMapping("/whmst")
	public String whmst() {
		System.out.println("SH_Controller requestMethodName start...");
		return "hsh/whmst";
	}
	
	
}
