$(document).on("page:change", (function(){

  
        $(window).scroll(function(){
//box one
    var $win = $(window);
  
    $('.navvy').css('left', 20 -$win.scrollLeft());
});    
 
    
     switch ($('body').attr('class')){
    //PRODUCT SHOW page JS  
    case 'products tearsheet':

    prod_config = {
          "finish":" ",
          "material":" ",
          "color":" "

        }
// "http://localhost:3000/products/tearsheet/1030BSN819-CHINADECO-CC-XX"
        tearsheet_config = $(window.location.pathname.split('/')).last()[0]

      
        
        
        $('.finish_tile').each(function(i,t){
          var ident = '';
          var parent_div = ''
          if ($($(t).parents()[1]).hasClass('finishes')){
             ident = t.dataset.finish_identifier;
             parent_div = '#product_finishes_list';
          }else if ($($(t).parents()[1]).hasClass('materials')){
              ident = t.dataset.material_identifier;
              parent_div = '#product_materials_list';
          }else if ($($(t).parents()[1]).hasClass('china_colors')){
              ident = t.dataset.material_identifier;
              parent_div = '#product_china_list';
          }else{
          }
           
          if (tearsheet_config.includes('-'+ ident ) && parent_div == '#product_china_list' ){
             $(t).addClass('highlight');

          }else if (tearsheet_config.includes('-'+ ident ) && parent_div != '#product_china_list' ){
            var $t = $(t);
            var pr = $(parent_div);
            swatch_tile_actions($t, pr); 
          }
        }); 

         //set the current configuration
         conff = $('.alt_choice')[0]
         if (conff){
            swap_product_info_for_configuration(conff);
          }


    break



    case 'products show':
      $('#row_content').removeClass('row_content_min');
      $('#center_main').removeClass('center_min_width');
      $('#center_main').addClass('center_min_show');

      var configurationObject = {};
        var tearSheetForm = document.getElementById('tearsheet-form');
        var product_base_number = tearSheetForm.elements["product_base_number"].value;
        var product_id = tearSheetForm.elements["product_id"].value;
        var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
        var finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;


        // !!!!!!!!!!!!!!!!!!!!!
        set_tearsheet_link();
        // !!!!!!!!!!!!!!!!!!!!!
       


        $('#product_finishes_list').find('li').click(function(e){
          var trg = $(e.target);
          swatch_tile_actions(trg,'#product_finishes_list');
        });
        $('#product_materials_list').find('li').click(function(e){
          var trg = $(e.target);
        swatch_tile_actions(trg,'#product_materials_list');
        });
        $('#product_china_list').find('li').click(function(e){
          $('#product_china_list').find('li').removeClass('highlight');
          var trg = $(e.target);
         $(trg).addClass('highlight');
        });
        

        nav_back();

         prod_config = {
          "finish":" ",
          "material":" ",
          "color":" "

        }

        //select the featured image from the alt's on load
      
        var image = $('.product_image')[0].dataset.url;
        var matchr = image.match(/\/[^\/]+.jpg/);

        $('.alt_img').each(function(i,t){
          if(t.dataset.url.indexOf(matchr) > -1){
            
            $(t).addClass('alt_choice');
            return false;
          }
        });
        
        $('.finish_tile').each(function(i,t){
          var ident = '';
          var parent_div = ''
          if ($($(t).parents()[1]).hasClass('finishes')){
             ident = t.dataset.finish_identifier;
             parent_div = '#product_finishes_list';
          }else if ($($(t).parents()[1]).hasClass('materials')){
              ident = t.dataset.material_identifier;
              parent_div = '#product_materials_list';
          }else if ($($(t).parents()[1]).hasClass('china_colors')){
              ident = t.dataset.material_identifier;
              parent_div = '#product_china_list';
          }else{
          }
           
          if (image.includes('-'+ ident ) && parent_div == '#product_china_list' ){
             $(t).addClass('highlight');

          }else if (image.includes('-'+ ident ) && parent_div != '#product_china_list' ){
            var $t = $(t);
            var pr = $(parent_div);
            swatch_tile_actions($t, pr);
              if  (parent_div == '#product_finishes_list'){
                prod_config.finish = ident;
              }else if  (parent_div == '#product_materials_list'){
                prod_config.material = ident;
              }
          }
        }); 

         //set the current configuration
         var conff = $('.alt_choice')[0]
         if (conff){
            swap_product_info_for_configuration(conff);
          }

       


        // *switch out product feat. img.*
        $('.alt_img').click(function(){
          var thiz = this;
           var new_img = thiz.dataset.url;
           var new_config = thiz;
          swap_product_image(new_img);
          swap_product_info_for_configuration(new_config);
          $(thiz).addClass('alt_choice');
          //SWAP OUT PRODUCT INFO W INFO FROM DATASET//




          $('.finish_tile').each(function(i,t){
            // console.log(t.dataset.material_identifier)
            var mat = t.dataset.material_identifier;
            var fin = t.dataset.finish_identifier;
            if (thiz.dataset.url.includes('-'+mat+'-') || thiz.dataset.url.includes('-'+fin)){
      //TODO refactor for all possible finishes ******
              
              $(t).trigger('click');
              // console.log(t);
            }

          }); 

          
  

          
        });


     
        
      
        tearsheet_targ = $('.tear-sheet-submit').attr('href');
        

        var material_code_regex = /(SEMI|SLSL|ONYX|HANDPAINTED|CHINADECO|GLAZE)/
       
        var tearsheet_targ2 = tearsheet_targ.replace(material_code_regex, prod_config.material);

         tearsheet_targ3 = tearsheet_targ2.replace("XX", prod_config.finish);
        $('.tear-sheet-submit').attr('href',tearsheet_targ3);
     




        $('.materials .finish_tile').click(function(f){
          //set the corrosponding finish
             var mat = this.dataset.material_identifier;
            console.log(mat);

            the_tear_targ = tearsheet_targ.replace('XX', prod_config.finish);

             finish_sheet_targ = the_tear_targ.replace(material_code_regex, mat);
            $('.tear-sheet-submit').attr('href',finish_sheet_targ);

            prod_config.material=mat;

          $('.alt_img').each(function(i,t){
             if (t.dataset.url.includes('-'+mat)){
              
              swap_product_image(t.dataset.url);
              swap_product_info_for_configuration(t);
              $(t).addClass('alt_choice');

             }else{
                if (i == $('.alt_img').length-1 ){
                  console.log('no material matches');
                  //do the swap B and W image here*
                }
             }
            // fin = $('.finishes .highlight')[0].dataset.finish_identifier
          });
        });

        $('.finishes .finish_tile').click(function(f){
          //set the corrosponding material
            if($('.materials .highlight')>0){
              var otherswatch = $('.materials .highlight')[0].dataset.material_identifier ;
              }

            
            var mat = this.dataset.finish_identifier;
            console.log(mat);

            var the_tear_targ = tearsheet_targ.replace(material_code_regex, prod_config.material);

             var mat_sheet_targ = the_tear_targ.replace("XX", mat);
            $('.tear-sheet-submit').attr('href',mat_sheet_targ);
            prod_config.finish = mat;


            // product_data[finish_identifier] = mat;
            var foundit = 0;
          $('.alt_img').each(function(i,t){
             if (t.dataset.url.includes('-'+mat)){  
              //To do -- if  there are multiple finishes, need to check for double match before showing the single match.. so use commented code...
              //check if material is right then:
                if (t.dataset.url.includes(otherswatch)){


              
                  swap_product_image(t.dataset.url);
                  swap_product_info_for_configuration(t);
                  $(t).addClass('alt_choice');
                  foundit = 1;

                // }else if(i == $('.alt_img').length-1 ) {
                //   $('.alt_img').each(function(i,t){
                //     if (t.dataset.url.includes('-'+mat)){  

                //       swap_product_image(t.dataset.url);
                //       swap_product_info_for_configuration(t);
                //       $(t).addClass('alt_choice');
                //     }
                //   });
                }else{
                  if (i == $('.alt_img').length-1 ){
                    console.log('no material+ finish matches');
                    //do the swap B and W image here*
                  }
                }

            }
             
            // fin = $('.finishes .highlight')[0].dataset.finish_identifier
          }, doublecheck());
          function doublecheck(){
            
            if (foundit ==0){
              if($('.alt_img.alt_choice')[0].dataset.url.includes('-'+mat)){

              }else{
                $('.alt_img').each(function(i,t){
                  if (t.dataset.url.includes('-'+mat)){  
                    swap_product_image(t.dataset.url);
                    swap_product_info_for_configuration(t);
                    $(t).addClass('alt_choice');
                    foundit = 1;

                  }else{
                    if (i == $('.alt_img').length-1 ){
                      console.log('no finish matches');
                      //do the swap B and W image here*
                    }
                  }
                });
                if(foundit == 0){
                  // console.log("zero match");
                  // console.log(otherswatch);
                  //to do
                  // if the selection does not include otherswatch:
                  //look for one that does and show that
                  //if there isn't one, show BW

                }
              }

            }
          }
        });  

        
        $('ul#components_list li').slice(2).hide();
        $('#see_all').show();
        
        
        $('#hide_all').hide();
        // var reset_list = false;
        $('#see_all').click(function(){
          
            $('#see_all').hide();
            $('ul#components_list li').slice(2).show();
            $('#hide_all').show();
            $('ul#components_list').addClass('expandComp');
          }
        );
        var linkout = false;
        $('ul#components_list li').on('click',function(e){

          $('ul#components_list li').slice(2).hide()
          
          $('#hide_all').hide();
          $('#see_all').show();
          $('ul#components_list').removeClass('expandComp');
          return

              
            })
        $('#hide_all').click(function(){
          
            $('#hide_all').hide();
            $('ul#components_list li').slice(2).hide();
            $('#see_all').show();
            $('ul#components_list').removeClass('expandComp');
            
          }
        );
        

        break;

      //end of product show page JS
      case 'styles index':  
      
      
        break;

      case 'styles show':
        filter_types2()
        $('#row_content').removeClass('row_content_min');
        $('#center_main').removeClass('center_min_width');
        var col_name=$('a#col_name');

        col_name.click(function(e){
          e.preventDefault();
          ($('li div.checkbox').find('input:checked').removeAttr('checked'));
          do_checkbox_filters();
           

        })
        break; 
      case 'static_pages home':
          $('#l_nav').remove();
          
        break;
      case 'static_pages showrooms': 
      
       set_map();

        break;
      case 'static_pages contact':

          set_map();

        break;



      default:
        var tearSheetForm = 'not form';
      break;


     }
      
  function swap_product_info_for_configuration(li){
    var config = li.dataset.number;
    $('.prod-config-number').html(li.dataset.number);
    $('.prod-config-description #description').html(li.dataset.description);
    show_only_config_components(config);
    $('#see_all').hide();
    $('#hide_all').show();
  }
  function show_only_config_components(config){
    var comp = $('#components_list').find('li');
    comp.hide();
    
    $.each(comp, function(i, c){
      
      if (c.dataset.configurations.indexOf(config) >= 0){
        $(c).show();
      }

    });
   
  }

   function swap_product_image(url){
    $('.product_image').css('background-image','url('+ url +')');
    $('.alt_img').removeClass('alt_choice');
    $('ul#components_list').addClass('expandComp');

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
        product_id = tearSheetForm.elements["product_id"].value;

       var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
      var finish_identifier = "checkthis";
       var china_color_identifier = tearSheetForm.elements["tearsheet[china_color_identifier]"].value;
           var product_data = { "product_base_number" : product_base_number,
           "material_identifier" : material_identifier,
           "finish_identifier" : finish_identifier,
           "china_color_identifier" : china_color_identifier
         }
      var root_url = window.location.origin
      // var material_code_regex = /(SEMI|SLSL|ONYX|HANDPAINTED|CHINADECO|GLAZE)/
       var tearsheet_number = product_base_number
       // .replace("XX", finish_identifier);
       // tearsheet_number = tearsheet_number.replace("CC", china_color_identifier);
       // tearsheet_number = tearsheet_number.replace(material_code_regex, material_identifier);
       console.log(product_id);



      var url = root_url + "/products/tearsheet/" + 
        product_id+ "/" +
        tearsheet_number
        

      return url;
     }

     function set_tearsheet_link(){
       var $tearsheetTag = $(".tear-sheet-submit");
       var url = generate_tearsheet_link();

       $tearsheetTag.attr("href", url);
     }

     

     function setProductInfoWithConfiguration(config){

       if (typeof config != "undefined") {
           // $('.prod-config-number').html(config.number);
           // $('.prod-config-description #description').html(config.description);
           // $('.product_image').attr('src', 'images/medium/' + config.image_file_name);
       }
     }



     function swatch_tile_actions(targ, listId){
       var r = targ;
       var l = listId;
           var URLparts = window.location.pathname.split('/');
           var product_id = URLparts[URLparts.length - 1];
           var product_object = { product_id: product_id };

           if ($(targ).data().material_identifier === undefined){
            var identifier = $(targ).data().finish_identifier;
            var choice_id = "#finish_choice";
            var config = {finish: identifier};
           }else{
            var identifier = $(targ).data().material_identifier;
            var choice_id = "#material_choice";
            var config = {material: identifier};
           }

           $.extend(configurationObject, config);
           $.extend(configurationObject, product_object);


           $(listId).find('li').removeClass('highlight');
           $(targ).addClass('highlight');
           //console.log("configObj: " + JSON.stringify(configurationObject));
          //* set the choice box values ****
          var identifier_name= $('[data-identifier="'+identifier+'"]')[0].children[0].innerHTML.trim()

           $(choice_id).html('<div class="m_name">'+identifier_name+'</div>');
           
           var bg = $(targ).css("background-image");
           $(choice_id).css("background-image", bg);
           $(choice_id).css("background-size", 'cover');
           $(choice_id).attr("title", identifier);
           var ct1 = configurationObject;
          
            
        
      }
      
    function filter_types2(){
    //filter on collections browse page
    $('div.checkbox').click(function(){
      do_checkbox_filters();
      $(this).find('input').blur();
      
    });
  }
  
}));

