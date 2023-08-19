<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="now_FD" value="${now }" pattern="yyyy-MM-dd"/>
<fmt:formatDate var="now_FD_ym" value="${now }" pattern="yyyy-MM-"/>

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
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- MetisMenu CSS -->
<link href="resources/vendor/metisMenu/metisMenu.min.css"
	rel="stylesheet">

<!-- Custom CSS -->
<link href="resources/dist/css/sb-admin-2.css" rel="stylesheet">

<!-- Morris Charts CSS -->
<link href="resources/vendor/morrisjs/morris.css" rel="stylesheet">

<!-- Custom Fonts -->
<link href="resources/vendor/font-awesome/css/font-awesome.min.css"
	rel="stylesheet" type="text/css">

<!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
<!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
<!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->

<!-- Calendar CSS -->
<link href="resources/css/calendar-style.css" rel="stylesheet">

</head>

<body>

	<div id="wrapper">

		<!-- Navigation -->
		<nav class="navbar navbar-default navbar-static-top" role="navigation"
			style="margin-bottom: 0">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle" data-toggle="collapse"
					data-target=".navbar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>
				<a class="navbar-brand" href="./home">To do Calendar</a>
			</div>
			<!-- /.navbar-header -->

			<ul class="nav navbar-top-links navbar-right">

				<!-- /.dropdown -->
				<c:if test="${member != null }">
				<div id="member_no" style="display:none">${member.member_no }</div>
				<li class="dropdown"><a class="dropdown-toggle"
					data-toggle="dropdown" href="#"> <i class="fa fa-user fa-fw"></i> ${member.name }님
						<i class="fa fa-caret-down"></i>
				</a>
					<ul class="dropdown-menu dropdown-user">
						<li><a href="pages/mypage"><i class="fa fa-user fa-fw"></i> 프로필</a></li>
						<li><a href="#"><i class="fa fa-gear fa-fw"></i> 설정</a></li>
						<li class="divider"></li>
						<li><a href="pages/logout"><i class="fa fa-sign-out fa-fw"></i>
								로그아웃</a></li>
					</ul> <!-- /.dropdown-user -->
				</li>
				</c:if>
				<c:if test="${member == null }">
					회원 정보 없음
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
                            <div class="input-group custom-search-form" \>
                                <legend style="border-bottom: none;"><a style="text-decoration: none; font-weight: bold;">Today Check List</a></legend>
                            </div>

                            <c:forEach var="category" items="${categoryList }" varStatus="status">
                            <!--여기부터-->
                            <a href="#" style="text-decoration: none;"><i class="fa fa-folder fa-fw"></i> ${category.category_nm }<span class="fa arrow"></span></a>
                            <ul class="nav nav-second-level">
	                            <c:forEach var="schedule" items="${scheduleList }" varStatus="status">
	                            <fmt:formatDate var="planDate_FD"  value="${schedule.plan_date }" pattern="yyyy-MM-dd"/>
	                            	<c:if test="${category.category_no == schedule.category_no }">
		                            		<li style="border-bottom: none;">
			                            		<c:if test="${now_FD == planDate_FD }">
			                            			<c:choose>
			                            				<c:when test="${schedule.complete eq 'Y' }">
			                            					<a><input type="checkbox" id="completeY${status.count }" value="${schedule.schedule_no }" checked="checked"> ${schedule.content }</a>
			                            				</c:when>
					                                   	<c:otherwise>
					                                   		<a><input type="checkbox" value="${schedule.schedule_no }" id="completeN${status.count }"> ${schedule.content }</a>
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
			<div class="row">
				<!--
				<div class="col-lg-12">
					<h1 class="page-header">Dashboard</h1>
				</div>
				-->
				<!-- /.col-lg-12 -->
			</div>
			<!-- /.row -->
			<div class="row" style="padding-top: 50px;">
				<div class="col-lg-12">
					<!-- 캘린더 -->
					<div class="visit-div" style="padding-top: 20px;">

						<div class="sec_cal" style="padding-bottom: 30px;">
							<div class="cal_nav">
								<a href="javascript:;" class="nav-btn go-prev">prev</a>
								<div class="year-month"></div>
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
					<form role="form" id="addNewScheduleForm" action="/pages/addSchedule" method="post">
						<div class="modal-body" id="addNewScheDate">Modal Date</div>
						<!--
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
			                <input type="hidden" name="plan_date" value="">
			                <div class="form-group">
								<label>반복여부</label>
								<div class="radio">
									<label><input type="radio" name="dday" value="0" checked="">없음</label>
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
						 -->

						<input type="hidden" name="member_no" value="1">
						<input type="hidden" name="category_no" value="1">
						<input type="hidden" name="content" value="111111">

						<%-- <fmt:parseDate var="testDate" value="2023-08-14" pattern="yyyy-MM-dd" />
						<input type="hidden" name="plan_date" value="${testDate }"> --%>

						<input type="hidden" name="dday" value="1">
						<input type="hidden" name="complete" value="N">
						<div class="modal-footer">
			                <input type="button" class="btn btn-primary" onclick="addScheduleSubmit();" value="저장">
			            </div>
		            </form>
				</div><!-- /.modal-content -->

			</div><!-- ./modal-dialog -->
		</div><!-- /.modal -->

	</div>
	<!-- /#wrapper -->

	<!-- Today Check List 체크박스 on/off -->
	<script type="text/javascript">
	<c:forEach var="schedule" items="${scheduleList}" varStatus="status">
	$(document).ready(function() {
		$(document).on("change", "#completeY${status.count}", function() {
			$("#completeY${status.count}").removeAttr("checked");
			$("#completeY${status.count}").attr("id", "completeN${status.count}");
			var value = $("#completeN${status.count}").val();
			console.log(value);
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
					console.log("success Y to N ");
				}
			}); //End Ajax
		});

		$(document).on("change", "#completeN${status.count}", function() {
			$("#completeN${status.count}").attr("checked", "checked");
			$("#completeN${status.count}").attr("id", "completeY${status.count}");
			var value = $("#completeY${status.count}").val();
			console.log(value);
			//Ajax로 전송
			$.ajax({
				url : './ChangeComplete',
				data : {
					complete : 'Y',
					schedule_no : value
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					console.log("success N to Y ");
				}
			}); //End Ajax
		});
	});
	</c:forEach>
	</script>

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

	<script type="text/javascript">

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

	// 이번달 스케줄 리스트 가져오기
	function getScheduleByMonth() {
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
						var day = result[i].day;
						var dateId = "#date" + day;
						var dateContentId = dateId + "Content";

						var complete = result[i].complete;

						$(dateContentId).append("<br>");
						if(complete == "Y") {
							$(dateContentId).append("<input type='checkbox' id='" + dateContentId + "Complete" + "' value='' checked='checked' >&nbsp");
						}
						else {
							$(dateContentId).append("<input type='checkbox' id='" + dateContentId + "Complete" + "' value='' >&nbsp");
						}

						$(dateContentId).append(result[i].content);
						scheduleList.push(result[i]);
					}
				}

			}
		});
	}

	// 날짜 클릭 시 Modal(todoListModal) 호출
	function dateClick(date) {
		var dateId  = date.getAttribute('id');							// 클릭한 날짜의 ID, ex. date12

		var dateDayId = dateId + "Day";									// 클릭한 날짜의 Day ID, ex. date12Day
		var dateDay = document.getElementById(dateDayId).innerHTML;		// 클릭한 날짜의 Day, ex. 12

		var dateContentId = dateId + "Content";							// 클릭한 날짜의 Content ID, ex.date12Content

		// 클릭한 날짜의 일정 목록 가져오기
		dateScheduleList = [];
		for(var i = 0; i < scheduleList.length; i++) {
			if(scheduleList[i].day == dateDay) {
				dateScheduleList.push(scheduleList[i]);
			}
		}

		var str = "";				// Modal에 채울 카테고리 + 일정 리스트
		var notEmptyCateList = [];	// 일정이 존재하는 카테고리

		for(var i = 0; i < categoryList.length; i++) {

			/*
			// 1. 카테고리 이름(category_nm) 표시(폴더)
			str += '<a href="#" style="text-decoration: none;"><i class="fa fa-folder fa-fw"></i> '
			str += categoryList[i].category_nm;
			str += '<span class="fa arrow"></span></a>';
			str += '<ul class="nav nav-second-level">';

			// 2. 폴더 아래 해당 카테고리의 일정들 표시
			var category_no = categoryList[i].category_no;
			for(var k = 0; k < dateScheduleList.length; k++) {
				var dateSchedule = dateScheduleList[k];
				if(dateSchedule.category_no == category_no) {		// 일치하는 카테고리의 일정들만 표시

					str += '<li style="border-bottom: none;">';

					// 일정 달성여부 표시(checkBox) + 일정 내용 표시
					var complete = dateSchedule.complete;
					var completeId = "date" + dateSchedule.day + "ContentComplete";
					if(complete == "Y") {
						str += "<a><input type='checkbox' id='" + completeId + "' value='' checked='checked' > " + dateSchedule.content + "</a>";
					}
					else {
						str += "<a><input type='checkbox' id='" + completeId + "' value='' > " + dateSchedule.content + "</a>";
					}

					str += '</li>';

				}

			}
			str += '</ul>';
			*/

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
					var complete = dateSchedule.complete;
					var completeId = "date" + dateSchedule.day + "ContentComplete";
					if(complete == "Y") {
						str += "<a><input type='checkbox' id='" + completeId + "' value='' checked='checked' > " + dateSchedule.content + "</a>";
					}
					else {
						str += "<a><input type='checkbox' id='" + completeId + "' value='' > " + dateSchedule.content + "</a>";
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
		//$("#modalDate").text(dateScheduleList[0].plan_date);
		if(dateDay.length < 2) dateDay = '0' + dateDay;
		$("#modalDate").text("${now_FD_ym }" + dateDay);		// '2023-08-' + '13'

		$("#todoListModal").modal("show");
	}

	// 새로운 일정 추가 Modal(addNewScheduleModal) 호출
	function addNewScheduleClick() {
		//alert("addNewScheduleClick");

		var date = $("#modalDate").text();
		$("#addNewScheDate").text(date);

		$("#addNewScheduleForm [name='plan_date']").val(date);
		$("#addNewScheduleForm [name='member_no']").val($("#member_no").text());

		$("#addNewScheduleModal").modal("show");
	}

	// 새로운 일정 추가 Submit 버튼
	function addScheduleSubmit() {
		debugger;
		$("#addNewScheduleForm").submit();
	}

	</script>
</body>

</html>
