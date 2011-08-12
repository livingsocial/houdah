module Houdah
  
  class Tracker
    attr_reader :thrift_tracker

    def initialize(client, thrift_tracker)
      @client = client
      @thrift_tracker = thrift_tracker
    end

    def tasks
      @thrift_tracker.taskReports || []
    end
    
    def method_missing(method, *args)
      @thrift_tracker.send method, *args
    end
  end

end
