class Setting < ActiveRecord::Base
  validates :setting_name, :uniqueness => true, :presence => true

  def self.default_settings
    @default_settings ||= YAML.load_file(Rails.root.join("config", "settings.yml")) || {}
  end

  def self.create_defaults
    default_settings.each do |setting_name, settings|
      self.where(:setting_name => setting_name).first_or_create
    end
  end
end
