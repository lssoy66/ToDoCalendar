package com.todocalendar.model;

import java.util.Date;

import lombok.Data;

/**
 * 일정(SCHEDULE)
 *
 */
@Data
public class ScheduleVO {

	private int schedule_no;       /* 일정번호(PK) */
	private int member_no;         /* 회원번호(FK) */
	private int category_no;       /* 카테고리번호(FK) */
	private String content;        /* 내용 */
	private Date plan_date;        /* 날짜 */
	private String dday;           /* 디데이 */
	private String dday_nm;		   /* 디데이구분명 */
	private String dday_cnt;	   /* 디데이일수 */
	private String complete;       /* 완료Y/N */

}
