---
title: "Database testing in 2026: what to check, SQL queries for testers and tools"
description: "A guide to database testing: data integrity and correctness, schema migrations, stored procedures, query performance, security, test data without personal data and data quality in warehouses. Ready-made SQL checks, tSQLt, pgTAP, Testcontainers, Flyway, Liquibase, dbt and a learning plan."
date: "2026-11-04"
updated: "2026-11-04"
---

# Database testing: what to check and with what

Users see the interface, but everything valuable lives in the database: orders, payments, profiles, history. A button can say "Saved" while the table gets a wrong amount, a duplicate or an orphan row with no parent. A migration can run in a second on the test server and lock a production table for half an hour. And a query that flew on a hundred rows can fall over on a million.

Database testing checks exactly that: is data written and stored correctly, are the relationships intact, do schema changes roll out safely, are queries fast, and is personal data protected from leaks.

> **In short.** A tester doesn't have to be a DBA, but SQL at the level of SELECT, JOIN and GROUP BY is a must. Check the data after every important action in the app, test migrations on a copy of realistic data, look at execution plans of slow queries, and never copy a production database into a test environment without masking personal data. We checked tool features and terms against official websites on 4 November 2026.

## Quick pick

| Task | Start with | Alternatives |
|---|---|---|
| Browse data and run SQL | [DBeaver](product:DBeaver) | [DataGrip](product:DataGrip), [pgAdmin](product:pgAdmin) (PostgreSQL) |
| Unit tests inside the database | [pgTAP](product:pgTAP) (PostgreSQL) | [tSQLt](product:tSQLt) (SQL Server), [utPLSQL](product:utPLSQL) (Oracle) |
| Integration tests with a real database | [Testcontainers](product:Testcontainers) | [DbUnit](product:DbUnit) (Java), [Neon](product:Neon) (database branches) |
| Test data | [Faker.js](product:Faker.js) | [Mockaroo](product:Mockaroo) |
| Schema migrations | [Flyway](product:Flyway) | [Liquibase](product:Liquibase), [Atlas](product:Atlas) |
| Risky change checks and SQL review | [Squawk](product:Squawk) (PostgreSQL) | [Atlas](product:Atlas), [Bytebase](product:Bytebase), [SQLFluff](product:SQLFluff) |
| Slow queries | [explain.dalibo.com](product:explain.dalibo.com) | [pgMustard](product:pgMustard), [pgBadger](product:pgBadger) |
| Database load | [HammerDB](product:HammerDB) | [sysbench](product:sysbench), [Apache JMeter](product:Apache JMeter), [Grafana k6](product:Grafana k6) |
| Masking personal data | [Greenmask](product:Greenmask) | [PostgreSQL Anonymizer](product:PostgreSQL Anonymizer) |
| Data quality in warehouses and ETL | [dbt](product:dbt) | [Great Expectations](product:Great Expectations), [Soda](product:Soda), [Datafold](product:Datafold) |
| SQL injection | [sqlmap](product:sqlmap) | — |
| Share an example in a bug report | [DB Fiddle](product:DB Fiddle) | — |

## What to test

| Area | What we check | Example defect |
|---|---|---|
| **Structure (schema)** | Tables, columns, types, lengths, defaults, indexes | A 20-character surname field truncates double-barrelled names |
| **Data integrity** | Primary and foreign keys, UNIQUE, NOT NULL, CHECK | A customer was deleted but their orders stayed behind as orphans |
| **Data correctness** | The app action wrote exactly what it should | A discount applied twice; the amount in the DB is lower than on screen |
| **Logic in the DB** | Stored procedures, functions, triggers, views | An audit trigger doesn't fire on bulk updates |
| **Transactions and concurrency** | Atomicity, isolation, locks, deadlocks | Two simultaneous orders sold the last item twice |
| **Migrations** | Apply, rollback, duration, compatibility with old code | A migration locked the orders table for 20 minutes |
| **Performance** | Query plans, indexes, behaviour at large volumes | A report page takes a minute because of a missing index |
| **Security** | SQL injection, role permissions, encryption, masking | The app account has DROP TABLE privileges |
| **Backups** | Backups are created and the database actually restores from them | Backups "existed" but restore fails halfway |
| **Data quality** | Completeness, uniqueness, freshness, consistency in a warehouse | Yesterday's sales report is empty because ETL silently failed |

## SQL checks worth knowing by heart

These queries catch most data problems. Table names are illustrative; the syntax is standard and works in PostgreSQL and MySQL.

**Orphans: child rows without a parent.**

```sql
SELECT o.id, o.customer_id
FROM orders o
LEFT JOIN customers c ON c.id = o.customer_id
WHERE c.id IS NULL;
```

**Duplicates where there shouldn't be any.**

