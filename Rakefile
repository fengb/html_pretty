require 'nokogiri'
require 'rexml/document'


task :compare do
  dstdir = 'compare'
  srcfile = "#{dstdir}/_orig.html"
  srcstr = IO.read(srcfile)

  `bin/html_pretty #{srcfile} >#{dstdir}/html_pretty.html`
  `htmlbeautifier <#{srcfile} >#{dstdir}/htmlbeautifier.html`
  `tidy -i -q #{srcfile} >#{dstdir}/tidy.html 2>&-`

  doc = Nokogiri::XML(srcstr, &:noblanks)
  File.open("#{dstdir}/nokogiri.html", 'w'){|f| f.write doc.to_xhtml(:indent => 2)}

  doc = REXML::Document.new(srcstr)
  File.open("#{dstdir}/rexml.html", 'w'){|f| doc.write f, 2}
end

task :default => :compare
