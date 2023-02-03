package kr.or.ddit.vo;

import java.util.List;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

//직원
@Data
public class EmpVO {
	//직원 번호
	@NotBlank
	private String empNum;
	//주소
	private String empAddr;
	//연락처
	@NotBlank
	private String empPne;
	//직원 명
	@NotBlank
	private String empNm;
	//급여
	@NotBlank
	private int empPay;
	//직원(EMP) : 서비스(SER) = 1 : N
	private List<SerVO> serVOList;
}
