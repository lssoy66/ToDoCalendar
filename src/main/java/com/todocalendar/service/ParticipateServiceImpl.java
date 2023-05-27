package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.ParticipateMapper;
import com.todocalendar.model.ParticipateVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class ParticipateServiceImpl implements ParticipateService {

	@Autowired
	private ParticipateMapper participateMapper;

	@Override
	public void insertParticipate(ParticipateVO participate) {
		log.info("insertParticipate.........");
		participateMapper.insertParticipate(participate);
	}

	@Override
	public List<ParticipateVO> selectParticipateList(ParticipateVO participate) {
		log.info("Service :: selectParticipateList...................");
		return participateMapper.selectParticipateList(participate);
	}

}
