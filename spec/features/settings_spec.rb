require "spec_helper"

describe "settings" do
  let(:user) {}
  let(:setting) {create(:setting)}

  before do
    capybara_login(user) if user
    visit root_path
  end
  
  context "when on the admin page" do
    let(:user) {create(:user, :admin)}
    before do
      visit admin_index_path
      click_link "Settings"
    end
    it "should go to the settings page" do
      expect(page).to have_content("Settings Page")
    end
    context "when on the index page" do
      let(:user) {create(:user, :admin)}
      before do
        visit admin_settings_path
      end
      it "should display the settings page" do
        expect(page).to have_content("Settings Page")
      end
      it "should display the add settings button" do
        expect(page).to have_content("Add Settings")
      end
      context "when there are settings entered" do
        before do
          setting
          visit admin_settings_path
        end
        it "should display the settings information" do
          expect(page).to have_content("#{setting.setting_name}")
        end
        it "should display the delete setting link" do
          expect(page).to have_content("Delete")
        end
        context "when deleting a setting" do
          before do
            within "#setting-#{setting.id}" do
              click_link "Delete"
            end
          end
          it "should delete the setting" do
            expect(Setting.count).to eq 3
          end
        end
        it "should display the edit settings link" do
          expect(page).to have_content("Edit")
        end
        context "when editing the setting" do
          before do
            within "#setting-#{setting.id}" do
              click_link "Edit"
            end
          end
          it "should display the setting information" do
            expect(page).to have_field("Value", :with => setting.value)
          end
          context "when updating the setting information" do
            before do
              find("#setting_setting_name").find(:xpath, 'option[2]').select_option
              fill_in "Value", :with => "Copyright information is please do not steal."
              click_button "Update Setting"
            end
            it "should update and display the settings" do
              expect(page).to have_content("Copyright information is please do not steal.")
              expect(page).to have_content("Copyright")
            end
          end
        end
        context "when adding settings" do
          before do
            click_link "Add Settings"
          end
          it "should display the add settings page" do
            expect(page).to have_content("Add Settings Page")
            expect(page).to have_field("Setting name")
            expect(page).to have_field("Value")
          end
          context "when creating the setting" do
            before do
              fill_in "Value", :with => "Test Copyright information is please do not steal"
              find("#setting_setting_name").find(:xpath, 'option[2]').select_option
              click_button "Create Setting"
            end
            it "should display the newly created setting info" do
              expect(page).to have_content("Test Copyright information is please do not steal")
              expect(page).to have_content("Copyright")
            end
          end
        end
      end
      context "when there are no settings entered" do
        it "should display three default settings" do
          expect(page).to have_content("Email")
          expect(page).to have_content("Copyright")
          expect(page).to have_content("About")
        end
      end
    end
  end
end
