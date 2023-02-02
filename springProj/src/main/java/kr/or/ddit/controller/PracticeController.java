package kr.or.ddit.controller;

import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.io.IOUtils;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Controller
public class PracticeController {
	
	//요청URI : /practice/ajaxHome
	@GetMapping("/practice/ajaxHome")
	public String ajaxHome() {
		//forwarding
		return "practice/ajaxHome";
	}
	
	/* 경로 패턴 매핑 
	 요청 경로를 동적으로 표현이 가능한 경로 패턴으로 지정할 수 있음 
	 - URI 경로 상의 변하는 값을 경로 변수 (PathVariable)로 취급함 
	 - 경로 변수에 해당하는 값을 파라미터 변수(매개변수-파라미터를 받아 값을 저장하는 변수)에 설정할 수 있음 
	 */
	//요청URI : /board/100 = 100은 boardNo(게시판 기본키)
	//요청방식 : get
	@PostMapping("/board/{boardNo}")
	public ResponseEntity<String> read(@PathVariable("boardNo") int boardNo){
		log.info("boardNo : " + boardNo);
		
		//String을 응답할 것임 
		ResponseEntity<String> entity = 
				new ResponseEntity<String>("SUCCESS", HttpStatus.OK); 
		
		return entity;
	}
	
	//요청URI : /board/hoHome0301
	//JSON데이터를 받을 땐.. 골뱅이RequestBody
	//JSON데이터로 응답할 땐.. 골뱅이ResponseBody
	@ResponseBody
	@GetMapping("/board/goHome0301")
	public LprodVO home0301() {
		log.info("home0301에 왔다");
		
		LprodVO lprodVO = new LprodVO(); 
		lprodVO.setLprodId(1);
		lprodVO.setLprodGu("P101");
		lprodVO.setLprodNm("컴퓨터제품");
		//forwarding도 아니고 redirect도 아님 
		//자바빈 객체가 JSON으로 보내짐 
		
		return lprodVO; 
	}
	
	//요청URI : /board/goHome04
	//요청파라미터(json) : {"lprodId":"1","lprodGu":"P101","lprodNm":"컴퓨터제품"}
	//방식 : post
	//리턴타입 : json
	@ResponseBody
	@PostMapping("/board/goHome04")
	public List<LprodVO> goHome04(@RequestBody LprodVO lprodVO){
		log.info("lprodVO : " + lprodVO);
		
		List<LprodVO> lprodVOList = new ArrayList<LprodVO>();
		
		LprodVO vo1 = new LprodVO();
		vo1.setLprodId(2);
		vo1.setLprodGu("P102");
		vo1.setLprodNm("전자제품");
		
		lprodVOList.add(vo1);
		///////////////////
		vo1 = new LprodVO();
		vo1.setLprodId(3);
		vo1.setLprodGu("P103");
		vo1.setLprodNm("피혁잡화");
		
		lprodVOList.add(vo1);
		///////////////////
		vo1 = new LprodVO();
		vo1.setLprodId(4);
		vo1.setLprodGu("P104");
		vo1.setLprodNm("문구류");
		
		lprodVOList.add(vo1);
		////////////////////////////////
		log.info("lprodVOList : " + lprodVOList);
		
		return lprodVOList;
	}
	
	//요청URI : /board/goHome05
	//방식 : post
	//컬렉션 Map 타입을 JSON으로 응답 
	@ResponseBody
	@PostMapping("/board/goHome05")
	public Map<String, LprodVO> goHome05(){
		log.info("goHome05에 왔다");
		
		Map<String,LprodVO> map = new HashMap<String, LprodVO>();
		
		LprodVO vo1 = new LprodVO();
		vo1.setLprodId(2);
		vo1.setLprodGu("P102");
		vo1.setLprodNm("전자제품");
		
		map.put("key1", vo1);
		///////////////////
		vo1 = new LprodVO();
		vo1.setLprodId(3);
		vo1.setLprodGu("P103");
		vo1.setLprodNm("피혁잡화");
		
		map.put("key2", vo1);
		///////////////////
		vo1 = new LprodVO();
		vo1.setLprodId(4);
		vo1.setLprodGu("P104");
		vo1.setLprodNm("문구류");
		
		map.put("key3", vo1);
		////////////////////////////////
		
		log.info("map : " + map);
		
		return map;
	}
	
