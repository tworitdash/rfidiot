#run this code in any system with a USB RFID connected. Tested in Mac OSX and Raspberry Pi. 
#This client receives the data from the RFID reader and sends it to the server.


require_relative 'em-websocket-client'
require "serialport"


#rfid object 
#9600 is the baud rate for the RFID reader and 
#"/dev/tty.usbserial-A90246LK" can be different fot your system. Make sure the port is assigned to the rfid reader.
rfid = SerialPort.new("/dev/tty.usbserial-A90246LK", 9600)
rfid.read_timeout = 1000

EM.run do
    conn = EventMachine::WebSocketClient.connect("ws://example.com:8000/")
    #if you want to accept the data from the rfid tags through a local server then uncomment the following line and make the above a comment line.
    #conn = EventMachine::WebSocketClient.connect("ws://127.0.0.1:8000/")
    conn.callback do
        conn.send_msg "connected !"
       # while true do 
           

        
    end

    conn.errback do |e|
        puts "Got error: #{e}"
    end

    conn.stream do |msg|
    	
    	puts "received: #{msg}"
    	
    	tag = rfid.gets #receives data from reader. 
        
            #puts "waiting for a card"
           
            puts tag #prints the tag ID
    	    puts tag.class #prints the tag data type
            puts tag.inspect #prints the exact data being received 
            conn.send_msg tag #sends data to the websocket server
        
    			
     end

     

    conn.disconnect do
        puts "disconnected!"
        EM::stop_event_loop
    end
end
