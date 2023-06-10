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
								<div class="form-group" id="changeToggleArea">
									<c:choose>
										<c:when test="${member.delay_auto eq 'Y' }">
											<input data-toggle="toggle" id="delayAutoY" type="checkbox" checked="checked">
										</c:when>
										<c:otherwise>
											<input data-toggle="toggle" id="delayAutoN" type="checkbox">
										</c:otherwise>
									</c:choose>
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
    
    <!-- 자동미루기 -->
    <script type="text/javascript">
    $(document).ready(function() {
    	$(document).on("change", "#delayAutoY", function(){
			$("#delayAutoY").removeAttr("checked");
			$("#delayAutoY").attr("id", "delayAutoN");
			
			//Ajax로 전송
			$.ajax({
				url : './DelayAutoOn',
				data : {
					delay_auto : 'N'
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					alert(result.message);
				}
			}); //End Ajax
		});
    	
    	$(document).on("change", "#delayAutoN", function(){
			$("#delayAutoN").attr("checked", "checked");
			$("#delayAutoN").attr("id", "delayAutoY");
			
			//Ajax로 전송
			$.ajax({
				url : './DelayAutoOff',
				data : {
					delay_auto : 'Y'
				},
				type : 'POST',
				dataType : 'json',
				success : function(result) {
					alert(result.message);
				}
			}); //End Ajax
		});
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