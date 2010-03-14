module GroupExpensesHelper
  def selected_entry_date
    (-5..5).map do |i|
      case i
      when 0
        [t('expenses.today'), Date.today]
      when -1
        [t('expenses.yesterday'), (Date.today - 1.day)]
      when 1
        [t('expenses.tomorrow'), (Date.today + 1.day)]
      else
        [(Date.today + i.day), (Date.today + i.day)]
      end 
    end
  end
end
