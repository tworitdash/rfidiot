#server for the RFID data communication !

require 'thin'
require 'em-websocket'
require 'sinatra/base'

EM.run do
   
    #client array

    @clients = []

    EM::WebSocket.start(:host => '0.0.0.0', :port => '8000') do |ws|
        ws.onopen do |handshake|
            @clients << ws
	    puts @clients
            ws.send "connected"
            puts "Connected"
        end

        ws.onclose do
            ws.send "Closed."
            puts "closed"
            @clients.delete ws
        end

        ws.onmessage do |msg|
			puts "Received Message: #{msg}"
            #The data collected from the server is then sent to each of the connected clients to the server. 
            @clients.each do |socket|
                socket.send msg
            end
        end
    end

end
