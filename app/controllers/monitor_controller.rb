class MonitorController < ApplicationController

# LOOK AT WEBTEST in geoprocessing

	def ListAll
		require "open-uri"
		@urlArray = Url.find(:all)
		render :action => 'monitor/ListAll_response', :layout => false and return and exit 1
	end
	
	def TestAll
		require "open-uri"
		@urlArray = Url.find(:all)
		for resource in @urlArray do
			referenceSnapshot = File.open("#{RAILS_ROOT}/public/snapshots/#{resource.id}.txt","r").read
			begin
				newSnapshot = open(resource.url).read()
			rescue OpenURI::HTTPError #=> e
				resource.status = "Error"
				resource.save
				next
			rescue SocketError
				resource.status = "Error"
				resource.save
				next
			end
			if referenceSnapshot == newSnapshot then
				resource.status = "OK"
			else
				resource.status = "Failed"
			end
			resource.save
		end
		render :action => 'monitor/TestAll_response', :layout => false and return and exit 1
	end

	def Register
		# standardize request parameters
    params.each do |key, value|
      case key.upcase        # clean up letter case in request parameters
        when "URL"
          @url = value
      end # case
    end # params
		# find out if the URL has been registered already
		oldResources = Url.find(:all, :conditions => {:url => @url})
		if oldResources.size == 0 then
			# add the new resource to the database
			newResource = Url.new
			newResource.url = @url
			newResource.status = "NotYet"
			newResource.save
			snapshotFileName = "#{RAILS_ROOT}/public/snapshots/#{newResource.id}.txt"
		elsif oldResources.size == 1 then
			# determine existing resource filename
			snapshotFileName = "#{RAILS_ROOT}/public/snapshots/#{oldResources[0].id}.txt"
		else
			render :action => 'monitor/Error_response', :layout => false and return and exit 1
		end
		# write url response to disk
		require "open-uri"
		snapshot = File.open(snapshotFileName,"w")
		snapshot << open(@url).read()
		snapshot.close
		# return response
		render :action => 'monitor/Register_response', :layout => false and return and exit 1
	end

end