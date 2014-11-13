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
//= require_tree .

$(function(){ $(document).foundation(); });
$('button').select('span').html("Donate");



$(document).ready(function(){

  $('.user-feed').delay(100).fadeIn();
	
  $('.nonprofit-info').fadeIn();
  $('.donations').delay(100).fadeIn();
  $('.topics').delay(300).fadeIn();

	$('.EIN-form').focusout(function(){
		var ein = $('#nonprofit-tax-id')[0].value;
		$.ajax({ 
      dataType:'jsonp', 
      contentType:'application/json',  
      jsonp:'jsonpfunc', 
      url:'http://graphapi.firstgiving.com/v1/list/organization?q=government_id:'+ein,
	}).success(function(data){
    console.log(data.payload[0]);
    $('.nonprofit-form').fadeIn();
    $('#nonprofit_name')[0].value = data.payload[0].organization_name;
    $('#nonprofit_city')[0].value = data.payload[0].city;
    $('#nonprofit_state')[0].value = data.payload[0].region;
    $('#nonprofit_website')[0].value = data.payload[0].url;
    $('#nonprofit_phone')[0].value = data.payload[0].phone_number;
    $('#nonprofit_description')[0].value = data.payload[0].mission_statement;
    $('#nonprofit_logo')[0].value = data.payload[0].logo_path;
    $('#nonprofit_ein')[0].value = data.payload[0].government_id;
    $('#nonprofit_uuid')[0].value = data.payload[0].organization_uuid;
    

    


  });

 });

});


var url = document.location.pathname +'.json';

var margin1 = {top: 20, right: 20, bottom: 30, left: 40},
    width1 = 700 - margin1.left - margin1.right,
    height1 = 500 - margin1.top - margin1.bottom;

var x = d3.scale.ordinal()
    .rangeRoundBands([0, width1], .1);

var y = d3.scale.linear()
    .range([height1, 0]);

var xAxis = d3.svg.axis()
    .scale(x)
    .orient("bottom");

var yAxis = d3.svg.axis()
    .scale(y)
    .orient("left")
    .ticks(1);

var svg1 = d3.select(".donations").append("svg")
    .attr("width", width1 + margin1.left + margin1.right)
    .attr("height", height1 + margin1.top + margin1.bottom)
  .append("g")
    .attr("transform", "translate(" + margin1.left + "," + margin1.top + ")");

d3.tsv($.get(url, function(data) {
  console.log(data);
  x.domain(data.data[0].map(function(d) { console.log(d.date);return d.date; }));
  y.domain([0, 3+d3.max(data.data[0], function(d) { console.log(d.donations);return d.donations; })]);

  svg1.append("g")
      .attr("class", "x axis")
      .attr("transform", "translate(0," + height1 + ")")
      .call(xAxis);

  svg1.append("g")
      .attr("class", "y axis")
      .call(yAxis)
    .append("text")
      .attr("transform", "rotate(-90)")
      .attr("y", 6)
      .attr("dy", ".71em")
      .style("text-anchor", "end")
      .text("# of Donations");

  svg1.selectAll(".bar")
      .data(data.data[0])
    .enter().append("rect")
      .attr("class", "bar")
      .attr("x", function(d) { return x(d.date); })
      .attr("width", x.rangeBand())
      .attr("y", function(d) { return y(d.donations); })
      .attr("height", function(d) { return height1 - y(d.donations); });

}));

function type(d) {
  d.donations = +d.donations;
  return d;
}

	
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

var allDonations = 
    d3.select('.d3')
      .append("svg")
        .attr("width", 1200)
        .attr("height", 900);
  var url = document.location.pathname +'.json';
    

  var jsonEventUsers = $.get(url,
    function(data) {
     
    var divWidth = 1000;   
    
    allDonations.selectAll("circle")
      .data(data.data[0])
      .enter()
      .append("circle")
      .attr("r", 10)
      .attr("cy", function(d, i){return (Math.floor(Math.random() * (700 - 200)) + 200)})
      .attr("cx", function(d, index){
         if (d.donations > 1){
            return (divWidth/d.donations)+(index*50)
          } else {
            return (divWidth - (index+100))
          }
        })
      .style("fill", function(d, index){
        
          return "rgba(" + Math.floor(Math.random() * (250 - 0) + 0) + ",255,255, .9)"
        // var color = index * 10 + 50;
        // return "rgba("+color+","+color+ ","+color+",1)";
      })
      .on('mouseover', function(d){
          var nodeSelection = d3.select(this).style({opacity:'.6'});
          d3.select('svg').append('text')
          d3.select('svg').select("text")
            .html(d.nonprofit)
            .attr("y", 100)
            .attr('x', 330)
            .style("fill", "#FFF")
            .style('font-size', '30px')})
      .on('mouseleave', function(d){
        d3.select(this).style({opacity: '1'})
      })
      .transition()
        .duration(750)
        .delay(function(d, i) { return i * 200; })
        .attr("r", function(d){return d.donations*(data.data[0].length* (10 - data.data[0].length))});
    
    




    profileEventHolder.attr("width", divWidth()); 
 


    $('.events-feed').css("width", function() {
      return divWidth()
    })  

  }) //Last closing brackets for jsonEventUsers






