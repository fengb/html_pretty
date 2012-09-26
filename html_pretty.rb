module HtmlPretty
  # Really bad assumption heavy tidy...
  # Self rolled because other versions have weird errors
  def self.fake_tidy(html)
    html = html.gsub(/\n+/, "\n")       # kill blank lines
    html = html.gsub(/^\s+/, '')        # kill opening whitespace
    html = html.gsub(/\s+$/, '')        # kill closing whitespace
    html = html.gsub(/[ \t]+/, ' ')     # collapse all whitespace
    html = html.gsub(/<[ \t]+/, '<')    # remove whitespace between brackets
    html = html.gsub(/[ \t]+>/, '>')    # remove whitespace between brackets

    indent = 0
    html.map do |line|
      if line.start_with?('<!') || line =~ /<html.*ie/
        line                            # Comments should have no alignment
      elsif line.start_with?('</')
        indent -= 1
        "  " * indent + line
      elsif line.end_with?("/>\n") ||   # <self-close />
            line =~ /<\/[^>]*>/ ||      # <tail>end</tail>
            line !~ /</                 # simple line
        "  " * indent + line
      else
        indent += 1
        val = "  " * (indent - 1) + line
      end
    end.join
  end
end
