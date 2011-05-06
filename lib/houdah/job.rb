require 'nokogiri'

module Houdah
  
  class Job
    STATES = [ :running, :succeeded, :failed, :prep, :killed ]

    def initialize(client, thrift_job)
      @client = client
      @thrift_job = thrift_job
    end

    ## Get the job's config XML
    def config_xml
      call :getJobConfXML
    end

    ## Get the job's config, as a Hash
    def config
      Nokogiri::XML(config_xml).xpath("//property").inject({}) { |props, xprop|
        props[xprop.xpath("./name").text] = xprop.xpath("./value").text
        props
      }
    end

    def state
      STATES[@thrift_job.status.runState - 1]
    end

    def percent_mapped
      @thrift_job.status.mapProgress
    end

    def percent_reduced
      @thrift_job.status.reduceProgress
    end

    def percent_cleaned_up
      @thrift_job.status.cleanupProgress
    end

    def percent_set_up
      @thrift_job.status.setupProgress
    end

    def percent_done
      (percent_mapped + percent_reduced) / 2.0
    end

    def method_missing(method, *args)
      @thrift_job.send method, *args
    end

    def kill!
      call :killJob
    end

    def call(method, *args)
      @client.call method, @thrift_job.jobID, *args
    end
  end

end
