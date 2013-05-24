Feature: special tags
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
