require 'patron'
require 'json'

baseURL="http://localhost:9393"

sess = Patron::Session.new()
sess.base_url = baseURL

msg = File.new("testResponse.json","r").readlines().join("")         
puts(msg)
JSON.parse(msg)

sess.post("/submit", msg, {"Content-Type" => "application/json"})