<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
<meta name="description" content="Developed By M Abdur Rokib Promy">
<meta name="keywords"
	content="Admin, Bootstrap 3, Template, Theme, Responsive">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<!-- bootstrap 3.0.2 -->
<link href="css/bootstrap.min.css" rel="stylesheet" type="text/css" />
<!-- font Awesome -->
<link href="css/font-awesome.min.css" rel="stylesheet" type="text/css" />
<!-- Ionicons -->
<link href="css/ionicons.min.css" rel="stylesheet" type="text/css" />
<!-- Morris chart -->
<link href="css/morris/morris.css" rel="stylesheet" type="text/css" />
<!-- jvectormap -->
<link href="css/jvectormap/jquery-jvectormap-1.2.2.css" rel="stylesheet"
	type="text/css" />
<!-- Date Picker -->
<link href="css/datepicker/datepicker3.css" rel="stylesheet"
	type="text/css" />
<!-- fullCalendar -->
<!-- <link href="css/fullcalendar/fullcalendar.css" rel="stylesheet" type="text/css" /> -->
<!-- Daterange picker -->
<link href="css/daterangepicker/daterangepicker-bs3.css"
	rel="stylesheet" type="text/css" />
<!-- iCheck for checkboxes and radio inputs -->
<link href="css/iCheck/all.css" rel="stylesheet" type="text/css" />
<!-- bootstrap wysihtml5 - text editor -->
<!-- <link href="css/bootstrap-wysihtml5/bootstrap3-wysihtml5.min.css" rel="stylesheet" type="text/css" /> -->
<link href='http://fonts.googleapis.com/css?family=Lato'
	rel='stylesheet' type='text/css'>
<!-- Theme style -->
<link href="css/style.css" rel="stylesheet" type="text/css" />
<link href="c3/c3.css" rel="stylesheet" type="text/css">

<style type="text/css">
</style>

