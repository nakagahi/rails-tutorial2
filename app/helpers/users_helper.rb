module UsersHelper

  def gravatar_for(user)
    grabatar_id = Digest::MD5::hexdigest(user.email.downcase)

     gravatar_url = "https://secure.gravatar.com/avatar/#{grabatar_id}"

     image_tag(gravatar_url, alt: user.name, class: "gravatar")

  end
end
