#!/usr/bin/env ruby
# Verify source records and the generated site, using Ruby standard libraries only.
require 'yaml'
require 'cgi'
require 'uri'
require 'date'
ROOT = File.expand_path('..', __dir__)
Dir.chdir(ROOT)
def check(condition, message)
  abort "FAIL: #{message}" unless condition
end
{
  'publications' => %w[title url authors citation year group],
  'talks' => %w[title authors format event location date date_label group language]
}.each do |kind, required|
  records = YAML.load_file("_data/#{kind}.yml")
  check(records.is_a?(Array) && !records.empty?, "#{kind}: empty data")
  records.each_with_index do |record, index|
    required.each { |key| check(record.key?(key) && !record[key].to_s.strip.empty?, "#{kind} #{index + 1}: missing #{key}") }
    allowed = kind == 'publications' ? %w[lead coauthor] : %w[international domestic]
    check(allowed.include?(record['group']), "#{kind}: invalid group")
    if kind == 'publications'
      check(record['url'].start_with?('https://'), 'publication URL must use HTTPS')
      check(record['year'].is_a?(Integer), 'publication year must be an integer')
    else
      check(record['date'].is_a?(String), 'quote talk dates in YAML')
      Date.iso8601(record['date'])
      check(%w[en ja it].include?(record['language']), 'invalid talk language')
    end
  end
  puts "OK: #{records.size} #{kind} records"
end
check(File.directory?('_site'), 'Run jekyll build first')
sections = ['', 'research/', 'publications/', 'talks/', 'cv/']
%w[en ja it].each do |lang|
  sections.each do |section|
    file = lang == 'en' && section.empty? ? '_site/index.html' : "_site/#{lang}/#{section}index.html"
    check(File.file?(file), "missing #{file}")
    content = File.read(file)
    check(content.include?("<html lang=\"#{lang}\""), "wrong language: #{file}")
    check(content.scan(/<h1[ >]/).length == 1, "expected one h1: #{file}")
    check(!content.include?('{%') && !content.include?('{{'), "unrendered Liquid: #{file}")
    %w[en ja it].each do |alternate|
      alternate_path = alternate == 'en' && section.empty? ? '/' : "/#{alternate}/#{section}"
      check(content.include?("href=\"#{alternate_path}\""), "missing language switch #{alternate}: #{file}")
    end
    content.scan(/(?:href|src)="([^"]+)"/).flatten.each do |raw|
      url = CGI.unescapeHTML(raw)
      next unless url.start_with?('/') && !url.start_with?('//')
      path = URI::DEFAULT_PARSER.unescape(url.split(/[?#]/).first)
      target = "_site#{path}"
      target += 'index.html' if path.end_with?('/')
      check(File.exist?(target), "broken local link #{url} in #{file}")
    end
    if %w[publications/ talks/].include?(section)
      kind = section.delete('/')
      expected = YAML.load_file("_data/#{kind}.yml").length
      check(content.scan('data-entry ').length == expected, "lost entries in #{file}")
    end
  end
end
{'/en/' => '/', '/publications/' => '/en/publications/', '/talks/' => '/en/talks/', '/cv/' => '/en/cv/', '/research/' => '/ja/research/', '/research_en/' => '/en/research/'}.each do |old, new_path|
  path = "_site#{old}index.html"
  check(File.file?(path) && File.read(path).include?(new_path), "missing redirect #{old}")
end
home = File.read('_site/index.html')
check(!home.match?(/noindex|http-equiv="refresh"/i), 'root homepage must not be noindex or redirect')
config = YAML.load_file('_config.yml')
check(home.include?(%Q{rel="canonical" href="#{config['url']}/"}), 'root canonical must point to root')
puts 'OK: 15 localized pages, entry counts, language links, assets, legacy redirects, and indexable root'
