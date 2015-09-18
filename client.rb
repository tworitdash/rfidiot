require_relative 'em-websocket-client'
require "serialport"
require "json"


rfid = SerialPort.new("/dev/tty.usbserial-A90246LK", 9600)
rfid.read_timeout = 1000

EM.run do
    conn = EventMachine::WebSocketClient.connect("ws://example.com:8000/")
    #conn = EventMachine::WebSocketClient.connect("ws://127.0.0.1:8000/")
    conn.callback do
        conn.send_msg "connected !"
       # while true do 
           

        ###
    end

    conn.errback do |e|
        puts "Got error: #{e}"
    end

    conn.stream do |msg|
    	
    	puts "received: #{msg}"
    	
    	tag = rfid.gets
        
            #puts "waiting for a card"
           
            puts tag
    	    puts tag.class 
            puts tag.inspect
            conn.send_msg tag
    
        
		

    	
        #port_file = "/dev/ttyACM0"
        #baud_rate = 9600
        #data_bits = 8
        #stop_bits = 1
        #parity = SerialPort::NONE
        #ser = SerialPort.new(port_file , baud_rate , data_bits , stop_bits , parity)
        #ser.write("#{msg}")
		#puts "registering..."
		#v_db.store("card#{msg}", {"id" => msg, "number" => "#{msg}"})
		#file.write(v_db.to_json)
		#puts "registered :) your RFID card has been registered and can be accessed by the reader !"	
     end

     

    conn.disconnect do
        puts "disconnected!"
        EM::stop_event_loop
    end
end
