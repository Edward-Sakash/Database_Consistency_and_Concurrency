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
    (SELECT id from member WHERE name = 'Noah Wilson'), 
    CURRENT_TIMESTAMP,
    3
);


ROLLBACK;
