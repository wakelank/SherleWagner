$(document).on("page:change", (function(){

  
        $(window).scroll(function(){
//box one
    var $win = $(window);
  
    $('.navvy').css('left', 20 -$win.scrollLeft());
});    
 
    
     switch ($('body').attr('class')){
    //PRODUCT SHOW page JS  
    case 'products tearsheet':

    var prod_config = {
          "finish":" ",
          "material":" ",
          "color":" "

        }
    
        tearsheet_config = $(window.location.pathname.split('/')).last()[0];

        //run through every swatch and choose the selected ones via regex
        $('.finish_tile').each(function(i,t){
          var ident = '';
          var parent_div = '';
          var parent_targ = $($(t).parents()[1]);
          // determine the parent of t (mat fin or chin)
          if (parent_targ.hasClass('finishes')){
             ident = t.dataset.finish_identifier;
             parent_div = '#product_finishes_list';             
          }else if (parent_targ.hasClass('materials')){
              ident = t.dataset.material_identifier;
              parent_div = '#product_materials_list';
          }else if (parent_targ.hasClass('china_colors')){
              ident = t.dataset.china_identifier;
              parent_div = '#product_china_list';
          }else{
          }
          // the regex part matching ident to config and dealing with china color or real swatch
          var rgxp = new RegExp('-'+ident+'(\\b|-)');

          if (tearsheet_config.match(rgxp) && parent_div == '#product_china_list' ){
             $(t).addClass('highlight');

          }else if (tearsheet_config.match(rgxp) && parent_div != '#product_china_list' ){

            var $t = $(t);
            var pr = $(parent_div);
            swatch_tile_actions($t, pr); 
          }
        }); 
         
         //set the current configuration if components are there
        if ($('#components_list li').length > 1){
          confi = tearsheet_config.split('-');
          confi = confi.splice(0, confi.length-1);
          confi = confi.join('-');
          
          if (confi){
             show_only_config_components(confi);
           }
        }

    break


    case 'products show':
    //deal with the layout,sections etc
      $('#row_content').removeClass('row_content_min');
      $('#center_main').removeClass('center_min_width');
      $('#center_main').addClass('center_min_show');

    //set the product name
      var product_name = $('h3#prod_name').html();
      
      // make a configuration obj to pass to tearsheet
      var configurationObject = {};

      //set up the tearsheet form object
      var tearSheetForm = document.getElementById('tearsheet-form');
      // console.log(tearSheetForm);

       var product_base_number = tearSheetForm.elements["product_base_number"].value;
      var product_id = tearSheetForm.elements["product_id"].value;
      var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
      var finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;


      //do swatch tile actions funciton on the tiles when they'r clicked (does that set up the config/tearsheet form?)
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
      
      //do a function to .. set up the back button? history state?
      nav_back();

      //create a configuration object that is unrelated to the first
       prod_config = {
        "finish":" ",
        "material":" ",
        "color":" "

      }

      //select the featured image from the alt's (on load)..->
      
      // grab the url from the actual image
      var image = $('.product_image')[0].dataset.url;
      // get a b_w url in dataset and a 'number'
       var bw_image = $('.product_image')[0].dataset.bw;
       var img_number = $('.product_image')[0].dataset.number;

       //make an array by splitting the prod nmbr of the image at each '-' 
       var img_num_array = img_number.split('-');
       //use a regex to define the prod nmbr from the current image's url (with a leading '/' included..)
      var matchr = image.match(/\/[^\/]+.jpg/);
      

      // if there's alt imgs 
      if ($('.alt_img').length > 0){
        //look at them all and find the one the includes the curr imgs url (matchr), add the altchoice class to it
        $('.alt_img').each(function(i,t){
          $(t).removeClass('alt_choice');
          if(t.dataset.url.indexOf(matchr) > -1){
            
            $(t).addClass('alt_choice');

            return false;
          }
        });
      };

      //THEN define a series of loops.

      SETS: for (var i = 0; i < $('.detail_list').length; i++) {
        var $tiles = $($('.detail_list')[i]).find('.finish_tile');
        
          // $('.swatches').each(function(i,t){

        TILES: for (var p = 0; p < $tiles.length; p++) {
          var t = $tiles[p];
          
          var ident = '';
          var parent_div = ''
          if ($($(t).parents()[1]).hasClass('finishes')){
             ident = t.dataset.finish_identifier;
             parent_div = '#product_finishes_list';
          }else if ($($(t).parents()[1]).hasClass('materials')){
              ident = t.dataset.material_identifier;
              parent_div = '#product_materials_list';
          }else if ($($(t).parents()[1]).hasClass('china_colors')){
              ident = t.dataset.china_identifier;
              parent_div = '#product_china_list';
          }else{
          }
          
          var ff = 0;
          if (image.includes(ident ) && parent_div == '#product_china_list' ){
            $('.china_colors .finish_tile').removeClass('highlight');
             $(t).addClass('highlight');
             prod_config.color = ident;

          }
          else if(img_num_array.indexOf(ident) > -1 && parent_div != '#product_china_list' ){
            
            ff ++;
            var $t = $(t);
            var pr = $(parent_div);
            swatch_tile_actions($t, pr);
              if  (parent_div == '#product_finishes_list'){
                prod_config.finish = ident;
              break TILES;  
                
              }else if  (parent_div == '#product_materials_list'){
              prod_config.material = ident;
              break TILES;
              }
              
            }
          else if (image.includes( '-'+ident ) && parent_div != '#product_china_list' ){
            
            var $t = $(t);
            var pr = $(parent_div);
            swatch_tile_actions($t, pr);
              if  (parent_div == '#product_finishes_list'){
                prod_config.finish = ident;
              }
              if  (parent_div == '#product_materials_list'){
                prod_config.material = ident;
              }
          }
          
            
      
          
        }
      } 

       //set the current configuration
       if ($('.alt_choice').length > 0){
           var conff = $('.alt_choice')[0];
          var prod_num_base = conff.dataset.number.split('-')[0];
        }else{
          var prod_num_base = product_base_number;
        }
        
       if (conff){
          swap_product_info_for_configuration(conff);
        }

       
        // !!!!!!!!!!!!!!!!!!!!!
       set_tearsheet_link();
        // !!!!!!!!!!!!!!!!!!!!!
       
        tearsheet_targ = $('.tear-sheet-submit').attr('href');

        

        var material_code_regex = /(SEMI|SLSL|ONYX|HANDPAINTED|CHINADECO|GLAZE|STONE|CHINABANDED|METALDECO|CHINAMETAL)/
        var finish_code_regex = /(-PN|-CP|-ES|-AP|-PE|-BN|-BC|-BS|-HP|-GP|-BG|-SB|-OB|-EP|-AL|-AG|-PB|-FP|-RG)/
        var china_code_regex = /(WH|SD|BLK)/
       
        var tearsheet_targ2 = tearsheet_targ.replace(material_code_regex, prod_config.material);
        tear_nmbr_ar = tearsheet_targ2.split('/')
        tear_nmbr = tear_nmbr_ar[tear_nmbr_ar.length-1];
        tear_nmbr = tear_nmbr.split('-');
        tear_nmbr[0] = prod_num_base;
        tear_nmbr = tear_nmbr.join('-');
        tear_nmbr_ar[tear_nmbr_ar.length-1] = tear_nmbr;
        tearsheet_targ4 = tear_nmbr_ar.join('/');

        //CHECK IF PROD CONFIGS HAVE VALUES BEFORE DOING REPLACE
         var tearsheet_targ3 = tearsheet_targ4.replace("XX", prod_config.finish)
         if (prod_config.color.length > 1){
          
          tearsheet_targ3 = tearsheet_targ3.replace('CC', prod_config.color).replace(china_code_regex, prod_config.color);
          }

        $('.tear-sheet-submit').attr('href',tearsheet_targ3);
        
        // *switch out product feat. img.*
        $('.alt_img').click(function(){
           var thiz = this;
          var new_img = thiz.dataset.url;
           var new_config = thiz;
          swap_product_image(new_img);
          swap_product_info_for_configuration(new_config);
          $(thiz).addClass('alt_choice');
          prodnum_raw = thiz.dataset.number;
           prod_num = thiz.dataset.number.split('-');
          
           prod_num_base = prod_num[0];
           tearsh = $('.tear-sheet-submit').attr('href').split('/');
          
          tearsh[tearsh.length-1] = prod_num.join('-');
          $('.tear-sheet-submit').attr('href', tearsh.join('/'));
          tearsheet_targ1 = $('.tear-sheet-submit').attr('href');
          // tearsh_prod_num = $(tearsh).last()[0].split('-')[0];
          // tearsh_prod_num = tearsh_prod_num.replace(tearsh_prod_num, prod_num_base);


          
          if ($('#components_list li').length > 1){

            set_tearsheet_link();
          }



          
          $('.finish_tile').each(function(i,t){
            
             var mat = t.dataset.material_identifier;
             var fin = t.dataset.finish_identifier;
             var chin = t.dataset.china_identifier;
             var foundn = 0;
            $(prod_num).each(function(i,n){
              if (n == mat || n == fin){
                if ($('#components_list li').length < 1){
                  
                  $(t).trigger('click');

                  
                }else{
                  
                    the_tear_targ = tearsheet_targ1.replace('XX', prod_config.finish).replace(finish_code_regex, "-"+prod_config.finish);
                   if (prod_config.color.length > 1){
                    the_tear_targ=the_tear_targ.replace('CC', prod_config.color).replace(china_code_regex, prod_config.color);
                   }

                 var finish_sheet_targ = the_tear_targ.replace(material_code_regex, mat);

                 

                $('.tear-sheet-submit').attr('href',finish_sheet_targ);
                  if($('ul#components_list').length >= 1){
                    tearsheet_targ = tearsheet_targ1.replace(finish_code_regex, "-XX");
                  }
                }
                foundn = 1;
                return false;
              }

              if (n == chin){
                $('.china_colors .finish_tile').removeClass('highlight');
                $(t).addClass('highlight');
              }
            })// end checking for exact match inside the prod num array (if you have a material with a dash in it, now we search for it in the image name*)
            if (foundn == 0){
              

              if (thiz.dataset.number.includes('-'+t.dataset.material_identifier)){
               
                swatch_tile_actions(t, '#product_materials_list');
              }
            }

          }); 

          
  

          
        });// end alt img.click



        $('.materials .finish_tile').click(function(f){
          //set the corrosponding finish
             var mat = this.dataset.material_identifier;
            

            var the_tear_targ = tearsheet_targ.replace('XX', prod_config.finish);
            if (prod_config.color.length > 1){
              the_tear_targ = the_tear_targ.replace('CC', prod_config.color).replace(china_code_regex, prod_config.color);
            }
             var finish_sheet_targ = the_tear_targ.replace(material_code_regex, mat);
             

            $('.tear-sheet-submit').attr('href',finish_sheet_targ);

              var otherswatch = "/"
            if($('.finishes .highlight').length > 0){
              otherswatch = $('.finishes .highlight')[0].dataset.finish_identifier ;
              }



            prod_config.material=mat;
          if ($('.alt_img').length > 0){
            $('.alt_img').each(function(i,t){
              
               if (t.dataset.url.includes('-'+mat) && t.dataset.url.includes(otherswatch) && t.dataset.number.includes(prod_num_base)){
                
                swap_product_image(t.dataset.url);
                swap_product_info_for_configuration(t);
                $(t).addClass('alt_choice');
                return false;


               }else{
                
                  if (i == $('.alt_img').length - 1 ){
                    
                    swap_product_image(bw_image);
                    swap_product_info_for_no_configuration();
                    //do the swap B and W image here*
                  }
               }
              
              // fin = $('.finishes .highlight')[0].dataset.finish_identifier
            });
          }else{
            
            swap_product_image(bw_image);
            swap_product_info_for_no_configuration();

          }
        });
        
        $('.china_colors .finish_tile').click(function(f){
          var mat = this.dataset.china_identifier;
           

            var the_tear_targ = tearsheet_targ.replace('XX', prod_config.finish)

             var finish_sheet_targ = the_tear_targ.replace("CC", mat).replace(china_code_regex, mat);
             finish_sheet_targ = finish_sheet_targ.replace(material_code_regex, prod_config.material);
            $('.tear-sheet-submit').attr('href',finish_sheet_targ);
               var otherswatch = "/"
               var otherswatch2 = "/"
            if($('.finishes .highlight').length > 0){
              otherswatch = $('.finishes .highlight')[0].dataset.finish_identifier ;
              }
            if($('.materials .highlight').length > 0){
              otherswatch2 = '-' + $('.materials .highlight')[0].dataset.material_identifier ;
              }
            
            prod_config.color=mat;

          if ($('.alt_img').length > 0){
            $('.alt_img').each(function(i,t){
              
               if (t.dataset.url.includes(mat) && t.dataset.url.includes(otherswatch) && t.dataset.url.includes(otherswatch2)  && t.dataset.number.includes(prod_num_base)){
                
                swap_product_image(t.dataset.url);
                swap_product_info_for_configuration(t);
                $(t).addClass('alt_choice');
                return false;


               }else{
                
                  if (i == $('.alt_img').length - 1 ){
                    
                    // swap_product_image(bw_image);
                    // swap_product_info_for_no_configuration();
                    //do the swap B and W image here*
                  }
               }
              
              // fin = $('.finishes .highlight')[0].dataset.finish_identifier
            });
          }else{
            
            swap_product_image(bw_image);
            swap_product_info_for_no_configuration();

          }
        }); 


        $('.finishes .finish_tile').click(function(f){
          //set the corrosponding material
          if(!prodnum_raw){
            if($('.alt_choice')[0]){
              var prodnum_raw = $('.alt_choice')[0].dataset.number;
            }else{
              var prodnum_raw = $('.product_image')[0].dataset.number;
            }
          }
          var otherswatch = "/"
            if($('.materials .highlight').length > 0){
             otherswatch = "-" + $('.materials .highlight')[0].dataset.material_identifier;

              }
            else if($('.china_colors .highlight').length > 0){
             otherswatch = $('.china_colors .highlight')[0].dataset.china_identifier ;
              } 

            
             mat = this.dataset.finish_identifier;
            

             the_tear_targ = tearsheet_targ.replace(material_code_regex, prod_config.material);

              mat_sheet_targ = the_tear_targ.replace("XX", mat);
              mat_sheet_split = mat_sheet_targ.split('-');

              $(mat_sheet_split).each(function(i,t){
                var targ = "-" + t;
                if(targ==finish_code_regex){
                  mat_sheet_split[i] = mat;
                }
              });
              mat_sheet_targ = mat_sheet_split.join('-');
           
            


             if (prod_config.color.length > 1){
              mat_sheet_targ = mat_sheet_targ.replace('CC',prod_config.color).replace(china_code_regex,prod_config.color);
             }
            $('.tear-sheet-submit').attr('href',mat_sheet_targ);
            prod_config.finish = mat;


            // product_data[finish_identifier] = mat;
            var foundit = 0;
          $('.alt_img').each(function(i,t){
             if (t.dataset.url.includes(mat)){
             
             
              //To do -- if  there are multiple finishes, need to check for double match before showing the single match.. so use commented code...
              //check if material is right then:
                if(t.dataset.url.includes(otherswatch) && t.dataset.number.includes(prodnum_raw)){
                  swap_product_image(t.dataset.url);
                  swap_product_info_for_configuration(t);
                  $(t).addClass('alt_choice');
                  foundit = 1;
                  return false;

                }else if (t.dataset.url.includes(otherswatch) && t.dataset.number.includes(prod_num_base)){

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
                }

                else{
                  if (i == $('.alt_img').length-1 ){
                    
                    //do the swap B and W image here*
                  }
                }

            }
             
            // fin = $('.finishes .highlight')[0].dataset.finish_identifier
          }, doublecheck());
          function doublecheck(){
            
            if (foundit ==0 && $('.alt_img').length > 0){
              
                $('.alt_img').each(function(i,t){
                  if (t.dataset.url.includes('-'+mat) && t.dataset.url.includes(otherswatch)){  
                    swap_product_image(t.dataset.url);
                    swap_product_info_for_configuration(t);
                    $(t).addClass('alt_choice');
                    foundit = 1;

                  }else{
                    if (i == $('.alt_img').length-1 ){
                      
                      if ($('#components_list li').length < 1){
                        swap_product_image(bw_image);
                        swap_product_info_for_no_configuration();
                      }
                      

                      //do the swap B and W image here*
                    }
                  }
                });
                
              

            }else{
              //there are no alt imgs*
              
              swap_product_info_for_no_configuration();
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
            var conff = $('.alt_choice')[0];
             if (conff){
                swap_product_info_for_configuration(conff);
              }
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
      case 'showrooms index': 
      
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
    $('h3#prod_name').html(li.dataset.description);
    $('h4#prod_subtitle').html(li.dataset.subtitle);
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
  function swap_product_info_for_no_configuration(){
    var the_code_url= $('.tear-sheet-submit').attr('href').split('/');
    var the_code = $(the_code_url).last()[0];
    $('.prod-config-number').html(the_code);
    var fake_description = "";
    if (prod_config.finish.length>1){
      fake_description += "Finish: " + prod_config.finish;
      if (prod_config.material.length>1){
        fake_description +=", ";
      }
    }
    if (prod_config.material.length>1){
      fake_description += "Option: " + prod_config.material;
    }
    $('.prod-config-description #description').html(fake_description);
    $('h3#prod_name').html(product_name);
    $('h4#prod_subtitle').html('');
    
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
        tearsheet_number = product_base_number
        if($('li.alt_choice').length >= 1){
          if ($('li.alt_choice')[0].dataset.number && $('#components_list li').length > 1){
            
            conf_tear_number= $('li.alt_choice')[0].dataset.number;
            tearsheet_number1= conf_tear_number.split('-');
            tearsheet_number1=tearsheet_number1.splice(0, tearsheet_number1.length-1);
            tearsheet_number = tearsheet_number1.join("-")+"-XX";
          }

        }else {
          if($('li.alt_choice').length < 1 && $('#components_list li').length > 1){
          
            }else{
              
            }
        }
       // .replace("XX", finish_identifier);
       // tearsheet_number = tearsheet_number.replace("CC", china_color_identifier);
       // tearsheet_number = tearsheet_number.replace(material_code_regex, material_identifier);
       
       



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
             var f_name = $(targ).data().finish_identifier;
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
           
          //* set the choice box values ****
           var identifier_name= $('[data-identifier="'+identifier+'"]')[0].dataset.name;

          var bg = $(targ).css("background-image").replace("thumb","medium");
          var nbg = bg.slice(5,-2);

           $(choice_id).html('<img src="'+nbg+'" class="option-img"></img><div class="m_wrap"><div class="m_name">'+identifier_name+'</div></div>');


           
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