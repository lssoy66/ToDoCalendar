package com.todocalendar.model;

import lombok.Data;

/**
 * 카테고리(CATEGORY)
 *
 */
@Data
public class CategoryVO {

	private int category_no;      /* 카테고리번호(PK) */
	private int member_no;        /* 회원번호(FK) */
	private String category_nm;   /* 카테고리이름 */
	private int color_code;       /* 컬러코드(FK) */
}
