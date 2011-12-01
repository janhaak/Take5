require 'sinatra'
require 'json'
require 'fileutils'
require 'mongo'


class Take5 < Sinatra::Base
    
	configure :development do    
		puts "Connecting to dev mongo..."
		@@conn = Mongo::Connection.new()
		@@db = @@conn["take5"]
		@@resultsCol= @@db["results"]
	end
	
	configure :production do
		puts "TODO - Load production mongo"
		@@conn = Mongo::Connection.new("ec2-174-129-188-30.compute-1.amazonaws.com")
		@@db = @@conn["take5"]
		@@db.authenticate("testprod","testpassword")
		@@resultsCol = @@db["results"]
	end
	
	@@TemplateDir="./Templates/"
    
	#
	# Templates
	#
	
	def getTemplates       
		templates = []
		dir = Dir.new(@@TemplateDir)
		dir.each do |item|
			if FileTest.file? ("#{@@TemplateDir}#{item}") then
				templates.push(item.split(".").first)
			end
		end		      
		templates
	end
	
	get "/templates/" do
		content_type :json
        templates = {:templates => getTemplates()}
		templates.to_json()
	end
	
	get "/template/:id" do |id|
		content_type :json
		template = File.new("#{@@TemplateDir}#{id}.json","r")
		contents = template.readlines().join("")
		
		# TODO - Remove this. Just to make sure we cop an exception for
		# invalid templates.
		JSON.parse(contents)
		
		contents
	end
    
	# 
	# Results
	#    
	
	def writeResults(data)     
		puts "Inserting data!"
		@@resultsCol.insert(data)
	end
	
	post "/submit" do
        body=request.body.read
		objBody = JSON.parse(body)
		template = objBody["template"]
		if getTemplates().include? (template) then          
			user = objBody["user"]
			pass = objBody["password"]
            writeResults(objBody)			
			puts "User '#{user}' Password '#{pass}' submitted for #{template}" 			
			"OK".to_json
		else 
			puts "Fail template #{template}"
			"FAIL".to_json
		end
	end    
	
	get "/results/:template/:user" do |template,user|  
		content_type :json
		@@resultsCol.find({:template => template, :user => user}).to_a.to_json
	end
	
	#get "/results/:template/:user/:id" do |template,user,id|
	#	content_type :json
	#	f = File.new("#{getResultsDir(template,user)}/#{id}.json","r") 
	#	f.readlines.join("")	 	
	#end
	
end                              
