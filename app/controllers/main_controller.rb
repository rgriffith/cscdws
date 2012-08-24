class MainController < ApplicationController
  def index
    require "savon"
    
    # create a client for the Asset Operation SOAP service
    @opsClient = Savon.client("http://localhost:7030/ws/services/AssetOperationService?wsdl")    
    
    @listMessagesResponse = @opsClient.request :list_messages do
      soap.namespaces["xmlns:ass"] = "http://www.hannonhill.com/ws/ns/AssetOperationService"
      soap.body = { 
        "ass:authentication" => { 
          "ass:username" => "admin", 
          "ass:password" => "admin" 
        }
      }
    end    
    
    # Example of building a SOAP request manually...    
    @readResponse = @opsClient.request :read do
      namespaces = {
        "xmlns:soapenv" => "http://schemas.xmlsoap.org/soap/envelope/",
        "xmlns:ops" => "http://www.hannonhill.com/ws/ns/AssetOperationService"
      }
      soap.xml do |xml|
        xml.soapenv(:Envelope, namespaces) do |xml|
          xml.soapenv(:Body) do |xml|
            xml.ops(:read) do |xml|
              xml.ops(:authentication) do |xml|         
                xml.ops(:password, "admin")
                xml.ops(:username, "admin")
              end
              xml.ops(:identifier) do |xml|         
                xml.ops(:id, "b54d846f0a00016c6a59d8da787f87cf")
                xml.ops(:type, "page")
              end
            end
          end        
        end 
      end
    end
    
    # create a client for the Security SOAP service
    @securityClient = Savon.client("http://localhost:7030/ws/services/SecurityService?wsdl")        
    @authenticateResponse = @securityClient.request :authenticate do
      soap.body = { 
        :authentication => { 
          :username => "admin", 
          :password => "admin" 
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
    
  end  
end