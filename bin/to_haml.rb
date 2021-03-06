#!/usr/bin/env ruby
class ToHaml
  def initialize(path)
    @path = path
  end

  def convert!
    Dir["#{@path}/**/*.erb"].each do |file|
      puts "converting #{file}..."
      `html2haml -rx #{file} #{file.gsub(/\.erb$/, '.haml')}`
    end
  end
end

path = File.join(File.dirname(__FILE__), '..', 'app', 'views')
# path = Rails.root.join('app', 'views')
ToHaml.new(path).convert!

