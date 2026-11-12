-- 阶段四 · 库存预警触发器

USE TPCH;


-- 1. 预警日志表
DROP TABLE IF EXISTS StockAlert_Log;

CREATE TABLE StockAlert_Log (
    alert_id   INT       NOT NULL AUTO_INCREMENT,
    partkey    INT       NOT NULL,
    suppkey    INT       NOT NULL,
    alert_time TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT PK_StockAlert_Log PRIMARY KEY (alert_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;


-- 2. 触发器
DROP TRIGGER IF EXISTS trg_partsupp_lowstock;

DELIMITER $$

CREATE TRIGGER trg_partsupp_lowstock
AFTER UPDATE ON PartSupp
FOR EACH ROW
BEGIN
    IF NEW.availqty < 10 AND OLD.availqty >= 10 THEN
        INSERT INTO StockAlert_Log (partkey, suppkey)
        VALUES (NEW.partkey, NEW.suppkey);
    END IF;
END$$

DELIMITER ;


-- 3. 测试
SELECT COUNT(*) AS log_cnt_before FROM StockAlert_Log;

SELECT * FROM PartSupp WHERE availqty IN (50, 15);

UPDATE PartSupp SET availqty = 5 WHERE partkey = 1000 AND suppkey = 102;
SELECT * FROM StockAlert_Log;

UPDATE PartSupp SET availqty = 12 WHERE partkey = 1001 AND suppkey = 102;
SELECT * FROM StockAlert_Log;

UPDATE PartSupp SET availqty = 3 WHERE partkey = 1002 AND suppkey = 104;
SELECT * FROM StockAlert_Log;
