class ReadController < ApplicationController    
  def index
      
  end
  
  def asset
    client = Savon.client(Cscdws::Application.config.cascade_asset_operation_service_wsdl)
  
    response = client.request :read do
      soap.body = {
        :authentication => {
          :password => "admin",
          :username => "admin",
          :order! => [:password, :username]
        },
        :identifier => {
          :id => params[:id],
          :type => params[:assettype],
          :order! => [:id, :type]
        },
        :order! => [:authentication, :identifier]
      }
    end 
    
    @asset = response.to_hash[:read_response][:read_return][:asset]
    
    respond_to do |format|
      format.html
      format.xml { render :xml => @asset.to_xml(:root => "asset", :skip_types => true) }
      format.json { render :xml => @asset.to_json }
    end
  end
  
end
