



//$(document).ready(function(){
var checked = []
var sidebarCat = function(cat){


}
$('input[type="checkbox"]').click(function(){
  checkboxer(this);

});

function checkboxer (box)
{
  //do check box array stuff here
  //then call the dom show/hide function here
  if($(box).prop("checked") == true)
  {
    checked.push(this.id);
              //console.log(this.id+ " is checked");
              
  }
  else if($(this).prop("checked") == false)
  {
    checked.splice((checked.indexOf(this.id)),1);
    //console.log(this.id+" is unchecked.");


    // *** to do this in a way that works in ie 8 use the below ****
    //                function remove(arr, item) {
    //     for(var i = arr.length; i--;) {
    //         if(arr[i] === item) {
    //             arr.splice(i, 1);
    //         }
    //     }
    // }
  }

  filterDom();
  
};
function filterDom(){


  if (checked.length > 0)
  {
    $(document.getElementsByClassName("prod_tile")).each(function(i)
    {
      this.style.display='none';
    });

    $(checked).each(function(ind)
    {
      console.log(checked[ind] + " LOOKLOOKATME ");

      var checkfilt = checked[ind];

      $(jsonproducts.product_groups).each(function(index)
      {
        var domProd = document.getElementById(this.id);

        for (var i = 0; i < this.get_filter_values.length; i++) 
        {
          //console.log("here"+this)

          if (this.get_filter_values[i].name == checkfilt)
          {
            domProd.style.display = 'block';
          }
        };

      });
    });
  } else 
  {
    $(jsonproducts.product_groups).each(function(index)
    {
      var domProd = document.getElementById(this.id);
      domProd.style.display = 'block';

    });
  }
  
  console.log("checked arr:"+ checked);  
  // });

}




//});





