require 'sinatra'
require 'json'
require 'FileUtils'

class Take5 < Sinatra::Base
	
	@@TemplateDir="./Templates/"
	@@ResultsDir="./Results/"
    
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
	
	def writeResultsFile(template,user,data)
		results = getResultsDir(template,user)
		if not Dir.exist?(results) then
			FileUtils.mkdir_p(results)
		end
		
		file = File.new("#{results}/#{Time.now.strftime("%2d-%2m-%Y-%H:%M:%S")}.json","w")
		file.write(data)
		file.close
	end
	
	def getResultsDir(template,user)
		"#{@@ResultsDir}/#{template}/#{user}"   
	end
	
	post "/submit" do
        body=request.body.read
		objBody = JSON.parse(body)
		template = objBody["data"]["template"]
		if getTemplates().include? (template) then          
			user = objBody["user"]
			pass = objBody["password"]
            
			writeResultsFile(template,user,objBody["data"])
			
			puts "User '#{user}' Password '#{pass}' submitted for #{template}" 			
			"OK".to_json
		else 
			puts "Fail template #{template}"
			"FAIL".to_json
		end
	end    
	
	get "/results/:template/:user" do |template,user|  
		content_type :json
		results = [] 
		resultsDir = getResultsDir(template,user)
	  	dir = Dir.new(resultsDir)
	   	dir.each do |item|
	   		if FileTest.file? ("#{resultsDir}/#{item}") then
   				results.push(item.split(".").first)
   			end
   		end		      
   		results.to_json
	end
	
	get "/results/:template/:user/:id" do |template,user,id|
		content_type :json
		f = File.new("#{getResultsDir(template,user)}/#{id}.json","r") 
		f.readlines.join("")	 	
	end
	
end                              
