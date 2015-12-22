$(document).on("page:change", (function(){
     $('#tearsheet-form').children().change(set_tearsheet_link);
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
        
       var tearSheetForm = document.getElementById('tearsheet-form');
       var product_base_number = tearSheetForm.elements["product_base_number"].value;
       var product_id = tearSheetForm.elements["product_id"].value;
       var material_identifier = tearSheetForm.elements["tearsheet[material_identifier]"].value;
       var finish_identifier = tearSheetForm.elements["tearsheet[finish_identifier]"].value;
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

     $('#product_finishes_list').find('li').click(function(e){
       var finish_identifier = $(e.target).data().finish_identifier
       var finish_config = {finish: finish_identifier}
       $.extend(configurationObject, finish_config);
       $('#product_finishes_list').find('li').removeClass('highlight');
       $(e.target).addClass('highlight');
       console.log("configObj: " + JSON.stringify(configurationObject));
     });

     $('#product_materials_list').find('li').click(function(e){
       var material_identifier = $(e.target).data().material_identifier
       var material_config = {material: material_identifier}
       $.extend(configurationObject, material_config);
       $('#product_materials_list').find('li').removeClass('highlight');
       $(e.target).addClass('highlight');
       console.log("configObj: " + JSON.stringify(configurationObject));
     });
}))
