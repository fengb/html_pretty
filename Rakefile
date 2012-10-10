require 'nokogiri'


task :compare do
  dstdir = 'compare'
  srcfile = "#{dstdir}/_orig.html"

  `bin/html_pretty #{srcfile} >#{dstdir}/html_pretty.html`
  `htmlbeautifier <#{srcfile} >#{dstdir}/htmlbeautifier.html`
  `tidy -i -q #{srcfile} >#{dstdir}/tidy.html 2>&-`
end

task :default => :compare
