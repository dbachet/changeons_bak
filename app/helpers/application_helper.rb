# -*- encoding : utf-8 -*-
module ApplicationHelper
  
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
  
  def avatar_url(user, size)
    if user[:id] == -1 || user[:id] == -2
      "#{root_url}images/default_user_image.jpg"
    else
    
      # if user.avatar_url.present?
      #   user.avatar_url
      # else
      default_url = "#{root_url}images/default_user_image.jpg"
      gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
      "http://gravatar.com/avatar/#{gravatar_id}.png?s=48&d=#{CGI.escape(default_url)}&s=#{size}"
    end
  end
end
