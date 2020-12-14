import sys
print("<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<?xml-stylesheet href=\"out.xsl\" type=\"text/xsl\"?>\n<values>")
for i in range(0, int(sys.argv[1])):
    print("<value>{}</value>".format(i))
print("</values>")
