begin;

LOCK TABLE member; -- locks table in ACCESS EXCLUSIVE

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

-- Can you read the member table while the booking transaction is running? 
--Why?
-- No, the table cannot be read while the transaction is running.
-- This is because we locked the table with the `ACCESS EXCLUSIVE` lock mode,
-- which prevents any kind of access to the table.

--What error do you get if the transaction is still running?
-- No error is produced, the `SELECT` statement simply waits 
--for the lock to be released.

--What instruction did you use to release the lock?
-- The final instruction in the transaction (COMMIT) will release the lock. 
