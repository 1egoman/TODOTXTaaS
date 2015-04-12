$.getJSON("sampleData.json",function(response){

  response.forEach(function(item){
    var li = $("<li>").html(item.text).addClass("list-group-item");

    if (item.complete == true){
      var checkbox = $("<input>").attr("type","checkbox");
      $(li).prepend(checkbox);
      $("#incomplete").append(li);
    }
    else{
      var li = $("<li>").html(item.text).addClass("list-group-item");
      var checkbox = $("<input>").attr("type","checkbox").attr("checked","checked");
      $(li).prepend(checkbox);

      $("#completed").append(li);
    }
  });
});


$("#addItem").click( function () {
  $("#incomplete").append("<li>blah</li>");
  //make a varaible with list item html
  //append that variable to incomplete list.
});
