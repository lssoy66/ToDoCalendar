package com.todocalendar.model;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class MemberVO {

	private int member_no;
	private String id;
	private String password;
	private String name;
	private String email;
	private Timestamp join_date;
	private int membership;
	private String delay_auto;
}
