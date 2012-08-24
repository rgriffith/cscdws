class MainController < ApplicationController
  def index
    require "savon"
    
    # create a client for the Asset Operation SOAP service
    @opsClient = Savon.client("http://localhost:7030/ws/services/AssetOperationService?wsdl")    
    
    # sample listMessages call
    @listMessagesResponse = @opsClient.request :list_messages do
      soap.body = { 
        "authentication" => { 
          "username" => "admin", 
          "password" => "admin" 
        }
      }
    end   
            
    # Example of building a SOAP request manually...    
    #@listMessagesResponse = @opsClient.request :list_messages do
    #  namespaces = {
    #    "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
    #    "xmlns:ops" => "http://www.hannonhill.com/ws/ns/AssetOperationService"
    #  }
    #  soap.xml do |xml|
    #    xml.soapenv(:Envelope, namespaces) do |xml|
    #      xml.soapenv(:Body) do |xml|
    #        xml.ops(:listMessages) do |xml|
    #          xml.ops(:authentication) do |xml|         
    #            xml.ops(:password, "admin")
    #            xml.ops(:username, "admin")
    #          end
    #        end
    #      end        
    #    end 
    #  end
    #end 
    
    # sample read (Page) call
    @readResponse = @opsClient.request :read do
      soap.body = { 
        "authentication" => {
          "password" => "admin",
          "username" => "admin"
        },
        "identifier" => { 
          "id" => "b54d846f0a00016c6a59d8da787f87cf", 
          "type" => "page"
        }
      }
    end
    
    # create a client for the Security SOAP service
    @securityClient = Savon.client("http://localhost:7030/ws/services/SecurityService?wsdl")    
    
    # sample authenticate call    
    @authenticateResponse = @securityClient.request :authenticate do
      soap.body = { 
        :authentication => { 
          :username => "admin", 
          :password => "admin" 
        }
      }
    end
        
  end  
end