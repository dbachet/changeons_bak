# -*- encoding : utf-8 -*-
module ModerationSettingsHelper

  def moderatable
    @tip || @post || @event || @product_test || @comment || @question || @answer || @moderatable
  end
  
  def moderatable_class
    (@tip || @post || @event || @product_test || @comment || @question || @answer || @moderatable).class.to_s.underscore.downcase
  end
  
end








