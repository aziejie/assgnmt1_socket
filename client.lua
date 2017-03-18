socket = require("socket")

host = "localhost"
port = 8080

print("Attempting connection to server '" .. host .. "' and port " .. port .. "...")

client = assert(socket.connect(host, port))

client:setoption("keepalive", true)
client:setoption("reuseaddr", true)
client:settimeout(10)

print("Connected!")

repeat
    print("Sending message request...")
    assert(client:send("arquivo" .. "\n"))

    print("Message request sent! Waiting for message...")
    data, errormsg = client:receive("*a")

    if data then
        print("Message received!")
        print(data)
    else
        print("Failed to receive message.")
        break
    end
until not client
