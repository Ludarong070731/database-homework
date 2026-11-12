SELECT name
FROM part
WHERE partkey IN (
    SELECT partkey
    FROM partsupp
    WHERE suppkey IN (
        SELECT s.suppkey
        FROM supplier s
        JOIN nation n ON s.nationkey = n.nationkey
        JOIN region r ON n.regionkey = r.regionkey
        WHERE r.name = 'ASIA'
    )
);
