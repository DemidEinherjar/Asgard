--вход в ORCL под пользователем sys
sqlplus sys/ESDU_ORCL44 as sysdba/ORCL

--остановка кластера
crsctl stop cluster -all

--запуск кластера
srvctl start database -db ORCL

--запуск базы
srvctl start instance -d ORCL -n si44b

--состояние кластера
crsctl stat res -t

--войти в rman
rman target ORCL

--бэкап архлоги и удаление после бэкапа
backup archivelog all DELETE all input;
backup archivelog all not backed up DELETE all input;

--разблокирование пользователя ORCL
ALTER USER TNPKSUser ACCOUNT UNLOCK;

--просмотр всех активных сессий
SELECT
  *
FROM
  v$session
WHERE
  username IS NOT NULL;

--все параметры ORCL
SELECT
  *
FROM
  v$parameter;

--все DP_FILES
SELECT
  *
FROM
  v$datafile;

--arc_log сортировка по времени
SELECT
  *
FROM
  arc_log
ORDER BY
  ts;

--ошибки в алерты в arc_log
SELECT
  *
FROM
  arc_log
WHERE
  type = 'E' OR type = 'W';

--контроль резервного копирования
SELECT
  *
FROM
  v$rman_backup_job_details;

--узнать DBID
SELECT
  DBID
FROM
  v$database;

--узнать instance
SELECT
  *
FROM
  v$instance;

--узнать SNAPSHOT
SELECT
  *
FROM
 dba_hist_snapshot;

 --узнать кол-ва места в области DATA и FRA (ASMA)
SELECT
  *
FROM
  v$asm_diskgroup_stat;

--Добавление DB_FILES. Число опционально (но не более 65 000)
ALTER SYSTEM SET DB_FILES = 10000 SCOPE = SPFILE
______________________________________________________________________________
--запрос всех табличных пространств с их параметрами памяти (всего, использовано, свободно)
SELECT 
  df.tablespace_name "Tablespace", 
  totalusedspace "Used MB", 
  (
    df.totalspace - tu.totalusedspace
  ) "Free MB", 
  df.totalspace "Total MB", 
  ROUND(
    100 * (
      (
        df.totalspace - tu.totalusedspace
      )/ df.totalspace
    )
  ) "Pct. Free" 
FROM 
  (
    SELECT 
      tablespace_name, 
      ROUND(
        SUM(bytes) / 1048576
      ) TotalSpace 
    FROM 
      dba_data_files 
    GROUP BY 
      tablespace_name
  ) df, 
  (
    SELECT 
      ROUND(
        SUM(bytes)/(1024 * 1024)
      ) totalusedspace, 
      tablespace_name 
    FROM 
      dba_segments 
    GROUP BY 
      tablespace_name
  ) tu 
WHERE 
  df.tablespace_name = tu.tablespace_name;
______________________________________________________________________________
--поиск и удаление дублирующихся значений
DELETE FROM 
  TNPKSUSER.elements 
WHERE 
  element_name IN (
    SELECT 
      element_name 
    FROM 
      (
        SELECT 
          element_name, 
          count(element_name) 
        FROM 
          elements 
        GROUP BY 
          element_name 
        HAVING 
          count (element_name) > 1
      )
  );
______________________________________________________________________________
--кол-во сигналов по архивным группам
SELECT
  group_name,
  COUNT(*)
FROM
  elements
GROUP BY
  group_name
ORDER BY
  COUNT(*) DESC;
______________________________________________________________________________
--искать хуярящие параметры
SELECT 
  element_id "ELEM", 
  element_name 
FROM 
  elements 
WHERE 
  element_id in (
    SELECT 
      "ELEM" 
    FROM 
      (
        SELECT 
          * 
        FROM 
          (
            SELECT 
              element_id "ELEM", 
              count(*) "COUNT" 
            FROM 
              tir1zdvhistORy_00000152 
            WHERE 
              TS > '24.09.2020 00:00:00,000' 
              AND TS < '24.09.2020 04:00:00,000' 
            GROUP BY 
              element_id 
            ORDER BY 
              count(*) desc
          ) 
        WHERE 
          "COUNT" > 14400
      )
  );
______________________________________________________________________________
--удаление строк из табличного пространства
DELETE FROM
  sales
WHERE
  order_id = 1
  AND item_id = 1;
______________________________________________________________________________