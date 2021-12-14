require 'rails_helper'

RSpec.feature "Get /potepan/products/:id", type: :feature do
  let(:product) { create(:product) }

  background do
    visit potepan_product_url(id: product.id)
  end

  scenario "ページタイトルが正常なこと" do
    expect(page).to have_title(product.name + " - " + "BIGBAG Store")
  end

  scenario "ページ表示が正常なこと" do
    expect(page).to have_selector ".page-title h2", text: product.name
    expect(page).to have_selector ".col-xs-6 h2", text: product.name
    expect(page).to have_selector ".media-body h2", text: product.name
    expect(page).to have_selector ".media-body h3", text: product.display_price
    expect(page).to have_selector ".media-body p", text: product.description
    expect(page).to have_content product.images[0]
  end

  scenario "「Home」へのリンクが正常なこと" do
    expect(page).to have_link "Home", href: potepan_path
  end
end
