package com.todocalendar.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.todocalendar.mapper.CategoryMapper;
import com.todocalendar.model.CategoryVO;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
@AllArgsConstructor
public class CategoryServiceImpl implements CategoryService {

	@Autowired
	private CategoryMapper categoryMapper;

	@Override
	public void insertCategory(CategoryVO category) {
		log.info("insertCategory.........");
		categoryMapper.insertCategory(category);
	}

	@Override
	public List<CategoryVO> selectCategoryList(CategoryVO category) {
		log.info("Service :: selectCategoryList...................");
		return categoryMapper.selectCategoryList(category);
	}

}
