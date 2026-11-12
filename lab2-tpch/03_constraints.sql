-- 阶段二 · 完整性约束验证与级联删除

USE TPCH;


-- 1. 主键冲突
SELECT * FROM Region WHERE regionkey = 0;

INSERT INTO Region (regionkey, name, comment) VALUES (0, 'ASIA_DUP', '重复主键测试');


-- 2. 外键冲突（插入）
SELECT * FROM Region WHERE regionkey = 999;

INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES (99, 'ATLANTIS', 999, '引用不存在的地区');


-- 3. 外键冲突（删除）
SELECT * FROM Nation WHERE regionkey = 0;

DELETE FROM Region WHERE regionkey = 0;


-- 4. 检查约束（零售价格）
INSERT INTO Part (partkey, name, mfgr, brand, type, size, container, retailprice, comment)
VALUES (1004, 'Spring', 'Factory#1', 'Brand#11', 'SMALL ANODIZED STEEL', 10, 'SM BOX', 0.00, '非法价格');


-- 5. 检查约束（可用数量）
INSERT INTO PartSupp (partkey, suppkey, availqty, supplycost, comment)
VALUES (1003, 104, -5, 20.00, '负库存测试');


-- 6. 级联删除
SHOW CREATE TABLE Nation;

ALTER TABLE Nation DROP FOREIGN KEY FK_Nation_Region;

ALTER TABLE Nation ADD CONSTRAINT FK_Nation_Region
    FOREIGN KEY (regionkey) REFERENCES Region (regionkey) ON DELETE CASCADE;

SELECT CONSTRAINT_NAME, DELETE_RULE
FROM information_schema.REFERENTIAL_CONSTRAINTS
WHERE CONSTRAINT_SCHEMA = 'TPCH' AND TABLE_NAME = 'Nation';

INSERT INTO Region (regionkey, name, comment) VALUES (9, 'TESTLAND', '级联删除演示');
INSERT INTO Nation (nationkey, name, regionkey, comment) VALUES (98, 'CASCADIA', 9, '测试地区下属国家');

SELECT * FROM Nation WHERE regionkey = 9;

DELETE FROM Region WHERE regionkey = 9;

SELECT * FROM Nation WHERE regionkey = 9;
