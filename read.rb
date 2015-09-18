#only reading the data from the RFID reader. This code is just to test if the reader is properly working.

require 'serialport'
#require 'thread'

rfid_tags = SerialPort.new("/dev/tty.usbserial-A90246LK", 9600)

code = ''
rfid_tags.read_timeout = 1000

while true do 
	while(i = rfid_tags.gets) do 
		puts i 
		puts i.class
	end
end

rfid_tags.close

