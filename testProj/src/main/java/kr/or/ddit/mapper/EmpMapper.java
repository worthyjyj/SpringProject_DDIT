package kr.or.ddit.mapper;

import java.util.List;
import java.util.Map;

import kr.or.ddit.vo.EmpVO;

public interface EmpMapper {
	//다음 직원번호를 가져옴 
//	<select id="getEmpNum" resultType="String">
	public String getEmpNum();

	//신규 직원 등록 
	public int createPost(EmpVO empVO); 
	
//	 모든 직원 정보 가져오기 
	public List<EmpVO> getEmpAll(); 
	
//	직원 상세 보기(관리자가 있으면 관리자 정보도 포함) 
	public List<EmpVO> detail(EmpVO empVO); 
	
	//직원 삭제 
	public int deletePost(EmpVO empVO);
	
	//직원목록 
	public List<EmpVO> list(Map<String, String> map);

	public EmpVO showMj(EmpVO empVO); 
	
	public int getTotal(Map<String, String> map);
}
