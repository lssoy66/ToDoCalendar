package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.DdayMapper;
import com.todocalendar.model.DdayVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class DdayServiceImpl implements DdayService {

	@Autowired
	private DdayMapper ddayMapper;
	
	@Override
	public List<DdayVO> selectDdayList(int member_no) {
		log.info("Service :: selectDdayList..................");
		return ddayMapper.selectDdayList(member_no);
	}
}
