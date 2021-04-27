SET SERVEROUTPUT ON;
DECLARE
  in_rec2 varchar2(30);
  sqltext varchar2(2000);
  
  start_date varchar(20) :=  '01.06.20 00:00:00'; -- дата начала запроса
  end_date varchar(20) :=  '18.06.20 00:00:00';   -- конечная дата 
  points_len PLS_INTEGER := 100;                 -- количество записей в историю
  TYPE nested_type IS TABLE OF elements.element_name%TYPE;
  TYPE return_type IS TABLE OF PLS_INTEGER;
  el_name nested_type;
  el_return return_type;
  CURSOR c1 IS select view_name 
               from all_views 
               where owner = 'SCHEMAUSER' and view_name like '%HISTORY';
               
BEGIN
  OPEN c1;
  loop
    fetch c1 into in_rec2;
    sqltext := q'[select T2.element_name, COUNT(TS) from ]' || in_rec2
    || q'[ T1, elements T2 where T1.element_id = T2.element_id AND TS BETWEEN to_date(']' 
    || start_date || q'[', 'DD.MM.YY HH24:MI:SS') AND to_date(']' 
    || end_date || q'[', 'DD.MM.YY HH24:MI:SS') group by t2.element_name having COUNT(TS) > ]' || points_len;
    execute immediate sqltext bulk collect into el_name, el_return;
    if el_name.count > 0 then
      dbms_output.put_line('ARHIVEGROUP' ||chr(9)|| in_rec2 ||chr(9)|| el_name.count);
      for j in 1 .. el_name.count loop
        dbms_output.put_line(el_name(j) ||chr(9)|| el_return(j));
      end loop;
    end if;
    exit when c1%notfound;
  end loop;
  close c1;
END;