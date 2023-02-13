package kr.or.ddit.service.impl;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.or.ddit.mapper.CusMapper;
import kr.or.ddit.service.CusService;
import kr.or.ddit.vo.CarVO;
import kr.or.ddit.vo.CusVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class CusServiceImpl implements CusService {
	@Autowired
	CusMapper cusMapper;
	
	//고객테이블(CUS)의 기본키 데이터 생성
	@Override
	public String getCusNum() {
		return this.cusMapper.getCusNum();
	}
	
	//고객(CUS) + 소유자동차(CAR) 등록
	@Transactional //다중인서트를 해야할 때는 트랜잭셔널을 통해 오류가 났을 때 그 이전에 실행되었던것을 롤백으로 원래 상태로 돌려놓음 (rootContext파일에 설정함) 
	@Override
	public int createPost(CusVO cusVO) {
		int result = 0;
		//1) 고객(CUS) 등록(1행)
		result = this.cusMapper.createPost(cusVO);
		
		//2) 소유자동차(CAR) 등록(N행)
		List<CarVO> carVOList = cusVO.getCarVOList();
		List<CarVO> carVOListNew = new ArrayList<CarVO>();
		
		//cusNum 최신화
		for(CarVO carVO : carVOList) {
			carVO.setCusNum(cusVO.getCusNum());
			carVOListNew.add(carVO);
		}
		
		result = result + this.cusMapper.createPostCar(carVOListNew);
		log.info("result : " + result);
		
		return result;
	}
	
	@Override
	public CusVO detail(CusVO cusVO) {
		return this.cusMapper.detail(cusVO);
	}
}











