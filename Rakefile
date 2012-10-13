require 'rexml/document'


task :compare do
  dstdir = 'compare'
  srcfile = "#{dstdir}/_orig.html"
  srcstr = IO.read(srcfile)

  `ruby -Ilib bin/html_pretty #{srcfile} >#{dstdir}/html_pretty.html`
  `htmlbeautifier <#{srcfile} >#{dstdir}/htmlbeautifier.html`
  `tidy -i -q #{srcfile} >#{dstdir}/tidy.html 2>&-`

  begin
    require 'nokogiri'
    doc = Nokogiri::XML(srcstr, &:noblanks)
    File.open("#{dstdir}/nokogiri.html", 'w'){|f| f.write doc.to_xhtml(:indent => 2)}
  rescue LoadError => e
    $stderr.puts '-- nokogiri not found -- skipping'
  end

  doc = REXML::Document.new(srcstr)
  File.open("#{dstdir}/rexml.html", 'w'){|f| doc.write f, 2}
end

task :default => :compare
