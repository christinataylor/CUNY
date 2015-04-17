

// d3.select('body').selectAll('div')
// 	.data([5,10,15,20,25])
// 	.enter()
// 	.append('div')
// 	.attr('class', 'bar')
// 	.style('height', function(d) {
// 		var barHeight = d * 5;
// 		return barHeight + 'px';
// 	});

// (function(){

// 	d3.csv('presidents.csv', function(data){

// 		d3.select('body').selectAll('div')
// 			.data(data)
// 			.enter()
// 			.append('div')
// 			.attr('class', 'bar')
// 			.style('height', function(d){
// 				var barHeight = d.Height * 2;
// 				return barHeight + 'px';
// 			})
// 			.style('width', function(d){
// 				var barWidth = d.Weight /5;
// 				return barWidth + 'px';
// 			});
// 	});


// })();

// (function(){

// 	var w = 500;
// 	var h = 100;
// 	var dataset = [5,10,-15,20,25];

// 	var svg = d3.select('body')
// 							.append('svg')
// 							.attr('width', w)
// 							.attr('height', h);

// 	svg.selectAll('rect')
// 		.data(dataset)
// 		.enter()
// 		.append('rect')
// 		.attr('x', function(d, i){
// 			return i * (w / dataset.length);
// 		})
// 		.attr('y', function(d){
// 			if(d >= 0){
// 				return (h/2) - d;
// 			} else {
// 				return (h/2);
// 			}
// 		})
// 		.attr('width', 20)
// 		.attr('height', function(d){
// 			return Math.abs(d);
// 		});

// })();

// Bars using presidents.csv, compatible with negative numbers

(function(){

	var w = 500;
	var h = 300;

	d3.csv('presidents.csv', function(data){

		var svg = d3.select('body')
								.append('svg')
								.attr('width', w)
								.attr('height', h);

		svg.selectAll('rect')
			.data(data)
			.enter()
			.append('rect')
			.attr('x', function(d, i){
				return i * (w / data.length);
			})
			.attr('y', function(d){
				if(d.Height >= 0){
					return (h/2)- d.Height;
				} else {
					return (h/2);
				}
			})
			.attr('width', 20)
			.attr('height', function(d){
				return Math.abs(d.Height);
			})

	});

})();

// bars using econ data, compatible with negative numbers

(function(){

	var w = 500;
	var h = 300;

	d3.csv('d3econdata.csv', function(data){

		var svg = d3.select('body')
								.append('svg')
								.attr('width', w)
								.attr('height', h);

		svg.selectAll('rect')
			.data(data)
			.enter()
			.append('rect')
			.attr('x', function(d, i){
				return i * (w / data.length);
			})
			.attr('y', function(d){
				if(d.MeanCVS >= 0){
					return (h/2)- (d.MeanCVS*20);
				} else {
					return (h/2);
				}
			})
			.attr('width', 20)
			.attr('height', function(d){
				return Math.abs(d.MeanCVS*20);
			})

	});

})();