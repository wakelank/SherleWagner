Thermostatic Shower Trims 
 Concentric Thermostatic Trims 
 Volume on/off & Diverter Control Trims 
 Shower Heads 
 Rain Domes 
 Body Sprays 
 Rain Bars 
 Hand Showers 
 Hand Shower Accessories 
 Deck Mount Tub Spouts 
 Wall Mount Tub Spouts 
 Waste Assembly 
 Shower Arm Diverters 


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