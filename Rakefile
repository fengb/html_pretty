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

  task :html_pretty do |t|
    require 'html_pretty'
    str = HtmlPretty.run(src_str)
    File.open(dst_file(t), 'w'){|f| f.write str}
  end

  task :htmlbeautifier do |t|
    require 'htmlbeautifier'
    File.open(dst_file(t), "w"){|f| HtmlBeautifier::Beautifier.new(f).scan(src_str)}
  end

  task :rexml do |t|
    require 'rexml/document'
    doc = REXML::Document.new(src_str)
    File.open(dst_file(t), 'w'){|f| doc.write f, 2}
  end

  task :nokogiri do |t|
    require 'nokogiri'
    doc = Nokogiri::XML(src_str, &:noblanks)
    File.open(dst_file(t), 'w'){|f| f.write doc.to_xhtml(:indent => 2)}
  end
end
task :output => 'output:html_pretty'

RSpec::Core::RakeTask.new(:spec) do |rt|
  rt.fail_on_error = false
end

task :default => :spec
