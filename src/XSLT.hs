module XSLT where

import Data.List
import XML

xslStylesheet :: [XMLAttribute] -> [XMLNode] -> XMLNode
xslStylesheet attributes children =
    XMLNode "xsl" "stylesheet" attributes children

xslTemplate :: String -> [XMLNode] -> XMLNode
xslTemplate match =
    XMLNode "xsl" "template" [XMLAttribute "match" (XMLString match)]  

xslOutput :: String -> XMLNode
xslOutput method =
    XMLNode "xsl" "output" [XMLAttribute "method" (XMLString method)] []

xslValueOf :: String -> XMLNode
xslValueOf select =
    XMLNode "xsl" "value-of" [XMLAttribute "select" (XMLString select)] []

xslVariable :: String -> [String] -> XMLNode
xslVariable name select =
    XMLNode "xsl" "variable" [
        XMLAttribute "name" (XMLString name),
        XMLAttribute "select"
            (XMLString (intercalate ", " $ map (\x -> "\'" ++ x ++ "\'") select))
        ] []

defaultXSLT :: [XMLAttribute] -> [XMLNode] -> XMLDocument
defaultXSLT attrib children = XMLDocument 
    (XMLHeader [
        XMLAttribute "version" (XMLString "1.0"),
        XMLAttribute "encoding" (XMLString "UTF-8")
    ])
    $ xslStylesheet (XMLAttribute "version" (XMLString "1.0") : attrib) children

extLookup :: String -> String
extLookup "xsl" = "http://www.w3.org/1999/XSL/Transform"
extLookup "math" = "http://exslt.org/math"
extLookup "dyn" = "http://exslt.org/dynamic"
extLookup "date" = "http://exslt.org/dates-and-time"
extLookup "exsl" = "http://exslt.org/common"
extLookup "regexp" = "http://exslt.org/regular-expressions"
extLookup "set" = "http://exslt.org/sets"
extLookup "str" = "http://exslt.org/strings"
extLookup "random" = "http://exslt.org/random"
extLookup "func" = "http://exslt.org/functions"

extNamespaces :: [String] -> [XMLAttribute]
extNamespaces [] = []
extNamespaces (curr:rest) = (xmlns curr $ extLookup curr) : extNamespaces rest

extensions :: [String] -> [XMLAttribute]
extensions ext = extNamespaces ext ++
    [XMLAttribute "extension-element-prefixes" (XMLString $ intercalate " " ext)]
