package com.todocalendar.model;

import java.util.Date;

import lombok.Data;

@Data
public class ScheduleVO {

	private int schedule_no;
	private int member_no;
	private int category_no;
	private String content;
	private Date plan_date;
	private String alarm_first;
	private String alarm_second;
	private String dday;
	private String complete;
	
}
