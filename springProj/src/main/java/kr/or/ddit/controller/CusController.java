package kr.or.ddit.controller;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.Errors;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import kr.or.ddit.service.CusService;
import kr.or.ddit.vo.CusVO;
import lombok.extern.slf4j.Slf4j;

//프링아 이거 컨트롤러야. 자바빈으로 등록해서 관리해줘
//"value="는 속성이 1개일 땐 속성명 생략 가능
@Slf4j
@RequestMapping("/cus")
@Controller
public class CusController {
	
	@Autowired
	CusService cusservice; 
	//단순한 페이지 이동일 때 void
	//void로 응답 ->리턴없이 다시 그 jsp페이지 요청
	//요청URI : /cus/create
	@GetMapping("/create")
	public void create(@ModelAttribute CusVO cusVO, Model model) { 
		log.info("create()에 왔다");
		
		//기본키 데이터 생성                                                             
		String cusNum = this.cusservice.getCusNum();
		//cusVO{cusNum=CUS002,cusNm=null,CusAddr=null...}
		cusVO.setCusNum(cusNum); 
		cusVO.setCusNm("개똥이"); 
		
		//취미 등록 (jsp단에서 체크박스 select 여부를 미리 체크 할 수 있음)
		List<String> hobbyList = new ArrayList<String>(); 
		hobbyList.add("Music"); 
//		hobbyList.add("Movie"); 
		hobbyList.add("Sports"); 
		hobbyList.add("테스트"); 
		cusVO.setHobbyList(hobbyList);
		
		//성별 등록 (남성 : male, 여성 : female, 기타 : others)
		cusVO.setGender("female");
		
		//국적(한개 선택) -> select박스 
		Map<String, String> nationalityMap = new HashMap<String, String>(); 
		nationalityMap.put("Korea", "Korea");
		nationalityMap.put("English", "English");
		nationalityMap.put("Germany", "Germany");
		
		model.addAttribute("nationalityMap",nationalityMap);
		//생성된 고객번호를 model에 넣음 
		model.addAttribute("cusNum",cusNum);
		
		//forwarding
//		return "cus/create";
	}
	
	//String으로 응답 ***********
//	요청URI : /cus/createPost
//	요청파라미터 : {cusNum=12345, cusNm=개똥이, postno=33233...}
//	요청방식 : post
	//String, int, Map.. => 골뱅이RequestParam
	//VO => ModelAttribute
	//골뱅이 Valid는 CusVO의 validation 체크를 해주는 어노테이션
	//문제 발생 시 Errors객체에 오류를 담아서 꼭 forwording해주면 됨 
	@PostMapping("/createPost")
	public String createPost(@Valid @ModelAttribute CusVO cusVO,
			String cusNum, String cusNm, String postno, String cusAddr,
			String addrDet, @RequestParam("cusPhe") String phone, 
			@DateTimeFormat(pattern="yyyy-MM-dd") Date cusBir, 
			String gender, String nationality,  
			Errors errors) {
		//cusVO : CusVO(cusNum=12345, cusNm=개똥이, cusAddr=제주특별자치도 제주시 첨단로 242
		//, cusPhe=010-123-1234, postno=63309, addrDet=ㅁㄴㅇㄹ
		//, carVOList=null, serVOList=null)
		log.info("cusVO : " + cusVO);
		log.info("cusNum : " + cusNum + ", cusNm : " + cusNm + 
				", postno : " + postno + ", phone : " + phone + 
				", addrDet : " + addrDet + ", cusBir : " + cusBir);
		
		String hobby = ""; 
		
		List<String> list = cusVO.getHobbyList(); 
		
		//List<String> hobbyList 처리 
		for(String str : list) {
			hobby += str + ","; 
		}
		
		cusVO.setHobby(hobby);
		
		
		//errors.hasErrors() : 문제 발생 시 true
		if(errors.hasErrors()) {
			return "cus/create";
		}
		
		//CUS 테이블에 insert
		int result = this.cusservice.createPost(cusVO);
		log.info("result : " + result);
				
		//입력성공 : 상세보기로 redirect. 기본키 데이터를 파라미터로 보냄
		return "redirect:/cus/detail?cusNum="+cusVO.getCusNum();
	}
	
	/* 컨트롤러 메서드 매개변수
	- String, int, Date
	- Model
	- RedirectAttributes
	- 자바빈즈 클래스
	- MultipartFile
	- BindingResult
	- java.util.Locale
	- java.security.Principal
	*/
	//요청URI : /cus/detail
	@GetMapping("/detail")
	public String detail(Model model, RedirectAttributes ras, 
			@ModelAttribute CusVO cusVO) {
		
		//상세보기 
		cusVO = this.cusservice.detail(cusVO);
		
		//국적(한개 선택)->select박스
		Map<String, String> nationalityMap = new HashMap<String, String>();
		nationalityMap.put("Korea","Korea");
		nationalityMap.put("English","English");
		nationalityMap.put("Germany","Germany");
		
		model.addAttribute("nationalityMap", nationalityMap);
		
		//forwarding
		return "cus/detail";
	}
	
}









