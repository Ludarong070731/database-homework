-- 阶段三 · 复杂查询

USE TPCH;


-- 任务 5：按供应商所在国家统计
SELECT n.name                       AS nation,
       COUNT(DISTINCT s.suppkey)    AS supplier_cnt,
       COUNT(DISTINCT ps.partkey)   AS part_kind_cnt,
       SUM(ps.availqty)             AS total_availqty,
       ROUND(AVG(ps.supplycost), 2) AS avg_cost
FROM Supplier  s
JOIN Nation    n  ON n.nationkey = s.nationkey
JOIN PartSupp  ps ON ps.suppkey  = s.suppkey
GROUP BY n.nationkey, n.name
HAVING SUM(ps.availqty) > 500
ORDER BY total_availqty DESC;


-- 任务 6：余额高于所在国家平均余额的顾客
SELECT c.name    AS customer,
       n.name    AS nation,
       c.acctbal AS acctbal
FROM Customer c
JOIN Nation   n ON n.nationkey = c.nationkey
WHERE c.acctbal > (
        SELECT AVG(c2.acctbal)
        FROM Customer c2
        WHERE c2.nationkey = c.nationkey
      )
ORDER BY n.name, c.acctbal DESC;


-- 加分题：从未下过订单的顾客
SELECT c.custkey AS custkey,
       c.name    AS customer,
       n.name    AS nation
FROM Customer c
JOIN Nation   n ON n.nationkey = c.nationkey
WHERE NOT EXISTS (
        SELECT 1 FROM Orders o WHERE o.custkey = c.custkey
      )
ORDER BY c.custkey;
