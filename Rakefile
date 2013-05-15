require 'rspec/core/rake_task'

namespace :output do
  def src_str
    @src_str ||= IO.read("compare/_orig.html")
  end

  def outtask(taskname, options={}, &block)
    desc "Output #{taskname}"
    task taskname do
      require options.delete(:require) || taskname.to_s
      File.open("compare/#{taskname}.html", 'w') do |outfile|
        block.call(outfile, src_str)
      end
    end
  end

  outtask :html_pretty do |outfile, instr|
    outfile.write HtmlPretty.run(src_str)
  end

  outtask :htmlbeautifier do |outfile, instr|
    HtmlBeautifier::Beautifier.new(outfile).scan(instr)
  end

  outtask :rexml, require: 'rexml/document' do |outfile, instr|
    REXML::Document.new(instr).write(outfile, 2)
  end

  outtask :nokogiri do |outfile, instr|
    outfile.write Nokogiri::XML(instr, &:noblanks).to_xhtml(indent: 2)
  end
end
task :output => %w[output:html_pretty output:htmlbeautifier output:rexml output:nokogiri]

RSpec::Core::RakeTask.new(:spec) do |rt|
  rt.fail_on_error = false
end

task :default => :spec
