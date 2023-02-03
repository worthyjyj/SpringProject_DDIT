package kr.or.ddit.vo;

import java.util.List;

import javax.validation.constraints.Size;

import org.hibernate.validator.constraints.NotBlank;

import lombok.Data;

//고객
/* Bean Validation이 제공하는 제약 애너테이션
 - NotNull : 빈 값 체크
 - *NotBlank : null 체크, trim(공백제거) 후 길이가 0인지 체크
 - Size : 글자 수 체크
 - Email : 이메일 주소 형식 체크
 - Past : 오늘보다 과거 날짜(ex. 생일)
 - Future : 미래 날짜 체크(ex. 예약일)
 */
@Data
public class CusVO {
	//고객번호(필수=mandatory), null 체크, trim 후 길이가 0인지 체크
	@NotBlank
	private String cusNum;
	//고객명(김아무개와두루미삼천갑자동박사...)
	@Size(min=2,max=10, message = "2자~10자 이내로 입력해 주세요")
	@NotBlank
	private String cusNm;
	//주소
	private String cusAddr;
	//연락처
	@NotBlank
	private String cusPhe;
	//우편번호
	private String postno;
	//주소 상세
	private String addrDet;
	//고객(CUS) : 자동차(CAR) = 1 : N
	private List<CarVO> carVOList;
	//고객(CUS) : 서비스(SER) = 1 : N
	private List<SerVO> serVOList;
}




