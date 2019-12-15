CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_local`()
BEGIN
	declare done boolean default false;
    declare locale varchar(45);
    declare cur1 cursor for select distinct DES_LOCAL from DB_URG.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into locale;
        
        if done then
			leave read_loop;
		end if;
        
        insert into DW_URG.DIM_LOCAL (local) values (locale);
	
	end loop;
        
	close cur1;
END