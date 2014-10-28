// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require turbolinks
//= require_tree .

$(function(){ $(document).foundation(); });
$('button').select('span').html("Donate");


$(document).ready(function(){
  $('.stripe-button-el').fadeIn();
  $('.user-feed').delay(100).fadeIn();
	
  $('.nonprofit-info').fadeIn();
  $('.donations').delay(100).fadeIn();
  $('.topics').delay(300).fadeIn();

	$('#nonprofit-tax-id').focusout(function(){
		var ein = $('#nonprofit-tax-id')[0].value;
		$.ajax({
  			type:     "GET",
  			url:      "https://projects.propublica.org/nonprofits/api/v1/organizations/"+ein+".json",
  			dataType: "jsonp",
  			crossDomain: true,
		}).success(function(data){
			console.log(data);
			$('.stripe-sign-in-link').fadeIn();
		});

	});

 

})


	
var url = document.location.pathname +'.json';
		
var width = 300,
    height = 300,
    radius = Math.min(width, height) / 2;

var color = d3.scale.ordinal()
    .range(["#98abc5", "#8a89a6", "#7b6888", "#6b486b", "#a05d56", "#d0743c", "#ff8c00"]);

var arc = d3.svg.arc()
    .outerRadius(radius - 10)
    .innerRadius(radius - 70);

var pie = d3.layout.pie()
    .sort(null)
    .value(function(d) { return d.donations; });

var svg = d3.select('.user-donations').append("svg")
    .attr("width", width)
    .attr("height", height)
  	.append("g")
    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");

d3.csv($.get(url, function(data) {

data.data.forEach(function(d) {
	console.log(d)
    d.donations = +d.donations;
  });

  var g = svg.selectAll(".arc")
      .data(pie(data.data))
    .enter().append("g")
      .attr("class", "arc");

  g.append("path")
  .style("fill", function(d) { return color(d.data.topic); })
  .transition().delay(function(d, i) { return i * 500; }).duration(600)
  .attrTween('d', function(d) {
       var i = d3.interpolate(d.startAngle+0.1, d.endAngle);
       return function(t) {
           d.endAngle = i(t);
         return arc(d);
       }
  });

  g.append("text")
      .attr("transform", function(d) { return "translate(" + arc.centroid(d) + ")"; })
      .attr("dy", ".35em")
      .style("text-anchor", "middle")
      .text(function(d) { return d.data.topic; });

}));














