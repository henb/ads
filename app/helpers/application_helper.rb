module ApplicationHelper
  def label_state(index)
    arr = [:default,:primary,:warning,:info,:success,:archive,:danger]
    arr[index]
  end

  def label_event(symbol)
  	arr = %i(draft fresh reject approve publish archive ban)
    label_state arr.index(symbol)
  end
end
