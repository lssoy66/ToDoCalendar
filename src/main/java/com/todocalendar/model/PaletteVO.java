package com.todocalendar.model;

import lombok.Data;

/**
 * 팔레트(PALETTE)
 *
 */
@Data
public class PaletteVO {

	private int color_code;		  /* 컬러코드(PK) */
	private String color_name;    /* 컬러이름 */
	private String hex_code;      /* 헥스코드 */
	private int membership;       /* 멤버쉽 */
}
