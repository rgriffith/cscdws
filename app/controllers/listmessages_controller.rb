class ListmessagesController < ApplicationController
  def index
    # create a client for the Asset Operation SOAP service
    client = Savon.client(Cscdws::Application.config.cascade_asset_operation_service_wsdl)
    
    @response = client.request :wsdl, :list_messages do
      soap.body = {
        :authentication => {
          :password => "admin",
          :username => "admin",
          :order! => [:password, :username]
        }
      }
    end 
    
    @list_messages = @response.to_hash[:list_messages_response][:list_messages_return][:messages][:message]
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @list_messages.to_xml(:root => "messages", :skip_types => true) }
      format.json { render :xml => @list_messages.to_json }
    end
  end
end
