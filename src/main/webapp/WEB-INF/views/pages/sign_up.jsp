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
                                    <label id="label1"></label>
                                    <div style="display: block; text-align: right;">
                                    	<span style="text-align: left;" id="result"></span>
                                    	<!--  
                                    	<input type="button" value="중복확인" class="btn btn-primary" id="comfirm" onclick="confirmId()">
                                    	-->
                                    </div>
                                </div>
                            	이름
                            	<div class="form-group">
                                    <input class="form-control" placeholder="이름을 입력해주세요" name="name" id="name" type="text" autofocus>
                                </div>
                                	이메일
                                <div class="form-group">
                                    <input class="form-control" placeholder="이메일을 입력해주세요." name="email" id="email" type="email" autofocus>
                                    <div style="display: block; text-align: right;">
                                    	<input type="button" value="인증하기" class="btn btn-primary" id="emailAuth">
                                    </div>
                                    <input class="form-control" placeholder="인증 코드 6자리를 입력해주세요." maxlength="6" disabled="disabled" name="authCode" id="authCode" type="text" autofocus>
                                	<span id="emailAuthWarn"></span>
                                </div>
                                	비밀번호
                                <div class="form-group">
                                    <input class="form-control" placeholder="비밀번호를 입력해주세요." name="password" id="password" type="password" value="">
                                </div>
                                <div class="checkbox">
                                    <label>
                                        <input name="remember" type="checkbox" value="Remember Me">회원가입과 동시에 개인정보취급방침및 이용약관에 동의하게 됩니다.
                                    </label>
                                </div>
                                <!--  
                                <input id="hiddenValue" name="hiddenValue" type="hidden" value="">
                                -->
                                
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
    $(document).ready(function() {
    	
    	//ID 중복 확인
    	//id를 입력할 수 있는 input text 영역을 벗어나면 동작한다.
    	$("#id").on("focusout", function() {
    		
    		var id = $("#id").val();
    		
    		if(id == '' || id.length == 0) {
    			$("#label1").css("color", "red").text("공백은 ID로 사용할 수 없습니다.");
    			return false;
    		}
    		
        	//Ajax로 전송
        	$.ajax({
        		url : './ConfirmId',
        		data : {
        			id : id
        		},
        		type : 'POST',
        		dataType : 'json',
        		success : function(result) {
        			if (result == true) {
        				$("#label1").css("color", "black").text("사용 가능한 ID 입니다.");
        			} else{
        				$("#label1").css("color", "red").text("사용 불가능한 ID 입니다.");
        				$("#id").val('');
        			}
        		}
        	}); //End Ajax
    	});
    })
    
    
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
        		$("#emailAuthWarn").css('color','green');
    			$('#emailAuth').attr('disabled',true);
    			$('#email').attr('readonly',true);
    		}else{
        		$("#emailAuthWarn").html('인증번호가 불일치 합니다. 다시 확인해주세요!');
        		$("#emailAuthWarn").css('color','red');
    		}
    	});
    </script>
    
    <!--  
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
    			if (result == true) {
    				var value = "true";
    				$("#label1").css("color", "black").text("사용 가능한 ID 입니다.");
    				$("#comfirm").attr("value", "check");
    				$("#comfirm").attr("disabled", "disabled");
    				$("#name").removeAttr("disabled");
    				$("#email").removeAttr("disabled");
    				$("#password").removeAttr("disabled");
    			} else {
    				var value = "false";
    				$("#label1").css("color", "red").text("이미 사용 중인 ID 입니다.");
    				
    				$("#id").val('');
    				//중복된 ID일 경우 id가 hiddenValue인 input 태그의 value 값을 "false"로 설정한 뒤 submit 되면 데이터를 넘긴다.
    				$("#hiddenValue").val(value); 
    			}
    		}
    	}); //End Ajax
    }
    </script>
    -->

</body>

</html>