begin;

UPDATE member
    SET balance = balance - 3 * (
        SELECT membercost FROM facility
        WHERE name = 'Tennis Court 1'
    )
    WHERE name = 'Noah Wilson';

SELECT pg_sleep(5);   

INSERT INTO 
booking(facility_id, member_id, start_time, slots)
VALUES (
    (SELECT id FROM facility WHERE name = 'Tennis Court 1'), --null
    (SELECT id from member WHERE name = 'Noah Wilson'), 
    CURRENT_TIMESTAMP,
    3
);


COMMIT;

-- Can you read the member table while the booking transaction is running? Why?
-- Yes, the tables used in a transaction that involves `UPDATE`, `INSERT` or `DELETE`
-- can still be accessed for reading.
-- This is because the DML commands use the `ROW EXCLUSIVE` lock mode, which does not
 -- conflict with the lock mode used by `SELECT` commands: `ACCESS SHARE`.

 -- When does the SELECT query see the changes from the transaction? 
 --Why? Explain it in terms of which ACID properties are playing a role on this.

 -- The `SELECT` statement does not see the data until the other transaction has ended.
-- This is because the database is ACID compliant and the transactions are, among other
-- things, atomic (they execute as a whole or don't execute) and
-- isolated (a transaction
 -- does not interfere with another).
