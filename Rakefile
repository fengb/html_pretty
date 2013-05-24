namespace :compare do
  def src_str
    @src_str ||= IO.read("compare/_orig.html")
  end

  def comptask(taskname, options={}, &block)
    desc "Output comparison for #{taskname}"
    task taskname do
      require options.delete(:require) || taskname.to_s
      File.open("compare/#{taskname}.html", 'w') do |outfile|
        block.call(outfile, src_str)
      end
    end
  end

  comptask :html_pretty do |outfile, instr|
    outfile.write HtmlPretty.run(src_str)
  end

  comptask :htmlbeautifier do |outfile, instr|
    HtmlBeautifier::Beautifier.new(outfile).scan(instr)
  end

  comptask :rexml, :require => 'rexml/document' do |outfile, instr|
    REXML::Document.new(instr).write(outfile, 2)
  end

  comptask :nokogiri do |outfile, instr|
    outfile.write Nokogiri::XML(instr, &:noblanks).to_xhtml(:indent => 2)
  end
end
desc "Output all comparisons"
task :compare => %w[compare:html_pretty compare:htmlbeautifier compare:rexml compare:nokogiri]

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |rt|
  rt.fail_on_error = false
end

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features) do |t|
  t.cucumber_opts = "features --format progress"
end

task :default => [:spec, :features]
