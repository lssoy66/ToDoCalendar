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
                    <div class="panel-body">
                        <form role="form" name="loginForm" action="../pages/loginCheck" method="post">
                            <fieldset>
                            	ID
                                <div class="form-group">
                                    <input class="form-control" placeholder="ID를 입력해주세요." name="id" type="text" autofocus>
                                </div>
                                	비밀번호
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호를 입력해주세요." name="password" type="password" value="">
                                </div>
                                <!--  
                                <div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="Remember Me">기억하기
                                    </label>
                                </div>
                                -->
                                <div style="text-align: right;">
                                	<label>
                                		<a href="../pages/ForgetId">ID 찾기</a>
                                		<a>|</a>
                                		<a href="../pages/ForgetPassword">비밀번호 찾기</a>
                                	</label>
                                </div>
                                <!-- Change this to a button or input when using this as a form -->
                                <input type="submit" value="로그인" class="btn btn-lg btn-success btn-block">
                            </fieldset>
                        </form>
                        
                        <div style="text-align: center; padding-top: 20px">
                        	To Do Calendar 계정이 없으신가요? <a href="../pages/sign_up">회원가입</a>
                        </div>
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

</body>

</html>
