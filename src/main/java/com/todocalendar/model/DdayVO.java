package com.todocalendar.model;

import lombok.Data;

/**
 * 일정(SCHEDULE) + 반복(REPEAT)
 * 
 */

@Data
public class DdayVO {
	
	private ScheduleVO schedule;	/* ScheduleVO */
	private RepeatVO repeat;		/* RepeatVO */
}
