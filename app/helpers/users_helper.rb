module UsersHelper
  def gravatar_for(user)
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    link_to image_tag(gravatar_url, alt: user.email), user, class: 'pull-left'
  end

  def full_name(user)
    "#{user.first_name} #{user.last_name}"
  end
end
