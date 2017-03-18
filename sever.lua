filename = "file10KB.txt"
file = assert(io.open(filename, "r"))
msg = file:read("*a")
file:close()

socket = require("socket")

host = "*"
port =  8080

print("Binding to host '" .. host .. "' and port " .. port .. "...")

server = assert(socket.bind(host, port))
server:setoption("reuseaddr", true)
ipaddress, socketport = server:getsockname()
assert(ipaddress, socketport)

print("Waiting connection from client on " .. ipaddress .. ":" .. socketport .. "...")

connection = assert(server:accept())
connection:setoption("keepalive", true)
connection:settimeout(10)

print("Connected!")

while true do
    print("Waiting for request...")
    data, errormsg = connection:receive()

    if data == "arquivo" then
        print("Proper request received, sending message...")
        assert(connection:send(msg .. "\n"))
        print("Message sent!")
    elseif not errormsg then
        print("Invalid request.")
        break
    else
        print("Error message: " .. errormsg)
        break
    end
end
