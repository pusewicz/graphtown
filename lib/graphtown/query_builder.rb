# frozen_string_literal: true

require "graphlient"
require "active_support/concern"

module Graphtown
  module QueryBuilder
    class Queries < OpenStruct; end

    extend ActiveSupport::Concern

    class_methods do
      attr_accessor :graphql_queries

      def graphql(graph_name, &block)
        self.graphql_queries ||= Queries.new
        graphql_queries.send("#{graph_name}=", block)
      end
    end

    def queries
      return self.class.graphql_queries if @_executed_queries

      client = graphql_client
      self.class.graphql_queries.each_pair do |graph_name, block|
        graph_dsl = Graphlient::Query.new(&block)

        query_variables = if respond_to?("variables_for_#{graph_name}")
                            send("variables_for_#{graph_name}")
                          end

        self.class.graphql_queries.send(
          "#{graph_name}=",
          client.execute(graph_dsl.to_s, query_variables).data.yield_self do |data|
            # avoid having to do query.foo.foo if possible
            data.send(graph_name)
          rescue NoMethodError
            data
          end
        )
      end

      @_executed_queries = true
      self.class.graphql_queries
    end

    def graphql_client
      Graphlient::Client.new(graphql_endpoint) do |client|
        configure_graphql_client(client)
      end
    end

    # override in concrete class if need be
    def graphql_endpoint
      raise "Please add graphql_endpoint to your config file" unless config[:graphql_endpoint]

      config[:graphql_endpoint]
    end

    # override in concrete class if need be
    def configure_graphql_client(client); end
  end
end
