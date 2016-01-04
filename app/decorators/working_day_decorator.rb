class WorkingDayDecorator < Draper::Decorator
  delegate_all

  def print_working_days
    "#{'Pon' if monday} #{'Wt' if tuesday} #{'Śr' if wednesday} #{'Czw' if thursday}
     #{'Pt' if friday} #{'Sob' if saturday} #{'Niedz' if sunday}"
  end
end
