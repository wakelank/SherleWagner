$(document).on("page:change", (function(){
  function submitTearSheet(){
//    e.preventDefault();
    var tearSheetForm = document.getElementById('tearsheet-form');
    var product_base_number = tearSheetForm.elements["product_base_number"].value;
    var material_id = tearSheetForm.elements["tearsheet[material_id]"].value;
    var finish_id = tearSheetForm.elements["tearsheet[finish_id]"].value;
    var china_color_id = tearSheetForm.elements["tearsheet[china_color_id]"].value;
    var product_data = { "product_base_number" : product_base_number,
                "material_id" : material_id,
                "finish_id" : finish_id,
                "china_color_id" : china_color_id
      }
     $.ajax({
            url: '/products/tearsheet.json',
            type: 'POST',
            contentType: "application/json",
            data: JSON.stringify(product_data),
            error: function(req, err){ console.log("my message" + err); },  
            success: function(data) {
              location.href = '/products/tearsheet.html?' + $.param(data);
            }
    });
  }

//# $('.tear-sheet-submit').click(function(e){
//       console.log("clicked");
//       e.preventDefault();
//       submitTearSheet();
//     });
     function generate_tearsheet_link(){
        
       debugger
       var tearSheetForm = document.getElementById('tearsheet-form');
       var product_base_number = tearSheetForm.elements["product_base_number"].value;
       var material_id = tearSheetForm.elements["tearsheet[material_id]"].value;
       var finish_id = tearSheetForm.elements["tearsheet[finish_id]"].value;
       var china_color_id = tearSheetForm.elements["tearsheet[china_color_id]"].value;
       var product_data = { "product_base_number" : product_base_number,
         "material_id" : material_id,
         "finish_id" : finish_id,
         "china_color_id" : china_color_id
       }
      var root_url = window.location.origin
      var product_id = "3"
      var tearsheet_number = product_base_number

      var url = root_url + "/tearsheets/" + product_id + "?number=" + tearsheet_number;
      return url;
     }

     function set_tearsheet_link(){
       var $tearsheetTag = $(".tear-sheet-submit");
       var url = generate_tearsheet_link();

       $tearsheetTag.attr("href", url);
     }

       $('#tearsheet-form').children().change(set_tearsheet_link);
}))
