## RFID with the Internet of Things  (IoT) 

The concept here is to glow a Led on an Arduino or any MCU with the help of an authorized RFID tag from anywhere (IoT). 

The server is an eventmachine websocket server written in Ruby. Run the server from any machine.

```
ruby server.rb

```

The client.rb file is to receive the data from a RFID reader and to send it to the server. The client is connected to the server in the same network connection.

```
ruby client.rb

```

The client1.rb file receives the message in terms of RFID tag ID and checks for an authentication and sends it to the arduino or any MCU to do certain tasks. (Here it sends 'b').

```
ruby client1.rb

```
The arduino code for glowing a Led when 'b' is received serailly is in the ```arduino``` folder.
The three softwares above can be run in different machines. The connectivity is through a webscocket server.

Tasted in both Raspberry Pi and Mac.

server - Mac or a Raspberry Pi
client - on a Raspberry Pi
client1 - on another Raspberry Pi

Made with :heart: by [@tworitdash](http://github.com/tworitdash/).  

