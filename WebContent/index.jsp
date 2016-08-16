<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Zurich Dashboard - Italy Customer Walk</title>
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

	<script type="text/javascript">
		d3.csv("customer_walk_flat_file.csv", function(error, csv_data) {
			var parseDate = d3.time.format("%m/%d/%Y").parse;
			filterTransactionType = "";
			csv_data.forEach(function(d) {
						d.Transaction_Date = parseDate(d.Transaction_Date);
					});
			
			original_dataset = csv_data;
			filtered_data = csv_data;
			createDonutChart();

			var modData = [];
			var category = [];
			var item = [];

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
			}).entries(filtered_data);
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
			
			populateMonthFilterList(category);
			populateChannelTypeFilterList();
			populateChannelNameFilterList();
			populateRegionFilterList();
			populateProdFamilyFilterList();
			populatePolicyNameFilterList();
			populatecustomerTypeFilterList();
			
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

			createWaterfallChart();
			
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
		
		function refreshCharts(){
			createFilterDataTable();
			createDonutChart ();
		}
		
		function resetCharts(){
			document.getElementById('monthDropDown').value = "";
			document.getElementById('channelTypeDropDown').value = "";
			document.getElementById('channelNameDropDown').value = "";
			document.getElementById('regionDropDown').value = "";
			document.getElementById('prodFamilyDropDown').value = "";
			document.getElementById('policyNameDropDown').value = "";
			document.getElementById('customerTypeDropDown').value = "";
			
			filtered_data = original_dataset;
			createDonutChart();
			createWaterfallChart();
		}
		
		function createWaterfallChart(){
			var waterfallData = d3.nest().key(function(d) {
					return d.Transaction_Detail;
				}).rollup(function(d) {
					return d3.sum(d, function(g) {
						return 1;
					});
				}).entries(filtered_data);
			console.log("waterfall chart...", waterfallData);
			var xAxisList = [];
			for(var i = 0; i < waterfallData.length; i++) {
					xAxisList.push(waterfallData[i].key);
				}
			xAxisList.push("Closing");
			console.log("waterfall chart 2...", xAxisList);
			// Transform data (i.e., finding cumulative values and total)
			var cumulative = 0;
			for (var i = 0; i < waterfallData.length; i++) {
				waterfallData[i].start = cumulative;
				cumulative += waterfallData[i].values;
				waterfallData[i].end = cumulative;
				//WIP::::PENDING----LOGIC FOR +ve / -ve
				waterfallData[i].class = (waterfallData[i].values >= 0) ? 'positive'
						: 'negative'
			}
			waterfallData.push({
				name : 'Total',
				key : 'Total',
				end : cumulative,
				values : cumulative,
				start : 0,
				class : 'total'
			});

			var startValueArray = [ 'data1' ];
			var endValueArray = [ 'data2' ];
			waterfallData.forEach(function(k) {
				startValueArray.push(k.start);
				endValueArray.push(k.values);
			});

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
						/*axis : {
							x : {
								type : 'category',
								categories : xAxisList
						},*/
						bindto : '#chart4'
					});
		}
		
		function createDonutChart(){
			//Prepare Data for Donut Chart
			var modData = [];
			var item = [];
			
			var donutData = d3.nest().key(function(d) {
				return d.Transaction_Type;
			}).rollup(function(d) {
				return d3.sum(d, function(g) {
					return 1;
				});
			}).entries(filtered_data);

			donutData.filter(function(d) {
				return (d.key == "New" || d.key == "Lost")
			}).forEach(function(d, i) {
				var item = [ d.key ];
				item.push(d.values);
				modData.push(item);
			});
			
			//Create Donut chart
			var currentSlice;
			var donutChart = c3.generate({
				data : {
					columns : modData,
					type : 'donut',
					onclick : function(d, i) {
						if(filterTransactionType == d.id)	{
							filterTransactionType = "";
						} else {
							filterTransactionType = d.id;
						}
						createFilterDataTable();
						createWaterfallChart();
						/*console.log("currentSlice", currentSlice);
						if(currentSlice !== void 0) {
							currentSlice.attr("transform","scale(1)")
						}
						console.log("currentSlice 2", currentSlice);
						currentSlice = d3.select(i).attr("transform", "scale(1.1)");
						console.log("currentSlice 3", currentSlice);*/
					},
					onmouseover : function(d, i) {
						//console.log("onmouseover", d, i);
						//console.log("onmouseover 2", d3.select(i));
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
			
			d3.selectAll(".c3-legend-item-modData text").text("Changed")
		}

		function createFilterDataTable() {
			//Filter Panel Values
			var monthValue = document.getElementById('monthDropDown').value;
			var channelType = document.getElementById('channelTypeDropDown').value;
			var channelName = document.getElementById('channelNameDropDown').value;
			var regionValue = document.getElementById('regionDropDown').value;
			var prodFamily = document.getElementById('prodFamilyDropDown').value;
			var policyName = document.getElementById('policyNameDropDown').value;
			var customerType = document.getElementById('customerTypeDropDown').value;
			
			filtered_data = original_dataset.filter(function(e) {
				if((monthValue == "" || e.Month == monthValue) && (channelType == "" || e.Sales_Channel == channelType) 
					&& (channelName == "" || e.Sales_Channel_Name == channelName) && (regionValue == "" || e.Sales_Channel_City == regionValue)
					&& (prodFamily == "" || e.Product_Family == prodFamily) && (policyName == "" || e.Policy_Name == policyName)
					&& (customerType == "" || e.Customer_Type == customerType) && (filterTransactionType == "" || e.Transaction_Type == filterTransactionType))	{
					return e;
				}
			});
		}
		
		function populateMonthFilterList(category){
			var sel = document.getElementById('monthDropDown');
			addBlankOptionToDropDownList(sel, "Select Month...");
			
			for(var i = 0; i < category.length; i++) {
				opt = document.createElement('option');
				opt.innerHTML = category[i];
				opt.value = category[i];
				sel.appendChild(opt);
			}
		}
		
		function populateChannelTypeFilterList(){
			
			var ChannelTypeOptions = d3.nest().key(function(d) {
				return d.Sales_Channel;
			}).entries(filtered_data);
			
			var sel = document.getElementById('channelTypeDropDown');
			addBlankOptionToDropDownList(sel, "Select Channel...");						
			addOptionsToDropDownList(sel, ChannelTypeOptions);	
		}
		
		function populateChannelNameFilterList(){
			var ChannelNameOptions = d3.nest().key(function(d) {
				return d.Sales_Channel_Name;
			}).entries(filtered_data);
			
			var sel = document.getElementById('channelNameDropDown');
			addBlankOptionToDropDownList(sel, "Select Channel Name...");
			addOptionsToDropDownList(sel, ChannelNameOptions);	
		}
		
		function populateRegionFilterList(){
			var regionOptions = d3.nest().key(function(d) {
				return d.Sales_Channel_City;
			}).entries(filtered_data);
			
			var sel = document.getElementById('regionDropDown');
			addBlankOptionToDropDownList(sel, "Select Region...");
			addOptionsToDropDownList(sel, regionOptions);
		}
		
		function populateProdFamilyFilterList(){
			var prodFamilyOptions = d3.nest().key(function(d) {
				return d.Product_Family;
			}).entries(filtered_data);
			
			var sel = document.getElementById('prodFamilyDropDown');
			addBlankOptionToDropDownList(sel, "Select Prod Family...");
			addOptionsToDropDownList(sel, prodFamilyOptions);
		}
		
		function populatePolicyNameFilterList(){
			var policyNameOptions = d3.nest().key(function(d) {
				return d.Policy_Name;
			}).entries(filtered_data);
			
			var sel = document.getElementById('policyNameDropDown');
			addBlankOptionToDropDownList(sel, "Select Policy Name...");
			addOptionsToDropDownList(sel, policyNameOptions);
		}

		function populatecustomerTypeFilterList(){
			var customerTypeOptions = d3.nest().key(function(d) {
				return d.Customer_Type;
			}).entries(filtered_data);
			
			var sel = document.getElementById('customerTypeDropDown');
			addBlankOptionToDropDownList(sel, "Select Customer Type...");
			addOptionsToDropDownList(sel, customerTypeOptions);
		}
		
		function addBlankOptionToDropDownList(sel, optionName){
			var opt = document.createElement('option');
			opt.innerHTML = optionName;
			opt.value = "";
			opt.selected  = true;
			opt.disabled  = true;
			sel.appendChild(opt);
		}
		
		function addOptionsToDropDownList(sel, optionsList){
			for(var i = 0; i < optionsList.length; i++) {
				var opt = document.createElement('option');
				opt.innerHTML = optionsList[i].key;
				opt.value = optionsList[i].key;
				sel.appendChild(opt);
			}
		}
	</script>
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

				<!-- sidebar menu: : style can be found in sidebar.less -->
				<ul class="sidebar-menu">
				<li><font color="white"><i class="fa"></i>
							<span style="font-weight:300px; font-size:16px;">Filters</span></font></li>
						
					<li><font color="white"><i class="fa fa-dashboard"></i>
							<span>Month</span></font></br> <select id="monthDropDown"
						class="form-control input-sm m-b-10">
					</select></li>
					<li><font color="white"><i class="fa fa-gear"></i> <span>Channel
								Type</span></font></br> <select id="channelTypeDropDown"
						class="form-control input-sm m-b-10" onchange="refreshCharts()">
					</select></li>

					<li><font color="white"><i class="fa fa-road"></i> <span>Channel
								Name</span></font></br> <select id="channelNameDropDown"
						class="form-control input-sm m-b-10">
					</select></li>

					<li><font color="white"><i class="fa fa-globe"></i> <span>Region</span></font></br>
						<select id="regionDropDown" class="form-control input-sm m-b-10">

					</select></li>
					<li><font color="white"><i class="fa fa-star"></i> <span>Product
								Family</span></font></br> <select id="prodFamilyDropDown"
						class="form-control input-sm m-b-10">

					</select></li>
					<li><font color="white"> <i class="fa fa-glass"></i><span>Policy
								Name</span></font></br> <select id="policyNameDropDown" class="form-control input-sm m-b-10">

					</select></li>
					<li><font color="white"><i class="fa fa-user"></i> <span>Customer
								Type</span></font></br> <select id="customerTypeDropDown"
						class="form-control input-sm m-b-10">

					</select></li>
					</br>
					<li>
						<button class="btn btn-info" style="margin-left: 15px" onclick="resetCharts()">Reset</button>
					</li>
				</ul>
			</section>
			<!-- /.sidebar -->
		</aside>
		<!-- Right side column. Contains the navbar and content of the page -->
            <div class="right-side">

                <section class="content">
                    <div class="row" style="margin-bottom: 5px;">
                            <!--breadcrumbs start -->
                            <ul class="breadcrumb">
                                <li><a href="#"><i class="fa fa-home"></i>Home</a></li>
                                <li><a href="#">Dashboard</a></li>
                                <li class="active">Customer Walk</li>
                            </ul>
                            <!--breadcrumbs end -->
                    </div>

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

</body>
</html>
