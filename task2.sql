begin;

INSERT INTO 
booking(facility_id, member_id, start_time, slots)
VALUES (
    (SELECT id FROM facility WHERE name = 'Tennis Court'), --null
    (SELECT id from member WHERE name = 'Mia Ali'), 
    CURRENT_TIMESTAMP,
    3
);

UPDATE member
    SET balance = balance - 3 * (
        SELECT membercost FROM facility
        WHERE name = 'Tennis Court'
    )
    WHERE name = 'Mia Ali';

COMMIT;

--What does the error mean and why does it occur?
-- ERROR:  null value in column "facility_id" violates not-null constraint
-- SELECT id FROM facility WHERE name = 'Tennis Court' gives us NULL
-- because there is no Tennis Court in the facility table
-- NULL values are not allowed and therefore, we can't insert a row with a null value
--for facility id

-- What property of ACID transactions is involved in the error description?
-- The error is raised to prevent reducing the consistency of the data.
-- Consistency ensures that the data after the changes still comply with
-- the constraints.
-- Atomicity ensures that none of the involved queries are executed due to the
-- error.  