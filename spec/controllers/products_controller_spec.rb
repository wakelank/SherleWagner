require 'rails_helper'
require 'support/paperclip_stub.rb'

RSpec.describe ProductsController, :type => :controller do

  describe "GET index" do
    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

 # describe "Product upload" do
 #   it "uploading product file adds products to database" do
 #     @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
 #     @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
 #     expect{ post :upload_product_file, :controller => :products, :filename => @file }.to change(Product, :count).by(7)
 #     request.env["HTTP_REFERER"] = products_upload_page_path
 #   end
 # end

  describe "Product upload" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      request.env["HTTP_REFERER"] = products_upload_page_path
      post :upload_product_file, :controller => :products, :filename => @file 
      @product = Product.find_by(number: '008BSN108-XX') || :non_product
      @product_with_china_colors = Product.find_by(number: '1029BSN821-04CC-XX') || :non_product
      @product_with_materials = Product.find_by(number: '008BSN108-SLSL-XX') || :non_product
    end

    it 'adds 9 products to table' do
      Product.all.each { |p| puts p.number }
      expect(Product.count).to eq 9 
    end

    it 'product name' do
      expect(Product.first.name).to eq 'Arco With Arco Lever'
    end

    it "product_type" do
      expect(@product.product_type.name).to eq "Fittings"
    end

    it "assigns associated collection" do
      associated_collection = Style.find_by(name: "Arco")
      expect(@product.associated_collection).to eq associated_collection
    end

    it "assigns one product to Arco" do
      style = Style.find_by(name: "Arco")
      expect(style.products.count).to eq 1
    end

  end

  describe "Upload process associates with product:" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      request.env["HTTP_REFERER"] = products_upload_page_path
      post :upload_product_file, :controller => :products, :filename => @file 
      @product = Product.find_by(number: '008BSN108-XX') || :non_product
      @product_with_china_colors = Product.find_by(number: '1029BSN821-04CC-XX') || :non_product
      @product_with_materials = Product.find_by(number: '008BSN108-SLSL-XX') || :non_product
      @product_with_chinametal = Product.find_by(number: 'UE15-CHINAMETAL-CC') || :non_product
    end

    it "product_type" do
      expect(@product.product_type.name).to eq "Fittings"
    end

    it "product_sub_type" do
      expect(@product.product_sub_type.name).to eq "Basin Sets"
    end
    it "filter_values" do
      expect(@product.filter_values.first.name).to eq "Levers"
    end
    it "finishes" do
      expect(@product.finishes.count).to be 20
    end
    it "china color" do
      expect(@product_with_china_colors.china_colors.count).to be 4
    end
    it "materials with material code SLSL" do
      expect(@product_with_materials.materials.count).to be 6
    end
    it "materials with material code CHINAMETAL" do
      expect(@product_with_chinametal.materials.count).to be 49
    end
    it "style" do
      expect(@product.styles.first.name).to eq "Arco"
    end
    it "genre" do
      expect(@product.genres.first.name).to eq "Contemporary"
    end

#    it "image" do
#      expect(@product.image.url).to eq "/system/products/images/000/001/927/original/008BSN108-CP.jpg?1448920256"
#    end

    it "product_configuration" do
      @product_with_configurations = Product.find_by(number: '008BSN108-SLSL-XX')
      expect(@product_with_configurations.product_configurations.pluck(:number).sort).to eq ["008BSN108-BLTI-CP","008BSN108-RHOD-CP"]
    end 

    it 'compilation' do
      @compilation = Product.find_by(number: "T101-CTS-TUB-SHR-CP")
      expect((@compilation.components).pluck(:number).sort).to eq ['101-SHHD-XX','101TUB-XX','T101-001-TMT-XX']
    end

    it 'components' do
      compilation = Product.find_by(number: "T101-CTS-TUB-SHR-CP")
      component = Product.find_by(number: '101-SHHD-XX')
      expect((component.compilations).pluck(:number).sort).to eq ['T101-CTS-008-SHR-HS-CP', 'T101-CTS-TUB-SHR-CP']
    end
  end

  describe "Seed file assigns filters:" do
    before :each do
      @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
      @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
      request.env["HTTP_REFERER"] = products_upload_page_path
      post :upload_product_file, :controller => :products, :filename => @file 
      @basins = ProductSubType.find_by(name: "Basins")
    end

    it "5 filters to Basins" do
      expect(@basins.filters.count).to eq 5
    end


  end
 # describe "Upload process creates ProductGroups" do
 #   before :each do
 #     @file = fixture_file_upload('files/test_product_data.csv', 'text/csv')
 #     @file = Rack::Test::UploadedFile.new(@file, 'text/csv')
 #     request.env["HTTP_REFERER"] = products_upload_page_path
 #     post :upload_product_file, :controller => :products, :filename => @file 
 #     @pg = ProductGroup.find_by!(number: '008BSN108-XX')
 #   end

 #     it "3 product groups" do
 #       expect(ProductGroup.all.length).to eq 3
 #     end

 #     it "with product_type" do
 #       expect(@pg.product_type.name).to eq "Fittings"
 #     end

 #     it "with product_sub_type" do
 #       expect(@pg.product_sub_type.name).to eq "Basin Sets"
 #     end

 #     it "with an attached product" do
 #       expect(@pg.products.length).to eq 1
 #     end

 #     it "with the correct attached product" do
 #       expect(@pg.products.first.name).to eq "Arco With Arco Lever"
 #     end

 #     it "attaches the filter_values to the product group" do
 #       expect(@pg.filter_values.first.name).to eq "Levers"
 #     end
 #     it "attaches the finishes to the product group" do
 #       expect(@pg.finishes.count).to be 20
 #     end
 #     it "attaches the materials to the product group with material code SLSL" do
 #       @pg_materials = ProductGroup.where(number: '008BSN108-SLSL-XX').first
 #       expect(@pg_materials.materials.count).to be 6
 #     end
 #     it "attaches the filters to the product group"
 #     it "attaches style to product group" do
 #       expect(@pg.styles.first.name).to eq "arco"
 #     end
 # end
  
end
