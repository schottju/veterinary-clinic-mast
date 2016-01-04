class RegistrationsController < Devise::RegistrationsController
  def new
    resource = build_resource({})
    set_minimum_password_length
    resource.build_address
    respond_with resource
  end

  def create
    if verify_recaptcha
      super
    else
      build_resource(sign_up_params)
      clean_up_passwords(resource)
      flash.now[:error] = "Un problème est survenu, merci de recommencer."
      flash.delete :recaptcha_error
      render :new
    end
  end

  def edit
    resource.build_address if resource.address.nil?
  end

  def update
    super
  end
end
