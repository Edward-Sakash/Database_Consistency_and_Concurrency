begin;

INSERT INTO 
booking(facility_id, member_id, start_time, slots)
VALUES (
    (SELECT id FROM facility WHERE name = 'Squash Court'), --7
    (SELECT id from member WHERE name = 'Noah Wilson'), -- 74
    CURRENT_TIMESTAMP,
    2
);

UPDATE member
    SET balance = balance - 2 * (
        SELECT membercost FROM facility
        WHERE name = 'Squash Court'
    )
    WHERE name = 'Noah Wilson';

COMMIT;