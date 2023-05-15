package com.todocalendar.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class ParticipateVO {
	
	private int member_no;
	private int schedule_no;
	private Timestamp prtcp_date;

}
