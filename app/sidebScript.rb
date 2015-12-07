   


 def checkLayout(arr)
  html = ""
  arr.each do |e|
    
    outP = "<div class=\"checkbox\">\n
                                      <label>\n<input type=\"checkbox\" value=\"\" id=\""+e.strip.gsub(' ', '_')+"\">\n"
    outP += e
    outP += "</label>\n
                                  </div>\n"
    html+=outP
    html+="\n"
  end
  print html

 end