module SessionsHelper

  # 渡されたユーザでログインする
  def log_in(user)

    session[:user_id] = user.id

  end

  # ログインしているユーザを返す(いる場合)
  def current_user

    if user_id = session[:user_id]

      @current_user ||= User.find_by(id: user_id)

    elsif user_id = cookies.signed[:user_id]


      user = User.find_by(id: user_id)

      if user && user.authenticated?(:remember, cookies[:remember_token])

        log_in user

        @current_user = user

      end

    end

  end

  def loged_in?

    !current_user.nil?

  end

  def log_out
    forget(current_user)
    session.delete(:user_id)
    @current_user = nil

  end

  def remember(user)

    user.remember

    cookies.permanent.signed[:user_id] = user.id
    cookies.permanent[:remember_token] = user.remember_token

  end

  def forget(user)
    user.forget
    cookies.delete(:user_id)
    cookies.delete(:remember_token)
  end

  #　アクセスしようとしたURLを覚えておく
  def store_location

    session[:fowarding_url] = request.original_url if request.get?

  end

  def redirect_back_or(default)

    redirect_to(session[:fowarding_url] || default )
    session.delete(:fowarding_url)

  end

  def current_user?(user)

    current_user == user

  end

  def send_activation_email(user)
    UserMailer.account_activation(user).deliver_now
  end



  def active(user)

    user.update_attribute(:activated, true)

    user.update_attribute(:activated_at, Time.zone.now)

  end


end
