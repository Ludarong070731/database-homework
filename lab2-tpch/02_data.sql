-- TPC-H 数据库实验 · 测试数据

USE TPCH;


-- Region
INSERT INTO Region (regionkey, name, comment) VALUES
(0, 'ASIA',    '亚洲地区'),
(1, 'EUROPE',  '欧洲地区'),
(2, 'AMERICA', '美洲地区');


-- Nation
INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES
(10, 'CHINA',   0, '中国'),
(11, 'JAPAN',   0, '日本'),
(20, 'GERMANY', 1, '德国'),
(21, 'FRANCE',  1, '法国');


-- Part
INSERT INTO Part (partkey, name, mfgr, brand, type, size, container, retailprice, comment) VALUES
(1000, 'Bolt',    'Factory#1', 'Brand#11', 'STANDARD ANODIZED TIN',  12, 'SM BOX',    12.50, '标准螺栓'),
(1001, 'Gear',    'Factory#2', 'Brand#22', 'SMALL PLATED COPPER',     8, 'LG CASE',   88.00, '传动齿轮'),
(1002, 'Bearing', 'Factory#1', 'Brand#33', 'MEDIUM BURNISHED STEEL', 15, 'MED BOX',   45.30, '轴承'),
(1003, 'Shaft',   'Factory#3', 'Brand#44', 'LARGE POLISHED BRASS',    20, 'JUMBO PKG',150.00, '传动轴');


-- Supplier
INSERT INTO Supplier (suppkey, name, address, nationkey, phone, acctbal, comment) VALUES
(100, 'Beijing Steel',   'Beijing, China',      10, '86-10-1234',  5000.00, '华北钢材'),
(101, 'Shanghai Metals', 'Shanghai, China',     10, '86-21-5678',  4000.00, '华东金属'),
(102, 'Tokyo Parts',     'Tokyo, Japan',        11, '81-3-1111',   3000.00, '关东零件'),
(103, 'Rhein Metall',    'Dusseldorf, Germany', 20, '49-211-2222', 8000.00, '莱茵金属'),
(104, 'Paris Compo',     'Paris, France',       21, '33-1-3333',   2000.00, '巴黎组件');


-- PartSupp
INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost, comment) VALUES
(1000, 100, 300, 10.00,  '中国-螺栓'),
(1001, 100, 250, 70.00,  '中国-齿轮'),
(1002, 100, 100, 40.00,  '中国-轴承'),
(1001, 101, 200, 68.00,  '中国-齿轮（第二供应商）'),
(1000, 102,  50, 12.00,  '日本-螺栓'),
(1001, 102,  15, 90.00,  '日本-齿轮'),
(1001, 103, 180, 75.00,  '德国-齿轮'),
(1002, 103, 170, 41.50,  '德国-轴承'),
(1003, 103, 160, 140.00, '德国-传动轴'),
(1002, 104,   5, 39.00,  '法国-轴承');


-- Customer
INSERT INTO Customer (custkey, name, address, nationkey, phone, acctbal, mktsegment, comment) VALUES
(200, 'Li Wei',       'Beijing, China',  10, '86-10-9001',  4000.00, 'BUILDING',   '中国客户'),
(201, 'Wang Fang',    'Shanghai, China', 10, '86-21-9002',  1000.00, 'AUTOMOBILE', '中国客户'),
(202, 'Chen Jie',     'Shenzhen, China', 10, '86-755-9003', 5000.00, 'MACHINERY',  '中国客户'),
(203, 'Yuki Tanaka',  'Tokyo, Japan',    11, '81-3-9004',   2000.00, 'HOUSEHOLD',  '日本客户'),
(204, 'Hans Muller',  'Berlin, Germany', 20, '49-30-9005',  6000.00, 'BUILDING',   '德国客户'),
(205, 'Marie Dubois', 'Paris, France',   21, '33-1-9006',   1500.00, 'FURNITURE',  '法国客户'),
(206, 'Ken Sato',     'Osaka, Japan',    11, '81-6-9007',   1000.00, 'AUTOMOBILE', '日本客户'),
(207, 'Anna Schmidt', 'Munich, Germany', 20, '49-89-9008',  2000.00, 'MACHINERY',  '德国客户'),
(208, 'Luc Martin',   'Lyon, France',    21, '33-4-9009',    500.00, 'BUILDING',   '法国客户');


-- Orders
INSERT INTO Orders (orderkey, custkey, orderstatus, totalprice, orderdate, orderpriority, clerk, shippriority, comment) VALUES
(300, 200, 'O', 1200.00, '2026-01-05', '1-URGENT', 'Clerk#001', 0, '中国客户首单'),
(301, 200, 'O',  800.00, '2026-02-10', '2-HIGH',   'Clerk#001', 0, '同一顾客第二单'),
(302, 201, 'F',  300.00, '2026-02-15', '3-MEDIUM', 'Clerk#002', 0, '待付款'),
(303, 202, 'O', 2500.00, '2026-03-01', '1-URGENT', 'Clerk#002', 0, '大额订单'),
(304, 204, 'P', 5000.00, '2026-03-20', '2-HIGH',   'Clerk#003', 0, '德国客户订单');


-- Lineitem
INSERT INTO Lineitem (orderkey, partkey, suppkey, linenumber, quantity, extendedprice, discount, tax,
                      returnflag, linestatus, shipdate, commitdate, receiptdate,
                      shipinstruct, shipmode, comment) VALUES
(300, 1000, 100, 1,  5,  62.50, 0.05, 0.02, 'N', 'O', '2026-01-08', '2026-01-06', '2026-01-12', 'DELIVER IN PERSON', 'AIR',   '明细1'),
(300, 1001, 100, 2,  2, 176.00, 0.02, 0.01, 'N', 'O', '2026-01-08', '2026-01-06', '2026-01-12', 'TAKE BACK RETURN',  'TRUCK', '明细2'),
(301, 1002, 100, 1,  3, 135.90, 0.00, 0.03, 'R', 'F', '2026-02-14', '2026-02-12', '2026-02-18', 'NONE',              'SHIP',  '退货'),
(302, 1001, 101, 1,  1,  88.00, 0.10, 0.05, 'N', 'O', '2026-02-18', '2026-02-16', '2026-02-22', 'DELIVER IN PERSON', 'MAIL',  '明细'),
(303, 1002, 103, 1, 10, 453.00, 0.05, 0.08, 'N', 'O', '2026-03-05', '2026-03-03', '2026-03-09', 'COLLECT COD',       'RAIL',  '大单明细');


-- 数据校验
SELECT 'Region' AS tbl, COUNT(*) AS n FROM Region
UNION ALL SELECT 'Nation',   COUNT(*) FROM Nation
UNION ALL SELECT 'Part',     COUNT(*) FROM Part
UNION ALL SELECT 'Supplier', COUNT(*) FROM Supplier
UNION ALL SELECT 'PartSupp', COUNT(*) FROM PartSupp
UNION ALL SELECT 'Customer', COUNT(*) FROM Customer
UNION ALL SELECT 'Orders',   COUNT(*) FROM Orders
UNION ALL SELECT 'Lineitem', COUNT(*) FROM Lineitem;
