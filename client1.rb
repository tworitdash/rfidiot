#The client which receives the data from the server to send it to the controller (For example arduino)

require_relative 'em-websocket-client'
require "serialport"




EM.run do
    #conn = EventMachine::WebSocketClient.connect("ws://example.com:8000/")
    conn = EventMachine::WebSocketClient.connect("ws://IP_address:8000/")
    #put the IP adress of the server machine in case of IP_address
    conn.callback do
        conn.send_msg "test"
    end

    conn.errback do |e|
        puts "Got error: #{e}"
    end

    conn.stream do |msg|

        to_send = msg.to_s 

        port_file = "/dev/ttyACM0"
        #port_file is according to the path to your controller
        baud_rate = 9600
        data_bits = 8
        stop_bits = 1
        parity = SerialPort::NONE
        #serialport object
        ser = SerialPort.new(port_file , baud_rate , data_bits , stop_bits , parity)

        if to_send == "your_authenticated_id"
            #put the result of tag.inspect of the tag in place of "your_authenticated_tag_id" that you want to use as an authenticated tag from the client.rb file.
            ser.write("b")
            #it sends the data "b" to the controller connected to the /dev/ttyACM0 in your system. Tested in arduino and ARM Cortex M4 (tm4c123g)

        end
	puts "received msg: #{msg}" #prints the tag ID (optional)
	
        
    end

    conn.disconnect do
        puts "disconnected!"
        EM::stop_event_loop
    end
end
