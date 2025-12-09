select Taxable.Month "Month",Taxable.Year,round(Non_taxable.tot_cif_usd,2) "ZeroRate_Imports",round(loss.tot_cif_usd,2) "ZeroExemted_Imports"
from
(SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON') Month, TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY') Year, 
SUM(AWUNADM.GEN_ITEM_N_2.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, 
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
and rownum=1))) tot_cif_usd, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') Month_No
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.TAR_T01<>'0')
 AND  (AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6)
GROUP BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY'), TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON'), 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC) Taxable,
(SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON') Month, TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY') Year, 
SUM(AWUNADM.GEN_ITEM_N_2.VIT_CIF/DECODE(AWUNADM.GEN_ITEM_N_2.VGS_INV_CUR_RAT, 
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
and rownum=1))) tot_cif_usd, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') Month_No
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.TAR_T01='0')
 AND  (AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6)
GROUP BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY'), TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON'), 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC) Non_taxable,(SELECT ALL TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON') Month, TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY') Year, 
ROUND(SUM(AWUNADM.GEN_ITEM_N_2.VIT_CIF/18), 2) tot_cif_usd, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') Month_No
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB, AWUNADM.SAD_TAX
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.TAR_T01<>'0'
 AND AWUNADM.SAD_TAX.TAX_LIN_COD='IMD'
 AND AWUNADM.SAD_TAX.TAX_LIN_AMT=0)
 AND  ((AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6)
 AND (AWUNADM.GEN_ITEM_N_2.INSTANCEID=AWUNADM.SAD_TAX.INSTANCEID)
 AND (AWUNADM.GEN_ITEM_N_2.KEY_ITM_NBR=AWUNADM.SAD_TAX.KEY_ITM_NBR))
GROUP BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'YYYY'), TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'MON'), 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC) loss
where Taxable.Month=Non_taxable.Month
and Taxable.Year=Non_taxable.Year
and Taxable.Month=loss.Month
and Taxable.Year=loss.Year
order by Taxable.Month_No ASC