module CardsHelper

  def card_color(card)
    card_tasks = card.tasks
    if card_tasks.count > 0
      if card_tasks.count == card_tasks.completed.count
        return 'panel-card-completed'
      else
        return 'panel-partial-task'
      end
    else
      return 'panel-default-card'
    end
  end
end
