SET SERVEROUTPUT ON;

CREATE OR REPLACE TRIGGER Updating_Fatura
  BEFORE 
    UPDATE OF VALOR_TOTAL
  ON FATURA
BEGIN 
  CASE 
    WHEN UPDATING THEN
      dbms_output.put_line('Updating VALOR_TOTAL...');
      dbms_output.put_line('');
  END CASE;
END;
/

CREATE OR REPLACE PROCEDURE Update_Fatura_Year_Month (this_year in NUMBER, this_month in NUMBER) IS

invalid_year EXCEPTION;
invalid_month EXCEPTION;
invalid_date_format EXCEPTION;
/*
ora_short_date_exception EXCEPTION; -- ORA-01840: input value not long enough for date format
PRAGMA EXCEPTION_INIT (ora_short_date_exception, -06512 );
*/

rows_update_num NUMBER(10,0);
this_date DATE:= to_date(this_year||this_month, 'yyyymm');

BEGIN
 -- dbms_output.put_line(to_char(this_date,'mm/yyyy'));    
  IF this_year <=0 THEN
    RAISE invalid_year;
  END IF;
  IF this_month <=0 OR this_month > 12 THEN
    RAISE invalid_month;
  END IF;
  /*
  IF to_date(this_date) THEN 
    dbms_output.put_line('Valid date');
  ELSE
    RAISE invalid_date_format;
  END IF; 
  Have to create a sub-function to check if date is valid and test as well if user put char instead of numbers in date.
  */
  
  UPDATE FATURA f 
    SET f.VALOR_TOTAL = (
      SELECT SUM(df.VALOR) FROM DETALHE_FATURA df 
      WHERE f.ID_FATURA = df.ID_FATURA 
      AND EXTRACT(YEAR FROM f.DATA_EMISSAO) = this_year
      AND EXTRACT(MONTH FROM f.DATA_EMISSAO) = this_month 
    ) 
    WHERE EXISTS (
      SELECT * FROM DETALHE_FATURA df 
      WHERE f.ID_FATURA = df.ID_FATURA 
      AND EXTRACT(month FROM f.DATA_EMISSAO) = this_month 
      AND EXTRACT(year FROM f.DATA_EMISSAO) = this_year
    );

    rows_update_num := SQL%rowcount; 
    
    IF rows_update_num > 0 THEN
      dbms_output.put_line('Good: ' || rows_update_num || ' contracts in ' || this_year || '/' || this_month  || ' have been updated.' );
    ELSE 
     dbms_output.put_line('Warning: No contracts found in this particular date: ('||to_char(this_date, 'yyyy/mm')||').');
    END IF;
    
EXCEPTION 
  WHEN invalid_year THEN
    dbms_output.put_line('Error: The inserted year (' || this_year || ') is not valid. Please, insert a valid year in the format yyyy.');
  WHEN invalid_month THEN
    dbms_output.put_line('Error: The inserted month (' || this_month || ') is not valid. Please, insert a valid month in the format MM.');
  WHEN no_data_found THEN
    dbms_output.put_line('No data found.'); 
  /*
  WHEN invalid_date_format THEN
		dbms_output.put_line('Error: Not a valid date.');
	WHEN ora_short_date_exception THEN
	  dbms_output.put_line('Error: Seems that you are not inserting a right date format. Please, check it.');
	*/
	WHEN others THEN 
    dbms_output.put_line('Error!');
     
COMMIT;
END;
/

/*Commands for test procedure compilation*/
show errors;
SELECT * FROM user_errors;


/*Commands for test, use and verify procedure execution*/

BEGIN
Update_Fatura_Year_Month(2015,10);
END;

COMMIT;

select * from fatura;


