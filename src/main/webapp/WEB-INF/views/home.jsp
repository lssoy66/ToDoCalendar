<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="kr">
	<head>
		<meta charset="utf-8">
		<meta http-equiv="X-UA-Compatible" content="IE=edge">
		<meta name="viewport" content="width=device-width, initial-scale=1">
		<meta name="description" content="">
		<meta name="author" content="">

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
		<link href="resources/vendor/font-awesome/css/font-awesome.min.css"	rel="stylesheet" type="text/css">

		<!-- Calendar CSS -->
		<link href="resources/css/calendar-style.css" rel="stylesheet">
	</head>

	<body>
		<div id="wrapper">

			<!-- Navigation -->
			<nav class="navbar navbar-default navbar-static-top" role="navigation" style="margin-bottom: 0">
				<div class="navbar-header">
					<button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
						<span class="sr-only">Toggle navigation</span>
						<span class="icon-bar"></span> <span class="icon-bar"></span>
						<span class="icon-bar"></span>
					</button>
					<a class="navbar-brand" href="./home">To do Calendar</a>
				</div><!-- /.navbar-header -->

				<ul class="nav navbar-top-links navbar-right">
					<c:if test="${member != null }">
						<li class="dropdown">
							<a class="dropdown-toggle" data-toggle="dropdown" href="#">
								<i class="fa fa-user fa-fw"></i> ${member.name }님
								<i class="fa fa-caret-down"></i>
							</a>
							<ul class="dropdown-menu dropdown-user">
								<li><a href="#"><i class="fa fa-user fa-fw"></i> 프로필</a></li>
								<li><a href="#"><i class="fa fa-gear fa-fw"></i> 설정</a></li>
								<li class="divider"></li>
								<li><a href="pages/logout"><i class="fa fa-sign-out fa-fw"></i>로그아웃</a></li>
							</ul> <!-- /.dropdown-user -->
						</li><!-- /.dropdown -->
					</c:if>
					<c:if test="${member == null }">
						회원 정보 없음
					</c:if>
				</ul><!-- /.navbar-top-links -->

				<div class="navbar-default sidebar" role="navigation">
					<div class="sidebar-nav navbar-collapse">
						<ul class="nav" id="side-menu">
							<li class="sidebar-search">
								<div class="input-group custom-search-form">
									<input type="text" class="form-control" placeholder="Search...">
									<span class="input-group-btn">
										<button class="btn btn-default" type="button">
											<i class="fa fa-search"></i>
										</button>
									</span>
								</div> <!-- /input-group -->
							</li>
							<li><a href="index.html"><i class="fa fa-dashboard fa-fw"></i>Dashboard</a></li>
							<li><a href="#"><i class="fa fa-bar-chart-o fa-fw"></i>Charts<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="flot.html">Flot Charts</a></li>
									<li><a href="morris.html">Morris.js Charts</a></li>
								</ul> <!-- /.nav-second-level --></li>
							<li><a href="tables.html"><i class="fa fa-table fa-fw"></i>Tables</a></li>
							<li><a href="forms.html"><i class="fa fa-edit fa-fw"></i>Forms</a></li>
							<li><a href="#"><i class="fa fa-wrench fa-fw"></i> UI Elements<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="panels-wells.html">Panels and Wells</a></li>
									<li><a href="buttons.html">Buttons</a></li>
									<li><a href="notifications.html">Notifications</a></li>
									<li><a href="typography.html">Typography</a></li>
									<li><a href="icons.html"> Icons</a></li>
									<li><a href="grid.html">Grid</a></li>
								</ul> <!-- /.nav-second-level --></li>
							<li><a href="#"><i class="fa fa-sitemap fa-fw"></i>Multi-Level Dropdown<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="#">Second Level Item</a></li>
									<li><a href="#">Second Level Item</a></li>
									<li><a href="#">Third Level <span class="fa arrow"></span></a>
										<ul class="nav nav-third-level">
											<li><a href="#">Third Level Item</a></li>
											<li><a href="#">Third Level Item</a></li>
											<li><a href="#">Third Level Item</a></li>
											<li><a href="#">Third Level Item</a></li>
										</ul> <!-- /.nav-third-level -->
									</li>
								</ul> <!-- /.nav-second-level -->
							</li>
							<li><a href="#"><i class="fa fa-files-o fa-fw"></i>Sample Pages<span class="fa arrow"></span></a>
								<ul class="nav nav-second-level">
									<li><a href="blank.html">Blank Page</a></li>
									<li><a href="login.html">Login Page</a></li>
								</ul> <!-- /.nav-second-level -->
							</li>
						</ul>
					</div><!-- /.sidebar-collapse -->
				</div><!-- /.navbar-static-side -->
			</nav>

			<div id="page-wrapper">
				<div class="row">
					<div class="col-lg-12">
						<h1 class="page-header">Dashboard</h1>
					</div><!-- /.col-lg-12 -->
				</div>
				<div class="row">
					<div class="col-lg-12	">
						<!-- 캘린더 -->
						<div class="visit-div" style="padding-top: 20px;">
							<div class="sec_cal" style="padding-bottom: 30px;">
								<div class="cal_nav">
									<a href="javascript:;" class="nav-btn go-prev">prev</a>
									<div class="year-month"></div>
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
			</div><!-- /#page-wrapper -->

		</div><!-- /#wrapper -->

		<!-- Modal 추가  -->
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close"	data-dismiss="modal" aria-hidden="true">&times;</button>
		                <h4 class="modal-title" id="myModalLabel">Modal title</h4>
					</div>
					<div class="modal-body" id="modalBody">Modal Body</div>
					<div class="modal-footer">
						<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
						<button type="button" class="btn btn-primary">Save changes</button>
					</div>
				</div>
				<!-- /.modal-content -->
			</div>
			<!-- ./modal-dialog -->
		</div><!-- /.modal -->

		<!-- jQuery -->
		<script src="resources/vendor/jquery/jquery.min.js"></script>

		<!-- Bootstrap Core JavaScript, Metis Menu Plugin JavaScript -->
		<script src="resources/vendor/bootstrap/js/bootstrap.min.js"></script>
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

		/* 전역변수 */

		$(document).ready(function () {
			//debugger;

			/*
			$("#regBtn").on("click", function(){
				self.location = "/board/register";
			});
			*/

		});

		// 날짜 클릭
		function dateClick(a) {
			var obj = a;
			var id = obj.getAttribute('id');
			var value =  document.getElementById(id).innerHTML;

			// modal 본문 내용
			$("#modalBody").text(id);

			$("#myModal").modal("show");
		}

		</script>
	</body>

</html>
