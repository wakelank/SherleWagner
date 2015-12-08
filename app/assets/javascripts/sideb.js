
//this is JS to manage that sticky sidebar


$(function(){

  productCategory();
  subTypePanel();
  hideNeighbors('#accordion2');
  attach_filters_to_checkboxes();
 

});


function productCategory() {
  $( ".prod-cat" ).click(function()
  {
    var anchor = this;
    var link = $(anchor).attr('href');
    var text = $(anchor).text().toLowerCase();
    console.log(text);
    console.log("clicked product-type");

  });
}

//make sure sidenav subtype links open their dropdowns when clicked
function subTypePanel(){
  $('div.panel-title label').click(function()
  { 
    var href = $(this).attr('href');
    // console.log($href);
    //var id ="'" + href + "'";
    var $trgt = $(href);
    // $trgt.addClass('in');
    $trgt.collapse('toggle');

    var neighbors = $()


    

  });
}

//Make sure sidenav subtype links close their neighbors
// ** it accepts the css id in 'quotes' of the panel to target 
function hideNeighbors(panel){
  var $trgt = $(panel);
   $trgt.on('show.bs.collapse', function () {
      selectr = panel+" .in";
      $(selectr).collapse('hide');

    });


   // $('#accordion2').on('show.bs.collapse', function () 
   //  {
   //    console.log("SHOWBS COLL?")
   //    $('#accordion2 .in').collapse('hide')

   //  });
}

function attach_filters_to_checkboxes(){
  $('.filter').click(filter_products);
}

function filter_products(){
  var filterArr = $('input:checked').map(function(i, val, arr){
    return (val.id.toLowerCase());
  });
  $product_tiles = $('.prod_tile');

  $product_tiles.filter(function(index, $element, array){
    var element_filters = $element.dataset.filtervalues.split(' ');
    return (containsAll(filterArr, element_filters) == false);
    }).hide();

  $product_tiles.filter(function(index, $element, array){
    var element_filters = $element.dataset.filtervalues.split(' ');
    return (containsAll(filterArr, element_filters) == true);
    }).show();
}

function containsAll(needles, haystack){
  for(i = 0, len = needles.length; i < len; ++i){
    if($.inArray(needles[i], haystack) == -1) return false;
  }
  return true;
}




//OLD CRAP FOR REFERENCE
// var checked = []
// var sidebarCat = function(cat){


// }
// $('input[type="checkbox"]').click(function(){
//   checkboxer(this);

// });

// function checkboxer (box)
// {
//   //do check box array stuff here
//   //then call the dom show/hide function here
//   if($(box).prop("checked") == true)
//   {
//     checked.push(this.id);
//               //console.log(this.id+ " is checked");
              
//   }
//   else if($(this).prop("checked") == false)
//   {
//     checked.splice((checked.indexOf(this.id)),1);
//     //console.log(this.id+" is unchecked.");


//     // *** to do this in a way that works in ie 8 use the below ****
//     //                function remove(arr, item) {
//     //     for(var i = arr.length; i--;) {
//     //         if(arr[i] === item) {
//     //             arr.splice(i, 1);
//     //         }
//     //     }
//     // }
//   }

//   filterDom();

// };
// function filterDom(){

// //looked at the array of checked filter 
//   if (checked.length > 0)
//   {
//     $(document.getElementsByClassName("prod_tile")).each(function(i)
//     {
//       this.style.display='none';
//     });

//     $(checked).each(function(ind)
//     {
//       console.log(checked[ind] + " LOOKLOOKATME ");

//       var checkfilt = checked[ind];

//       $(jsonproducts.product_groups).each(function(index)
//       {
//         var domProd = document.getElementById(this.id);

//         for (var i = 0; i < this.get_filter_values.length; i++) 
//         {
//           //console.log("here"+this)

//           if (this.get_filter_values[i].name == checkfilt)
//           {
//             domProd.style.display = 'block';
//           }
//         };

//       });
//     });
//   } else 
//   {
//     $(jsonproducts.product_groups).each(function(index)
//     {
//       var domProd = document.getElementById(this.id);
//       domProd.style.display = 'block';

//     });
//   }
  
//   console.log("checked arr:"+ checked);  
//   // });

//}




//});





