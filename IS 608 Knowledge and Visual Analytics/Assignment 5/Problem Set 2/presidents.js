function displayCustomTable(){

	d3.csv('presidents.csv', function(data){

		d3.select('body').select('table').remove();

		var presName = document.getElementById('presField').value;

		var columns = ['Name', 'Height', 'Weight'];

		var table = d3.select('body').append('table'),
			thead = table.append('thead'),
			tbody = table.append('tbody');

		thead.append('tr')
			.selectAll('th')
			.data(columns)
			.enter()
			.append('th')
			.text(function(column) { return column; });

		var rows = tbody.selectAll('tr')
			.data(data)
			.enter()
			.append('tr')
			.filter(function(presRow){ return presRow.Name == presName; });

		var cells = rows.selectAll('td')
			.data(function(row){
				return columns.map(function(column){
					return {column: column, value: row[column]};
				});
			})
			.enter()
			.append('td')
			.text(function(d){ return d.value; });

	});	


}

(function(){
	
	// d3.csv('presidents.csv')
	// d3.select('body').append('p').text('Hello!');
	d3.csv('presidents.csv', function(data){

		// d3.select('body').append('p').text(data[1].Name);

		// <body><table>scott</table></body>;
		// console.log(data);

		var columns = ['Name', 'Height', 'Weight'];

		var table = d3.select('body').append('table'),
			thead = table.append('thead'),
			tbody = table.append('tbody');

		thead.append('tr')
			.selectAll('th')
			.data(columns)
			.enter()
			.append('th')
			.text(function(column) { return column; });

		var rows = tbody.selectAll('tr')
			.data(data)
			.enter()
			.append('tr')

		// Why does this run even though it's only being stored in a var?
		var cells = rows.selectAll('td')
			.data(function(row){
				return columns.map(function(column){
					return {column: column, value: row[column]};
				});
			})
			.enter()
			.append('td')
			.text(function(d){ return d.value; });





		// d3.select('body').append('table')

		// d3.select('body').select('table').selectAll('tr').data(data).enter().append('tr')
		// .selectAll('td').data(function(row){
		// 	return columns.map(function(column){
		// 		return  {column: column, value: row[column]};
		// 	})
		// })
		// .enter().append('td').text(function(d){ return d.value; });
		
		// d3.select('body').selectAll('p').data(data).enter().append('p').text(data[0].Name);


		// data.forEach(function(president){
		// 	d3.select('body').select('table').append('tr').selectAll('td').data(president).enter().append('td').text(president);
		// })

		// data.forEach(function(president, index){

		// 	d3.select('body').select('table').append('tr').append('td').text(president.Name);
		// 	d3.select('body').select('table').select('tr:nth-child(index)').append('td').text(president.Height);
		// 	d3.select('body').select('table').select('tr').append('td').text(president.Weight);

		// });
	});

})();