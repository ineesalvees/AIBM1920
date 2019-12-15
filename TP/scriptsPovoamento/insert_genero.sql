CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_genero`()
BEGIN
	declare done boolean default false;
    declare genero varchar(45);
    declare cur1 cursor for select distinct SEXO from DB_URG.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into genero;
        
        if done then
			leave read_loop;
		end if;
        
        insert into DW_URG.DIM_GENERO (genero) values (genero);
	
	end loop;
        
	close cur1;
END