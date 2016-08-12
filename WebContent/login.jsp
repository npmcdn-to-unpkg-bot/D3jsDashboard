<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<!-- bootstrap 3.0.2 -->
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<!-- font Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />

<link href='http://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<!-- Theme style -->
<link href="css/style.css" rel="stylesheet" type="text/css" />

<title>Zurich Dashboard - Login Page</title>
</head>
<body>
	<div class="col-lg-6">

		<section class="login_panel"> <header class="panel-heading">
		Dashboard Login </header>
		<div class="panel-body">
			<form class="form-horizontal" role="form" action="loginCheck.jsp"
				method="post">
				<div class="form-group">
					<label for="inputEmail1" class="col-lg-2 col-sm-2 control-label">Username</label>
					<div class="col-lg-10">
						<input type="text" class="form-control" id="inputEmail1"
							placeholder="Username" name="username">
					</div>
				</div>
				<div class="form-group">
					<label for="inputPassword1" class="col-lg-2 col-sm-2 control-label">Password</label>
					<div class="col-lg-10">
						<input type="password" class="form-control" id="inputPassword1"
							placeholder="Password" name="password">
					</div>
				</div>
				<div class="form-group">
				<label for="inputBU" class="col-lg-2 col-sm-2 control-label">Business </label>
				<div class="col-lg-10">
				<select id = "prodFamilyDropDown" class="form-control">
								<option disabled selected>Select BU</option>
								<option>Germany</option>
								<option>Italy</option>
						</select>
						</div>
				</div>
				<div class="form-group">
					<div class="col-lg-offset-2 col-lg-10">
						<div class="checkbox">
							<label> <input type="checkbox"> Remember me
							</label>
						</div>
					</div>
				</div>
				<div class="form-group">
					<div class="col-lg-offset-2 col-lg-10">
						<button type="submit" class="btn btn-danger" value="Submit">Sign
							in</button>
					</div>
				</div>
			</form>
		</div>
		</section>

	</div>
</body>
</html>