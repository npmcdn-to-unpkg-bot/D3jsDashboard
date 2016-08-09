<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link rel="stylesheet" href="css/style.css">
<title>JSP Page</title>
</head>
<body>
	<div class="login">
		<div class="login-screen">
			<div class="app-title">
				<h1>Login Screen</h1>
			</div>
<form action="loginCheck.jsp" method="post">
			<div class="login-form">
				<div class="control-group">
				<input type="text" class="login-field" value="" placeholder="username" id="login-name" name="username">
				<label class="login-field-icon fui-user" for="login-name"></label>
				</div>

				<div class="control-group">
				<input type="password" class="login-field" value="" placeholder="password" id="login-pass" name="password">
				<label class="login-field-icon fui-lock" for="login-pass"></label>
				</div>
<input type="submit" class="btn btn-primary btn-large btn-block" value="Submit">
			<a class="login-link" href="#">Lost your password?</a>
			</form>
			</div>
		</div>
	</div>
</body>
</html>