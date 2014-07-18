class AboutController < ApplicationController

  def index
    @about_us = Setting.about
  end

end
