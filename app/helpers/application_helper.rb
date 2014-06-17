module ApplicationHelper

  def label_state(index)
    arr = [:default,:primary,:warning,:info,:success,:archive,:danger]
    return :none unless (0...arr.size).include? index
    arr[index]
  end

  def label_event(symbol)
    label_state events_ad.index(symbol)
  end

  def events_ad
    Myad.state_machine.events.map &:name
  end

  def states_ad
    Myad.state_machine.states.map &:name
  end
  
  def flash_key(key)
    ['info','warning','danger','success','default'].include?(key.to_s) ? key : 'info'  
  end

  def admin?
    current_user && current_user.role == "admin"
  end
end
