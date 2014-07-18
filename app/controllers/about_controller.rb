class AboutController < ApplicationController

  def index
    @about_us = Setting.where(:setting_name => 'About').first!
  end

end
