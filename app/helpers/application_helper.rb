# -*- encoding : utf-8 -*-
module ApplicationHelper
  
  def javascript(*files)
      content_for(:head) { javascript_include_tag(*files) }
  end
  
  def getMonthFromNumber(month)
    if month == '01'
      "Jan"
    elsif month == '02'
      "Fév"
    elsif month == '03'
      "Mar"
    elsif month == '04'
      "Avr"
    elsif month == '05'
      "Mai"
    elsif month == '06'
      "Juin"
    elsif month == '07'
      "Juil"
    elsif month == '08'
      "Aoû"
    elsif month == '09'
      "Sep"
    elsif month == '10'
      "Oct"
    elsif month == '11'
      "Nov"
    elsif month == '12'
      "Déc"
    end
  end
  
  def entry_class(entry)
    entry.class.to_s.underscore.downcase
  end
  
  def entry_title(entry)
    
    if entry_class(entry) == "product_test"
      entry.brand + entry.product_model
    else
      entry.title
    end
  end
  
  def entry_description(entry)
    
    if entry_class(entry) == "post"
      entry.short_description
    elsif entry_class(entry) == "question"
      entry.content
    else
      entry.description
    end
  end
  
  def entry_class_french(entry)
    if entry_class(entry) == "post"
      "ARTICLE"
    elsif entry_class(entry) == "tip"
      "ASTUCE"
    elsif entry_class(entry) == "question"
      "QUESTION"
    elsif entry_class(entry) == "event"
      "ÉVÈNEMENT"
    elsif entry_class(entry) == "product_test"
      "AVIS/TEST DE PRODUIT"
    end
  end
  
  def avatar_url(user, size)
    if user[:id] == -1 || user[:id] == -2
      asset_path("default_user_image.jpg")
    else
    
      if user.avatar.present?
          user.get_avatar.url(:thumb)
      else

        default_url = "retro"
        gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
        "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}&s=#{size}"
      end
    end
  end
end
