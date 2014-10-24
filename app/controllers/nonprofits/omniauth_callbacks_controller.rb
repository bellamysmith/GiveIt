class Nonprofits::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  # You should configure your model like this:
  # devise :omniauthable, omniauth_providers: [:twitter]

  def stripe_connect
   @nonprofit = Nonprofit.from_omniauth(request.env["omniauth.auth"])

    if @nonprofit.persisted?
      sign_in @nonprofit, :event => :authentication #this will throw if @user is not activated
      set_flash_message(:notice, :success, :kind => "Stripe") if is_navigational_format?
      redirect_to nonprofit_path(@nonprofit)
    else
      session["devise.stripe_data"] = request.env["omniauth.auth"]
      redirect_to new_nonprofit_registration_url
    end


  end
  # You should also create an action method in this controller like this:
  # def twitter
  # end

  # More info at:
  # https://github.com/plataformatec/devise#omniauth

  # GET|POST /resource/auth/twitter
  # def passthru
  #   super
  # end

  # GET|POST /users/auth/twitter/callback
  # def failure
  #   super
  # end

  # protected

  # The path used when omniauth fails
  # def after_omniauth_failure_path_for(scope)
  #   super(scope)
  # end
end
