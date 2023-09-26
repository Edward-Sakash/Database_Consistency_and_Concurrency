begin;

UPDATE member
    SET balance = balance - 3 * (
        SELECT membercost FROM facility
        WHERE name = 'Tennis Court 1'
    )
    WHERE name = 'Noah Wilson';

INSERT INTO 
booking(facility_id, member_id, start_time, slots)
VALUES (
    (SELECT id FROM facility WHERE name = 'Tennis Court 1'), --null
    (SELECT id from member WHERE name = 'Alice Peters'), 
    CURRENT_TIMESTAMP,
    3
);


COMMIT;

--What does the error mean and why does it occur?
-- There is no Alice Peters, therefore we get a null value.
-- The first operation executed without an error. Did Noah get charged? Why?
-- No, all operations in a transaction must be successfull for any of them to take place.
-- No changes are committed for any operation.
