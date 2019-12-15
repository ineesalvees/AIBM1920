CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_facts`()
BEGIN
	declare done boolean default false;
    declare id int;
    declare idade int;
    declare tempo_urg int;
    declare id_CAUSA int;
    declare id_DATA int;
    declare id_ESPECIALIDADE int;
    declare id_GENERO int;
    declare id_LOCAL int;
    declare id_PROVENIENCIA int;
    declare cur1 cursor for SELECT GERAL.URG_EPISODIO, TIMESTAMPDIFF(YEAR, GERAL.DTA_NASCIMENTO, GERAL.DATAHORA_ALTA), TIMESTAMPDIFF(MINUTE, GERAL.DATAHORA_ADM, 
    	GERAL.DATAHORA_ALTA), DC.idDIM_causa, DD.idDIM_data, DE.idDIM_especialidade, DG.idDIM_genero, DL.idDIM_local, DP.idDIM_proveniencia
		FROM dw_urg.dim_causa DC, dw_urg.dim_data DD, dw_urg.dim_especialidade DE,
		dw_urg.dim_genero DG, dw_urg.dim_local DL, dw_urg.dim_proveniencia DP, DB_URG.urg_inform_geral GERAL 
		WHERE DC.causa = GERAL.DES_CAUSA AND DD.data_adm = GERAL.DATAHORA_ADM AND DE.especialidade = GERAL.ALTA_DES_ESPECIALIDADE
		AND DG.genero = GERAL.SEXO AND DL.local = GERAL.DES_LOCAL AND DP.proveniencia = GERAL.DES_PROVENIENCIA ;

    declare continue handler for not found set done = true;
    
    open cur1;
    
    read_loop: loop
		fetch cur1 into id, idade, tempo_urg, id_CAUSA, id_DATA, id_ESPECIALIDADE, id_GENERO, id_LOCAL, id_PROVENIENCIA;
        
        if done then
			leave read_loop;
		end if;
        
        insert into dw_urg.facts_urg(idFACTS_URG, idade, tempo_urg, idDIM_ESPECIALIDADE, idDIM_LOCAL, idDIM_GENERO, idDIM_CAUSA, idDIM_PROVENIENCIA, idDIM_DATA) 
								values (id, idade,tempo_urg,id_ESPECIALIDADE, id_LOCAL, id_GENERO, id_CAUSA, id_PROVENIENCIA,id_DATA);
	
	end loop;
        
	close cur1;
END