package kr.or.ddit.rsv.service;

import java.util.List;

import kr.or.ddit.rsv.dao.IRsvDao;
import kr.or.ddit.rsv.dao.RsvDaoImpl;
import kr.or.ddit.vo.RsvVO;

public class RsvServiceImpl implements IRsvService {

	private IRsvDao dao;
	private static IRsvService service;
	
	private RsvServiceImpl() {
		dao = RsvDaoImpl.getInstance();
	}
	
	public static IRsvService getInstance() {
		if(service == null) service = new RsvServiceImpl();
		return service;
	}
	
	@Override
	public List<RsvVO> selectRsv() {
		return dao.selectRsv();
	}

}
