CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_data`()
BEGIN
	declare done boolean default false;
    declare dataa datetime;
    declare cur1 cursor for select distinct DATAHORA_ADM from DB_URG.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into dataa;
        
        if done then
			leave read_loop;
		end if;
        
        insert into DW_URG.DIM_DATA (data_adm) values (dataa);
	
	end loop;
        
	close cur1;
END