	//SpringFramework를 이용한 파일 다운로드 
	/*  MIME(Multipurpose Internet Mail Extentsions)
	    문자열을 전송할 때는 7비트 아스키파일로 전송하여 사용하지만
	    사진, 음악, 동영상, 문서 파일을 보낼 땐 8비트 데이터(바이너리 데이터)를 사용함. 
	    이것을 전송하기 위해서는 바이너리 데이터를 텍스트로 변환하는 인코딩 작업이 필요함 
	    
	  MIME은 이런 인코딩 방식의 일종. 인코딩 + data type(contents type) 
	  
	  image/jpeg
	 
	 */
	//요청URI : /board/goHome1102
	@ResponseBody
	@GetMapping("/board/goHome1102")
	public ResponseEntity<byte[]> home1102() throws IOException{
		log.info("home1102에 왔다");
		//입력 스트림(00110111011000..)
		InputStream in = null;
		ResponseEntity<byte[]> entity = null;
		
		HttpHeaders headers = new HttpHeaders();
		
		String fileName = "C:\\eclipse_202006\\SpringProject_DDIT\\springProj\\src\\main\\webapp\\resources\\upload\\2023\\01\\31\\393ac066-6bce-4e7d-9b6e-ef878e0cfc20_하트.jpg";
		
		try {
			in = new FileInputStream(fileName);
			//APPLICATION_OCTET(8비트)_STREAM(순수한 바이너리 데이터) : 
			//	표준으로 정의되어 있지 않은 파일인 경우 지정하는 타입
			headers.setContentType(MediaType.APPLICATION_OCTET_STREAM);
			//Content-Disposition : 웹브라우저에서 다운로드 창을 띄움
			//	이 뒤에는 파일 이름과 확장자를 지정해야 함
			// 스트림 파일을 통해 write해줌
			headers.add("Content-Disposition", "attachment;filename=\"" + 
						new String(fileName.getBytes("UTF-8"),"ISO-8859-1") + "\"");
			//new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
			entity = new ResponseEntity<byte[]>(IOUtils.toByteArray(in),
					headers, HttpStatus.CREATED);
		} catch (FileNotFoundException e) {
			log.info(e.getMessage());
			entity = new ResponseEntity<byte[]>(HttpStatus.BAD_REQUEST);
		}finally {
			in.close();
		}
		
		return entity;
	}
	
	/*
	 요청URI : /board/uploadAjax
	 요청 데이터 : 
	 	<form>
			<input type="file" name="uploadFile" />
			<input type="file" name="uploadFile" />
			<input type="file" name="uploadFile" />
			<input type="text" name="lprodId" value="1" />
			<input type="text" name="lprodGu" value="P101" />
			<input type="text" name="lprodNm" value="컴퓨터제품" />
		</form>
	방식 : post
	요청파라미터 : {lprodId=1,lprodGu=P101,lprodNm=컴퓨터제품,uploadFile=파일객체}	
	 */
	@ResponseBody
	@PostMapping("/board/uploadAjax")
	public ResponseEntity<String> uploadAjax(String lprodId, String lprodGu,
			String lprodNm, MultipartFile[] uploadFile,
			@RequestParam Map<String,Object> map,
			@ModelAttribute LprodVO lprodVO
			){
		
		log.info("lprodId : " + lprodId + ", lprodGu : " + lprodGu + 
				", lprodNm : " + lprodNm);
		
		log.info("map : " + map);
		log.info("lprodVO : " + lprodVO);
		
		return new ResponseEntity<String>("SUCCESS",HttpStatus.OK);
	}
	
}
