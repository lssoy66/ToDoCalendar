package com.todocalendar.model;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.jsonFormatVisitors.JsonFormatTypes;

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
	private String category_nm;       /* 카테고리이름 */
	private String content;        /* 내용 */
	//@JsonFormat(shape=JsonFormat.Shape.STRING, pattern = "yyyy-MM-dd", timezone="Asia/Seoul")
	private Date plan_date;        /* 날짜 */
	private String dday;           /* 디데이 */
	private String dday_nm;		   /* 디데이구분명 */
	private String dday_cnt;	   /* 디데이일수 */
	private String complete;       /* 완료Y/N */

	private String plan_date2;

	private String month;
	private String day;

}
