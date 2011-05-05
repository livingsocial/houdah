module Houdah
  
  class Client
    attr_reader :client, :context
    def initialize(server, port, user="houdah", timeout=60)
      socket = Thrift::Socket.new(server, port)
      socket.timeout = timeout * 1000
      @transport = Thrift::BufferedTransport.new(socket)
      @transport.open
      protocol = Thrift::BinaryProtocol.new(@transport)
      @client = Hadoop::API::Jobtracker::Jobtracker::Client.new(protocol)
      @context = Hadoop::API::RequestContext.new(:confOptions => { 'effective_user' => user })
    end

    def getJobTrackerName
      call :getJobTrackerName
    end

    def getRunningJobs
      call(:getRunningJobs).jobs.map { |j| Job.new(self, j) }
    end

    def getQueues
      call :getQueues
    end

    def close
      @transport.close
    end

    def call(method, *args)
      @client.send method, @context, *args
    end
  end

end
