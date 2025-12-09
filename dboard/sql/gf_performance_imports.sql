select all_tax."Month Year" "Date",all_tax."Link Amount" "Estimated_Total_Imports_USD", 
all_tax.tot_cif_usd "Actual_Total_Imports_USD",only_taxable."Estimated Taxable Imports" "Estimated_Taxable_Imports",
only_taxable.tot_cif_usd "ActualTaxable_Imports"
from
(SELECT ALL AWUNADM.GEN_ITEM_N_2.MONTH_YEAR "Month Year", AWUNADM.IMP_LINK.IMP_AMOUNT "Link Amount", 
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
and rownum=1))), 2) tot_cif_usd
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB, AWUNADM.IMP_LINK
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.VALID_TO IS NULL)
 AND  ((AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
 AND (AWUNADM.GEN_ITEM_N_2.MONTH_YEAR=AWUNADM.IMP_LINK.IMP_MONTH_YEAR(+)))
GROUP BY AWUNADM.GEN_ITEM_N_2.MONTH_YEAR, AWUNADM.IMP_LINK.IMP_AMOUNT,
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC) all_tax,
(SELECT ALL AWUNADM.GEN_ITEM_N_2.MONTH_YEAR "Month Year", AWUNADM.IMP_NON_ZERO_LINK.IMP_AMOUNT "Estimated Taxable Imports", 
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
and rownum=1))), 2) tot_cif_usd, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') month_no
FROM AWUNADM.GEN_ITEM_N_2, AWUNADM.N_UNTARTAB, AWUNADM.IMP_NON_ZERO_LINK
WHERE (AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
 AND AWUNADM.N_UNTARTAB.VALID_TO IS NULL
 AND AWUNADM.N_UNTARTAB.TAR_T01<>'0')
 AND  ((AWUNADM.GEN_ITEM_N_2.N_H6=AWUNADM.N_UNTARTAB.N_T_H6(+))
 AND (AWUNADM.GEN_ITEM_N_2.MONTH_YEAR=AWUNADM.IMP_NON_ZERO_LINK.IMP_MONTH_YEAR(+)))
GROUP BY AWUNADM.GEN_ITEM_N_2.MONTH_YEAR, AWUNADM.IMP_NON_ZERO_LINK.IMP_AMOUNT, 
TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm')
ORDER BY TO_CHAR(AWUNADM.GEN_ITEM_N_2.IDE_RCP_DAT, 'mm') ASC) only_taxable
where all_tax."Month Year"=only_taxable."Month Year"