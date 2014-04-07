#!/usr/bin/env ruby

require 'json'
require 'sinatra'

versions = [
  'latest'
]

def create_route(path, value)
  puts "Creating route #{path}"
  if value.class == String
    get path do 
      value
    end
  elsif value.class == Hash
    create_route("#{path}", "")
    create_route("#{path}/", value.keys.join("\n"))
    value.each do |k, v|
      create_route("#{path}/#{k}", v)
    end
  end
end

md = JSON.parse(File.read('fim.json'))
versions.each do |version|
  create_route("/#{version}/meta-data", md)
end
