
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
  
  keepCatOpenOnClick();

   $( ".hide-dropdowns" ).click(function()
   {
    
      if(isSmall == true){
      var yo = $(this);

       // $('.panel-heading:not($(this))').hide()
       var opn = $('.panel').find('.in');
       var pn = opn.parent();
        $('.panel:not(yo)').toggle();
        
        $(opn).show();
        $(pn).show();
        $(yo).parent().show();
        $( ".panel-title" ).click(function()
        {
          $('.panel:not(yo)').show();
        });

      }
      
    });
});

// media query
var isSmall = false;
if (matchMedia) {
  var mq = window.matchMedia("(min-width: 800px)");
  mq.addListener(WidthChange);
  WidthChange(mq);
}

// media query change
function WidthChange(mq) {

  if (mq.matches) {
    // window width is at least 500px
    // console.log ('IIITSSSS BIIIIG')
    isSmall = false;
    $('.hide-dropdowns').hide();
    $('.panel').show();
  } else {
    // window width is less than 500px
    // console.log ('IIITSSSS SMALLL')


    isSmall = true;
    $('.hide-dropdowns').show();
    //DOn't affix a sidenav (it jumps past the mobile menu) - see application JS for on reload etc
    $('.navvy').removeClass('affix');
    $('.navvy').removeClass('affix-top');
    $('.navvy').attr('data-spy','');


    // console.log(isSmall);
    // $('body').addClass('mobile');
  }

}

 


//end media query

function productCategory() {
  $( ".prod-cat" ).click(function()
  {
    var anchor = this;
    
    var link = $(anchor).attr('href');
    var text = $(anchor).text();
    // console.log(text);
    // console.log("clicked product-type");

     $trgt = $(link);
     tag = $trgt.selector;

      $trgt.collapse('toggle');

  });
}

//make sure sidenav subtype links open their dropdowns when clicked
function subTypePanel(){
  $('div.panel-title label').click(function()
  { 
    var href = $(this).attr('href');
    
    var $trgt = $(href);
    
    $trgt.collapse('toggle');

    var neighbors = $()


    

  });
}

//Make sure sidenav subtype links close their neighbors
// ** it accepts the css id in 'quotes' of the panel to target 
function hideTypeNeighbors(panel){
  $( ".prod-cat" ).click(function(){
    var $trgt = $(panel);
        dis = this;
      
        var selectr = panel+" .in";
        
         var typearr = ["no_type1","Fittings1","Fixtures1","Accessories1","Hardware1","Lighting1","Wall_Coverings1"];

        if (typearr.indexOf($(selectr).attr('id')) != null){
          $(selectr).collapse('hide');
           //console.log('hiding');

        }



  });


}
function hideSubTypeNeighbors(panel){
  $( ".panel-sub-heading label" ).click(function(){
    var $trgt = $(panel);

      // *collapse event option* $trgt.on('show.bs.collapse', function () {
        var selectr = panel+" .sub-type-panel .in";

          $(selectr).collapse('hide');
           // console.log('hiding');

  });

   
}

function uncheckOnCollapse(prodCat)
{
  $($(prodCat).find('label').attr('href')).on('hidden.bs.collapse', function (e) {
    var trgt = ("#" + $(e.currentTarget.id).selector);//
    // console.log(trgt);
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
    $($filters[i]).find('input').blur();
    var arr = $($filters[i]).find('input:checked').map(function(i, val){
      var raw_id = (val.id.toLowerCase());
       filter_id = raw_id.split('|')[1]
      return filter_id;
    });
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

function keepCatOpenOnClick(){
  //this is for getting back to prod-type from subtype in side nav w\ out prod type closing
  //this solution changes classes in the collapse target and then reverts them after small delay
  $('.prod-cat a').on('click',function(e){
   
    if($(this).parents('.panel').find('.panel-collapse.in').size() >= 2){
      hh = $(this).parents('.panel');
      v = $(hh).find('h4 label')
      targ = $(this).parents('.panel').children('.panel-collapse');
      old_id = $(targ).attr('id');
      old_classes = $(targ).attr('class');
      $(targ).attr('id', 'umm');
      $(targ).attr('class', '');

      //WOORK?
      setTimeout(function(){
        $(targ).attr('id', old_id);
        $(targ).attr('class', old_classes);
        }, 100
      );


      // console.log('mess w targ');
      
     
        
    }
  });
}

