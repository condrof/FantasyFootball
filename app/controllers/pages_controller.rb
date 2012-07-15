class PagesController < ApplicationController  
  def home
    @content = Content.first(5).reverse
  end
end
