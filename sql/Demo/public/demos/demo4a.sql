-- Section 4a - Functions
--  What are functions?
--  Useful Functions

SELECT  COUNT(*) "English Users"

FROM    Users

WHERE   substring(Culture, 1, 2) = 'en'
