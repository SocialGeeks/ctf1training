-- Section 3b - Conditional Logic
--  Boolean Logic
--  Boolean Operators
--  Columns And Constants

SELECT  * FROM    Users

WHERE   ID > 10
AND     (
                Culture = 'en-ZW'
            OR  Culture = 'en-US'
        )
