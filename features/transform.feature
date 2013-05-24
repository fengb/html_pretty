Feature: HTML transform
  # FIXME: group single tags
  Scenario: converts simplest html block
       When the input is:
            """
            <html></html>
            """
       Then the output is:
             """
             <html></html>
             """

  Scenario: quashes beginning whitespace
       When the input is:
            """
            <html>
            	  </html>
            """
       Then the output is:
            """
            <html>
            </html>
            """

  Scenario: quashes trailing whitespace
       When the input is:
            """
            <html>      
            </html>	
            """
       Then the output is:
            """
            <html>
            </html>
            """

  Scenario: collapses whitespace within tags:
       When the input is:
            """
            <html  foo='bar'	tony='hawk'></html>
            """
       Then the output is:
            """
            <html foo='bar' tony='hawk'></html>
            """

  Scenario: quashes whitespace at the tag extremes
       When the input is:
            """
            <    html	></html   >
            """
       Then the output is:
            """
            <html></html>
            """

  Scenario: quashes blank lines
       When the input is:
            """
            <html>
                
            	
           </html>
            """
       Then the output is:
            """
            <html>
            </html>
            """

  Scenario: collapses spaces between tags
       # HTML text nodes have meanings so we shouldn't just quash them.
       When the input is:
            """
            <html> 	  </html>
            """
       Then the output is:
            """
            <html> </html>
            """

  # FIXME: group nested tags
  Scenario: indent with outstanding opening tag:
       When the input is:
            """
            <html>
            <hi>
            </hi>
            </html>
            """
       Then the output is:
            """
            <html>
              <hi>
              </hi>
            </html>
            """

  Scenario: indent with text on either side
       When the input is:
            """
            <html>
            <spam>abc
            123</spam>
            </html>
            """
       Then the output is:
            """
            <html>
              <spam>abc
              123</spam>
            </html>
            """

  Scenario: indent with multiple opening tags
       When the input is:
            """
            <html>
            <hi>
            <bye>
            </bye>
            </hi>
            </html>
            """
       Then the output is:
            """
            <html>
              <hi>
                <bye>
                </bye>
              </hi>
            </html>
            """

  Scenario: indent with multiple opening tags on one line
       When the input is:
            """
            <html><hi><bye>
            </bye>
            </hi>
            </html>
            """
       Then the output is:
            """
            <html><hi><bye>
                </bye>
              </hi>
            </html>
            """

  Scenario: do not indent further with self closing tags
       When the input is:
            """
            <html>
            <hi />
            <bye />
            </html>
            """
       Then the output is:
            """
            <html>
              <hi />
              <bye />
            </html>
            """

  Scenario: indents hrefs
       When the input is:
            """
            <a href='http://www.google.com'>
            something
            </a>
            """
       Then the output is:
            """
            <a href='http://www.google.com'>
              something
            </a>
            """

  # FIXME: group special
  Scenario: do not indent from DOCTYPE
       When the input is:
            """
            <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
              'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
                <html></html>
            """
       Then the output is:
            """
            <!DOCTYPE html PUBLIC '-//W3C//DTD XHTML 1.0 Transitional//EN'
              'http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd'>
            <html></html>
            """

  Scenario: do not indent from HTML5 DOCTYPE
       When the input is:
            """
            <!DOCTYPE html>
                <html></html>
            """
       Then the output is:
            """
            <!DOCTYPE html>
            <html></html>
            """

  Scenario: does not affect comments
       When the input is:
            """
            <!-- comment
                  <html> -->
              <html>
              </html>
            """
       Then the output is:
            """
            <!-- comment
                  <html> -->
            <html>
            </html>
            """

  Scenario: does not affect script
       When the input is:
            """
            <script type='text/javascript'>
              if(0 == 1) {
                raise 'End of the world!'
              }
            </script>
              <html>
              </html>
            """
       Then the output is:
            """
            <script type='text/javascript'>
              if(0 == 1) {
                raise 'End of the world!'
              }
            </script>
            <html>
            </html>
            """

  Scenario: does not affect style
       When the input is:
            """
            <style type='text/css'>
              html {
                position: absolute;
              }
            </style>
              <html>
              </html>
            """
       Then the output is:
            """
            <style type='text/css'>
              html {
                position: absolute;
              }
            </style>
            <html>
            </html>
            """

  # FIXME: group malformed
  Scenario: indents correctly even after descender fails
       When the input is:
            """
            <html>
            </title>
            </head>
            <body>
            <p></p>
            </body>
            </html>
            """
       Then the output is:
            """
            <html>
            </title>
            </head>
            <body>
              <p></p>
            </body>
            </html>
            """
