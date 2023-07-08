package com.todocalendar.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.todocalendar.model.DdayVO;

public interface DdayMapper {
	
	public List<DdayVO> selectDdayList(@Param("member_no") int member_no);

}
