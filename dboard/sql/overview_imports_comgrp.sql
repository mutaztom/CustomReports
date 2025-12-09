SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') MONTH, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY') YEAR, 
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
and rownum=1))), 2) TOT_CIF_USD, 
NVL(AWUNADM.N_COMGRP.COM_GRP,'Others') COM_GRP
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB, AWUNADM.N_COMGRP
WHERE AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND  ((AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
 AND (AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_COMGRP.N_H6_G(+)))
GROUP BY NVL(AWUNADM.N_COMGRP.COM_GRP,'Others'), TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm'), 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY') ASC