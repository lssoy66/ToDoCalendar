package com.todocalendar.model;

import java.sql.Timestamp;

import lombok.Data;

/**
 * 회원(MEMBER)
 *
 */
@Data
public class MemberVO {

	private int member_no;        /* 회원번호(PK) */
	private String id;            /* 아이디 */
	private String password;      /* 패스워드 */
	private String name;          /* 이름 */
	private String email;         /* 이메일 */
	private Timestamp join_date;  /* 가입일시 */
	private int membership;       /* 멤버십 */
	private String delay_auto;    /* 자동미루기 Y/N */
}
