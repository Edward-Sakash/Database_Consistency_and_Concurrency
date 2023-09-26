begin;

UPDATE member
    SET balance = balance - 1 * (
        SELECT membercost FROM facility
        WHERE name = 'Massage Room 1'
    )
    WHERE name = 'Ella Lee';

INSERT INTO 
booking(facility_id, member_id, start_time, slots)
VALUES (
    (SELECT id FROM facility WHERE name = 'Tennis Court 1'), --null
    (SELECT id from member WHERE name = 'Ella Lee'), 
    CURRENT_TIMESTAMP,
    1
);

Savepoint reward;

UPDATE member
    SET balance = balance + 0.5
    WHERE id = (
        SELECT recommended_by FROM member
        WHERE name = 'Ella Lee'
    );


ROLLBACK to reward;

commit;
