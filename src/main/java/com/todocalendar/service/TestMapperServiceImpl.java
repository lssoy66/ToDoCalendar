package com.todocalendar.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.todocalendar.domain.TestVO;
import com.todocalendar.mapper.TestMapper;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class TestMapperServiceImpl implements TestMapperService {
	
	private TestMapper testMapper;

	@Override
	public List<TestVO> testSelectMEMBER(TestVO testParam) {
		log.info("Service :: testSelectMEMBER.........................");
		return testMapper.testSelectMEMBER(testParam);
	}

}