```sql
SELECT email, COUNT(*) AS cnt
FROM users
GROUP BY email
HAVING COUNT(*) > 1;
```

**Empty values in fields that are required by the business.**

```sql
SELECT COUNT(*) AS total,
       SUM(CASE WHEN phone IS NULL OR phone = '' THEN 1 ELSE 0 END) AS no_phone
FROM customers;
```

**Consistent totals: order header vs. line items.**

```sql
SELECT o.id, o.total, SUM(i.price * i.qty) AS items_total
FROM orders o
JOIN order_items i ON i.order_id = o.id
GROUP BY o.id, o.total
HAVING o.total <> SUM(i.price * i.qty);
```

**Impossible values: negative stock, future dates, unknown statuses.**

```sql
SELECT id, stock FROM products WHERE stock < 0;
SELECT id, created_at FROM orders WHERE created_at > CURRENT_TIMESTAMP;
SELECT DISTINCT status FROM orders;
```

**What an app action changed.** Before the test, note `MAX(id)` or the time, perform the action in the UI and look at new and changed rows:

```sql
SELECT * FROM orders WHERE id > 15230 ORDER BY id;
SELECT * FROM audit_log WHERE created_at >= '2026-11-04 10:15:00' ORDER BY created_at;
```

These queries are easy to turn into automated checks: the test fails if the query returns at least one row.

## Manual database testing

Manual work needs a good client. [DBeaver](product:DBeaver) Community is free and connects to almost any database, JetBrains [DataGrip](product:DataGrip) is free for non-commercial use and understands SQL very well, and [pgAdmin](product:pgAdmin) is the official PostgreSQL tool. On shared environments connect with a read-only user so you don't accidentally change other people's data.

What to check manually:

- **Data after UI actions.** Created an order? Check every related table: orders, line items, stock movements, payment, audit log.
- **Boundary values.** Maximum string length, zero and negative numbers, very large amounts, 29 February and 31 December, NULL vs. empty string.
- **Non-Latin characters and emoji.** A name like "Ґалаґан-Їжакевич" or "Zoë 😊" must be saved and returned without "??". In MySQL that requires `utf8mb4`, not the legacy `utf8`. Also check sorting and search: in accent-insensitive collations, letters such as "ї" and "і" or "й" and "и" may compare as equal, and a unique index may unexpectedly reject a different name.
- **Time zones.** Save an event at 23:30 local time and see which date it gets in the database and in reports. Check daylight saving transitions separately.
- **Concurrent operations.** Open two sessions and change the same row at once, or buy the last item in two tabs. That's where isolation and locking bugs hide.
- **Deletion.** What happens to related rows: cascade delete, restriction or soft delete with a flag?
- **Restore from backup.** At least once a quarter, together with the admins, restore a copy into a separate environment and check that the app works with it.

## Automated tests

### Unit tests inside the database

If business logic lives in stored procedures and triggers, test it there.

- **[pgTAP](product:pgTAP)** for PostgreSQL checks schema structure (does a table, column, index or key exist) and the results of functions and queries. Run with `pg_prove`.
- **[tSQLt](product:tSQLt)** for SQL Server: tests in T-SQL, each in a rolled-back transaction, and `FakeTable` isolates a procedure from real data.
- **[utPLSQL](product:utPLSQL)** for Oracle: annotated tests in PL/SQL packages and code coverage reports.

### Integration tests with a real database

Running app tests on an embedded "lightweight" database instead of the real one often misses bugs: different types, different NULL and sorting behaviour, missing functions. Test on the same engine and version as production.

- **[Testcontainers](product:Testcontainers)** spins up a real database in a Docker container for the duration of the tests and removes it afterwards, for Java, .NET, Python, Go, Node.js and more.
- **[DbUnit](product:DbUnit)** in Java projects loads a known dataset before a test and compares tables afterwards.
- **[Neon](product:Neon)** creates a branch of a PostgreSQL database with all its data in seconds, handy for a separate environment per pull request.

To keep tests from interfering with each other, use one of three strategies: a transaction rolled back after each test, a separate clean database per run, or unique data for each test.

### Test data

[Faker.js](product:Faker.js) (in code, with many locales) and [Mockaroo](product:Mockaroo) (in the browser, exporting SQL and CSV) generate realistic data. Generate not only "nice" data but edge cases too: long strings, apostrophes in surnames (`O'Connor`), empty optional fields, very old and future dates.

## Schema migrations: the riskiest part

Most production database incidents come not from query bugs but from schema changes. Migrations should live in Git, go through review and be tested like code.

