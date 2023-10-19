package kr.or.ddit.rsv.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;

import kr.or.ddit.mybatis.config.MyBatisUtil;
import kr.or.ddit.vo.RsvVO;

public class RsvDaoImpl implements IRsvDao {
	
	private static IRsvDao dao;
	private SqlSession session;
	
	public static IRsvDao getInstance() {
		if(dao == null) dao = new RsvDaoImpl();
		return dao;
	}
	
	// 예약 전체 내역 조회
	@Override
	public List<RsvVO> selectRsv() {
		session = MyBatisUtil.getSqlSession();
		List<RsvVO> list = null;
		
		try {
			list = session.selectList("rsv.selectRsv");
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			session.commit();
			session.close();
		}	
		return list;
	}

}
