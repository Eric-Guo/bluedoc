# frozen_string_literal: true

module Types
  class SearchType < GraphQL::Schema::Object
    field :total, Integer, null: false, description: "Total of this query search results."
    field :limit, Integer, null: false, description: "Number of records limit for this query."
    field :records, [SearchRecordType], null: false, description: "Search result items."
  end
end
