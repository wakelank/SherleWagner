require 'rails_helper'

feature 'On product upload page ' do
  scenario 'page comes up' do
    visit products_upload_page_path
    expect(page).to have_content "Sherle Wagner 2.0"
  end

  scenario 'user can upload a file' do
    visit products_upload_page_path
    attach_file(:filename, File.join(Rails.root, 'spec', 'fixtures', 'files', 'test_products.csv'))
    click_button 'Save changes'

    expect(current_path).to eq products_upload_page_path
  end

  scenario 'uploaded products appear on products index page'
  
end

