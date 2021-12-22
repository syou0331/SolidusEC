require 'rails_helper'

RSpec.feature "Get /potepan/products/:id", type: :feature do
  let(:product) { create(:product) }
  let!(:image) { create(:image) }

  background do
    visit potepan_product_path(product.id)
    product.images << image
  end

  scenario "ページタイトルが表示されること" do
    expect(page).to have_title(product.name + " - " + "BIGBAG Store")
    expect(page).to have_selector ".page-title h2", text: product.name
  end

  scenario "商品テキストが表示されること" do
    expect(page).to have_selector ".media-body h2", text: product.name
    expect(page).to have_selector ".media-body h3", text: product.display_price
    expect(page).to have_selector ".media-body p", text: product.description
  end

  scenario "画像が表示されること" do
    product.images.all? do |img|
      expect(page).to have_selector("img[src$='#{img.attachment_file_name}']")
    end
  end

  scenario "「Home」へリンクされていること" do
    within("ol") do
      expect(page).to have_link "Home", href: potepan_path
    end
    within("ul.navbar-right") do
      expect(page).to have_link "Home", href: potepan_path
    end
  end
end
