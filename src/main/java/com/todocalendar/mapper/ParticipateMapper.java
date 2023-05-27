package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.model.ParticipateVO;

public interface ParticipateMapper {

	/**
	 * 참여회원 저장
	 */
	public void insertParticipate(ParticipateVO participate);

	/**
	 * 참여회원 목록
	 */
	public List<ParticipateVO> selectParticipateList(ParticipateVO participate);

}