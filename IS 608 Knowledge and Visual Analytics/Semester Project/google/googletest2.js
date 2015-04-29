
var globalConcept = "DemandScore";
var globalConcept2 = "EmploymentScore";
var globalSector = "Total";
var globalCurrentOrFuture = "Current";

var dataForGoogle = []

// d3.select("#EconDropDown select")
//   .on("change", function(){
//     google.load("visualization", "1", {packages:["motionchart"]});

//     google.setOnLoadCallback(drawChart);

//   })




function drawChart() {
  d3.csv("agents.csv", function(error, data){

    dataForGoogle = data;


    var data = new google.visualization.DataTable();
        data.addColumn('string', globalConcept);
        data.addColumn('date', 'Date');
        data.addColumn('number', globalConcept);
        data.addColumn('number', globalConcept2);
        data.addColumn('string', 'ColorPlaceHolder');
        data.addColumn('number', 'SurveyCount');
        data.addRows([
    ["-4", new Date(2008,0,1), -4, -1.8333333333333333, "Color", 6],
    ["-3", new Date(2008,0,1), -3, -1, "Color", 8],
    ["-2", new Date(2008,0,1), -2, -1.35, "Color", 20],
    ["-1", new Date(2008,0,1), -1, 0.375, "Color", 16],
    ["0", new Date(2008,0,1), 0, 1.06, "Color", 50],
    ["1", new Date(2008,0,1), 1, 1.0232558139534886, "Color", 43],
    ["2", new Date(2008,0,1), 2, 0.4074074074074074, "Color", 81],
    ["3", new Date(2008,0,1), 3, 0.833333333333333, "Color", 96],
    ["4", new Date(2008,0,1), 4, 1.7833333333333337, "Color", 60],
    ["5", new Date(2008,0,1), 5, 2.041666666666667, "Color", 24],
    ["-5", new Date(2008,3,1), -5, -0.14285714285714285, "Color", 7],
    ["-4", new Date(2008,3,1), -4, -1.7333333333333334, "Color", 15],
    ["-3", new Date(2008,3,1), -3, 1.6071428571428577, "Color", 28],
    ["-2", new Date(2008,3,1), -2, -1.3, "Color", 30],
    ["-1", new Date(2008,3,1), -1, -0.28, "Color", 25],
    ["0", new Date(2008,3,1), 0, -0.5714285714285713, "Color", 42],
    ["1", new Date(2008,3,1), 1, 0.23999999999999996, "Color", 50],
    ["2", new Date(2008,3,1), 2, 0.48648648648648635, "Color", 111],
    ["3", new Date(2008,3,1), 3, 1.3495934959349591, "Color", 123],
    ["4", new Date(2008,3,1), 4, 1.6790123456790123, "Color", 81],
    ["5", new Date(2008,3,1), 5, 2.2592592592592595, "Color", 27],
    ["-5", new Date(2008,6,1), -5, -2.933333333333333, "Color", 15],
    ["-4", new Date(2008,6,1), -4, -2.8421052631578947, "Color", 19],
    ["-3", new Date(2008,6,1), -3, -1.6730769230769231, "Color", 52],
    ["-2", new Date(2008,6,1), -2, -1.2500000000000002, "Color", 44],
    ["-1", new Date(2008,6,1), -1, -1.2424242424242424, "Color", 33],
    ["0", new Date(2008,6,1), 0, -0.3846153846153846, "Color", 65],
    ["1", new Date(2008,6,1), 1, 0.3333333333333333, "Color", 57],
    ["2", new Date(2008,6,1), 2, 0.5327102803738317, "Color", 107],
    ["3", new Date(2008,6,1), 3, 0.9574468085106383, "Color", 141],
    ["4", new Date(2008,6,1), 4, 1.2954545454545452, "Color", 88],
    ["5", new Date(2008,6,1), 5, 1.9130434782608698, "Color", 23]
          ]);


      var chart = new google.visualization.MotionChart(document.getElementById('chart_div'));

      chart.draw(data, {width: 600, height:300});

    }); 

}

 


// ["-4", new Date(2008,0,1), -4, -1.8333333333333333, "Color", 6],
// ["-3", new Date(2008,0,1), -3, -1, "Color", 8],
// ["-2", new Date(2008,0,1), -2, -1.35, "Color", 20],
// ["-1", new Date(2008,0,1), -1, 0.375, "Color", 16],
// ["0", new Date(2008,0,1), 0, 1.06, "Color", 50],
// ["1", new Date(2008,0,1), 1, 1.0232558139534886, "Color", 43],
// ["2", new Date(2008,0,1), 2, 0.4074074074074074, "Color", 81],
// ["3", new Date(2008,0,1), 3, 0.833333333333333, "Color", 96],
// ["4", new Date(2008,0,1), 4, 1.7833333333333337, "Color", 60],
// ["5", new Date(2008,0,1), 5, 2.041666666666667, "Color", 24],
// ["-5", new Date(2008,3,1), -5, -0.14285714285714285, "Color", 7],
// ["-4", new Date(2008,3,1), -4, -1.7333333333333334, "Color", 15],
// ["-3", new Date(2008,3,1), -3, 1.6071428571428577, "Color", 28],
// ["-2", new Date(2008,3,1), -2, -1.3, "Color", 30],
// ["-1", new Date(2008,3,1), -1, -0.28, "Color", 25],
// ["0", new Date(2008,3,1), 0, -0.5714285714285713, "Color", 42],
// ["1", new Date(2008,3,1), 1, 0.23999999999999996, "Color", 50],
// ["2", new Date(2008,3,1), 2, 0.48648648648648635, "Color", 111],
// ["3", new Date(2008,3,1), 3, 1.3495934959349591, "Color", 123],
// ["4", new Date(2008,3,1), 4, 1.6790123456790123, "Color", 81],
// ["5", new Date(2008,3,1), 5, 2.2592592592592595, "Color", 27],
// ["-5", new Date(2008,6,1), -5, -2.933333333333333, "Color", 15],
// ["-4", new Date(2008,6,1), -4, -2.8421052631578947, "Color", 19],
// ["-3", new Date(2008,6,1), -3, -1.6730769230769231, "Color", 52],
// ["-2", new Date(2008,6,1), -2, -1.2500000000000002, "Color", 44],
// ["-1", new Date(2008,6,1), -1, -1.2424242424242424, "Color", 33],
// ["0", new Date(2008,6,1), 0, -0.3846153846153846, "Color", 65],
// ["1", new Date(2008,6,1), 1, 0.3333333333333333, "Color", 57],
// ["2", new Date(2008,6,1), 2, 0.5327102803738317, "Color", 107],
// ["3", new Date(2008,6,1), 3, 0.9574468085106383, "Color", 141],
// ["4", new Date(2008,6,1), 4, 1.2954545454545452, "Color", 88],
// ["5", new Date(2008,6,1), 5, 1.9130434782608698, "Color", 23]