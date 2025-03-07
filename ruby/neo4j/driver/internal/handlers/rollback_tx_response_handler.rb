module Neo4j::Driver
  module Internal
    module Handlers
      class RollbackTxResponseHandler
        include Spi::ResponseHandler
        def on_success(_metadata)
        end

        def on_failure(error)
          raise error
        end

        def on_record(fields)
          raise "Transaction rollback is not expected to receive records: #{fields}"
        end
      end
    end
  end
end
