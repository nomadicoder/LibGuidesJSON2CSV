#! /usr/bin/env ruby

require 'csv'
require 'json'
require 'pry'

source_filename = ARGV[0]
target_filename = ARGV[1]

json_doc = JSON.parse(File.open(source_filename).read)
hash_docs = json_doc["response"]["docs"]

# Get all of the possible keys
keys = hash_docs.map { |hash| hash.keys }.flatten.uniq!

# Generate the CSV string
csv_string = CSV.generate(headers: true) do |csv|
  csv << keys
  JSON.parse(File.open(source_filename).read).each do |hash|
    hash_docs.each do |hash|
      csv << keys.map { |k| hash.fetch(k, "") }
    end
  end
end

puts csv_string
