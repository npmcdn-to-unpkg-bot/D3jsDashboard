<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<meta
	content='width=device-width, initial-scale=1, maximum-scale=1, user-scalable=no'
	name='viewport'>
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
	<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
	<script src="c3/c3.min.js"></script>
	<script>
		d3
				.csv(
						"customer_walk_flat_file.csv",
						function(error, csv_data) {
							var parseDate = d3.time.format("%m/%d/%Y").parse;
							csv_data
									.forEach(function(d) {
										d.Transaction_Date = parseDate(d.Transaction_Date);
									});
							var modData = [];
							var category = [];
							var item = [];
							var donutData = d3.nest().key(function(d) {
								return d.Transaction_Type;
							}).rollup(function(d) {
								return d3.sum(d, function(g) {
									return 1;
								});
							}).entries(csv_data);

							//     console.log(donutData);

							donutData.filter(function(d) {
								return (d.key == "New" || d.key == "Lost")
							}).forEach(function(d, i) {
								//   console.log(d.key)
								var item = [ d.key ];
								item.push(d.values);
								modData.push(item);
							});

							var donutChart = c3.generate({
								data : {
									columns : modData,
									//mimeType: 'json'
									type : 'donut',
									onclick : function(d, i) {
										//    console.log("onclick", d, i);
									},
									onmouseover : function(d, i) {
										//  console.log("onmouseover", d, i);
									},
									onmouseout : function(d, i) {
										//  console.log("onmouseout", d, i);
									}
								},
								donut : {
									title : "Customer"
								},
								bindto : "#chart"
							});

							modData = [];
							category = [];
							item = [];
							//var data = csv_data.filter(function(d) { return (d.Transaction_Type == "New" || d.Transaction_Type == "Lost");});
							//console.log(csv_data);
							var categoryLineData = d3.nest()

							.key(
									function(d) {

										var monthYear = d3.time.format("%b-%Y")
												(new Date(d.Transaction_Date));
										//  console.log(monthYear);
										return monthYear;
									}).rollup(function(d) {

								var subData = d3.nest().key(function(d) {
									return d.Transaction_Type;
								}).rollup(function(d) {
									return d
								}).entries(d);
								return subData;
							}).entries(csv_data);
							console.log(categoryLineData);
							var customerCountKPI = totalPolicy = totalPaymentCost = 0;
							var newItem = [ "New" ];
							var lostItem = [ "Lost" ];
							category = [];
							item = [ "Total Customer Count" ];
							var totalModData = [];
							var lastMonthChangeCC = 0;
							var firstMonthChangeCC = 0;
							var lastMonthChangePD = 0;
							var firstMonthChangePD = 0;
							var lastMonthChangeGWP = 0;
							var firstMonthChangeGWP = 0;
							var lastMonthChangeRES = 0;
							var firstMonthChangeRES = 0;

							var prevMonthCC = 1;
							var firstMonthCC = 0;
							var currMonthCC = 0;
							var prevMonthPD = 1;
							var firstMonthPD = 0;
							var currMonthPD = 0;
							var prevMonthGWP = 1;
							var firstMonthGWP = 0;
							var currMonthGWP = 0;
							var prevMonthRES = 1;
							var firstMonthRES = 0;
							var currMonthRES = 0;
							categoryLineData
									.filter(function(f) {
										return f.key != "Jan-1970"
									})
									.forEach(
											function(d, i) {

												currMonthCC = 0;

												console.log(d.key);
												category.push(d.key);

												d.values
														.forEach(function(k, l) {

															var custCount = d3
																	.map(
																			k.values,
																			function(
																					d) {
																				return d.Customer_ID;
																			})
																	.keys().length;
															var policyCount = k.values.length;
															var paymentSum = d3
																	.sum(
																			k.values,
																			function(
																					d) {
																				return d.Payment_Cost;
																			});
															if (k.key == "Lost") {
																console
																		.log(custCount);
																lostItem
																		.push(custCount);
																customerCountKPI = customerCountKPI
																		- custCount;
																totalPolicy = totalPolicy
																		- policyCount;
																totalPaymentCost = totalPaymentCost
																		- paymentSum;
															} else if (k.key == "New") {
																newItem
																		.push(custCount);
																customerCountKPI = customerCountKPI
																		+ custCount;
																totalPolicy = totalPolicy
																		+ policyCount;
																totalPaymentCost = totalPaymentCost
																		+ paymentSum;
															} else {
																customerCountKPI = customerCountKPI
																		+ custCount;
																totalPolicy = totalPolicy
																		+ policyCount;
																totalPaymentCost = totalPaymentCost
																		+ paymentSum;
															}
														});
												//customerCountKPI = customerCountKPI + currMonthCC;
												lastMonthChangeCC = ((customerCountKPI - prevMonthCC) / prevMonthCC) * 100;
												lastMonthChangePD = ((totalPolicy - prevMonthPD) / prevMonthPD) * 100;
												lastMonthChangeGWP = ((totalPaymentCost - prevMonthGWP) / prevMonthGWP) * 100;
												item.push(customerCountKPI);
												//        console.log(currMonthCC);
												//      console.log(prevMonthCC);
												if (prevMonthCC == 1) {
													firstMonthCC = customerCountKPI;
													firstMonthPD = totalPolicy;
													firstMonthGWP = totalPaymentCost;
												}
												prevMonthCC = customerCountKPI;
												prevMonthPD = totalPolicy;
												prevMonthGWP = totalPaymentCost;

											});
							policyDensityKPI = (totalPolicy / customerCountKPI);
							firstMonthChangeCC = ((customerCountKPI - firstMonthCC) / firstMonthCC) * 100;
							firstMonthChangePD = ((totalPolicy - firstMonthPD) / firstMonthPD) * 100;
							firstMonthChangeGWP = ((totalPaymentCost - firstMonthGWP) / firstMonthGWP) * 100;

							var reserveKPI = totalPaymentCost * 0.75;
							var amtFormat = d3.format(",.0f");
							var txtFormat = d3.format(",.2f");
							//// ######### Customer Count KPI ################# ////
							d3.select("#txtCustomerCountKPI").text(
									customerCountKPI);

							d3.select("#lastMonthCCKPI").style("color",
									txtColorFunc(lastMonthChangeCC)).style(
									"font-weight", "bold").text(
									txtFormat(lastMonthChangeCC).concat("%"));
							d3.select("#firstMonthCCKPI").style("color",
									txtColorFunc(firstMonthChangeCC)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangeCC).concat("%"));
							d3.select("#eoyCCKPI").style("color",
									txtColorFunc(firstMonthChangeCC)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangeCC).concat("%"));

							//// ######### Product Density KPI ################# ////
							d3.select("#txtProductDensityKPI").text(
									txtFormat(policyDensityKPI));

							d3.select("#lastMonthPDKPI").style("color",
									txtColorFunc(lastMonthChangePD)).style(
									"font-weight", "bold").text(
									txtFormat(lastMonthChangePD).concat("%"));
							d3.select("#firstMonthPDKPI").style("color",
									txtColorFunc(firstMonthChangePD)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangePD).concat("%"));
							d3.select("#eoyPDKPI").style("color",
									txtColorFunc(firstMonthChangePD)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangePD).concat("%"));

							//// ######### Gross Written Premium KPI ################# ////
							d3.select("#txtGrossWrittenPremiumKPI").style(
									"font-size", "15px").text(
									"€ ".concat(amtFormat(totalPaymentCost)));

							d3.select("#lastMonthGWPKPI").style("color",
									txtColorFunc(lastMonthChangeGWP)).style(
									"font-weight", "bold").text(
									txtFormat(lastMonthChangeGWP).concat("%"));
							d3.select("#firstMonthGWPKPI").style("color",
									txtColorFunc(firstMonthChangeGWP)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangeGWP).concat("%"));
							d3.select("#eoyGWPKPI").style("color",
									txtColorFunc(firstMonthChangeGWP)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangeGWP).concat("%"));

							//// ######### Reserve KPI ################# ////
							d3
									.select("#txtReserveKPI")
									.style("font-size", "15px")
									.text(
											"€ "
													.concat(amtFormat(totalPaymentCost * 0.75)));
							var amtFormat = d3.format(",.0f");
							d3.select("#lastMonthRESKPI").style("color",
									txtColorFunc(lastMonthChangeGWP)).style(
									"font-weight", "bold").text(
									txtFormat(lastMonthChangeGWP).concat("%"));
							d3.select("#firstMonthRESKPI").style("color",
									txtColorFunc(firstMonthChangeGWP)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangeGWP).concat("%"));
							d3.select("#eoyRESKPI").style("color",
									txtColorFunc(firstMonthChangeGWP)).style(
									"font-weight", "bold").text(
									txtFormat(firstMonthChangeGWP).concat("%"));

							//   console.log(item);
							totalModData.push(item);
							modData.push(newItem);
							modData.push(lostItem);
							//     console.log(customerCountKPI);
							//   console.log(totalModData);
							//							console.log(modData);
							var categoryLineChart = c3.generate({
								data : {
									columns : modData

								},
								axis : {
									x : {
										type : 'category',
										categories : category
									}
								},
								bindto : '#chart2'
							});

							//    console.log(category);
							//console.log(modData);
							var totalLineChart = c3.generate({
								data : {
									columns : totalModData

								},
								axis : {
									x : {
										type : 'category',
										categories : category
									}
								},
								bindto : '#chart1'
							});

							/////WIP::::WORK IN PROGRESS: WATERFALL
							modData = [];
							category = [];
							item = [];
							var WaterfallData = d3.nest().key(function(d) {
								return d.Transaction_Detail;
							}).rollup(function(d) {
								return d3.sum(d, function(g) {
									return 1;
								});
							}).entries(csv_data);

							console.log("Waterfall");
							console.log(WaterfallData);

							// Transform data (i.e., finding cumulative values and total)
							var cumulative = 0;
							for (var i = 0; i < WaterfallData.length; i++) {
								WaterfallData[i].start = cumulative;
								cumulative += WaterfallData[i].values;
								WaterfallData[i].end = cumulative;
								//WIP::::PENDING----LOGIC FOR +ve / -ve
								WaterfallData[i].class = (WaterfallData[i].values >= 0) ? 'positive'
										: 'negative'
							}
							WaterfallData.push({
								name : 'Total',
								key : 'Total',
								end : cumulative,
								values : cumulative,
								start : 0,
								class : 'total'
							});

							var startValueArray = [ 'data1' ];
							var endValueArray = [ 'data2' ];
							WaterfallData.forEach(function(k) {
								startValueArray.push(k.start);
								endValueArray.push(k.values);
							});
							console.log("Start waterfall");
							console.log(startValueArray);
							console.log(endValueArray);

							var waterfallChart = c3
									.generate({
										data : {
											columns : [ startValueArray,
													endValueArray ],
											type : 'bar',
											colors : {
												data1 : '#ffffff'
											},
											groups : [ [ 'data2', 'data1' ] ],
											order : null
										},
										grid : {
											y : {
												lines : [ {
													value : 0
												} ]
											}
										},
										bindto : '#chart4'
									});
						});

		function txtColorFunc(value) {
			var valueColor = "green";
			if (value < 0) {
				valueColor = "red";
			} else if (value == 0) {
				valueColor = "orange";
			} else {
				valueColor = "green";
			}
			return valueColor;
		}
	</script>
	<!-- header logo: style can be found in header.less -->
	<header class="header">
		<a href="index.html" class="logo"> Italy Customer Walk</a>
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
							class="fa fa-user"></i> <span>Dhaval Modi<i class="caret"></i></span>
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
						<p>Hello, Dhaval</p>

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
					<li class="active"><a href="#"> <i class="fa fa-dashboard"></i>
							<span>Month</span></br> <select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
					</a></li>
					<li><a href="general.html"> <i class="fa fa-gavel"></i> <span>Channel
								Type</span></br> <select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
					</a></li>

					<li><a href="basic_form.html"> <i class="fa fa-globe"></i>
							<span >Channel Name</span></br> <select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
					</a></li>

					<li><a href="simple.html"> <i class="fa fa-globe"></i> <span>Region</span></br>
							<select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
					</a></li>
					<li><a href="simple.html"> <i class="fa fa-glass"></i> <span>Product
								Family</span></br> <select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
					</a></li>
					<li><a href="simple.html"> <i class="fa fa-glass"></i> <span>Policy
								Name</span></br> <select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
					</a></li>
					<li><a href="simple.html"> <i class="fa fa-glass"></i> <span>Customer
								Type</span></br> <select class="form-control m-b-10">
								<option value="volvo">Volvo</option>
								<option value="saab">Saab</option>
								<option value="opel">Opel</option>
								<option value="audi">Audi</option>
						</select>
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
							<div class="sm-st-info">
								<span>Customer Count</span>
								<div id="txtCustomerCountKPI" class="bigText"></div>
								<div class="smallText">&nbsp; &nbsp;vs. Start Date</div>
								<div id="firstMonthCCKPI" class="smallText"></div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. EOY (12/31/2015)</div>
								<div id="eoyCCKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. Same Month Last</div>
								<div id="lastMonthCCKPI" class="smallText">2.53%</div>
								</br>

							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="sm-st clearfix">

							<div class="sm-st-info">
								<span>Product Density</span>
								<div id="txtProductDensityKPI" class="bigText">1343</div>
								<div class="smallText">&nbsp; &nbsp;vs. Start Date</div>
								<div id="firstMonthPDKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. EOY (12/31/2015)</div>
								<div id="eoyPDKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. Same Month Last</div>
								<div id="lastMonthPDKPI" class="smallText">2.53%</div>
								</br>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="sm-st clearfix">

							<div class="sm-st-info">
								<span>Gross Written Premium</span>
								<div id="txtGrossWrittenPremiumKPI" class="bigText">2424</div>
								<div class="smallText">&nbsp; &nbsp;vs. Start Date</div>
								<div id="firstMonthGWPKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. EOY (12/31/2015)</div>
								<div id="eoyGWPKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. Same Month Last</div>
								<div id="lastMonthGWPKPI" class="smallText">2.53%</div>
								</br>
							</div>
						</div>
					</div>
					<div class="col-md-3">
						<div class="sm-st clearfix">

							<div class="sm-st-info">
								<span>Reserve</span>
								<div id="txtReserveKPI" class="bigText">1342</div>
								<div class="smallText">&nbsp; &nbsp;vs. Start Date</div>
								<div id="firstMonthRESKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. EOY (12/31/2015)</div>
								<div id="eoyRESKPI" class="smallText">2.53%</div>
								</br>
								<div class="smallText">&nbsp; &nbsp;vs. Same Month Last</div>
								<div id="lastMonthRESKPI" class="smallText">2.53%</div>
								</br>
							</div>
						</div>
					</div>
				</div>

				<!-- Main row -->
				<div class="row">

					<div class="col-md-6">
						<!--earning graph start-->
						<section class="panel">
							<header class="panel-heading"> What are the customer
								movements in this time period? </header>
							<div class="panel-body">
								<div id="chart"></div>
							</div>
						</section>
						<!--earning graph end-->

					</div>
					<div class="col-md-6">

						<!--chat start-->
						<section class="panel">
							<header class="panel-heading"> What are the detailed
								customer movements in this time period? </header>
							<div class="panel-body">
								<div id="chart4"></div>
							</div>
						</section>
					</div>
				</div>
				<div class="row">
					<div class="col-md-6">
						<section class="panel">
							<header class="panel-heading"> How are customer
								movements trending over time? </header>
							<div class="panel-body">
								<div id="chart1"></div>
							</div>
						</section>
					</div>
					<!--end col-6 -->
					<div class="col-md-6">
						<section class="panel">
							<header class="panel-heading"> How is customer
								acquisition trending over time? </header>
							<div class="panel-body">
								<div id="chart2"></div>
							</div>
						</section>
					</div>

				</div>
			</section>
			<!-- /.content -->
			<div class="footer-main">Copyright &copy Zurich EDAA, 2016</div>
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