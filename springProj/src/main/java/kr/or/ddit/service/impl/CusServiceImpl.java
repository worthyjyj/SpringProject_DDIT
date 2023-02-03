package kr.or.ddit.service.impl;

import java.sql.SQLException;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.ddit.dao.CusDao;
import kr.or.ddit.dao.LprodDao;
import kr.or.ddit.service.CusService;
import kr.or.ddit.service.LprodService;
import kr.or.ddit.vo.AttachVO;
import kr.or.ddit.vo.LprodVO;
import lombok.extern.slf4j.Slf4j;


@Slf4j
@Service
public class CusServiceImpl implements CusService {
	@Autowired
	CusDao cusdao; 
	
	//다음 값 가져오는 메서드 
	public String getNextNum() {
		return this.cusdao.getNextNum(); 
	}
}
