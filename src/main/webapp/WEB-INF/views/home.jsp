<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="now_FD" value="${now }" pattern="yyyy-MM-dd"/>
<fmt:formatDate var="now_FD_yy" value="${now }" pattern="yyyy"/>

<!DOCTYPE html>
<html lang="kr">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<meta name="description" content="">
	<meta name="author" content="">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>

	<title>To Do Calendar</title>

	<!-- Bootstrap Core CSS -->
	<link href="resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

	<!-- MetisMenu CSS -->
	<link href="resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

	<!-- Custom CSS -->
	<link href="resources/dist/css/sb-admin-2.css" rel="stylesheet">

	<!-- Morris Charts CSS -->
	<link href="resources/vendor/morrisjs/morris.css" rel="stylesheet">

	<!-- Custom Fonts -->
	<link href="resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

	<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
	<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
	<!--[if lt IE 9]>
	        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
	        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
	    <![endif]-->

	<!-- Calendar CSS -->
	<link href="resources/css/calendar-style.css" rel="stylesheet">

	<!-- Bootstrap Toggle -->
	<link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">
</head>

<body>
	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
					<span class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="./home">To do Calendar</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">
				<!-- /.dropdown -->
				<c:if test="${member != null }">
					<div id="member_no" style="display:none">${member.member_no }</div>
					<li class="dropdown">
						<a class="dropdown-toggle" data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i> ${member.name }님 <i class="fa fa-caret-down"></i></a>
						<ul class="dropdown-menu dropdown-user">
							<li>
								<a><i class="fa fa-star fa-fw"></i>
								<c:choose>
									<c:when test="${member.membership == 1 }">
										베이직
									</c:when>
									<c:otherwise>
										프리미엄
									</c:otherwise>
								</c:choose>
								</a>
							</li>
							<li class="divider"></li>
							<li><a href="pages/mypage"><i class="fa fa-user fa-fw"></i> 사용자 정보 수정</a></li>
							<li class="divider"></li>
							<li><a href="pages/logout"><i class="fa fa-sign-out fa-fw"></i> 로그아웃</a></li>
						</ul> <!-- /.dropdown-user -->
					</li>
				</c:if>

				<c:if test="${member == null }">
					회원 정보 없음
				</c:if>
				<!-- /.dropdown -->

				<!-- /.dropdown -->
				<c:if test="${member != null }">
					<div id="member_no" style="display:none">${member.member_no }</div>
					<li class="dropdown"><a class="dropdown-toggle" data-toggle="dropdown" href="#"> <i class="fa fa-ellipsis-h fa-fw"></i></a>
						<ul class="dropdown-menu dropdown-user" style="width: max-content;">
							<li><a href="#"><i class="fa fa-user fa-fw"></i> 카테고리 관리</a></li>
							<li><a href="#"><i class="fa fa-gear fa-fw"></i> 알림 관리</a></li>
							<li><a href="#"><i class="fa fa-gear fa-fw"></i> 디데이 관리</a></li>
							<li><a href="#"><i class="fa fa-gear fa-fw"></i> 참여회원 관리</a></li>
							<li class="divider"></li>
							<li>
								<a><i class="fa fa-gear fa-fw"></i> 설정</a>
								<div>
									<ul>
										<li>
											<div>
												<span>공휴일 자동 표시</span>
												<input data-toggle="toggle" id="publicAutoN" type="checkbox">
											</div>
										</li>
										<li>
											<div>
												<span>자동 미루기</span>
												<c:choose>
													<c:when test="${member.delay_auto eq 'Y' }">
														<input data-toggle="toggle" id="delayAutoY" type="checkbox" checked="checked">
													</c:when>
													<c:otherwise>
														<input data-toggle="toggle" id="delayAutoN" type="checkbox">
													</c:otherwise>
												</c:choose>
											</div>
										</li>
									</ul>
								</div>
							</li>

						</ul>
						<!-- /.dropdown-user -->
					</li>
				</c:if>
				<!-- /.dropdown -->

			</ul>
			<!-- /.navbar-top-links -->

			<div class="navbar-default sidebar" role="navigation">
				<div class="sidebar-nav navbar-collapse">
					<ul class="nav" id="side-menu">
						<li class="sidebar-search">

							<div class="input-group custom-search-form">
                                <legend style="border-bottom: none;"><a style="text-decoration: none; font-weight: bold;">D-day</a></legend>
                                <ul class="nav">
                                    <li style="border-bottom: none;">
	                                    <c:forEach var="dday" items="${ddayList }" varStatus="status">
	                                    <!-- DDAY 컬럼의 값이 1(D-day)인 것만 보여준다. -->
	                                    	<c:if test="${dday.schedule.dday == 1 }">
	                                    	<!--
	                                    	formatDate는 날짜 및 시간 값을 지정한 형식으로 변경해준다.
	                                    	parseDate는 String타입으로 표시된 날짜 및 시간 값을 Date타입으로 파싱해준다.
	                                    	 -->
	                                    		<fmt:formatDate var="planDate_FD"  value="${dday.schedule.plan_date }" pattern="yyyy-MM-dd"/>

		                                    	<fmt:parseDate var="now_PD" value="${now_FD }" pattern="yyyy-MM-dd" />
		                                    	<fmt:parseDate var="planDate_PD" value="${planDate_FD }" pattern="yyyy-MM-dd" />

		                                    	<fmt:parseNumber var="now_PN" value="${now_PD.time/(1000*60*60*24) }" integerOnly="true" />
		                                    	<fmt:parseNumber var="planDate_PN" value="${planDate_PD.time/(1000*60*60*24) }" integerOnly="true" />

		                                		<!--
		                                		지정 날짜에서 현재 날짜의 일 수 차이를 구하고 그 값이 (-)가 아닐 때에만 D-day와 내용을 보여준다.
		                                		-->
		                                		<c:set var="d_day" value="${planDate_PN-now_PN }" />
		                                		<c:if test="${d_day > 0 }">
		                                			<a>· ${dday.schedule.content } D-${d_day }</a>
		                                		</c:if>
	                                    	</c:if>
	                                	</c:forEach>
                                    </li>
                                </ul>
                            </div>

						</li>
						<li class="sidebar-search">

							<div class="input-group custom-search-form">
                                <legend style="border-bottom: none;"><a style="text-decoration: none; font-weight: bold;">기념일</a></legend>
                                <ul class="nav">
                                    <li style="border-bottom: none;">
                                    	<c:forEach var="anniversary" items="${ddayList }" varStatus="status">
	                                    	<!-- DDAY 컬럼의 값이 2(D-day)인 것만 보여준다. -->
	                                    	<c:if test="${anniversary.schedule.dday == 2 }">
	                                    	<!--
	                                    	formatDate는 날짜 및 시간 값을 지정한 형식으로 변경해준다.
	                                    	parseDate는 String타입으로 표시된 날짜 및 시간 값을 Date타입으로 파싱해준다.
	                                    	 -->
	                                    		<fmt:formatDate var="planDate_FD"  value="${anniversary.schedule.plan_date }" pattern="yyyy-MM-dd"/>

		                                    	<fmt:parseDate var="now_PD" value="${now_FD }" pattern="yyyy-MM-dd" />
		                                    	<fmt:parseDate var="planDate_PD" value="${planDate_FD }" pattern="yyyy-MM-dd" />

		                                    	<fmt:parseNumber var="now_PN" value="${now_PD.time/(1000*60*60*24) }" integerOnly="true" />
		                                    	<fmt:parseNumber var="planDate_PN" value="${planDate_PD.time/(1000*60*60*24) }" integerOnly="true" />

		                                		<!--
		                                		현재 날짜에서 지정 날짜 까지의 일 수 차이를 구하고 그 값이 (-)가 아닐 때에만 D-Day(기념일)와 내용을 보여준다.
		                                		(기념일이란 과거의 날짜로부터 현재 날짜까지 얼마나 지나왔는지)
		                                		-->
		                                		<c:set var="anni" value="${now_PN-planDate_PN }" />
		                                		<c:if test="${anni > 0 }">
		                                			<a>· ${anniversary.schedule.content } D+${anni }</a>
		                                		</c:if>
	                                    	</c:if>
	                                	</c:forEach>
                                    </li>
                                </ul>
                            </div>

						</li>
						<li class="sidebar-search">
                            <div class="input-group custom-search-form" \>
                                <legend style="border-bottom: none;"><a style="text-decoration: none; font-weight: bold;">Today Check List</a></legend>
                            </div>

                            <c:forEach var="category" items="${categoryList }" varStatus="status">
                            <!--여기부터-->
                            <c:forEach var="palette" items="${paletteList }" varStatus="status">
	                            <c:if test="${category.color_code eq palette.color_code }">
	                            	<a href="#" style="text-decoration: none; color: ${palette.hex_code};">
		                            	<i class="fa fa-folder fa-fw"></i> ${category.category_nm }
		                            	<span class="fa arrow"></span>
	                            	</a>
	                            </c:if>
                            </c:forEach>

                            <ul class="nav nav-second-level">
	                            <c:forEach var="schedule" items="${scheduleList }" varStatus="status">
	                            <fmt:formatDate var="planDate_FD"  value="${schedule.plan_date }" pattern="yyyy-MM-dd"/>
	                            	<c:if test="${category.category_no == schedule.category_no }">
	                            		<li style="border-bottom: none;">
		                            		<c:if test="${now_FD == planDate_FD }">
		                            			<c:choose>
		                            				<c:when test="${schedule.complete eq 'Y' }">
		                            					<a><input type="checkbox" id="todayComplete${schedule.schedule_no }" value="${schedule.schedule_no }" checked="checked"> ${schedule.content }</a>
		                            				</c:when>
				                                   	<c:otherwise>
				                                   		<a><input type="checkbox" id="todayComplete${schedule.schedule_no }" value="${schedule.schedule_no }" > ${schedule.content }</a>
				                                   	</c:otherwise>
				                                </c:choose>
		                            		</c:if>
			                            </li>
	                               	</c:if>
	                            </c:forEach>
                            </ul>
                            <!--여기까지가 한 카테고리-->
                            </c:forEach>

                            <a style="text-align: right">
                            	달성도<span id="y_count"> ${y_count }</span> / ${all_count }
                            </a>
                        </li>
				</div>
				<!-- /.sidebar-collapse -->
			</div>
			<!-- /.navbar-static-side -->
		</nav>

		<div id="page-wrapper">
			<div class="row"></div>
			<div class="row" style="padding-top: 50px;">
				<div class="col-lg-12">
					<!-- 캘린더 -->
					<div class="visit-div" style="padding-top: 20px;">

						<div class="sec_cal" style="padding-bottom: 30px;">
							<div class="cal_nav">
								<a href="javascript:;" class="nav-btn go-prev">prev</a>
								<div class="year-month"></div>
								<div class="year" id="year" style="display:none"></div>
								<div class="month" id="month" style="display:none"></div>
								<a href="javascript:;" class="nav-btn go-next">next</a>
							</div>
							<div class="cal_wrap">
								<div class="days">
									<div class="day">월</div>
									<div class="day">화</div>
									<div class="day">수</div>
									<div class="day">목</div>
									<div class="day">금</div>
									<div class="day">토</div>
									<div class="day">일</div>
								</div>
								<div class="dates"></div>
							</div>
						</div>
					</div>
				</div>
			</div>

		</div>
		<!-- /#page-wrapper -->


		<!-------------------------------
			* modal
		--------------------------------->

		<!-- 날짜 클릭 Modal -->
		<div class="modal fade" id="todoListModal" tabindex="-1" role="dialog" aria-labelledby="todoListModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"	data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="modalTitle">To-Do List</h4>
					</div>
					<div class="modal-body" id="modalDate">Modal Date</div>
					<div class="modal-body" id="modalTodoList">
						<div class="col-lg-12">
							<div class="panel panel-default">
								<div class="panel-body">
									<div class="panel-group" id="modalTodoList">
										<!-- 카테고리 및 일정 -->
									</div>
								</div>
							</div>
						</div>
					</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-primary" onclick="addNewScheduleClick()">새로운 일정 추가</button>
						<button type="button" class="btn btn-default" data-dismiss="modal">닫기</button>
					</div>
				</div><!-- /.modal-content -->
			</div><!-- ./modal-dialog -->
		</div><!-- /.modal -->

		<!-- 새로운 일정 추가 Modal -->
		<div class="modal fade" id="addNewScheduleModal" tabindex="-1" role="dialog" aria-labelledby="addNewScheduleLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"	data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="modalTitle">새로운 일정 추가하기</h4>
					</div>
					<form role="form" id="addNewScheduleForm" action="./pages/addSchedule" method="post">
						<div class="modal-body" id="addNewScheDate">Modal Date</div>
						<div class="modal-body">
			                <input type="text" class="form-control" name="content" placeholder="새로운 할 일을 적어주세요." ><hr>
			                <input type="hidden" name="member_no" value="">
			                <div class="form-group">
								<label>카테고리</label>
								<select class="form-control" name="category_no">
									<c:forEach var="item" items="${categoryList }" varStatus="status">
										<option value="${item.category_no}">${item.category_nm}</option>
									</c:forEach>
								</select>
								<button type="button" class="btn btn-link">새로운 카테고리 추가</button>
			                </div>
			                <!-- <input type="date" name="plan_date" value="2023-08-19"> -->
			                <input type="hidden" name="plan_date2" value="">
			                <div class="form-group">
								<label>반복여부</label>
								<div class="radio">
									<label><input type="radio" name="dday" value="0">없음</label>
								</div>
								<div class="radio">
									<label><input type="radio" name="dday" value="1">디데이</label>
								</div>
								<div class="radio">
									<label><input type="radio" name="dday" value="2">기념일</label>
								</div>
							</div>
			                <input type="hidden" name="complete" value="N">
						</div>
						<div class="modal-footer">
			                <input type="button" class="btn btn-primary" onclick="addScheduleSubmit();" value="저장">
			            </div>
		            </form>
				</div><!-- /.modal-content -->

			</div><!-- ./modal-dialog -->
		</div><!-- /.modal -->

		<!-- 일정 상세 수정 Modal -->
		<div class="modal fade" id="updateScheduleModal" tabindex="-1" role="dialog" aria-labelledby="updateScheduleLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"	data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="modalTitle">일정 수정하기</h4>
					</div>
					<form role="form" id="updateScheduleForm" action="#" method="post">
						<div class="modal-body" id="updateScheDate">Modal Date</div>
						<div class="modal-body">
			                <input type="text" class="form-control" name="content" placeholder="새로운 할 일을 적어주세요." ><hr>
			                <input type="hidden" name="schedule_no" value="">
			                <input type="hidden" name="member_no" value="">
			                <div class="form-group">
								<label>카테고리</label>
								<select class="form-control" name="category_no">
									<c:forEach var="item" items="${categoryList }" varStatus="status">
										<option value="${item.category_no}">${item.category_nm}</option>
									</c:forEach>
								</select>
								<button type="button" class="btn btn-link">새로운 카테고리 추가</button>
			                </div>
			                <!-- <input type="date" name="plan_date" value="2023-08-19"> -->
			                <input type="hidden" name="plan_date2" value="">
			                <div class="form-group">
								<label>반복여부</label>
								<div class="radio">
									<label><input type="radio" name="dday" value="0">없음</label>
								</div>
								<div class="radio">
									<label><input type="radio" name="dday" value="1">디데이</label>
								</div>
								<div class="radio">
									<label><input type="radio" name="dday" value="2">기념일</label>
								</div>
							</div>
			                <input type="hidden" name="complete" value="N">
						</div>
						<div class="modal-footer">
			                <input type="button" class="btn btn-primary" onclick="updateScheduleSubmit('update');" value="수정">
			                <input type="button" class="btn btn-danger"  onclick="updateScheduleSubmit('delete');" value="삭제">
			                <!-- <button type="button" class="btn btn-default" data-dismiss="modal">닫기</button> -->
			            </div>
		            </form>
				</div><!-- /.modal-content -->

			</div><!-- ./modal-dialog -->
		</div><!-- /.modal -->

	</div><!-- /#wrapper -->


	<!-------------------------------
		* script
	--------------------------------->

	<!-- jQuery -->
	<script src="resources/vendor/jquery/jquery.min.js"></script>

	<!-- Bootstrap Core JavaScript -->
	<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>

	<!-- Metis Menu Plugin JavaScript -->
	<script src="resources/vendor/metisMenu/metisMenu.min.js"></script>

	<!-- Morris Charts JavaScript -->
	<script src="resources/vendor/raphael/raphael.min.js"></script>
	<script src="resources/vendor/morrisjs/morris.min.js"></script>
	<script src="resources/data/morris-data.js"></script>

	<!-- Custom Theme JavaScript -->
	<script src="resources/dist/js/sb-admin-2.js"></script>

	<!-- Calendar JavaScript -->
	<script src="resources/js/calendar.js"></script>

	<!-- Bootstrap Toggle -->
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>

    <script type="text/javascript">

	<!-- Today Check List 체크박스 on/off -->
	<c:forEach var="schedule" items="${scheduleList}" varStatus="status">
	//$(document).ready(function() {

		/*
		$(document).on("change", "#completeY${status.count}", function() {				// checkBox
			$("#completeY${status.count}").removeAttr("checked");
			$("#completeY${status.count}").attr("id", "completeN${status.count}");
			var value = $("#completeN${status.count}").val();
			//console.log(value);

			//Ajax로 전송
			$.ajax({
				url : './ChangeComplete',
				data : {
					complete : 'N',
					schedule_no : value
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					//console.log("success Y to N ");
					//console.log(result.scheduleCount.y_count);
					$("#y_count").html(" <span id='y_count'>" + result.scheduleCount.y_count + "</span>");		// 달성도
				}
			}); //End Ajax
		});

		$(document).on("change", "#completeN${status.count}", function() {
			$("#completeN${status.count}").attr("checked", "checked");
			$("#completeN${status.count}").attr("id", "completeY${status.count}");	// id를 변경함 ex. completeN$1 -> completeY$1
			var value = $("#completeY${status.count}").val();	// schedule_no
			//console.log(value);

			//Ajax로 전송
			// 해당 schedule_no(value)의 데이터에 대해, complete = 'Y'로 update
			$.ajax({
				url : './ChangeComplete',
				data : {
					complete : 'Y',
					schedule_no : value
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					//console.log("success N to Y ");
					//console.log(result.scheduleCount.y_count);
					$("#y_count").html(" <span id='y_count'>" + result.scheduleCount.y_count + "</span>");	// 달성도
				}
			}); //End Ajax
		});
		*/

		// Today CheckList 일정 check/unckeck
		$(document).on("change", "#todayComplete${schedule.schedule_no}", function() {
			var schedule_no = $("#todayComplete${schedule.schedule_no}").val();
			var completeYN = $("#todayComplete${schedule.schedule_no}").prop("checked");	// 현재 달성여부
			var todayYN = "Y";

			if(completeYN) {
				// N to Y
				checkSchedule(schedule_no, todayYN);
			}
			else if(!completeYN) {
				// Y to N
				uncheckSchedule(schedule_no, todayYN);
			}

		});

		// 달력 일정 check/unckeck
		// 달력에 표시되는 일정의 check/uncheck는 모달에서만 변경 가능
		$(document).on("change", "#modalComplete${schedule.schedule_no}", function() {
			var schedule_no = $("#modalComplete${schedule.schedule_no}").val();
			var completeYN = $("#modalComplete${schedule.schedule_no}").prop("checked");	// 현재 달성여부

			var todayYN = "N";
			var nowDate = "${now_FD }";				  // 오늘 날짜
			var date = dateScheduleList[0].plan_date; // (dateScheduleList는 현재 띄워진 Modal 날짜에 해당하는 모든 일정 정보를 가지고 있음)
			if(nowDate == date) todayYN = "Y";

			if(completeYN) {
				// N to Y
				checkSchedule(schedule_no, todayYN);
			}
			else if(!completeYN) {
				// Y to N
				uncheckSchedule(schedule_no, todayYN);
			}

		});

	//});
	</c:forEach>

	/* ************************************
	 * check / uncheck Ajax 전송
	************************************ */
	function checkSchedule(schedule_no, todayYN) {

		var todayCompleteId = "#todayComplete" + schedule_no;
		var completeId = "#complete" + schedule_no;				// 달력 표시 일정
		var modalCompleteId = "#modalComplete" + schedule_no;	// 날짜 클릭 상세정보 일정(modal)

		// check 상태로 변경하는 ajax 호출
		$.ajax({
			url : './ChangeComplete',
			data : {
				complete : 'Y',
				schedule_no : schedule_no
			},
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				//console.log("success N to Y ");

				// 일정 check 표시
				if(todayYN == "Y") {	// 오늘의 일정이면 Today CheckList + 달력 일정 함께 변경
					$(todayCompleteId).prop("checked", true);
				}
				$(completeId).prop("checked", true);
				$(modalCompleteId).prop("checked", true);

				// scheduleList의 complete 변경(modal 표시 시에 필요)
				for(var i = 0; i < scheduleList.length; i++) {
					var schedule = scheduleList[i];
					if(schedule.schedule_no == schedule_no) {
						schedule.complete = 'Y';
					}
				}

				// 달성도
				$("#y_count").html(" <span id='y_count'>" + result.scheduleCount.y_count + "</span>");
			}
		});
	}

	function uncheckSchedule(schedule_no, todayYN) {

		var todayCompleteId = "#todayComplete" + schedule_no;
		var completeId = "#complete" + schedule_no;				// 달력 표시 일정
		var modalCompleteId = "#modalComplete" + schedule_no;	// 날짜 클릭 상세정보 일정(modal)

		// uncheck 상태로 변경하는 ajax 호출
		$.ajax({
			url : './ChangeComplete',
			data : {
				complete : 'N',
				schedule_no : schedule_no
			},
			type : 'POST',
			dataType : 'json',
			success : function(result) {
				//console.log("success Y to N ");

				// 일정 check 속성 삭제
				if(todayYN == "Y") {	// 오늘의 일정이면 Today CheckList + 달력 일정 함께 변경
					$(todayCompleteId).prop("checked", false);
				}
				$(completeId).prop("checked", false);
				$(modalCompleteId).prop("checked", false);

				// scheduleList의 complete 변경(modal 표시 시에 필요)
				for(var i = 0; i < scheduleList.length; i++) {
					var schedule = scheduleList[i];
					if(schedule.schedule_no == schedule_no) {
						schedule.complete = 'N';
					}
				}

				// 달성도
				$("#y_count").html(" <span id='y_count'>" + result.scheduleCount.y_count + "</span>");
			}
		});
	}

	/* 설정 관련 */
	$(document).ready(function() {

		//공휴일 자동 표시
		$(document).on("change", "#publicAutoY", function(){
			console.log("Y->N");
			$("#publicAutoY").removeAttr("checked");
			$("#publicAutoY").attr("id", "publicAutoN");

			var year = $("#year").text();
			var month = $("#month").text();

			//Ajax로 전송
			$.ajax({
				url : './GetHoliday',
				data : {
					year : year,
					month : month
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					if(result != "") {
						//div id가 dateiDay인 것들을 전부 조회하여 dateiDay의 .text()값과 조회해온 공휴일 날짜를 비교하여 일치하면 dateContent에 .append()한다.
						for(var i = 1; i <= 31; i++) {
							for(var j = 0; j < result.length; j++) {
								var dateName = result[j].dateName;
								var dateId;
								//ex)공휴일이 20231003이면 끝의 한 자리만 잘라내고 20231225면 끝의 두 자리면 잘라낸다.
								if(((result[j].locdate).toString()).slice(-2).match("0")) {
									dateId = "date" + ((result[j].locdate).toString()).slice(-1);
								}
								else {
									dateId = "date" + ((result[j].locdate).toString()).slice(-2);
								}
								var dateContentId = dateId + "Content";

								var date = ((result[j].locdate).toString()).slice(-1);

								if ($("#date" + i + "Day").text() == ((result[j].locdate).toString()).slice(-1) || $("#date" + i + "Day").text() == ((result[j].locdate).toString()).slice(-2)) {
									$("#" + dateContentId).empty();
								}
							}
						}
					}
				}
			}); //End Ajax
		});

    	$(document).on("change", "#publicAutoN", function(){
    		console.log("N->Y");
			$("#publicAutoN").attr("checked", "checked");
			$("#publicAutoN").attr("id", "publicAutoY");

			var year = $("#year").text();
			var month = $("#month").text();

			//Ajax로 전송
			$.ajax({
				url : './GetHoliday',
				data : {
					year : year,
					month : month
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					if(result != "") {
						//div id가 dateiDay인 것들을 전부 조회하여 dateiDay의 .text()값과 조회해온 공휴일 날짜를 비교하여 일치하면 dateContent에 .append()한다.
						for(var i = 1; i <= 31; i++) {
							for(var j = 0; j < result.length; j++) {
								var dateName = result[j].dateName;
								var dateId;
								//ex)공휴일이 20231003이면 끝의 한 자리만 잘라내고 20231225면 끝의 두 자리면 잘라낸다.
								if(((result[j].locdate).toString()).slice(-2).match("0")) {
									dateId = "date" + ((result[j].locdate).toString()).slice(-1);
								}
								else {
									dateId = "date" + ((result[j].locdate).toString()).slice(-2);
								}
								var dateContentId = dateId + "Content";

								var date = ((result[j].locdate).toString()).slice(-1);

								if ($("#date" + i + "Day").text() == ((result[j].locdate).toString()).slice(-1) || $("#date" + i + "Day").text() == ((result[j].locdate).toString()).slice(-2)) {
									$("#" + dateId).css("color", "#ff0000");
									$("#" + dateContentId).append("<br>");
									$("#" + dateContentId).append("<a></a>&nbsp");
									$("#" + dateContentId).append(dateName).css("color", "#ff0000");
								}
							}
						}
					}
				}
			}); //End Ajax
		});

		//자동 미루기
		$(document).on("change", "#delayAutoY", function(){
			$("#delayAutoY").removeAttr("checked");
			$("#delayAutoY").attr("id", "delayAutoN");

			//Ajax로 전송
			$.ajax({
				url : './pages/ChangeDelayAuto',
				data : {
					delay_auto : 'N'
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log("success Y to N ");
				}
			}); //End Ajax
		});

    	$(document).on("change", "#delayAutoN", function(){
			$("#delayAutoN").attr("checked", "checked");
			$("#delayAutoN").attr("id", "delayAutoY");

			//Ajax로 전송
			$.ajax({
				url : './pages/ChangeDelayAuto',
				data : {
					delay_auto : 'Y'
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log("success N to Y ");
				}
			}); //End Ajax
		});
	});

	var scheduleList = [];			// 이번달 스케줄 리스트(JSON)
	var dateScheduleList = [];		// 해당 날짜의 일정 목록(JSON)
	/*
		[
			{
				category_no:1
			  , category_nm:"공부"
			  , complete:"N"
			  , content:"♥락페스티벌 당일♥"
			  , day:"5"
			  , dday:"1"
			  , dday_cnt:"7"
			  , dday_nm:"디데이"
			  , member_no:1
			  , month:"8"
			  , plan_date:"2023-08-05"
			  , schedule_no:13
			},
			{
				...
			}
		]
	*/

	var categoryList = [];			// 사용자 카테고리 리스트(JSON)
	<c:forEach var="item" items="${categoryList }" varStatus="status">
		var data = { "category_no":${item.category_no}, "category_nm":"${item.category_nm}", "color_code":${item.color_code} };
		categoryList.push(data);
	</c:forEach>
	/*
		[
			{category_no: 1, category_nm: '공부', color_code: 1},
			{category_no: 2, category_nm: '취미', color_code: 2}
		]
	*/

	/* 일정 저장 후 alert 표시 + 이전 모달 다시 road */
	$(document).ready(function() {

		var result = '<c:out value="${msg }"/>';
		var resultStatus = '<c:out value="${status }"/>';
		if(result != '' && result == "success") {
			if(resultStatus == "insert") {
				alert("저장이 완료되었습니다.");

				var plan_date = '<c:out value="${plan_date }"/>';		// 2023-08-31
				var date = plan_date.replace(/-/g, '');					// 20230831

				document.getElementById("year").innerHTML = date.substring(0, 4);
				document.getElementById("month").innerHTML = date.substring(4, 6);

				dateClick(date.slice(-2));
			}
			else if(resultStatus == "update") {
				alert("수정이 완료되었습니다.");
			}
			else if(resultStatus == "delete") {
				alert("삭제되었습니다.");
			}
		}
	});

	// 이번달 스케줄 리스트 가져오기
	function getScheduleByMonth() {

		scheduleList = [];
		var month = document.getElementById("month").innerHTML;
		var member_no = document.getElementById("member_no").innerHTML;
		var data = JSON.stringify({'month': month, 'member_no':member_no});

		$.ajax({
			url : './pages/scheduleListByMonth',
			type : 'POST',
			contentType : "application/json; charset=utf-8",		// 전송할 데이터 타입(JSON)
			dataType : 'json',										// 받을 데이터 타입(JSON)
			data: data,

			success : function(result){
				if(result != "") {
					for(var i = 0; i < result.length; i++) {
						var dateId = "#date" + result[i].day;
						var dateContentId = dateId + "Content";

						var completeId = "complete" + result[i].schedule_no;
						var complete = result[i].complete;

						// Content에 일정 추가
						$(dateContentId).append("<br>");
						if(complete == "Y") {
							$(dateContentId).append("<input type='checkbox' id='" + completeId + "' value='' checked='checked' onClick='return false' >&nbsp");
						}
						else {
							$(dateContentId).append("<input type='checkbox' id='" + completeId + "' value='' onClick='return false' >&nbsp");
						}
						$(dateContentId).append(result[i].content);
						scheduleList.push(result[i]);
					}
				}
			}
		});
	}

	// 날짜 클릭 시 Modal(todoListModal) 호출
	function dateClick(dateDay) {
		var day = dateDay.toString();

		// 클릭한 날짜의 일정 목록 가져오기
		dateScheduleList = [];
		for(var i = 0; i < scheduleList.length; i++) {
			if(scheduleList[i].day == day) {
				dateScheduleList.push(scheduleList[i]);
			}
		}

		var str = "";				// Modal에 채울 카테고리 + 일정 리스트
		var notEmptyCateList = [];	// 일정이 존재하는 카테고리

		for(var i = 0; i < categoryList.length; i++) {

			// 1. 카테고리 이름(category_nm) 표시(폴더)
			str += '<div class="panel panel-default">';
			str += '<a data-toggle="collapse" data-parent="#modalTodoList" href="#collapseOne' + i + '" aria-expanded="true" class="">';		// 각 카테고리의 일정 그룹 아이디 : collapseOne + i
			str += '<div class="panel-heading"><h4 class="panel-title">';
			str += categoryList[i].category_nm;
			str += '</h4>';
			str += '</a>';
			str += '</div>';

			// 2. 폴더 아래 해당 카테고리의 일정들 표시
			/*
				카테고리 펼치기	: class="panel-collapse collapse in"
				카테고리 접기	: class="panel-collapse collapse"
			*/
			str += '<div id="collapseOne' + i + '" class="panel-collapse collapse" aria-expanded="true" style="">';
			str += '<div class="panel-body">';
			str += '<ul class="nav nav-second-level">';

			// 일정 반복
			var category_no = categoryList[i].category_no;
			for(var k = 0; k < dateScheduleList.length; k++) {
				var dateSchedule = dateScheduleList[k];
				if(dateSchedule.category_no == category_no) {		// 일치하는 카테고리의 일정들만 표시

					// 일정이 존재하는 카테고리 id 추가
					if(notEmptyCateList > 0) {
						if(notEmptyCateList[notEmptyCateList.length-1] != i) {
							notEmptyCateList.push(i);
						}
					}
					else {
						notEmptyCateList.push(i);
					}

					str += '<li style="border-bottom: none;">';

					// 일정 달성여부 표시(checkBox) + 일정 내용 표시
					var schedule_no = dateSchedule.schedule_no;
					var completeId = "modalComplete" + schedule_no;
					var complete = dateSchedule.complete;

					if(complete == "Y") {
						str += "<a style='display:inline;'><input type='checkbox' id='" + completeId + "' value='" + schedule_no + "' checked='checked' >";
						str += "<a href='#' style='display:inline;' onclick='updateScheduleModalOpen(" + schedule_no + ");'>" + dateSchedule.content + "</a></a>";
					}
					else {
						str += "<a style='display:inline;'><input type='checkbox' id='" + completeId + "' value='" + schedule_no + "' >";
						str += "<a href='#' style='display:inline;' onclick='updateScheduleModalOpen(" + schedule_no + ");'>" + dateSchedule.content + "</a></a>";
					}

					str += '</li>';
				}
			}
			str += '</ul>';

			str += '</div></div>';
			str += '</div>';
		}

		// 일정 내용
		$("#modalTodoList").text("");
		$("#modalTodoList").append(str);

		// 일정이 존재하는 카테고리만 펼치기
		//$("#collapseOne" + i).attr('class', 'panel-collapse collapse in');
		for(var i = 0; i < notEmptyCateList.length; i++) {
			$("#collapseOne" + notEmptyCateList[i]).addClass('in');
		}

		// 클릭한 날짜 표시
		var year = document.getElementById("year").innerHTML;
		var month = document.getElementById("month").innerHTML;
		if(month.length < 2) month = '0' + month;
		if(day.length < 2) day = '0' + day;

		$("#modalDate").text(year + '-' + month + '-' + day);		// '2023' + '-' + '08' + '-' + '13'

		$("#todoListModal").modal("show");
	}

	// 새로운 일정 추가 Modal(addNewScheduleModal) 호출
	function addNewScheduleClick() {

		// 내용 초기화
		var date = $("#modalDate").text();
		$("#addNewScheDate").text(date);
		$("#addNewScheduleForm [name='content']").val('');
		$("#addNewScheduleForm [name='dday']").prop('checked', false);
		$("#addNewScheduleForm [value='0']").prop('checked', true);

		$("#addNewScheduleForm [name='plan_date2']").val(date);
		$("#addNewScheduleForm [name='member_no']").val($("#member_no").text());

		// 모달 호출
		$("#addNewScheduleModal").modal("show");
	}

	// 새로운 일정 추가 Submit 버튼
	function addScheduleSubmit() {
		$("#addNewScheduleForm").submit();
	}

	// 일정 상세 Modal
	function updateScheduleModalOpen(schedule_no) {
		// 세팅 후 모달 호출
		var schedule = "";
		for(var i = 0; i < dateScheduleList.length; i++) {
			if(dateScheduleList[i].schedule_no == schedule_no) {
				schedule = dateScheduleList[i];
			}
		}

		//console.log(schedule);
		/*
			{ category_nm:"취미", category_no:2, complete:"N", content:"17일 새로운 일정", day:"17"
			, dday:"0", dday_cnt:"-1", dday_nm:"해당없음", member_no:1, month:"9", plan_date:1694876400000, plan_date2:null, schedule_no:53 }
		*/

		var date = $("#modalDate").text();
		$("#updateScheDate").text(date);
		$("#updateScheduleForm [name='content']").val(schedule.content);

		var category_no = schedule.category_no;
		$("#updateScheduleForm [name='category_no']").val(category_no).prop('checked', false);

		var dday = schedule.dday;
		$("#updateScheduleForm [name='dday']").prop('checked', false);
		$("#updateScheduleForm [value='"+ dday +"']").prop('checked', true);
		$("#updateScheduleForm [name='plan_date2']").val(date);

		$("#updateScheduleForm [name='member_no']").val(schedule.member_no);
		$("#updateScheduleForm [name='schedule_no']").val(schedule.schedule_no);

		// 모달 호출
		$("#updateScheduleModal").modal("show");
	}

	// 일정 상세 Modal - 수정/삭제
	function updateScheduleSubmit(status) {
		if("update" == status) {
			$("#updateScheduleForm").attr("action", "./pages/updateSchedule");
		}
		else if("delete" == status) {
		    if (!confirm("삭제하시겠습니까?")) {
		        return;
		    }
			$("#updateScheduleForm").attr("action", "./pages/deleteSchedule");
		}

		// 저장
		$("#updateScheduleForm").submit();
	}

	</script>
</body>

</html>
