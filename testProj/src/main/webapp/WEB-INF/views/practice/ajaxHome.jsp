<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript" src="/resources/js/jquery-3.6.0.js"></script>
<title>도서관리시스템</title>
<script type="text/javascript">
$(function() {
	//아이디가 btnSubmit인 버튼을 클릭 시 
	//1) 아이디가 boardNo인 요소의 값을 boardNoVal 변수에 할당.
	//2) ajax 구문을 작성.(url(/board/+boardNoVal)
			//, contentType(application/json;charset=utf-8)
			//, data, type(get), success)
	//3) data는 json데이터.{boardNo:boardNoVal}
	
	$('#btnSubmit').on("click", function(){
		//1) 아이디가 boardNo인 요소의 값을 boardNoVal 변수에 할당.
		let boardNoVal = $("#boardNo").val();
		//3) data는 json데이터.{boardNo:boardNoVal}
		let data = {"boardNo":boardNoVal}; 
		//2) ajax 구문을 작성.(url(/board/+boardNoVal)
				//, contentType(application/json;charset=utf-8)
				//, data, type(get), success)
		//아작나써유. 피씨다타써.
		//url : 요청경로 
		//contentType : 보내는 데이터 타입
		//dataType : 응답 데이터 타입(생략가능)
		//data : 요청 시 전송할 데이터 
		//type : get, post, put
		//요청URI : /board/100
		$.ajax({
			url :"/board/"+boardNoVal, 
			contentType : "application/json;charset=utf-8", //보내는타입
			data: JSON.stringify(data),
			//변수를 쓰면 여기까지는 무조건 써야함 
			type : "post",
			success: function(result){
				//ResponseEntity<String> entity = 
				//new ResponseEntity<String>("SUCCESS", HttpStatus.OK);
				//result : SUCCESS
				console.log("result :" + result); 
			}
		});	
	})
		
	//hoHome0301버튼을 클릭 시
	//ajax로 /board/hoHome0301 URI를 요청(방식 : get). 
	//	success로 bookVO 자바빈 객체 데이터를 result 오브젝트 변수에 담자
	$('#goHome0301').on("click", function(){
		$.ajax({
			url :"/board/goHome0301", 
			type : "get",
			success: function(result){
				let lprodId = result.lprodId; 
				let lprodGu = result.lprodGu; 
				let lprodNm = result.lprodNm; 
				//Json계에서 객체는 getter가 아닌 직접 멤버변수에 접근해서 값을 뽑아낼 수 있음
				
				console.log("result :" + JSON.stringify(result)); 
				console.log("lprodId :" + lprodId); 
				console.log("lprodGu :" + lprodGu); 
				console.log("lprodNm :" + lprodNm); 
				//JSON.stringify는 json계의 toString 같은거 .. 
				
				$('#lprodId').val(lprodId); 
				$('#lprodGu').val(lprodGu); 
				$('#lprodNm').val(lprodNm); 
			},
			dataType : "json"
		});	
	})
	
	//goHome04
	   $("#goHome04").on("click", function () {
	      //1) lprodId, lprodGu, lprodNm인 요소의 value를 각각의 이름의 변수에 담은 후
	      //   data 오브젝트 변수에 json 데이터로 저장해보자
	      //2) 요청URI는 /board/goHome04
	      //3) JSON.stringify(data)를 데이터로 담아 요청해보자
	      //4) type은 post
	      //5) success는 res변수로 콜백해보자
	      
	      let lprodId = $("#lprodId").val();
	      let lprodGu = $("#lprodGu").val();
	      let lprodNm = $("#lprodNm").val();
	      
	      let data = {"lprodId":lprodId, 
	               "lprodGu":lprodGu, 
	               "lprodNm":lprodNm};
	      
	      $.ajax({
	         url: "/board/goHome04",
	         contentType: "application/json;charset=utf-8",
	         data: JSON.stringify(data),
	         type: "post",
	         success: function(res) {
	            console.log("result : " + JSON.stringify(res));
	            
	            //list 데이터 처리
	            //res(json데이터) : List<LprodVO>
	            //item : LprodVO{"lprod"}
	            //{"rnum":0,"lprodId":2,"lprodGu":"P102","lprodNm":"전자제품","uploadFile":null,"attachVOList":null}
	               str = ""; 
	            $.each(res,function(i, v){
	               let v_Id = v.lprodId;
	               let v_Gu = v.lprodGu;
	               let v_Nm = v.lprodNm;
	               
	               console.log("v_Id : " + v_Id, "v_Gu : " + v_Gu, "v_Nm : " + v_Nm);
	               
	             //아이디가 divLprod인 div요소 내부에 목록을 채우자
	               /* ex)
	               <div id="divLprod">
	                  <p><input type="text" name="lprodVOList[0].lprodId" value="2" />
	                  <input type="text" name="lprodVOList[0].lprodGu" value="P102" />
	                  <input type="text" name="lprodVOList[0].lprodNm" value="전자제품" /></p>
	                  <p><input type="text" name="lprodVOList[1].lprodId" value="3" />
	                  <input type="text" name="lprodVOList[1].lprodGu" value="P103" />
	                  <input type="text" name="lprodVOList[1].lprodNm" value="피혁잡화" /></p>
	                  <p><input type="text" name="lprodVOList[2].lprodId" value="4" />
	                  <input type="text" name="lprodVOList[2].lprodGu" value="P104" />
	                  <input type="text" name="lprodVOList[2].lprodNm" value="문구류" /></p>
	               </div>
	               */
	               
	               str += 
	            	  `<p><input type='text' name='${v.lprodId}' value='${v_Id}' /><br>`
		              +`<input type='text' name='${v.lprodGu}' value='${v.lprodGu}' /><br>`
		              +`<input type='text' name='${v.lprodNm}' value='${v.lprodNm}' /></p>`;
		              
		              console.log(str); 
		              
	            });
		           $("#divLprod").append(str);
	         }
	      });
	   });
	
	//map->json 데이터 받기
	$("#goHome05").on("click",function(){
		$.ajax({
			url:"/board/goHome05",
			type:"post",
			dataType:"json",
			success:function(result){
				console.log("result : " + JSON.stringify(result));
				//result : {
// 				"key1":{"rnum":0,"lprodId":2,"lprodGu":"P102","lprodNm":"전자제품","uploadFile":null,"attachVOList":null},
// 				"key2":{"rnum":0,"lprodId":3,"lprodGu":"P103","lprodNm":"피혁잡화","uploadFile":null,"attachVOList":null},
// 				"key3":{"rnum":0,"lprodId":4,"lprodGu":"P104","lprodNm":"문구류","uploadFile":null,"attachVOList":null}}
				$.each(result,function(index,item){
					let v_Id = item.lprodId;
					let v_Gu = item.lprodGu;
					let v_Nm = item.lprodNm;
					
					console.log("v_Id : " + v_Id + ", v_Gu : " + v_Gu + 
								", v_Nm : " + v_Nm);
					
				});
			}
		});
	});
	
	//ajax파일업로드 처리
	//e : 클릭 이벤트
	$("#btnUpload").on("click",function(e){
		//가상의 form 태그 생성. <form></form>
		let formData = new FormData();
		//<input type="file" name="uploadFile" id="uploadFile" multiple />
		let inputfile = $("input[name='uploadFile']");
		//파일 오브젝트 안에 이미지 파일들을 가져와보자
		//.files : 파일 오브젝트 안에 들어있는 이미지들
		let files = inputfile[0].files;
		//files : [object fileList]
		console.log("files : " + files);
		
		//가상의 form인 formData Object에 filedata를 추가해보자
		for(let i=0; i<files.length;i++){
			//파일 확장자/크기 체킹(확장자가 exe, sh, zip, alz이면 안됨)
			if(!checkExtension(files[i].name, files[i].size)){
				//반복문 종료 및 함수 종료
				return false;
			}
			
			//<form>
			//<input type="file" name="uploadFile" />
			//<input type="file" name="uploadFile" />
			//<input type="file" name="uploadFile" />
			//</form>
			formData.append("uploadFile",files[i]);
		}
		
		//<form>
		//<input type="file" name="uploadFile" />
		//<input type="file" name="uploadFile" />
		//<input type="file" name="uploadFile" />
		//<input type="text" name="lprodId" value="1" />
		//<input type="text" name="lprodGu" value="P101" />
		//<input type="text" name="lprodNm" value="컴퓨터제품" />
		//</form>
		formData.append("lprodId","1");
		formData.append("lprodGu","P101");
		formData.append("lprodNm","컴퓨터제품");
		
		console.log("formData : " + formData);
		
		//아작나써유. 피씨다타써
		//contentType : 보내는 데이터 타입
		//dataType : 응답 데이터 타입
		//processData : 데이터 파라미터를 data라는 속성으로 넣는데, 제이쿼리 내부적으로 쿼리스트링을 구성합니다. 
		//              파일 전송의 경우 쿼리스트링을 사용하지 않으므로 해당 설정을 false로 비활성화 합니다. 
		//contentType : Content-Type을 설정 시, 사용하는데 해당 설정의 기본값은 
		//              "application/x-www-form-urlenceded; charset=utf-8"입니다.
		//               하여, 기본값으로 나가지 않고 "multipart/form-data;로 나갈 수 있도록 설정을 false 합니다.
		//               request 요청에서 Content-Type을 확인해보면 
		//               "multipart/form-data"; boundary=----WebkitFormBoundary~~~"와  같은 값으로 
		//               전송된 것을 확인할 수 있습니다. 
		$.ajax({
			url:"/board/uploadAjax",
			processData:false, //파일을 아작스로 보낼때 꼭 설정해야함 
			contentType:false, //파일을 아작스로 보낼때 꼭 설정해야함 
			data:formData,
			dataType:"json",
			type:"post",
			success:function(result){
				console.log("result : " + JSON.stringify(result));
			}
		});
	});
	
	//이미지 체킹
	//(.*?) : 파일명 
	// \. : 이스케이프로 처리하여 문자 .을 의미
	// | : 또는 
	let regex = new RegExp("(.*?)\.(exe|sh|zip|alz)$"); // 정규식
	let maxSize = 5242880; //5MB
	
	function checkExtension(filename, fileSize){ //확장자, 크기 체킹
		//1) 문제 발생 : false 리턴
		if(fileSize >= maxSize){
			alert("파일 사이즈가 초과되었습니다."); 
			//함수 종료 
			return false; 
		}
		//filename : 개똥이.zip
		if(regex.test(filename)){
			alert("해당 종류의 파일은 업로드 할 수 없습니다."); 
			return false; 
		}
		//2) 통과 : true 리턴 
		return true; 
	}
})


</script>
</head>
<body>
	<form>
		<p><input type="text" name="boardNo" id="boardNo" /></p>
		<p><input type="button" id="btnSubmit" value="전송" /></p>
	</form>
	<form>
		<p><input type="text" name="lprodId" id="lprodId" readonly /></p>
		<p><input type="text" name="lprodGu" id="lprodGu" readonly /></p>
		<p><input type="text" name="lprodNm" id="lprodNm" readonly /></p>
		<p><input type="button" id="goHome0301" value="goHome0301" /></p>
	</form>
	<form>
		<p><input type="button" id="goHome04" value="goHome04" /></p>
	</form>
	<form>
		<div id="divLprod"></div>
		<p><input type="button" id="goHome05" value="goHome05" /></p>
	</form>
	<form>
		<p><input type="file" name="uploadFile" id="uploadFile" multiple /></p>
		<p><input type="button" id="btnUpload" value="ajax파일업로드" /></p>
	</form>
</body>
</html>