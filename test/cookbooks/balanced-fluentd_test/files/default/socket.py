import socket
import time

s = socket.socket(socket.AF_UNIX, socket.SOCK_STREAM)
s.connect("/var/run/fluentd/fluentd.sock")
s.send('["debug.bar", ' + str(int(time.time())) + ', {"foo": "bar"}]')
s.close()
