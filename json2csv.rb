#! /usr/bin/env ruby

require 'csv'
require 'json'

source_filename = ARGV[0] || "has_diamond_non-premanent_links_1.json"

target_filename = File.basename(source_filename, ".json") + ".csv" # => "has_diamond_non-premanent_links_1.csv"

json_doc = JSON.parse(File.open(source_filename).read)
hash_docs = json_doc["response"]["docs"]

exclude = ["description_display", "subject_topic_facet", "language_facet", "score"]

# Get all of the possible keys
keys = hash_docs.map { |hash| hash.keys }.flatten.uniq!  # => 
keys.reject! { |k| exclude.include?(k) }                 # => 

# Generate the CSV string
CSV.open(target_filename, "w", headers: true) do |csv|
  csv << keys
  JSON.parse(File.open(source_filename).read).each do |hash|
    hash_docs.each do |hash|
      csv << keys.map { |k|
        value = hash.fetch(k, "")
        value
      }
    end
  end
end

