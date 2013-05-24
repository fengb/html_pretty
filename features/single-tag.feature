Feature: single tags
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
