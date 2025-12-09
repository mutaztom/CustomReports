SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'YYYY') YEAR, TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'MON ') MONTH, 
ROUND(SUM(0.000001*AWUNADM.GEN_ITEM_N_EXP.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_EXP.VGS_INV_CUR_RAT, 
AWUNADM.GEN_ITEM_N_EXP.VGS_INV_CUR_RAT, (select 
                            AWCURUPDATE_ITM.CUR_NRAT  CUR_NRAT
                                        from    
                                         AWUNADM.AWCURUPDATE_ITM,
                                         AWUNADM.AWCURUPDATE_GEN
                            Where    
                              AWCURUPDATE_ITM.INSTANCE_ID = AWCURUPDATE_GEN.INSTANCE_ID 
                              and AWCURUPDATE_ITM.CUR_COD ='USD'
                              and AWCURUPDATE_GEN.VDAT =
                                 (select 
                              max(AWCURUPDATE_GEN.VDAT) MVDAT
                            
                            from    
                             AWUNADM.AWCURUPDATE_ITM,
                             AWUNADM.AWCURUPDATE_GEN
                            Where    
                              AWCURUPDATE_ITM.INSTANCE_ID = AWCURUPDATE_GEN.INSTANCE_ID 
                              and AWCURUPDATE_ITM.CUR_COD ='USD'
and AWCURUPDATE_GEN.VDAT <:date2)
and rownum=1))), 2) TOT_CIF_USD, 
AWUNADM.GEN_ITEM_N_EXP.GEN_CTY_DES_COD
FROM AWUNADM.N_UNTARTAB, AWUNADM.GEN_ITEM_N_EXP
WHERE (AWUNADM.N_UNTARTAB.VALID_TO IS NULL and AWUNADM.GEN_ITEM_N_EXP.GEN_CTY_DES_COD<>'SDE'
 AND AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT BETWEEN :date1 AND :date2)
 AND  (AWUNADM.GEN_ITEM_N_EXP.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
GROUP BY TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'YYYY'), TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'MON '), 
AWUNADM.GEN_ITEM_N_EXP.GEN_CTY_DES_COD
HAVING ROUND(SUM(0.000001*AWUNADM.GEN_ITEM_N_EXP.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_EXP.VGS_INV_CUR_RAT, 
AWUNADM.GEN_ITEM_N_EXP.VGS_INV_CUR_RAT, (select 
                            AWCURUPDATE_ITM.CUR_NRAT  CUR_NRAT
                                        from    
                                         AWUNADM.AWCURUPDATE_ITM,
                                         AWUNADM.AWCURUPDATE_GEN
                            Where    
                              AWCURUPDATE_ITM.INSTANCE_ID = AWCURUPDATE_GEN.INSTANCE_ID 
                              and AWCURUPDATE_ITM.CUR_COD ='USD'
                              and AWCURUPDATE_GEN.VDAT =
                                 (select 
                              max(AWCURUPDATE_GEN.VDAT) MVDAT
                            
                            from    
                             AWUNADM.AWCURUPDATE_ITM,
                             AWUNADM.AWCURUPDATE_GEN
                            Where    
                              AWCURUPDATE_ITM.INSTANCE_ID = AWCURUPDATE_GEN.INSTANCE_ID 
                              and AWCURUPDATE_ITM.CUR_COD ='USD'
and AWCURUPDATE_GEN.VDAT <:date2)
and rownum=1))), 2)>1