require 'spec_helper'

describe Setting do
  it {should validate_presence_of(:setting_name) }
  it {should validate_uniqueness_of(:setting_name) }

  describe "#create_defaults" do

    context "when there are no default setting names present" do
      before do
        Setting.create_defaults
      end
      Setting.default_settings.each do |setting|
        it "should create the default #{setting} setting" do
          expect(Setting.where(:setting_name => setting).count).to eq 1
        end
      end
    end
  end
end
