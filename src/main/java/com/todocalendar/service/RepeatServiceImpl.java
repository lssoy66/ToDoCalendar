package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.RepeatMapper;
import com.todocalendar.model.RepeatVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class RepeatServiceImpl implements RepeatService {

	@Autowired
	private RepeatMapper repeatMapper;

	@Override
	public void insertRepeat(RepeatVO repeat) {
		log.info("insertRepeat.........");
		repeatMapper.insertRepeat(repeat);
	}

	@Override
	public List<RepeatVO> selectRepeatList(RepeatVO repeat) {
		log.info("Service :: selectRepeatList...................");
		return repeatMapper.selectRepeatList(repeat);
	}
	
	@Override
	public List<RepeatVO> selectDdayList(int member_no) {
		log.info("Service :: selectDdayList.....................");
		return repeatMapper.selectDdayList(member_no);
	}


}
