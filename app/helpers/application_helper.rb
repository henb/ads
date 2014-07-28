module ApplicationHelper
  def flash_key(key)
    %w(info warning danger success default).include?(key.to_s) ? key : 'info'
  end

  def admin?
    current_user && current_user.admin?
  end

  def help_for_serch_form
    search = Myad.search
  end
end
