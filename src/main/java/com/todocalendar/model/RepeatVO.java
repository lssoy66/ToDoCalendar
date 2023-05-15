package com.todocalendar.model;

import java.util.Date;

import lombok.Data;

@Data
public class RepeatVO {

	private int schedule_detail_no;
	private int schedule_no;
	private Date start_date;
	private Date end_date;
	private int re_devision;
	private String re_date;
}
