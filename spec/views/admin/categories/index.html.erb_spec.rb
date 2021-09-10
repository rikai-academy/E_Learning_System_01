require "rails_helper"

RSpec.describe "admin/categories/index", type: :view do
  before(:each) do
    thirty_one_charater = "1aDm9VfJOo5LHjEIr0gNFGkkZ49upna"gi
    @categories = Category.all.paginate(page: params[:page] )
  end

  it "renders the index categories" do
    render
    assert_select "tr>th", text: t("admin.categories.name").to_s, count: 1
    assert_select "tr>th", text: t("admin.categories.status").to_s, count: 1
    assert_select "tr>th", text: t("admin.categories.decrip").to_s, count: 1
    @categories.each do |cate|
      assert_select "tr>td", text: cate.name.to_s
      assert_select "tr>td", text: cate.decription.to_s
      assert_select "a[href=?]", edit_admin_category_path(id: cate.id)
    end
  end
end


