class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def demo
  	render layout: "demo"
  end

  def iphone6
  	render layout: "demo"
  end
end
