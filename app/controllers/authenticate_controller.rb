class AuthenticateController < ApplicationController
  def index
    # create a client for the Security SOAP service
    client = Savon.client(Cscdws::Application.config.cascade_security_service_wsdl)

    response = client.request :authenticate do
      soap.body = {
        :authentication => {
          :password => "admin",
          :username => "admin",
          :order! => [:password, :username]
        }
      }
    end

    @authenticate_response = response.to_hash[:authenticate_response][:authenticate_return]

    respond_to do |format|
      format.html
      format.xml { render :xml => @authenticate_response.to_xml(:root => "authentication_response", :skip_types => true) }
      format.json { render :xml => @authenticate_response.to_json }
    end
  end
end
