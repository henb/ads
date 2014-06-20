module MyadsHelper
  def state_bool(array)
    array.map{|value| [value,"can_#{value}?".to_sym] }  
  end

  def published_only
  	return false if current_user.admin?
    !params[:published].nil?
  end

  def admin_states_ad
    states_ad - [:drafting,:archives]
  end
end
