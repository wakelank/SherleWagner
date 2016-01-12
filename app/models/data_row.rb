class DataRow

  def initialize row
    @row = row
  end

  
  def get_name_from
    @row["GENERIC PRODUCT NAME _ Revised"] || "no name"
  end

  def get_generic_number_from
    @row["Generic Product Number"] || "no product number"
  end

  def get_image_name_from
    name = @row["IMAGE FILE"] || "no image"
    name = name + ".jpg" if name != "no image"
    name
  end
end

