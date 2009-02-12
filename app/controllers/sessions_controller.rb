# This controller handles the login/logout function of the site.  
class SessionsController < ApplicationController

  # render new.rhtml
  def new
  end

  def create
#    if using_open_id?
#      open_id_authentication
#    else
      password_authentication(params[:login], params[:password])
#    end
  end
  
  def view
    @sessions = Session.find(:all)
  end

  def destroy
    logout_killing_session!
    flash[:notice] = "You have been logged out."
    redirect_back_or_default('/')
  end

protected
  # Track failed login attempts
  def note_failed_signin
    flash[:error] = "Couldn't log you in as '#{params[:login]}'"
    logger.warn "Failed login for '#{params[:login]}' from #{request.remote_ip} at #{Time.now.utc}"
  end
  
  def open_id_authentication
    authenticate_with_open_id do |result, identity_url|
      if result.successful?
        if @current_user = Users.find_by_identity_url(identity_url)
          successful_login
        else
          failed_login "Sorry, no user by that identity URL exists (#{identity_url})"
        end
      else
        failed_login result.message
      end
    end
  end  
    
  def password_authentication(login, password)
    logout_keeping_session!
    user = User.authenticate(login, password)
    if user
      # Protects against session fixation attacks, causes request forgery
      # protection if user resubmits an earlier form using back
      # button. Uncomment if you understand the tradeoffs.
      # reset_session
      self.current_user = user
      successful_login
#      new_cookie_flag = (params[:remember_me] == "1")
#      handle_remember_cookie! new_cookie_flag
#      redirect_back_or_default('/')
#      flash[:notice] = "Logged in successfully"
    else
      failed_login "Sorry, that username/password doesn't work"
    end
  end
  
  def failed_login(message = "Authentication failed.")
    note_failed_signin
    @login       = params[:login]
    @remember_me = params[:remember_me]
    render :action => 'new'
  end
  
  def successful_login
    if params[:remember_me] == "1"
      self.current_user.remember_me
      cookies[:auth_token] = { :value => self.current_user.remember_token , :expires => self.current_user.remember_token_expires_at }
    end
    redirect_back_or_default('/')
    flash[:notice] = "Logged in successfully"
  end

end
