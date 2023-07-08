package com.todocalendar.mapper;

import java.util.List;

import com.todocalendar.model.CategoryVO;

public interface CategoryMapper {

	/**
	 * 카테고리 저장
	 */
	public void insertCategory(CategoryVO category);

	/**
	 * 카테고리 목록
	 */
	public List<CategoryVO> selectCategoryList(int member_no);
	
}