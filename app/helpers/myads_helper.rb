module MyadsHelper
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
