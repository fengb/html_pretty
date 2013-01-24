

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
    sh "ruby -Ilib bin/html_pretty #{src_file} >#{dst_file(t)}"
  end

  task :htmlbeautifier do |t|
    sh "htmlbeautifier <#{src_file} >#{dst_file(t)}"
  end

  task :tidy do |t|
    sh "tidy -i -q #{src_file} >#{dst_file(t)} 2>&1"
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

task :default => :output
