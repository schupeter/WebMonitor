@identifier = "WPS"
@xurl = "http://flexigeoweb.lat-lon.de/deegree-wps-demo/services?SERVICE=WPS&REQUEST=GetCapabilities&VERSION=1.0.0"
require "#{RAILS_ROOT}/app/helpers/libxml-helper"
require "open-uri"
@XML = open(@xurl).read().to_libxml_doc.root
# register contents
require "xrs#{@identifier}"
		@resource = eval("XRS_" + @identifier).register(@xurl,@XML)

for operation in @XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation") do
	if operation.search("@name")[0].content == "DescribeProcess" then
		# conditions needed for strange behaviour of some XML
		if operation.search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].class.to_s == "XML::Node" then
			describeProcessURLroot = operation.text_at("ows:DCP/ows:HTTP/ows:Get/@xlink:href").split("?")[0]
		elsif operation.search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].class.to_s == "XML::Attr" then
			describeProcessURLroot = operation.search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].to_s.split("?")[0].split(" ")[2]
		else
			describeProcessURLroot = @xurl.split("?")[0]
		end
			describeProcessURL = describeProcessURLroot + "?Request=DescribeProcess&Service=WPS&Version=1.0.0"
	end
end

@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[0].search("@name")[0]

for operation in @XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation") do
puts operation.search("@name")[0].content
end

for operation in @XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation") do
if operation.search("@name")[0].content == "DescribeProcess" then
puts operation.search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].content.split("?")[0] 
end
end


@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[0].search("@name")
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[1].search("@name")
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[2].search("@name")
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[0].search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[1].search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[2].search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")

@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[0].search("@name")[0].class
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[1].search("@name")[0].class
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[2].search("@name")[0].class
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[0].search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].class
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[1].search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].class
@XML.search("//wps:Capabilities/ows:OperationsMetadata/ows:Operation")[2].search("ows:DCP/ows:HTTP/ows:Get/@xlink:href")[0].class
