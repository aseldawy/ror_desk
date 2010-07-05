# Some instance methods that should be existing in ApplicationController to
# be used as before filters
module RorDesk::ControllerAdditions
protected

  # Used as a before filter for methods that will access oDesk APIs
  # It guarantees that the user permits this application to use oDesk APIs
  def odesk_required
    create_odesk_connector
    if !session[:odesk_api_token]
      session[:odesk_back_url] = request.url
      redirect_to @odesk_connector.auth_url
    end
  end

  # Creates the oDesk connector on each request
  # It relies on an API token stored in SessionStore
  def create_odesk_connector
    @odesk_connector = RubyDesk::Connector.new(
      OdeskController.odesk_config['api_key'],
      OdeskController.odesk_config['api_secret'], session[:odesk_api_token])
    @odesk_connector.auth_user = session[:odesk_auth_user]
    # Return the created connector
    @odesk_connector
  end

  # Causes the application to acquire a new token
  # This is usually called when the old token has expired
  def reaquire_token
    # Remove any saved tokens
    session[:odesk_api_token] = nil

    # Causes the application to redirect to oDesk and ask for a new token
    odesk_required
  end
end

