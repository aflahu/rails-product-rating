class HomeController < ApplicationController
  def index
  end
  
  def error
    raise 'Test Error'
  end
end
