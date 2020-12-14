module Main where

import XSLT

main :: IO ()
main = print $
    defaultXSLT (extensions ["xsl", "exsl", "math"]) [
        xslOutput "text",
        xslTemplate "values" [
            xslValueOf "math:max(value)"
        ]
    ]
