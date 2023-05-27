package com.todocalendar.model;

import java.util.Date;

import lombok.Data;

/**
 * 반복(REPEAT)
 *
 */
@Data
public class RepeatVO {

	private int schedule_no;        /* 일정번호(FK) */
	private int schedule_detail_no; /* 일정상세번호(PK) */
	private Date start_date;        /* 시작날짜 */
	private Date end_date;          /* 종료날짜 */
	private int re_devision;        /* 반복구분 */
	private String re_date;         /* 반복날 */

}