- **[Flyway](product:Flyway)** from Redgate applies versioned SQL scripts in order. The free Community edition covers the basics; since May 2025 the Teams edition is no longer sold to new customers, leaving Enterprise for commercial features.
- **[Liquibase](product:Liquibase)** describes changes in changelog files and supports rollback. Since version 5.0 (September 2025) Liquibase Community is under the FSL license (code converts to Apache 2.0 after two years), and the commercial edition is called Liquibase Secure.
- **[Atlas](product:Atlas)** generates migrations from the desired schema and lints them for risky changes.
- **[Squawk](product:Squawk)** is a PostgreSQL migration linter: it warns that `CREATE INDEX` without `CONCURRENTLY` will block writes to the table.
- **[Bytebase](product:Bytebase)** organises review and approval of SQL changes for a team, and **[SQLFluff](product:SQLFluff)** checks style and common mistakes in SQL code.

Migration testing checklist:

1. Apply the migration to a copy of the database with a realistic (masked) data volume, not an empty one.
2. Measure the duration and check for table locks. What takes a second on a test database can take an hour in production.
3. Check that the old app code works with the new schema and the new code with the old one. During a rollout both versions run at once. The safe path is "expand, migrate, contract": add the new column first, then move data and code, and only drop the old column in a separate release.
4. Check the rollback or recovery plan.
5. After the migration, run the integrity SQL checks above and [pgTAP](product:pgTAP) structure tests.

**A database version upgrade is a migration too.** MySQL 8.0 reached end of life on 30 April 2026, and many teams are moving to MySQL 8.4 LTS. PostgreSQL 18 came out in September 2025, and PostgreSQL 13 support ended in November 2025. Before upgrading, run a full regression on the new version and compare plans of key queries: the new optimiser may choose a different plan.

## Query performance

- **Execution plan.** `EXPLAIN ANALYZE` (in PostgreSQL ideally with `BUFFERS`) shows how the database actually ran a query: which indexes it used, how many rows it read and where it spent time. Raw plans are hard to read, so paste them into [explain.dalibo.com](product:explain.dalibo.com) (free) or [pgMustard](product:pgMustard) (with advice).
- **Slow query logs.** Enable `slow_query_log` in MySQL or `log_min_duration_statement` in PostgreSQL. [pgBadger](product:pgBadger) turns a PostgreSQL log into a report of the slowest and most frequent queries. The `pg_stat_statements` extension collects query statistics inside the database.
- **Typical problems:** a missing index on a `WHERE` or `JOIN` column; a function over an indexed column (`WHERE LOWER(email) = ...`) that prevents index use; `SELECT *` on large tables; the N+1 problem when an ORM runs a separate query for each row in a list; pagination with a large `OFFSET`.
- **Data volume.** Always test at a realistic volume: a query that works on 100 rows can be a disaster on 10 million.

To load-test the database itself there's **[HammerDB](product:HammerDB)** (standard TPROC-C and TPROC-H workloads) and **[sysbench](product:sysbench)** (quick OLTP tests for MySQL and PostgreSQL). For load through the application use [Apache JMeter](product:Apache JMeter) with JDBC requests or [Grafana k6](product:Grafana k6). More in [Load testing](blog-post.php?slug=load-testing&hl=en).

## Database security

- **SQL injection.** Check every input field, URL parameter and API. [sqlmap](product:sqlmap) automates the search; use it only on your own systems or with written permission. The main defence in code is parameterised queries.
- **Least privilege.** The app account shouldn't have `DROP`, `ALTER` or access to other schemas. Check this by querying the system privilege tables.
- **Sensitive data.** Passwords are stored only as hashes, card numbers are not stored at all or are tokenised, backups are encrypted.
- **Errors.** Database error text must not reach the user: it reveals the table structure.

More in [Security testing](blog-post.php?slug=security-testing&hl=en).

## Test data without personal data

The easiest way to get a realistic test database is to copy production. It's also the most dangerous: test environments are less protected, contractors have access, and data leaks into screenshots, bug reports and chats. Personal data processing is regulated by laws such as the GDPR in the EU.

So mask a production copy before handing it to testing:

- **[Greenmask](product:Greenmask)** dumps PostgreSQL and replaces names, emails, phones and addresses with fake ones on the way, preserving relationships between tables.
- **[PostgreSQL Anonymizer](product:PostgreSQL Anonymizer)** lets you declare masking rules right in the schema and do static or dynamic masking.

After masking, verify the result: search the test database for a few known real emails or phone numbers. They shouldn't be there.

## Data quality in warehouses and ETL

If you test analytics, a data warehouse or ETL pipelines, the focus shifts from single transactions to large datasets: did all the data arrive, are there duplicates, is it fresh, are the aggregates right.

