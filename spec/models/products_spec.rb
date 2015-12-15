require 'rails_helper'
include ActionDispatch::TestProcess

RSpec.describe Product, :type => :model do
  describe "this works" do
    it "returns true" do
      val = true
      expect(val).to eq true
    end
  end

  describe "product upload from file" do
    let(:headers) { "GENERIC PRODUCT NAME _ Revised, Generic Product Number, MAIN, SUB FOLDER\r\n" }
    let(:rows)    { ["prod name,123,Fixtures,Basins\r\n"] }
    let(:io) do
      StringIO.new.tap do |sio|
        sio << headers
        rows.each { |row| sio << row }
        sio.rewind
      end
    end
    it "should parse file contents and return a result" do
      file = File.stub(:open).with("filename","rb") { io }
      Product.new_upload_product_file(file).to change(Product, :count).by(1)
    end
  end


end
