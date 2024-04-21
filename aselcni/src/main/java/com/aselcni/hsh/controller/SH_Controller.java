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
import com.aselcni.hsh.model.Whmst;
import com.aselcni.hsh.service.HshPaging;
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
      
      int totalprocmst = sh.totalprocmst();
      HshPaging page = new HshPaging(totalprocmst, procmst.getCurrentPage());
      
      procmst.setStart(page.getStart());
      procmst.setEnd(page.getEnd());
      
      List<Procmst> procmsts = sh.getProcmst(procmst);
      
      
      model.addAttribute("Procmst", procmst);
      model.addAttribute("processList", procmsts);
      model.addAttribute("page", page);
      
      System.out.println("SH_Controller requestMethodName procmsts->"+" "+procmsts);
      
      
      return "hsh/procmst";
   }
	/*
	 * //공정관리 페이지 다음칸
	 * 
	 * @RequestMapping("/nextProcmst") public String nextProcmst(Procmst procmst,
	 * Model model) {
	 * System.out.println("SH_Controller requestMethodName start...");
	 * 
	 * int totalprocmst = sh.totalprocmst(); HshPaging page = new
	 * HshPaging(totalprocmst, procmst.getCurrentPage());
	 * 
	 * procmst.setStart(page.getStart()); procmst.setEnd(page.getEnd());
	 * 
	 * List<Procmst> procmsts = sh.getProcmst(procmst);
	 * 
	 * 
	 * model.addAttribute("Procmst", procmst); model.addAttribute("processList",
	 * procmsts); model.addAttribute("page", page);
	 * 
	 * System.out.println("SH_Controller requestMethodName procmsts->"+" "+procmsts)
	 * ;
	 * 
	 * 
	 * return "hsh/procmst"; }
	 */
   
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
         
         String procd = procmst.getProc_Cd();
         System.out.println("SH_Controller NewProc procmst.getProc_Cd()=>"+" "+procd);
         String empId = procmst.getProc_Emp_Id();
         
         if (procmst.getProc_Cd() == null || procmst.getProc_Cd().trim().isEmpty() ||
               procmst.getProc_Nm() == null || procmst.getProc_Nm().trim().isEmpty()) {
                 System.out.println("창고 코드 또는 창고 이름이 비어 있습니다.");
                 return "error1";
             }
         
         if(sh.same_Emp_Id(empId) && sh.same_pro_cd(procd)) {
            sh.NewProc(procmst);
            String status = "success";
            return status;
         }
         
         if(!sh.same_pro_cd(procd)) {
             String status = "error2";
        	 return status;
         }
         
         else {
            String status = "error3";
            System.out.println("SH_Controller NewProc error...");

            return status;
         }

      }
   
      // ====================================창고관리========================================
   
   //창고관리 페이지 넘어가기
   @RequestMapping("/whmst")
   public String whmst(Whmst whmst, Model model) {
System.out.println("SH_Controller requestMethodName start...");
      
      int totalwhmst = sh.totalwhmst();
      System.out.println("SH_Controller totalwhmst ->"+""+totalwhmst);
      

      HshPaging page = new HshPaging(totalwhmst, whmst.getCurrentPage());
      
      whmst.setStart(page.getStart());
      whmst.setEnd(page.getEnd());
      
      List<Whmst> whmsts = sh.getWhmst(whmst);
      
      
      model.addAttribute("whmst", whmst);
      model.addAttribute("WhmstsList", whmsts);
      model.addAttribute("page", page);
      
      System.out.println("SH_Controller whmst whmsts->"+" "+whmsts);
      
      
      return "hsh/whmst";
   }
 
   
   
   
   
   
   
   //창고상세정보
      @ResponseBody
      @RequestMapping("whmstDetails")
      public Whmst whmstDetails(@RequestParam("id") String id) {
         System.out.println("SH_Controller whmstDetails start...");
         System.out.println("SH_Controller whmstDetails id->"+" "+id);

         Whmst whmsts = sh.GetwhmstDetails(id);
         System.out.println("SH_Controller whmstDetails whmst->"+" "+whmsts);

         return whmsts;
      }
      //창고 수정
      @ResponseBody
      @PostMapping("updateWhmst")
      public String updateWhmst (@ModelAttribute Whmst whmst) {
         System.out.println("SH_Controller updateProc start...================");
         String whmstId = whmst.getWh_emp_id();
         System.out.println("SH_Controller updateWhmst whmstId->"+" "+whmstId);
         System.out.println("SH_Controller updateWhmst whmst->"+" "+whmst);
         if(sh.same_Emp_Id(whmstId)) {
            sh.updateWhmst(whmst);
            String status = "success";
            return status;
         }else {
            String status = "error";
            return status;
         }
      }


      //창고 삭제
      @ResponseBody
      @PostMapping("DelDateWhmst")
      public String DelDateWhmst (@ModelAttribute Whmst whmst) {
         System.out.println("SH_Controller DelDateWhmst start...");
            sh.DelDatewhmst(whmst);
            String status = "success";
            return status;
      }
      
      //창고 추가
            @ResponseBody
            @PostMapping("NewWhmst")
            public String NewWhmst (@ModelAttribute  Whmst whmst) {
               System.out.println("SH_Controller NewProc start...================");
               
               if (whmst.getWh_cd() == null || whmst.getWh_cd().trim().isEmpty() ||
                       whmst.getWh_nm() == null || whmst.getWh_nm().trim().isEmpty()) {
                       System.out.println("창고 코드 또는 창고 이름이 비어 있습니다.");
                       return "error1";
                   }

               
               String whmstId = whmst.getWh_emp_id();
               if(sh.same_Emp_Id(whmstId)) {
                  sh.NewWhmst(whmst);
                  String status = "success";
                  return status;
               }else {
                  String status = "error2";
                  return status;
               }

            }
            
            @ResponseBody // 회원가입시 아이디 중복 체크
            @RequestMapping(value = "hshWhCk")
            public int hshWhCk(@RequestParam("wh_cd") String wh_cd) {
               System.out.println("SH_Controller hshWhCk Start...");
               System.out.println("SH_Controller hshWhCk wh_cd->"+" "+wh_cd);
               if (wh_cd == null || wh_cd == "")
                  return -1;
               else
                  return sh.checkCd(wh_cd); //입력한 아이디와 일치하는 아이디가 있는지 찾아옴, 0이어야 가입가능
            } // 스트링을 보내서 인트를 받아옴
}