- **[dbt](product:dbt)** has built-in `unique`, `not_null`, `accepted_values` and `relationships` tests plus model unit tests. In June 2026 dbt Labs completed its merger with Fivetran; dbt Core remains open source.
- **[Great Expectations](product:Great Expectations)** and **[Soda](product:Soda)** describe expectations about data and run them in pipelines.
- **[Datafold](product:Datafold)** compares data before and after a code change or a cross-database migration and shows the difference right in the pull request.

A baseline set of checks for any load: row counts match between source and target, keys are unique, required fields are filled, control totals (for example, daily sales) match the source, and data is no older than expected.

## If you test the database engine itself

Teams building databases or their forks use specialised approaches. [SQLancer](product:SQLancer) automatically generates databases and queries and looks for logic bugs where the engine returns a wrong result; it has found hundreds of defects in SQLite, MySQL, PostgreSQL and others. For distributed databases there's the well-known Jepsen approach: checking consistency guarantees under network partitions and node crashes.

## How to report data defects

A good database bug report includes:

- **the app action** that caused the defect and the environment;
- **the SQL query** that shows the problem and its result (without personal data);
- **the expected result**: "`orders.total` should equal the sum of line items";
- **record IDs** so the developer can find them;
- **the database version** and, if relevant, the last applied migration;
- for slow queries, **the execution plan** and the table sizes.

If you can reproduce the problem on a small example, build it in [DB Fiddle](product:DB Fiddle): the schema, a few rows and the query returning a wrong result, all behind a single link.

## A one-month learning plan

| Week | What to do |
|---|---|
| 1 | SQL basics: SELECT, WHERE, JOIN, GROUP BY, HAVING. Interactive lessons in [SQLBolt](product:SQLBolt), exercises in [SQLZoo](product:SQLZoo) and the [SQL Murder Mystery](product:SQL Murder Mystery) to practise. |
| 2 | Install [DBeaver](product:DBeaver) and a local PostgreSQL or MySQL. Create a practice shop schema, fill it with data from [Mockaroo](product:Mockaroo) and write all the SQL checks from this article. |
| 3 | Transactions and isolation levels: reproduce a lost update and a deadlock in two sessions. Learn `EXPLAIN ANALYZE`: add an index and compare the plans in [explain.dalibo.com](product:explain.dalibo.com). |
| 4 | Automation: write a few [pgTAP](product:pgTAP) tests or an integration test with [Testcontainers](product:Testcontainers), add [Flyway](product:Flyway) migrations and a [Squawk](product:Squawk) check in GitHub Actions. |

More practice tools are in the [Practice Sites for Testers](subcategory:qa-practice) subcategory.

## AI in database testing

AI assistants are good at writing SQL from a description ("find unpaid orders created more than a day ago"), explaining other people's queries and execution plans, suggesting indexes and generating test data and edge cases. Many clients, including paid editions of [DBeaver](product:DBeaver) and [DataGrip](product:DataGrip), have built-in AI assistants that see your schema.

Two rules, though. First, check generated SQL before running it, especially `UPDATE` and `DELETE`: AI can easily drop a `WHERE` condition or mix up columns. Second, don't paste real personal or commercial data into public chatbots; share the schema and masked examples. Look for AI data tools in the [Databases](subcategory:databases) subcategory.

For other kinds of testing, see [API testing](blog-post.php?slug=api-testing&hl=en), [Load testing](blog-post.php?slug=load-testing&hl=en), [Security testing](blog-post.php?slug=security-testing&hl=en) and [Test automation tools](blog-post.php?slug=test-automation-tools&hl=en). All tools from this article are in the [Testing](subcategory:testing) and [Databases](subcategory:databases) subcategories.

## FAQ

**Does a tester need SQL?**
Yes. Even manual testers need SQL to check data after UI actions, prepare test data and describe defects precisely. SELECT, JOIN and GROUP BY are enough to start.

**How is database testing different from API testing?**
API testing checks what the service returns. Database testing checks what was actually stored and whether the data is intact. An API can answer "200 OK" while a wrong row lands in the database.

**Can I test on a copy of the production database?**
Only after masking personal and sensitive data. Real data in test environments is a common cause of leaks.

**How do I test NoSQL databases such as MongoDB?**
The principles are the same: data correctness, document schema validation, indexes and query plans (`explain()`), performance at realistic volume. [Testcontainers](product:Testcontainers) works for integration tests here too.

**What if the logic is in stored procedures and there are no tests?**
Start with the most critical procedures (money, stock, permissions) and write unit tests for them in [tSQLt](product:tSQLt), [pgTAP](product:pgTAP) or [utPLSQL](product:utPLSQL), depending on the database.

**Not sure where to start?**
Ask [Elya](eli.php): she'll pick database testing tools for your project and level.

*Facts checked on 4 November 2026. Service terms, licenses and database support dates may change, so check official websites.*
