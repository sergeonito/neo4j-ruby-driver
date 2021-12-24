# frozen_string_literal: true

module Neo4j::Driver::Internal::Summary
  class InternalDatabaseInfo < Struct.new(:name)
    DEFAULT_DATABASE_INFO = InternalDatabaseInfo.new(nil)
  end
end
