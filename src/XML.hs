module XML where

import Data.List

-- Core XML Types

data XMLValue = XMLString String | XMLInt Integer
    deriving (Eq)

data XMLAttribute = XMLAttribute String XMLValue
    deriving (Eq)

data XMLNode = XMLNode String String [XMLAttribute] [XMLNode]
    deriving (Eq)

data XMLHeader = XMLHeader [XMLAttribute]
    deriving (Eq)

data XMLDocument = XMLDocument XMLHeader XMLNode
    deriving (Eq)

-- Helper to 

attributes :: [XMLAttribute] -> String
attributes attrib = intercalate " " (map show attrib)

named :: String -> String -> String
named namespace name = namespace ++ ":" ++ name

instance Show XMLHeader where
    show (XMLHeader attrib) =
        "<?xml " ++ attributes attrib ++ " ?>"

instance Show XMLValue where
    show (XMLString x) = x
    show (XMLInt x) = show x

instance Show XMLAttribute where
    show (XMLAttribute key value) =
        key ++ "=\"" ++  show value ++ "\""

instance Show XMLDocument where
    show (XMLDocument header node) = show header ++ show node

instance Show XMLNode where

    show (XMLNode namespace name attributes []) =
        "<"
        ++ named namespace name ++ " "
        ++ intercalate " " (map show attributes)
        ++ "/>"

    show (XMLNode namespace name attributes children) =
        "<" ++ named namespace name ++ " "
        ++ intercalate " " (map show attributes) ++
        ">"
        ++ (concatMap show children)
        ++ "</" ++ namespace ++ ":" ++ name ++ ">"

xmlns :: String -> String -> XMLAttribute
xmlns ns value = XMLAttribute ("xmlns:" ++ ns) (XMLString value)