<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script src="c3/c3.min.js"></script>
</head>
<body class="skin-black">
	<!-- header logo: style can be found in header.less -->
	<header class="header">
		<a href="index.html" class="logo"> Italy </a>
		<!-- Header Navbar: style can be found in header.less -->
		<nav class="navbar navbar-static-top" role="navigation">
			<!-- Sidebar toggle button-->
			<a href="#" class="navbar-btn sidebar-toggle" data-toggle="offcanvas"
				role="button"> <span class="sr-only">Toggle navigation</span> <span
				class="icon-bar"></span> <span class="icon-bar"></span> <span
				class="icon-bar"></span>
			</a>
			<div class="navbar-right">
				<ul class="nav navbar-nav">
					<!-- User Account: style can be found in dropdown.less -->
					<li class="dropdown user user-menu"><a href="#"
						class="dropdown-toggle" data-toggle="dropdown"> <i
							class="fa fa-user"></i> <span>Jane Doe <i class="caret"></i></span>
					</a>
						<ul class="dropdown-menu dropdown-custom dropdown-menu-right">
							<li class="dropdown-header text-center">Account</li>

							<li><a href="#"> <i class="fa fa-user fa-fw pull-right"></i>
									Profile
							</a> <a data-toggle="modal" href="#modal-user-settings"> <i
									class="fa fa-cog fa-fw pull-right"></i> Settings
							</a></li>

							<li class="divider"></li>

							<li><a href="#"><i class="fa fa-ban fa-fw pull-right"></i>
									Logout</a></li>
						</ul></li>
				</ul>
			</div>
		</nav>
	</header>
	<div class="wrapper row-offcanvas row-offcanvas-left">
		<!-- Left side column. contains the logo and sidebar -->
		<aside class="left-side sidebar-offcanvas">
			<!-- sidebar: style can be found in sidebar.less -->
			<section class="sidebar">
				<!-- Sidebar user panel -->
				<div class="user-panel">
					<div class="pull-left image">
						<img src="img/26115.jpg" class="img-circle" alt="User Image" />
					</div>
					<div class="pull-left info">
						<p>Hello, Jane</p>

					</div>
				</div>
				<!-- search form -->
				<form action="#" method="get" class="sidebar-form">
					<div class="input-group">
						<input type="text" name="q" class="form-control"
							placeholder="Search..." /> <span class="input-group-btn">
							<button type='submit' name='seach' id='search-btn'
								class="btn btn-flat">
								<i class="fa fa-search"></i>
							</button>
						</span>
					</div>
				</form>
				<!-- /.search form -->
				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
					<li class="active"><a href="index.html"> <i
							class="fa fa-dashboard"></i> <span>Dashboard</span>
					</a></li>
					<li><a href="general.html"> <i class="fa fa-gavel"></i> <span>General</span>
					</a></li>

					<li><a href="basic_form.html"> <i class="fa fa-globe"></i>
							<span>Basic Elements</span>
					</a></li>

					<li><a href="simple.html"> <i class="fa fa-glass"></i> <span>Simple
								tables</span>
					</a></li>

				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>

		<aside class="right-side">

			<!-- Main content -->
			<section class="content">

				<div class="row" style="margin-bottom: 5px;">


					<div class="col-md-3">
						<div class="sm-st clearfix">
							<span class="sm-st-icon st-red"><i
								class="fa fa-check-square-o"></i></span>
							<div class="sm-st-info">
								<span>3200</span> Customer Count
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="sm-st clearfix">
							<span class="sm-st-icon st-violet"><i
								class="fa fa-envelope-o"></i></span>
							<div class="sm-st-info">
								<span>2200</span> Product Density
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="sm-st clearfix">
							<span class="sm-st-icon st-blue"><i class="fa fa-dollar"></i></span>
							<div class="sm-st-info">
								<span>100,320</span> Gross Written Premium
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="sm-st clearfix">
							<span class="sm-st-icon st-green"><i
								class="fa fa-paperclip"></i></span>
							<div class="sm-st-info">
								<span>4567</span> Reserve
							</div>
						</div>
					</div>
				</div>

				<!-- Main row -->
				<div class="row">

					<div class="col-lg-4">
						<!--earning graph start-->
						<section class="panel">
							<header class="panel-heading"> Earning Graph </header>
							<div class="panel-body">
								<div id="chart2"></div>
								<script>
									d3.csv("transaction_data.csv", function(
											error, csv_data) {
										var modData = [];
										var category = [];
										var item = [];
										var data = d3.nest().key(function(d) {
											return d.Transaction_Type;
										}).rollup(function(d) {
											return d3.sum(d, function(g) {
												return 1;
											});
										}).entries(csv_data);

										console.log(data);

										data.forEach(function(d, i) {
											console.log(d.key)
											var item = [ d.key ];
											item.push(d.values);
											modData.push(item);
										});

										var chart = c3.generate({
											data : {
												columns : modData,
												//mimeType: 'json'
												type : 'donut',
												onclick : function(d, i) {
													console
															.log("onclick", d,
																	i);
												},
												onmouseover : function(d, i) {
													console.log("onmouseover",
															d, i);
												},
												onmouseout : function(d, i) {
													console.log("onmouseout",
															d, i);
												}
											},
											donut : {
												title : "Customer"
											},
											bindto : '#chart2'
										});
									});
								</script>
							</div>
						</section>
						<!--earning graph end-->

					</div>
					<div class="col-md-8">

						<!--chat start-->
						<section class="panel">
							<header class="panel-heading"> Notifications </header>
							<div class="panel-body">

								<div id="chart3"></div>
								<script>
									d3.csv("transaction_data.csv", function(
											error, csv_data) {
										var modData = [];
										var category = [];
										var item = [];
										var data = d3.nest().key(function(d) {
											return d.Transaction_Type;
										}).rollup(function(d) {
											return d3.sum(d, function(g) {
												return 1;
											});
										}).entries(csv_data);

										console.log(data);

										data.forEach(function(d, i) {
											console.log(d.key)
											var item = [ d.key ];
											item.push(d.values);
											modData.push(item);
										});

										var chart = c3.generate({
											data : {
												columns : modData,
												//mimeType: 'json'
												type : 'donut',
												onclick : function(d, i) {
													console
															.log("onclick", d,
																	i);
												},
												onmouseover : function(d, i) {
													console.log("onmouseover",
															d, i);
												},
												onmouseout : function(d, i) {
													console.log("onmouseout",
															d, i);
												}
											},
											donut : {
												title : "Customer"
											},
											bindto : '#chart3'
										});
									});
								</script>


							</div>
						</section>



					</div>


				</div>
				<div class="row">

					<div class="col-md-8">
						<section class="panel">
							<header class="panel-heading"> Work Progress </header>
							<div class="panel-body">
								<div id="chart4"></div>
								<script>
									d3.csv("transaction_data.csv", function(
											error, csv_data) {
										var modData = [];
										var category = [];
										var item = [];
										var data = d3.nest().key(function(d) {
											return d.Transaction_Type;
										}).rollup(function(d) {
											return d3.sum(d, function(g) {
												return 1;
											});
										}).entries(csv_data);

										console.log(data);

										data.forEach(function(d, i) {
											console.log(d.key)
											var item = [ d.key ];
											item.push(d.values);
											modData.push(item);
										});

										var chart = c3.generate({
											data : {
												columns : modData,
												//mimeType: 'json'
												type : 'donut',
												onclick : function(d, i) {
													console
															.log("onclick", d,
																	i);
												},
												onmouseover : function(d, i) {
													console.log("onmouseover",
															d, i);
												},
												onmouseout : function(d, i) {
													console.log("onmouseout",
															d, i);
												}
											},
											donut : {
												title : "Customer"
											},
											bindto : '#chart4'
										});
									});
								</script>
							</div>
						</section>


					</div>
					<!--end col-6 -->
					<div class="col-md-4">
						<section class="panel">
							<header class="panel-heading"> Twitter Feed </header>
							<div class="panel-body">
								<div class="twt-area">
									<form action="#" method="post">
										<textarea class="form-control" name="profile-tweet"
											placeholder="Share something on Twitter.." rows="3"></textarea>

										<div class="clearfix">
											<button class="btn btn-sm btn-primary pull-right"
												type="submit">
												<i class="fa fa-twitter"></i> Tweet
											</button>
											<a class="btn btn-link btn-icon fa fa-location-arrow"
												data-original-title="Add Location" data-placement="bottom"
												data-toggle="tooltip" href="#"
												style="text-decoration: none;" title=""></a> <a
												class="btn btn-link btn-icon fa fa-camera"
												data-original-title="Add Photo" data-placement="bottom"
												data-toggle="tooltip" href="#"
												style="text-decoration: none;" title=""></a>
										</div>
									</form>
								</div>
								<ul class="media-list">
									<li class="media"><a href="#" class="pull-left"> <img
											src="img/26115.jpg" alt="Avatar" class="img-circle"
											width="64" height="64">
									</a>
										<div class="media-body">
											<span class="text-muted pull-right"> <small><em>30
														min ago</em></small>
											</span> <a href="page_ready_user_profile.php"> <strong>John
													Doe</strong>
											</a>
											<p>
												In hac <a href="#">habitasse</a> platea dictumst. Proin ac
												nibh rutrum lectus rhoncus eleifend. <a href="#"
													class="text-danger"> <strong>#dev</strong>
												</a>
											</p>
										</div></li>
									<li class="media"><a href="#" class="pull-left"> <img
											src="img/26115.jpg" alt="Avatar" class="img-circle"
											width="64" height="64">
									</a>
										<div class="media-body">
											<span class="text-muted pull-right"> <small><em>30
														min ago</em></small>
											</span> <a href="page_ready_user_profile.php"> <strong>John
													Doe</strong>
											</a>
											<p>
												In hac <a href="#">habitasse</a> platea dictumst. Proin ac
												nibh rutrum lectus rhoncus eleifend. <a href="#"
													class="text-danger"> <strong>#design</strong>
												</a>
											</p>
										</div></li>
								</ul>
							</div>
						</section>
					</div>

				</div>
				<div class="row">
					<div class="col-md-5">
						<div class="panel">
							<header class="panel-heading"> Teammates </header>

							<ul class="list-group teammates">
								<li class="list-group-item"><a href=""><img
										src="img/26115.jpg" width="50" height="50"></a> <span
									class="pull-right label label-danger inline m-t-15">Admin</span>
									<a href="">Damon Parker</a></li>
								<li class="list-group-item"><a href=""><img
										src="img/26115.jpg" width="50" height="50"></a> <span
									class="pull-right label label-info inline m-t-15">Member</span>
									<a href="">Joe Waston</a></li>
								<li class="list-group-item"><a href=""><img
										src="img/26115.jpg" width="50" height="50"></a> <span
									class="pull-right label label-warning inline m-t-15">Editor</span>
									<a href="">Jannie Dvis</a></li>
								<li class="list-group-item"><a href=""><img
										src="img/26115.jpg" width="50" height="50"></a> <span
									class="pull-right label label-warning inline m-t-15">Editor</span>
									<a href="">Emma Welson</a></li>
								<li class="list-group-item"><a href=""><img
										src="img/26115.jpg" width="50" height="50"></a> <span
									class="pull-right label label-success inline m-t-15">Subscriber</span>
									<a href="">Emma Welson</a></li>
							</ul>
							<div class="panel-footer bg-white">
								<!-- <span class="pull-right badge badge-info">32</span> -->
								<button class="btn btn-primary btn-addon btn-sm">
									<i class="fa fa-plus"></i> Add Teammate
								</button>
							</div>
						</div>
					</div>
					<div class="col-md-7">
						<section class="panel tasks-widget">
							<header class="panel-heading"> Todo list </header>
							<div class="panel-body">

								<div class="task-content">

									<ul class="task-list">
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey list-child" />
												<!-- <input type="checkbox" class="square-grey"/> -->
											</div>
											<div class="task-title">
												<span class="task-title-sp">Director is Modern
													Dashboard</span> <span class="label label-success">2 Days</span>
												<div class="pull-right hidden-phone">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey" />
											</div>
											<div class="task-title">
												<span class="task-title-sp">Fully Responsive &
													Bootstrap 3.0.2 Compatible</span> <span class="label label-danger">Done</span>
												<div class="pull-right hidden-phone">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey" />
											</div>
											<div class="task-title">
												<span class="task-title-sp">Latest Design Concept</span> <span
													class="label label-warning">Company</span>
												<div class="pull-right hidden-phone">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey" />
											</div>
											<div class="task-title">
												<span class="task-title-sp">Write well documentation
													for this theme</span> <span class="label label-primary">3
													Days</span>
												<div class="pull-right hidden-phone">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey" />
											</div>
											<div class="task-title">
												<span class="task-title-sp">Don't bother to download
													this Dashbord</span> <span class="label label-inverse">Now</span>
												<div class="pull-right">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey" />
											</div>
											<div class="task-title">
												<span class="task-title-sp">Give feedback for the
													template</span> <span class="label label-success">2 Days</span>
												<div class="pull-right hidden-phone">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>
										<li>
											<div class="task-checkbox">
												<!-- <input type="checkbox" class="list-child" value=""  /> -->
												<input type="checkbox" class="flat-grey" />
											</div>
											<div class="task-title">
												<span class="task-title-sp">Tell your friends about
													this admin template</span> <span class="label label-danger">Now</span>
												<div class="pull-right hidden-phone">
													<button class="btn btn-default btn-xs">
														<i class="fa fa-check"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-pencil"></i>
													</button>
													<button class="btn btn-default btn-xs">
														<i class="fa fa-times"></i>
													</button>
												</div>
											</div>
										</li>

									</ul>
								</div>

								<div class=" add-task-row">
									<a class="btn btn-success btn-sm pull-left" href="#">Add
										New Tasks</a> <a class="btn btn-default btn-sm pull-right"
										href="#">See All Tasks</a>
								</div>
							</div>
						</section>
					</div>
				</div>
				<!-- row end -->
			</section>
			<!-- /.content -->
			<div class="footer-main">Copyright &copy Director, 2014</div>
		</aside>
		<!-- /.right-side -->

	</div>
	<!-- ./wrapper -->


	<!-- jQuery 2.0.2 -->
	<script
		src="http://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js"></script>
	<script src="js/jquery.min.js" type="text/javascript"></script>

	<!-- jQuery UI 1.10.3 -->
	<script src="js/jquery-ui-1.10.3.min.js" type="text/javascript"></script>
	<!-- Bootstrap -->
	<script src="js/bootstrap.min.js" type="text/javascript"></script>
	<!-- daterangepicker -->
	<script src="js/plugins/daterangepicker/daterangepicker.js"
		type="text/javascript"></script>

	<script src="js/plugins/chart.js" type="text/javascript"></script>

	<!-- datepicker
        <script src="js/plugins/datepicker/bootstrap-datepicker.js" type="text/javascript"></script>-->
	<!-- Bootstrap WYSIHTML5
        <script src="js/plugins/bootstrap-wysihtml5/bootstrap3-wysihtml5.all.min.js" type="text/javascript"></script>-->
	<!-- iCheck -->
	<script src="js/plugins/iCheck/icheck.min.js" type="text/javascript"></script>
	<!-- calendar -->
	<script src="js/plugins/fullcalendar/fullcalendar.js"
		type="text/javascript"></script>

	<!-- Director App -->
	<script src="js/Director/app.js" type="text/javascript"></script>

	<!-- Director dashboard demo (This is only for demo purposes) -->
	<script src="js/Director/dashboard.js" type="text/javascript"></script>

	<!-- Director for demo purposes -->
	<script type="text/javascript">
		$('input').on('ifChecked', function(event) {
			// var element = $(this).parent().find('input:checkbox:first');
			// element.parent().parent().parent().addClass('highlight');
			$(this).parents('li').addClass("task-done");
			console.log('ok');
		});
		$('input').on('ifUnchecked', function(event) {
			// var element = $(this).parent().find('input:checkbox:first');
			// element.parent().parent().parent().removeClass('highlight');
			$(this).parents('li').removeClass("task-done");
			console.log('not');
		});
	</script>
	<script>
		$('#noti-box').slimScroll({
			height : '400px',
			size : '5px',
			BorderRadius : '5px'
		});

		$('input[type="checkbox"].flat-grey, input[type="radio"].flat-grey')
				.iCheck({
					checkboxClass : 'icheckbox_flat-grey',
					radioClass : 'iradio_flat-grey'
				});
	</script>
	<script type="text/javascript">
		$(function() {
			"use strict";
			//BAR CHART
			var data = {
				labels : [ "January", "February", "March", "April", "May",
						"June", "July" ],
				datasets : [ {
					label : "My First dataset",
					fillColor : "rgba(220,220,220,0.2)",
					strokeColor : "rgba(220,220,220,1)",
					pointColor : "rgba(220,220,220,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(220,220,220,1)",
					data : [ 65, 59, 80, 81, 56, 55, 40 ]
				}, {
					label : "My Second dataset",
					fillColor : "rgba(151,187,205,0.2)",
					strokeColor : "rgba(151,187,205,1)",
					pointColor : "rgba(151,187,205,1)",
					pointStrokeColor : "#fff",
					pointHighlightFill : "#fff",
					pointHighlightStroke : "rgba(151,187,205,1)",
					data : [ 28, 48, 40, 19, 86, 27, 90 ]
				} ]
			};
			new Chart(document.getElementById("linechart").getContext("2d"))
					.Line(data, {
						responsive : true,
						maintainAspectRatio : false,
					});

		});
		// Chart.defaults.global.responsive = true;
	</script>
</body>
</html>