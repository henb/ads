module MyadsHelper
  def label_state(index)
    arr = [:default, :primary, :warning, :info, :success, :archive, :danger]
    return :none unless (0...arr.size).include? index
    arr[index]
  end

  def can_event?(ad)
    !(ad.state_events & (admin? ? Myad.admin_events : Myad.user_events)).empty?
  end

  def label_event(symbol)
    label_state events_ad.index(symbol)
  end

  def events_ad
    Myad.state_machine.events.map &:name
  end

  def events_ad_for_select_tag
    events_ad & (admin? ? Myad.admin_events : Myad.user_events)
  end

  def states_ad
    Myad.state_machine.states.map &:name
  end

  def states_hash
    states_ad.each_with_index.map { |e, i| [e, i] }.to_h
  end

  def admin_states_ad
    states_ad - [:drafting, :archives]
  end

  def link_alternative(text, link1, link2, for_obj, &block)
    if block && block.call(for_obj)
      link_to text, link1
    else
      link_to text, link2
    end
  end

  def link_to_state(state, ad, hash = {})
    link_to(state.capitalize, { controller: 'myads', action: state.to_s, id: ad }, hash)
  end
end
