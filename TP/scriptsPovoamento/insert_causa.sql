CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_causa`()
BEGIN
	declare done boolean default false;
    declare causa varchar(45);
    declare cur1 cursor for select distinct DES_CAUSA from DB_URG.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into causa;
        
        if done then
			leave read_loop;
		end if;
        
        insert into DW_URG.DIM_CAUSA (causa) values (causa);
	
	end loop;
        
	close cur1;
END