package kr.or.ddit.rsv.dao;

import java.util.List;

import kr.or.ddit.vo.RsvVO;

public interface IRsvDao {
	/**
	 * 전체 예약 내역을 불러온다
	 * @return List<RsvVO> : 전체 예약 내역
	 */
	public List<RsvVO> selectRsv();
}
