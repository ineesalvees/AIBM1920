CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_especialidade`()
BEGIN
	declare done boolean default false;
    declare especialidade varchar(45);
    declare cur1 cursor for select distinct ALTA_DES_ESPECIALIDADE from DB_URG.urg_inform_geral;
    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into especialidade;
        
        if done then
			leave read_loop;
		end if;
        
        insert into DW_URG.DIM_ESPECIALIDADE (especialidade) values (especialidade);
	
	end loop;
        
	close cur1;
END