module Houdah
  
  class Client
    attr_reader :client, :context
    def initialize(server, port=9290, user="houdah", timeout=60)
      socket = Thrift::Socket.new(server, port)
      socket.timeout = timeout * 10000
      @transport = Thrift::BufferedTransport.new(socket)
      @transport.open
      protocol = Thrift::BinaryProtocol.new(@transport)
      @client = Hadoop::API::Jobtracker::Jobtracker::Client.new(protocol)
      @context = Hadoop::API::RequestContext.new(:confOptions => { 'effective_user' => user })
    end

    def name
      call :getJobTrackerName
    end

    ## Get jobs.  Type can be :running, :completed, :killed, :failed, or :all
    def jobs(type=:running)
      results = case type
      when :running then call(:getRunningJobs) 
      when :completed then call(:getCompletedJobs)
      when :failed then call(:getFailedJobs)
      when :killed then call(:getKilledJobs)
      else call(:getAllJobs)
      end
      results.jobs.map { |j| Job.new(self, j) }
    end

    def queues
      call :getQueues
    end

    def close
      @transport.close
    end

    def call(method, *args)
      @client.send method, @context, *args
    end

    def self.run(*args)
      c = Client.new *args
      result = yield c
      c.close
      result
    end
  end

end
