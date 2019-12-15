CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_proveniencia`()
BEGIN
	declare done boolean default false;
    declare proveniencia varchar(45);
    declare cur1 cursor for select distinct DES_PROVENIENCIA from DB_URG.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into proveniencia;
        
        if done then
			leave read_loop;
		end if;
        
        insert into DW_URG.DIM_PROVENIENCIA(proveniencia) values (proveniencia);
	
	end loop;
        
	close cur1;
END