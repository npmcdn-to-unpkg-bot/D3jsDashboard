<%@page contentType="text/html" pageEncoding="UTF-8"%>
<html>
<head>
<!DOCTYPE html>
<link href="c3/c3.css" rel="stylesheet" type="text/css">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<style>
.chart rect {
	fill: steelblue;
}

.chart text {
	fill: white;
	font: 10px sans-serif;
	text-anchor: end;
}
</style>


</head>

<body>
	<p>Hello World</p>
	<div id="chart"></div>
	<div id="chart1"></div>
	<div id="chart2"></div>
	<script src="http://d3js.org/d3.v3.min.js" charset="utf-8"></script>
	<script src="c3/c3.min.js"></script>
	<script>

	d3.csv("transaction_data.csv", function(error, csv_data) {
		var modData = [];
		var category = [];
		var item = [];
		var data = d3.nest()
		  .key(function(d) { return d.Transaction_Type;})
		  .rollup(function(d) { 
		   return d3.sum(d, function(g) {return 1; });
		  }).entries(csv_data);
  
    console.log(data);
    
    data.forEach(function(d, i) {
		  console.log(d.key)
		  var item = [d.key];
		  item.push(d.values);
		  modData.push(item);
	  });
	        
		  var chart = c3.generate({
	    data: {
	    	columns: modData,
	        //mimeType: 'json'
	 type : 'donut',
        onclick: function (d, i) { console.log("onclick", d, i); },
        onmouseover: function (d, i) { console.log("onmouseover", d, i); },
        onmouseout: function (d, i) { console.log("onmouseout", d, i); } 
	},
	donut: {
        title: "Customer"
	}
	});
	});
</script>
</body>
</html>