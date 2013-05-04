-- Section 2a - Retrieving Data (T-SQL)
--  Structured Query Language
--  Select Statement Overview

SELECT  Id
,       DisplayName
,       Username
,       Password
,       Culture

FROM    Users

WHERE   Username = 'akirts'