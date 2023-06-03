<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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
    <link href="../resources/vendor/bootstrap/css/bootstrap.min.css" rel="stylesheet">

    <!-- MetisMenu CSS -->
    <link href="../resources/vendor/metisMenu/metisMenu.min.css" rel="stylesheet">

    <!-- Custom CSS -->
    <link href="../resources/dist/css/sb-admin-2.css" rel="stylesheet">

    <!-- Custom Fonts -->
    <link href="../resources/vendor/font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">

    <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
        <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
    <![endif]-->
    
    <!-- Bootstrap Toggle -->
    <link href="https://gitcdn.github.io/bootstrap-toggle/2.2.2/css/bootstrap-toggle.min.css" rel="stylesheet">

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">회원정보</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" name="signUpForm" action="signUpMember" method="post">
                            <fieldset>
                            	아이디
                            	<div class="form-group">
                                    <input class="form-control" placeholder="${member.id }" name="id" type="text" readonly="readonly">
                                </div>
                            	이름
                            	<div class="form-group">
                                    <input class="form-control" placeholder="${member.name }" name="name" type="text" readonly="readonly">
                                </div>
                                	이메일
                                <div class="form-group">
                                    <input class="form-control" placeholder="${member.email }" name="email" type="email" readonly="readonly">
                                </div>
                                	비밀번호
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호를 입력해주세요." name="password" type="password" value="">
                                </div>
                                	멤버쉽
                                <div class="form-group">
                                    <input class="form-control" placeholder="${member.membership }" name="membership" type="text" readonly="readonly">
                                </div>
					                                    자동 미루기
                                <div class="form-group">
	                                <input data-toggle="toggle" name="delayAuto" id="delayAutoToggle" type="checkbox">
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" value="회원정보수정" class="btn btn-lg btn-success btn-block">
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

	<!--  
	<script type="text/javascript">
	$(document).ready(function() {
		var data = '<c:out value="${member.delay_auto}" />';
		if(data == 'Y') {
			$("#delayAutoToggle").bootstrapToggle('on')
		} else {
			$("#delayAutoToggle").bootstrapToggle('off')				
		}
	});
	</script>
	-->

	<!-- 자동미루기 on/off Ajax -->
	<script type="text/javascript">
	var delayAutoVal = '<c:out value="${member.delay_auto}" />';
	console.log(delayAutoVal);
	
	$(document).on("click", "#delayAutoToggle", function() {
		//on일때
		var data = $("#delayAutoToggle").is(':checked');
			console.log(data);
			var delayAuto;
			if(data == true ) {
				$("#delayAutoToggle").change(function(e) {
					delayAuto = 'N';
					//Ajax로 전송
					$.ajax({
						url : './changeDelayAuto',
						data : {
							delay_auto : delayAuto
						},
						type : 'POST',
						dataType : 'json',
						success : function(result) {
							console.log("result : " + result);
							showResult(result);
						}
					}); //End Ajax
				});
			}
	});
	</script>
	
	<script type="text/javascript">
	$(document).on("click", "#delayAutoToggle", function() {
		//off일때
		var data = $("#delayAutoToggle").is(':checked');
			console.log(data);
			var delayAuto;
			if(data == false ) {
				$("#delayAutoToggle").change(function(e) {
					delayAuto = 'Y';
					//Ajax로 전송
					$.ajax({
						url : './changeDelayAuto',
						data : {
							delay_auto : delayAuto
						},
						type : 'POST',
						dataType : 'json',
						success : function(result) {
							console.log("result : " + result);
							showResult(result);
						}
					}); //End Ajax
				});
			}
	});
	
	</script>
 	
	<!-- jQuery -->
    <script src="../resources/vendor/jquery/jquery.min.js"></script>

    <!-- Bootstrap Core JavaScript -->
    <script src="../resources/vendor/bootstrap/js/bootstrap.min.js"></script>

    <!-- Metis Menu Plugin JavaScript -->
    <script src="../resources/vendor/metisMenu/metisMenu.min.js"></script>

    <!-- Custom Theme JavaScript -->
    <script src="../resources/dist/js/sb-admin-2.js"></script>
    
    <!-- Bootstrap Toggle -->
    <script src="https://gitcdn.github.io/bootstrap-toggle/2.2.2/js/bootstrap-toggle.min.js"></script>
    
</body>

</html>