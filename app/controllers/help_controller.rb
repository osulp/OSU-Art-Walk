class HelpController < ApplicationController
  def index
    @help = Setting.help
  end
end
