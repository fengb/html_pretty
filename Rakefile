require 'rspec/core/rake_task'

namespace :output do
  def work_dir
    'compare'
  end

  def src_file
    "#{work_dir}/_orig.html"
  end

  def src_str
    IO.read(src_file)
  end

  def dst_file(t)
    "#{work_dir}/#{t.name.rpartition(':').last}.html"
  end

  def process(task, &block)
    File.open(dst_file(task), 'w') do |outfile|
      block.call(outfile, src_str)
    end
  end

  task :html_pretty do |t|
    require 'html_pretty'
    process(t) {|outfile, instr| outfile.write HtmlPretty.run(src_str) }
  end

  task :htmlbeautifier do |t|
    require 'htmlbeautifier'
    process(t) {|outfile, instr| HtmlBeautifier::Beautifier.new(outfile).scan(instr)}
  end

  task :rexml do |t|
    require 'rexml/document'
    process(t) {|outfile, instr| REXML::Document.new(instr).write(outfile, 2)}
  end

  task :nokogiri do |t|
    require 'nokogiri'
    process(t) {|outfile, instr| outfile.write Nokogiri::XML(instr, &:noblanks).to_xhtml(indent: 2)}
  end
end
task :output => %w[output:html_pretty output:htmlbeautifier output:rexml output:nokogiri]

RSpec::Core::RakeTask.new(:spec) do |rt|
  rt.fail_on_error = false
end

task :default => :spec
