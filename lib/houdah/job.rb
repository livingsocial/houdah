require 'nokogiri'

module Houdah
  
  class Job
    def initialize(client, thrift_job)
      @client = client
      @thrift_job = thrift_job
    end

    def config_xml
      call :getJobConfXML
    end

    def config
      Nokogiri::XML(config_xml).xpath("//property").inject({}) { |props, xprop|
        props[xprop.xpath("./name").text] = xprop.xpath("./value").text
        props
      }
    end

    def state
      @thrift_job.status.runState
    end

    def method_missing(method, *args)
      @thrift_job.send method, *args
    end

    def call(method, *args)
      @client.call method, @thrift_job.jobID, *args
    end
  end

end
