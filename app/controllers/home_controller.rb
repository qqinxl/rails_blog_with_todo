class HomeController < ApplicationController
  def index
    render :template => "home/show"
  end
end
