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


--COMMIT;
--- What is the observed difference between this case and the one on task 6? 
--and why do you think that happens?

-- ALTER TABLE member ADD city text; wants
-- to add an ACCESS EXCLUSIVE LOCK on my
-- members table
-- this conflicts with all other LOCKS 
