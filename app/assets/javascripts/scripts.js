$(document).on("page:change", (function(){
     //$('#tearsheet-form').children().change(set_tearsheet_link);
    
     // if($('body').attr('class') == 'products show'){
     //   var tearSheetForm = document.getElementById('tearsheet-form');
     //    product_base_number = tearSheetForm.elements["product_base_number"].value;
     //    product_id = tearSheetForm.elements["product_id"].value;
     //    material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
     // finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;
     //  set_tearsheet_link();
     // }
    

     switch ($('body').attr('class')){
      case 'products show':
        var tearSheetForm = document.getElementById('tearsheet-form');
        var product_base_number = tearSheetForm.elements["product_base_number"].value;
        var product_id = tearSheetForm.elements["product_id"].value;
        var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
        var finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;
        set_tearsheet_link();

        $('.prod-cat a').click(function(){
          // *make side nav links go back to cat pg*
          var thiis = $(this);
          var type_id = thiis[0].id
          window.history.pushState(type_id, null,"/product_types");
          //history state is a wormhole
          // window.history.replaceState(type_id, null,"product_types/"+type_id);               
          var href = thiis.find('a').html();
          var panel = '#' + href.replace(' ','_') + "1";
          $(panel).collapse('toggle');
                
        });

        // *switch out product feat. img.*
        $('.alt_img').click(function(){
           thiz = this;
           new_img = thiz.dataset.url;
          swap_product_image(new_img);
          $(thiz).addClass('alt_choice');

          $('#product_materials_list .finish_tile').each(function(i,t){
            // console.log(t.dataset.material_identifier)
            mat = t.dataset.material_identifier
            if (thiz.dataset.url.includes('-'+mat+'-')){
              console.log(mat);
              $(t).trigger('click');
              console.log(t);
            }

          });

          
        });

        break;
      case 'styles show':
          filter_types();
        break;  
      default:
        var tearSheetForm = 'not form';
      break;


     }
      
     

   function swap_product_image(alt_img){
    $('.product_image').css('background-image','url('+ alt_img +')');
    $('.alt_img').removeClass('alt_choice');

   }

//  function submitTearSheet(){
////    e.preventDefault();
//    var tearSheetForm = document.getElementById('tearsheet-form');
//    var product_base_number = tearSheetForm.elements["product_base_number"].value;
//    var material_id = tearSheetForm.elements["tearsheet[material_id]"].value;
//    var finish_id = tearSheetForm.elements["tearsheet[finish_id]"].value;
//    var china_color_id = tearSheetForm.elements["tearsheet[china_color_id]"].value;
//    var product_data = { "product_base_number" : product_base_number,
//                "material_id" : material_id,
//                "finish_id" : finish_id,
//                "china_color_id" : china_color_id
//      }
//     $.ajax({
//            url: '/products/tearsheet.json',
//            type: 'POST',
//            contentType: "application/json",
//            data: JSON.stringify(product_data),
//            error: function(req, err){ console.log("my message" + err); },  
//            success: function(data) {
//              location.href = '/products/tearsheet.html?' + $.param(data);
//            }
//    });
//  }
//
//# $('.tear-sheet-submit').click(function(e){
//       console.log("clicked");
//       e.preventDefault();
//       submitTearSheet();
//     });

     function generate_tearsheet_link(){
       // console.log('generate tear sheet link');
       var tearSheetForm = document.getElementById('tearsheet-form');
       var product_base_number = tearSheetForm.elements["product_base_number"].value;
       var product_id = tearSheetForm.elements["product_id"].value;
       //var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
      // var finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;
       var china_color_identifier = tearSheetForm.elements["tearsheet[china_color_identifier]"].value;
       var product_data = { "product_base_number" : product_base_number,
         "material_identifier" : material_identifier,
         "finish_identifier" : finish_identifier,
         "china_color_identifier" : china_color_identifier
       }
      var root_url = window.location.origin
      var material_code_regex = /(SEMI|SLSL|ONYX|HANDPAINTED|CHINADECO|GLAZE)/
      var tearsheet_number = product_base_number.replace("XX", finish_identifier);
      var tearsheet_number = tearsheet_number.replace("CC", china_color_identifier);
      var tearsheet_number = tearsheet_number.replace(material_code_regex, material_identifier);


      var url = root_url + "/tearsheets/" + 
        product_id +
        "?tearsheet=" + 
        tearsheet_number +
        "&finish_identifier=" +
        finish_identifier;

      return url;
     }

     function set_tearsheet_link(){
       var $tearsheetTag = $(".tear-sheet-submit");
       var url = generate_tearsheet_link();

       $tearsheetTag.attr("href", url);
     }

     var configurationObject = {};

     function setProductInfoWithConfiguration(config){
       if (typeof config != "undefined") {
           $('.prod-config-number').html("shown: " + config.number);
           $('.prod-config-description').html("shown: " + config.description);
           $('.product-image').attr('src', 'images/medium/' + config.image_file_name);
       }
     }

     $('#product_finishes_list').find('li').click(function(e){
       console.log(finish_identifier);
       var URLparts = window.location.pathname.split('/');
       var product_id = URLparts[URLparts.length - 1];
       var product_object = { product_id: product_id }
       console.log($(e.target).data().finish_identifier);
        finish_identifier = $(e.target).data().finish_identifier;
        set_tearsheet_link();

       var finish_config = {finish: finish_identifier}
       $.extend(configurationObject, finish_config);
       $.extend(configurationObject, product_object);
       $('#product_finishes_list').find('li').removeClass('highlight');
       $(e.target).addClass('highlight');
       console.log("configObj: " + JSON.stringify(configurationObject));

       $('#finish_choice').html(finish_identifier);

       $.ajax({
         url: "/product_configurations/show",
         type: 'GET',
         dataType: 'json',
         data: configurationObject,
         success: function(data){
           console.log("success" + JSON.stringify(data));
           setProductInfoWithConfiguration(data.configuration[0])
         },
         error: function(xhr, options, err){
           console.log("ajax error");
         }
       });

     });

     $('#product_materials_list').find('li').click(function(e){
       var URLparts = window.location.pathname.split('/');
       var product_id = URLparts[URLparts.length - 1];
       var product_object = { product_id: product_id }
       var material_identifier = $(e.target).data().material_identifier
       var material_config = {material: material_identifier}
       $.extend(configurationObject, material_config);
       $.extend(configurationObject, product_object);
       $('#product_materials_list').find('li').removeClass('highlight');
       $(e.target).addClass('highlight');
       console.log("configObj: " + JSON.stringify(configurationObject));

      //* set the choice box values ****
       $('#material_choice').html(material_identifier);

       $.ajax({
         url: "/product_configurations/show",
         type: 'GET',
         dataType: 'json',
         data: configurationObject,
         success: function(data){
           console.log("success" + JSON.stringify(data));
           setProductInfoWithConfiguration(data.configuration[0])
         },
         error: function(xhr, options, err){
           console.log("ajax error");
         }
       });
     });
  function filter_types(){
    
    $('.panel-title input').click(function(){
       check_cat = []
      var cat = $('.panel-heading').find('input:checked').map(function(i, val){
        check_cat.push(val.id);      
      });
      
      if (check_cat.length >= 1){
        
        $('.prod_tile').each(function(key, tile){
          if ($.inArray(tile.dataset.category, check_cat) == -1){  
            $(tile).hide();

          } else {
            $(tile).show();
          }
        });
      } else{
        $('.prod_tile').show();
      }
    });
  }
}));
