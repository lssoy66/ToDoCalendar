<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="kr">
<html>
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

	<div id="container">
		<div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                	<div class="panel-heading">
                        <h3 class="panel-title">가입 시 입력한 이메일로 인증</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" name="forgetIdForm" action="../pages/ForgetIdCheck" method="post">
                            <fieldset>
                                <div class="form-group">
                                    <input class="form-control" placeholder="이름을 입력해주세요." name="name" type="text" autofocus>
                                </div>
                                <div class="form-group">
                                    <input class="form-control" placeholder="이메일을 입력해주세요." name="email" id="email" type="email" autofocus>
                                	<div style="display: block; text-align: right;">
                                    	<input type="button" value="인증하기" class="btn btn-primary" id="emailAuth">
                                    </div>
                                    <input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled="disabled" name="authCode" id="authCode" type="text" autofocus>
                                	<span id="emailAuthWarn"></span>
                                </div>
                                
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" value="ID 찾기" id="findId" class="btn btn-lg btn-success btn-block" disabled="disabled">
                            </fieldset>
                        </form>
                    </div>
                </div>
            </div>
        </div>
	</div>
	
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
	
	<script type="text/javascript">
	$(document).ready(function() {
		//이메일 인증
		$("#emailAuth").click(function() {
    		const email = $("#email").val(); //사용자가 입력한 이메일 값 얻어오기
    		const checkInput = $("#authCode"); //인증 코드 입력하는 곳
    		
    		//Ajax로 전송
        	$.ajax({
        		url : './EmailAuth',
        		data : {
        			email : email
        		},
        		type : 'POST',
        		dataType : 'json',
        		success : function(result) {
        			console.log("result : " + result);
        			checkInput.attr("disabled", false);
        			code = result;
        			alert("인증 코드가 입력하신 이메일로 전송 되었습니다.");
        		}
        	}); //End Ajax
    	});
		
		//인증 코드 비교
		$("#authCode").on("focusout", function() {
    		const inputCode = $("#authCode").val();
    		
    		console.log("입력코드 : " + inputCode);
    		console.log("인증코드 : " + code);
    		
    		if(Number(inputCode) === code){
        		$("#emailAuthWarn").html('인증번호가 일치합니다.');
        		$("#emailAuthWarn").css('color', 'green');
    			$('#emailAuth').attr('disabled', true);
    			$('#email').attr('readonly', true);
    			$("#findId").attr("disabled", false);
    		}else{
        		$("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
        		$("#emailAuthWarn").css('color', 'red');
        		$("#findId").attr("disabled", true);
    		}
    	});
	})
	</script>

</body>
</html>