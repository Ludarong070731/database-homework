CREATE UNIQUE INDEX idx_part_name ON Part(name);
INSERT INTO Part (partkey, name, brand, retailprice)
VALUES (9999, '现有零件名称', '测试品牌', 100.00);
