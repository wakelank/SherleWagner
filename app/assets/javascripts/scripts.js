$(document).ready(function(){
  function submitTearSheet(){
//    e.preventDefault();
    var tearSheetForm = document.forms[0];
    var product_base_number = tearSheetForm.elements["product_base_number"].value;
    var material_id = tearSheetForm.elements["product[material_id]"].value;
    var finish_id = tearSheetForm.elements["product[finish_id]"].value;
    var product_data = { "product_base_number" : product_base_number,
                "material_id" : material_id,
                "finish_id" : finish_id
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

     $('.tear-sheet-submit').click(function(e){
       e.preventDefault();
       submitTearSheet();
     });
})
