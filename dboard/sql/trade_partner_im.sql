SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY') YEAR, TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON ') MONTH, 
ROUND(SUM(0.000001*AWUNADM.GEN_ITEM_N_2.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, 
AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, (select 
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
AWUNADM.GEN_ITEM_N_2.GDS_ORG_CTY
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.VALID_TO IS NULL and AWUNADM.GEN_ITEM_N_2.GDS_ORG_CTY<>'SDE')
 AND  (AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
GROUP BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY'), TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON '), 
AWUNADM.GEN_ITEM_N_2.GDS_ORG_CTY
HAVING ROUND(SUM(0.000001*AWUNADM.GEN_ITEM_N_2.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, 
AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, (select 
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
ORDER BY ROUND(SUM(0.000001*AWUNADM.GEN_ITEM_N_2.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, 
AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, (select 
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
and rownum=1))), 2) DESC