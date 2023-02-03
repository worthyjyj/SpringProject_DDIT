package kr.or.ddit.vo;

import java.util.Date;
import java.util.List;

import org.hibernate.validator.constraints.NotBlank;

//자동차
public class CarVO {
	//자동차 번호
	@NotBlank
	private String carNum;
	//제조 번호
	@NotBlank
	private String mnfNum;
	//연식
	private Date dt;
	//주행 거리
	private int dist;
	//고객 번호
	@NotBlank
	private String cusNum;
	//자동차(CAR) : 서비스(SER) = 1 : N
	private List<SerVO> serVOList;
}
