require "rails_helper"
RSpec.describe "admin/categories/new", type: :view do
  before(:each) do
    thirty_one_charater = "1aDm9VfJOo5LHjEIr0gNFGkkZ49upna"
    @category = assign(:category, Category.new(
                            name: "MyString",
                            decription: thirty_one_charater,
                            status: true
                          ))
  end

  it "renders the new category form" do
    render 
    assert_select "form[action=?][method=?]", admin_categories_path, "post" do
      assert_select "input[name=?]", "category[name]"
      assert_select "textarea[name=?]", "category[decription]"
      if @category.image.attached?
        assert @category.image.attached?
      end
    end
  end
end