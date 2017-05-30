module ItemsHelper


require 'xmlrpc/client'

 def lookup_upc(upc)
  rpc_key = ENV['UPC_LOOKUP_KEY'] 
  server = XMLRPC::Client.new2('https://www.upcdatabase.com/xmlrpc')
  begin
    response = server.call('lookup', { rpc_key: rpc_key, upc: upc })
    return response['found'] ? response : nil
  rescue XMLRPC::FaultException => e
    puts "Error: "
    puts e.faultCode
    puts e.faultString
  end
 end

end
