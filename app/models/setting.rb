class Setting < ActiveRecord::Base
  validates :setting_name, :uniqueness => true
  validate :setting_name, :presence => true

  def self.create_defaults(settings)
    @copyright = false
    @email = false
    @about = false
    settings.each do |s|
      if s.setting_name == "Copyright"
        @copyright = true
      elsif s.setting_name == "Email"
        @email = true
      elsif s.setting_name == "About"
        @about = true
      else
      end
    end
    if !@copyright
      Setting.create(:setting_name => "Copyright")
    elsif !@about
      Setting.create(:setting_name => "About")
    else
    end
    if !@email
      Setting.create(:setting_name => "Email")
    else
    end
  end
end
