

  function formCollect() {
    var multiple = document.getElementById('multField').value;

    var pageString = '<table>';
    
    for (var j =0; j <=4; j++){
      pageString += '<tr>';
      for (var i =1; i <= 4; i++) {
        pageString += '<td>' + multiple*(i+4*j) + '</td>';
      }
      pageString += '</tr>';
    }

    pageString += '</tr></table>';

    pageString += '<br>Enter Multiple: <input type=\'text\' id=\'multField\' value=' + multiple + 
    '><br><button onclick=\'formCollect()\'>Display Multiples</button>';

    document.body.innerHTML = pageString;
  }


// This would work with a prompt. The above works with the form.

// (function(){

//   var multiple = prompt('Enter a number');

//   var pageString = '<table><tr>';

//   for (var i = 1; i <= 4; i++) {
//     pageString = pageString + '<td>' + multiple*i + '</td>'; 
//   }

//   pageString = pageString + '</tr></table>';

//   document.body.innerHTML = pageString;


// })();


