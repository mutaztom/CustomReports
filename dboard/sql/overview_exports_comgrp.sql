SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'mm') MONTH, 
TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'YYYY') YEAR, ROUND(SUM(AWUNADM.GEN_ITEM_N_EXP.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_EXP.VGS_INV_CUR_RAT, 
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
AWUNADM.EXPGRP.GRP
FROM AWUNADM.GEN_ITEM_N_EXP, AWUNADM.N_UNTARTAB, AWUNADM.EXPGRP
WHERE AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND  ((AWUNADM.GEN_ITEM_N_EXP.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
 AND (AWUNADM.GEN_ITEM_N_EXP.N_H2=AWUNADM.EXPGRP.HS2(+)))
GROUP BY AWUNADM.EXPGRP.GRP, TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'mm'), 
TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'YYYY')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'mm') ASC, 
TO_CHAR(AWUNADM.GEN_ITEM_N_EXP.IDE_RCP_DAT, 'YYYY')
