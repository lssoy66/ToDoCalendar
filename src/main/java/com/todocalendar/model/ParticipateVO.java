package com.todocalendar.model;

import java.sql.Timestamp;

import lombok.Data;

/**
 * 참여회원(PARTICIPATE)
 *
 */
@Data
public class ParticipateVO {

	private int member_no;		  /* 회원번호(FK) */
	private int schedule_no;	  /* 일정번호(FK) */
	private Timestamp prtcp_date; /* 참여일 */

}
