select
    GEN_ITEM_N_EXP.GEN_CTY_DES_COD "city",round(sum(GEN_ITEM_N_EXP.VIT_CIF)/1000,2) "Export"
from
    AWUNADM.GEN_ITEM_N_EXP
where
    GEN_ITEM_N_EXP.IDE_RCP_DAT BETWEEN :date1 AND :date2
group by 
    GEN_ITEM_N_EXP.GEN_CTY_DES_COD