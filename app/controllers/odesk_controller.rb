require 'yaml'

class OdeskController < ApplicationController
  unloadable

  def index
    # Create an oDesk connector to use
    create_odesk_connector

    # store frob value in session to be used later
    @odesk_connector.frob = params[:frob]

    # store the token to be used with future requests
    session[:odesk_api_token] = @odesk_connector.get_token

    # redirect to the original url that required oDesk
    redirect_to session[:odesk_back_url]
  end

  @@odesk_config = nil
  def self.odesk_config
    return @@odesk_config if @@odesk_config
    odesk_config_filename = File.join(Rails.root, 'config', 'odesk.yml')
    @@odesk_config = YAML.load_file(odesk_config_filename)[Rails.env]
  end

end

