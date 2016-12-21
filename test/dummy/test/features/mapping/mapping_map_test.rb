require "test_helper"

feature "delete mapping" do
end
feature "edit mapping" do

end

feature "submit mapping data" do

  scenario "success" do
skip
    existing_content = FactoryGirl.create(:targeted_file)
    mapping = existing_content.mappings.create(attributes_for(:mapping))
    base_id = "mapping_legend_review"
    legends = {
      "#{base_id}_rating" => "rating",
      "#{base_id}_content" => "review",
      "#{base_id}_wine_vintage" => "vintage"
    }

    visit '/buttafly/contents'
    within("#content-scope-all") do
      within("#file-mapping-#{mapping.id}") do
        legends.each_pair do |k,v|
          select(v, from: k)
        end
        click_button("write #{mapping.targetable_model} legend")
      end
    end
    assert_selector(".alert-box", text: "mapping updated")

    within("#content-scope-all") do
      within("#file-mapping-#{mapping.id}") do
        legends.each_pair do |k,v|
          has_field?(k, with: v).must_equal true
        end
      end
    end
    assert_selector(".label.state-mapped")


  end
end