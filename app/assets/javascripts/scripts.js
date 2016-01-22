$(document).on("page:change", (function(){
    
     switch ($('body').attr('class')){
      case 'products show':
        var tearSheetForm = document.getElementById('tearsheet-form');
        var product_base_number = tearSheetForm.elements["product_base_number"].value;
        var product_id = tearSheetForm.elements["product_id"].value;
        var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
        var finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;
        set_tearsheet_link();

        var image = $('.product_image')[0].dataset.url;
        var matchr = image.match(/\/[^\/]+.jpg/);

        $('#product_finishes_list').find('li').click(function(e){
          var trg = $(e.target);
          swatch_tile_actions(trg,'#product_finishes_list');
        });
        $('#product_materials_list').find('li').click(function(e){
          var trg = $(e.target);
        swatch_tile_actions(trg,'#product_materials_list');
        });

        nav_back();

        //select the featured image from the alt's
        $('.alt_img').each(function(i,t){
          if(t.dataset.url.indexOf(matchr) > -1){
            console.log('MAATCH');
            $(t).addClass('alt_choice');
          }
        });
        
        $('.finish_tile').each(function(i,t){
         
          if ($($(t).parents()[1]).hasClass('finishes')){
             ident = t.dataset.finish_identifier;
          }else{
             ident = t.dataset.material_identifier;
          }
           
          if (image.includes('-'+ ident )){
            console.log(t);
            $(t).addClass('highlight');

          }

        }); 



        // *switch out product feat. img.*
        $('.alt_img').click(function(){
          var thiz = this;
           var new_img = thiz.dataset.url;
          swap_product_image(new_img);
          $(thiz).addClass('alt_choice');

          $('.finish_tile').each(function(i,t){
            // console.log(t.dataset.material_identifier)
            var mat = t.dataset.material_identifier;
            var fin = t.dataset.finish_identifier;
            if (thiz.dataset.url.includes('-'+mat+'-') || thiz.dataset.url.includes('-'+fin)){
              console.log(mat);
              $(t).trigger('click');
              console.log(t);
            }

          }); 

          
        });
        $('.materials .finish_tile').click(function(f){
            var mat = this.dataset.material_identifier;
          $('.alt_img').each(function(i,t){
             if (t.dataset.url.includes('-'+mat)){
              swap_product_image(t.dataset.url);
              $(t).addClass('alt_choice');

             }
            // fin = $('.finishes .highlight')[0].dataset.finish_identifier
          });
        });

        break;
      case 'styles show':
          filter_types();
        break; 
      case 'static_pages home':
          // $('.side-nav-contain').css('display','none');

        break;
      default:
        var tearSheetForm = 'not form';
      break;


     }
      
     

   function swap_product_image(url){
    $('.product_image').css('background-image','url('+ url +')');
    $('.alt_img').removeClass('alt_choice');

   }

   function nav_back(){
          $('.prod-cat a').click(function(){
            // *make side nav links go back to cat pg*
            var thiis = $(this);
            var type_id = thiis[0].id
            // window.history.pushState(type_id, null,"/product_types");

            //history state is a wormhole
            // window.history.replaceState(type_id, null,"product_types/"+type_id);               
            var href = $(thiis[0]).html();
            var panel = '#' + href.replace(' ','_') + "1";
            $(panel).collapse('toggle');
                  
          });
        }



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

     function swatch_tile_actions(targ, listId){
       
           var URLparts = window.location.pathname.split('/');
           var product_id = URLparts[URLparts.length - 1];
           var product_object = { product_id: product_id };

           if ($(targ).data().material_identifier === undefined){
            var identifier = $(targ).data().finish_identifier;
            var choice_id = "#finish_choice";
            var config = {finish: finish_identifier};
           }else{
            var identifier = $(targ).data().material_identifier;
            var choice_id = "#material_choice";
            var config = {material: material_identifier};
           }

           $.extend(configurationObject, config);
           $.extend(configurationObject, product_object);
           $(listId).find('li').removeClass('highlight');
           $(targ).addClass('highlight');
           //console.log("configObj: " + JSON.stringify(configurationObject));
          //* set the choice box values ****
           $(choice_id).html(identifier);
           
           var bg = targ.css("background-image");
           $(choice_id).css("background-image", bg);
           $(choice_id).css("background-size", 'contain');

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
        // });
      }
      

  function filter_types(){
    //filter on collections browse page
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
