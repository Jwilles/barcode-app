module ItemsHelper


require 'xmlrpc/client'

 def lookup_upc(upc)
  rpc_key = 'dd087801f3fae494999683ce8121aa10937858d3'
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
