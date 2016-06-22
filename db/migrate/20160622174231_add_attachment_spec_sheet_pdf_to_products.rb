class AddAttachmentSpecSheetPdfToProducts < ActiveRecord::Migration
  def self.up
    change_table :products do |t|
      t.attachment :spec_sheet_pdf
    end
  end

  def self.down
    remove_attachment :products, :spec_sheet_pdf
  end
end
