require "rails_helper"
RSpec.describe "admin/categories/edit", type: :view do
  before(:each) do
    thirty_one_charater = "1aDm9VfJOo5LHjEIr0gNFGkkZ49upna"
    @category = assign(:category, Category.create!(
                            id: 1,
                            name: "MyString",
                            decription: thirty_one_charater,
                            status: true
                          ))
  end

  it "renders the edit category form" do
    render
    assert_select "form[action=?][method=?]", admin_category_path(id: @category.id), "post" do
      assert_select "input[name=?]", "category[name]"
      assert_select "textarea[name=?]", "category[decription]"
      if @category.image.attached?
        assert @category.image.attached?
      end
    end
    assert_select "h3", text: t("admin.categories.lesson").to_s
    unless @category.lessons.blank?
      @category.lessons.each do |lesson|
        assert_select "a[href=?]", edit_admin_lesson_path(id: lesson.id)
      end
    end
  end
end
