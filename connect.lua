port = 8080
host = "localhost"

 int c
c = assert(socket.connect(host, 80))
c:send("GET " .. file .. " HTTP/1.0\r\n\r\n")

c:close()
