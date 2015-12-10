
//this is JS to manage that sticky sidebar


$(document).on('ready page:load', function () { 
  productCategory();
  subTypePanel();
  hideTypeNeighbors('#accordion1');
  hideSubTypeNeighbors('#accordion1'); 
  
  attach_filters_to_checkboxes();
  //uncheck on collapse function****
  uncheckOnCollapse("#Fittings");
  uncheckOnCollapse("#Fixtures");
  uncheckOnCollapse("#Accessories");
  uncheckOnCollapse("#Hardware");
  uncheckOnCollapse("#Lighting");
  uncheckOnCollapse("#Wall_Coverings");

});


function productCategory() {
  $( ".prod-cat" ).click(function()
  {
    var anchor = this;
    
    var link = $(anchor).attr('href');
    var text = $(anchor).text();
    console.log(text);
    console.log("clicked product-type");

    var $trgt = $(link);
    var tag = $trgt.selector;
    // $trgt.addClass('in');
    if ($(tag).find(".in").length > 0)
    { 
      console.log('im open');
  
    }else{
      $trgt.collapse('toggle');
    }
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
function hideTypeNeighbors(panel){
  $( ".prod-cat" ).click(function(){
    var $trgt = $(panel);

      // $trgt.on('show.bs.collapse', function () {
        selectr = panel+" .in";
        
         typearr = ["no_type1","Fittings1","Fixtures1","Accessories1","Hardware1","Lighting1","Wall_Coverings1"];

        if (typearr.indexOf($(selectr).attr('id')) != null ){
          $(selectr).collapse('hide');
           console.log('hiding');

        }


      // });
  });

   // $('#accordion2').on('show.bs.collapse', function () 
   //  {
   //    console.log("SHOWBS COLL?")
   //    $('#accordion2 .in').collapse('hide')

   //  });
}
function hideSubTypeNeighbors(panel){
  $( ".panel-sub-heading label" ).click(function(){
    var $trgt = $(panel);

      // *collapse event option* $trgt.on('show.bs.collapse', function () {
        selectr = panel+" .sub-type-panel .in";
        
        

        
          $(selectr).collapse('hide');
           console.log('hiding');
        


      // });
  });

   
}

function uncheckOnCollapse(prodCat)
{
  $($(prodCat).find('label').attr('href')).on('hidden.bs.collapse', function (e) {
    var trgt = ("#" + $(e.currentTarget.id).selector);//
    console.log(trgt);
    $(trgt).find('input[type=checkbox]:checked').removeAttr('checked');
  });
}

function attach_filters_to_checkboxes(){
  $('.filter').find('input:checkbox').click(filter_products);
}

function filter_products(){
  var filtersArr = [];
  var $filters = $('.filter');
  for(var i = 0, len = $filters.length; i < len; ++i){
    var arr = $($filters[i]).find('input:checked').map(function(i, val){
      return(val.id.toLowerCase());
    })
    filtersArr.push(arr);
  };
  $product_tiles = $('.prod_tile');
  $product_tiles.show();

  for(var i = 0, len = filtersArr.length; i < len; ++i){
    var filterArr = filtersArr[i];
    if (filterArr.length >0){
      $product_tiles.filter(function(index, $element, array){
        var element_filters = $element.dataset.filtervalues.split(' ');
        return (containsAtLeastOne(filterArr, element_filters) == false);
      }).hide();
      $product_tiles = $('.prod_tile:visible');
    }
  }
}

function containsAll(needles, haystack){
  for(var i = 0, len = needles.length; i < len; ++i){
    if($.inArray(needles[i], haystack) == -1) return false;
  }
  return true;
}


function containsAtLeastOne(needles, haystack){
  for(i = 0, len = needles.length; i < len; ++i){
    if($.inArray(needles[i], haystack) != -1) return true;
  }
  return false;
}