function do_checkbox_filters(){
  check_cat = []
    var cat = $('div.checkbox').find('input:checked').map(function(i, val){
      check_cat.push(val.id);      
    });
    
    if (check_cat.length >= 1){
      
      $('.prod_tile4').each(function(key, tile){
        if ($.inArray(tile.dataset.category, check_cat) == -1){  

          $(tile).hide();
          $('.grid').masonry({
            // options
            itemSelector: '.prod_tile4',
            columnWidth: 70
          });
       

        } else {
          $(tile).show();
          $('.grid').masonry({
            // options
            itemSelector: '.prod_tile4',
            columnWidth: 70
          });
        }
      });
    } else{
      $('.prod_tile4').show();
      $('.grid').masonry({
        // options
        itemSelector: '.prod_tile4',
        columnWidth: 70
      });
    }
}

function set_map(){
      var SW = {lat:40.762257 ,lng: -73.963006};
      var mapOptions = {
        center: SW,
        zoom: 17,
        mapTypeId: google.maps.MapTypeId.ROADMAP
      };
      var mapDiv = document.getElementById('map-canvas');
      var map = new google.maps.Map(document.getElementById("map-canvas"),
      mapOptions);
      var marker = new google.maps.Marker({
            position: SW,
            map: map,
            title: "Sherle Wagner"
            
          });

     marker.addListener('click', function() {
      window.open('https://www.google.com/maps/place/Sherle+Wagner+International/@40.7621881,-73.9650126,17z/data=!3m1!4b1!4m2!3m1!1s0x89c258e881faea7d:0xbc2c6a685eed277?hl=en','_blank');
      });

      
    }