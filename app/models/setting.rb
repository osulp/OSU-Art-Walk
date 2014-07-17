class Setting < ActiveRecord::Base
  validates :setting_name, :uniqueness => true, :presence => true

  def self.default_settings
    %w{Copyright Email About}
  end

  def self.create_defaults
    default_settings.each do |setting|
      self.where(:setting_name => setting).first_or_create
    end
  end
end
