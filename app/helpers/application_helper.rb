module ApplicationHelper
  def getMonthFromNumber(month)
    if month == '01'
      "Jan"
    elsif month == '02'
      "Féb"
    elsif month == '03'
      "Mar"
    elsif month == '04'
      "Apr"
    elsif month == '05'
      "Mai"
    elsif month == '06'
      "Juin"
    elsif month == '07'
      "Juil"
    elsif month == '08'
      "Aug"
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
end
