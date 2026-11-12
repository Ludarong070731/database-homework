# 数据库作业 · TPC-H SQL 实验代码

《数据库原理与应用》课程作业的 SQL 代码归档。全部实验基于 TPC-H 标准模式（8 张表：`Region`、`Nation`、`Part`、`Supplier`、`PartSupp`、`Customer`、`Orders`、`Lineitem`），在 MySQL 8.0 上完成。

- 学号：25345079
- 姓名：路达容
- 数据库环境：MySQL 8.0.45，字符集 `utf8mb4`，存储引擎 `InnoDB`
- 数据库名：`TPCH`

## 目录结构

```
.
├── lab1-basic-sql/       # 实验一：基础 SQL 操作
└── lab2-tpch/            # 实验二：TPC-H 数据库构建、完整性验证与复杂查询
```

## 实验一：基础 SQL 操作

按作业题目逐题命名的 8 个脚本，覆盖数据插入、单表查询、分组统计、多表连接、嵌套子查询、唯一索引与权限授予。

| 文件 | 内容 |
| --- | --- |
| `01_insert_region_nation.sql` | 向 `Region`、`Nation` 插入一条测试记录（regionkey 3 / nationkey 22） |
| `02_select_queries.sql` | 5 条查询：零件名称与零售价、余额低于 10000 的顾客、订单按日期倒序、按国家统计供应商数量、`Nation` 与 `Region` 连接筛选亚洲国家 |
| `03_select_queries_results_view.sql` | 与 `02` 相同的查询语句，用于配套结果视图/截图 |
| `04_nested_subquery_part.sql` | 三层嵌套子查询：找出亚洲地区供应商所供应零件的名称 |
| `05_part_index_insert.sql` | 在 `Part(name)` 上建唯一索引，并尝试插入同名列的零件记录 |
| `06_grant_user.sql` | 将 `customer_employee` 角色授予用户 `'mike'@'%'` |
| `07_supplier_insert.sql` | 向 `Supplier` 插入两条记录，用于演示主键冲突与外键校验 |
| `08_supplier_create_table.sql` | 同一张 `Supplier` 表的两种建表写法（列级主键 vs 表级 `PRIMARY KEY`） |

## 实验二：TPC-H 数据库构建、完整性验证与复杂查询

按实验阶段顺序编号，需依次执行；`03`～`05` 依赖 `01`、`02` 建好的库表与数据。

| 文件 | 阶段 | 内容 |
| --- | --- | --- |
| `01_ddl.sql` | 建库建表 | 创建 `TPCH` 库与 8 张表；全部主外键与检查约束显式命名（`PK_*`、`FK_*`、`CK_*`），并按依赖关系拓扑排序建表；末尾用 `information_schema` 自检表结构、引擎与约束 |
| `02_data.sql` | 测试数据 | 按建表顺序插入 Region→Nation→Part→Supplier→PartSupp→Customer→Orders→Lineitem 共 45 行数据，末尾用 `UNION ALL` 汇总各表行数（3/4/4/5/10/9/5/5） |
| `03_constraints.sql` | 约束验证 | 6 组实验：主键冲突、外键插入冲突、外键删除冲突、`CK_Part_Price` 与 `CK_PartSupp_AvailQty` 检查约束违反，以及 `DROP FOREIGN KEY` + `ADD CONSTRAINT ... ON DELETE CASCADE` 重建外键后的级联删除演示 |
| `04_queries.sql` | 复杂查询 | 任务 5：按国家 `COUNT(DISTINCT)` + `SUM` + `AVG` 聚合并用 `HAVING` 过滤；任务 6：关联子查询，找出余额高于本国平均余额的顾客；加分题：`NOT EXISTS` 找出从未下单的顾客 |
| `05_trigger.sql` | 触发器 | 建库存预警日志表 `StockAlert_Log`，创建 `AFTER UPDATE` 触发器 `trg_partsupp_lowstock`：库存从 ≥10 降到 <10 时写入预警日志；含三段 `UPDATE` 测试用例（触发 / 不触发 / 再次触发） |

## 运行方式

```bash
# 实验二：在 MySQL 客户端中按编号顺序执行
mysql -u root -p < lab2-tpch/01_ddl.sql
mysql -u root -p < lab2-tpch/02_data.sql
mysql -u root -p < lab2-tpch/03_constraints.sql
mysql -u root -p < lab2-tpch/04_queries.sql
mysql -u root -p < lab2-tpch/05_trigger.sql
```

`lab2-tpch/05_trigger.sql` 使用了 `DELIMITER`，若在 Navicat 等图形客户端中执行，请整段运行该文件而不要单条选中。

实验一的脚本为分散的题目片段，依赖先建好 TPC-H 库表（可直接复用 `lab2-tpch/01_ddl.sql` 与 `02_data.sql`），按文件编号逐条执行即可；其中 `05`、`06`、`07`、`08` 本身是演示性/对照性语句，部分会按预期报错（主键或唯一索引冲突、外键不存在、重复建表等），属于作业要求观察的现象。

## 说明

- 代码为作业原始提交版本，保留了用于观察报错的对照语句，未作清理。
- 实验报告（Word 文档）不在本仓库内，仓库仅归档代码部分。
