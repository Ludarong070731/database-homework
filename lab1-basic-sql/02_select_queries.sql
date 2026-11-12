SELECT name,retailprice
FROM part;
SELECT name,phone
FROM customer
WHERE acctbal<10000;
SELECT *
FROM orders
ORDER BY orderdate DESC;
SELECT n.name AS 国家名称,COUNT(s.suppkey) AS 供应商数量
FROM nation n
JOIN supplier s ON n.nationkey=s.nationkey
GROUP BY n.name;
SELECT n.name
FROM Nation n
JOIN Region r ON n.regionkey = r.regionkey
WHERE r.name = 'ASIA';
