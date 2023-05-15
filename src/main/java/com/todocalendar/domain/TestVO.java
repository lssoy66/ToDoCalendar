package com.todocalendar.domain;

import java.sql.Date;

import lombok.Data;

@Data
public class TestVO {
	
	public int member_no;       /* 회원번호 */ 
	public String id;           /* 아이디 */
	public String password;     /* 패스워드 */
	public String name;         /* 이름 */
	public String email;        /* 이메일 */
	public Date join_date;      /* 가입일시 */
	public int membership;      /* 멤버십 */
	public String delay_auto;   /* 자동미루기 y/n */    
	
}
