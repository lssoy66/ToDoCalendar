<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
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

</head>

<body>

    <div class="container">
        <div class="row">
            <div class="col-md-4 col-md-offset-4">
                <div class="login-panel panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">회원가입</h3>
                    </div>
                    <div class="panel-body">
                        <form role="form" name="signUpForm" action="signUpMember" method="post">
                            <fieldset>
                            	아이디
                            	<div class="form-group">
                                    <input class="form-control" placeholder="ID를 입력해주세요" name="id" id="id" type="text" autofocus>
                                    <div style="display: block; text-align: right;">
                                    	<span style="text-align: left;" id="result"></span>
                                    	<input type="button" value="중복확인" class="btn btn-primary" id="comfirm" onclick="confirmId()">
                                    </div>
                                </div>
                            	이름
                            	<div class="form-group">
                                    <input class="form-control" placeholder="이름을 입력해주세요" name="name" type="text" autofocus>
                                </div>
                                	이메일
                                <div class="form-group">
                                    <input class="form-control" placeholder="이메일을 입력해주세요." name="email" type="email" autofocus>
                                </div>
                                	비밀번호
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호를 입력해주세요." name="password" type="password" value="">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="Remember Me">회원가입과 동시에 개인정보취급방침및 이용약관에 동의하게 됩니다.
                                    </label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" value="회원가입" class="btn btn-lg btn-success btn-block">
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
    
    <script type="text/javascript">
    function confirmId() {
    	var id = $("#id").val();
    	
    	//Ajax로 전송
    	$.ajax({
    		url : './ConfirmId',
    		data : {
    			id : id
    		},
    		type : 'POST',
    		dataType : 'json',
    		success : function(result) {
    			alert(result);
    		}
    	}); //End Ajax
    }
    </script>

</body>

</html>