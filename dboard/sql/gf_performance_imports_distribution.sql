SELECT ALL AWUNADM.GEN_ITEM_N_2.MONTH_YEAR, 
TO_NUMBER(NVL(DECODE(AWUNADM.N_UNTARTAB.TAR_T01, 50, 40, AWUNADM.N_UNTARTAB.TAR_T01), 
0)) "Rate", 
ROUND(SUM(AWUNADM.GEN_ITEM_N_2.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, 
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
and rownum=1))), 2) "Custom_Value_USD"
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.VALID_TO IS NULL)
 AND  (AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
GROUP BY AWUNADM.GEN_ITEM_N_2.MONTH_YEAR, 
TO_NUMBER(NVL(DECODE(AWUNADM.N_UNTARTAB.TAR_T01, 50, 40, AWUNADM.N_UNTARTAB.TAR_T01), 
0)), 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm')
ORDER BY TO_NUMBER(NVL(DECODE(AWUNADM.N_UNTARTAB.TAR_T01, 50, 40, AWUNADM.N_UNTARTAB.TAR_T01), 
0)) ASC, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC