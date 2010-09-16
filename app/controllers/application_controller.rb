class ApplicationController < ActionController::Base
  include BrowserFilters
  include ExceptionNotifiable
  include AuthenticatedSystem
  
  before_filter :check_ip_addr
  before_filter CASClient::Frameworks::Rails::Filter if WebistranoConfig[:authentication_method] == :cas
  before_filter :login_from_cookie, :login_required, :ensure_not_disabled
  around_filter :set_timezone

  layout 'application'
  
  helper :all # include all helpers, all the time
  helper_method :current_stage, :current_project

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery
  
  protected
  def check_admin
    if current_user.admin?
      return
    else 
      flash[:error] = "Action not allowed for non-administrative users."
      redirect_to home_path
    end
  end
  def check_ip_addr
    
    if !AllowedIpAddress.all.map{|i|i.ip_address}.include?(request.remote_ip)
    	AllowedIpAddress.all.each{|i| return if request.remote_ip =~ Regexp.new(i.ip_address)}
	render :text =>"Your IP address is not authorized to use the web app",:status =>401

    end
  end 

  def set_timezone
    # default timezone is UTC
    Time.zone = logged_in? ? ( current_user.time_zone rescue 'UTC'): 'UTC'
    yield
    Time.zone = 'UTC'
  end
  
  def load_project
    @project = Project.find(params[:project_id])
  end
  
  def load_stage
    load_project
    @stage = @project.stages.find(params[:stage_id])
  end
  
  def current_stage
    @stage
  end
  
  def current_project
    @project
  end
  
  def ensure_admin
    if logged_in? && current_user.admin?
      return true
    else
      flash[:notice] = "Action not allowed"
      redirect_to home_path
      return false
    end
  end
  
  def ensure_not_disabled
    if logged_in? && current_user.disabled?
      logout
      return false
    else
      return true
    end
  end
  
  def logout
    self.current_user.forget_me if logged_in?
    cookies.delete :auth_token
    reset_session
    if WebistranoConfig[:authentication_method] != :cas
      flash[:notice] = "You have been logged out."
      redirect_back_or_default( home_path )
    else
      redirect_to "#{CASClient::Frameworks::Rails::Filter.config[:logout_url]}?serviceUrl=#{home_url}"
    end
  end
  
end
