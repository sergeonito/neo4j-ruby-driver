# frozen_string_literal: true

module DriverHelper
  module Helper
    mattr_accessor :single_driver

    def uri
      "bolt://#{ENV.fetch('TEST_NEO4J_HOST', '127.0.0.1')}:#{ENV.fetch('TEST_NEO4J_PORT', 7687)}"
    end

    def port
      uri.split(':').last
    end

    def basic_auth_token
      Neo4j::Driver::AuthTokens.basic(neo4j_user, neo4j_password)
    end

    def neo4j_user
      ENV.fetch('TEST_NEO4J_USER', 'neo4j')
    end

    def neo4j_password
      ENV.fetch('TEST_NEO4J_PASS', 'pass')
    end

    def driver
      self.single_driver ||= Neo4j::Driver::GraphDatabase.driver(
        uri, basic_auth_token,
        max_transaction_retry_time: 2,
        connection_timeout: 3
      # logger: ActiveSupport::Logger.new(IO::NULL, level: ::Logger::DEBUG)
      # logger: ActiveSupport::Logger.new(STDOUT, level: ::Logger::DEBUG)
      )
      # @@driver ||= Neo4j::Driver::GraphDatabase.driver(uri, Neo4j::Driver::AuthTokens.none)
    end

    def version?(requirement)
      Gem::Requirement.create(requirement).satisfied_by?(Gem::Version.new(ENV['NEO4J_VERSION']))
    end

    def not_version?(requirement)
      !version?(requirement)
    end
  end
end
