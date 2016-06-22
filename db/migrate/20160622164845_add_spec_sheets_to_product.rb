class AddSpecSheetsToProduct < ActiveRecord::Migration
  def change
    def up
      add_attachment :products, :spec_sheet_pdf
      add_attachment :products, :spec_sheet_2d
      add_attachment :products, :spec_sheet_3d
    end

    def down
      remove_attachment :products, :spec_sheet_pdf
      remove_attachment :products, :spec_sheet_2d
      remove_attachment :products, :spec_sheet_3d
    end
  end
end
