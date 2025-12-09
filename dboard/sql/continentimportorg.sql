select
    GEN_ITEM_N_2.GDS_ORG_CTY "city",round(sum(GEN_ITEM_N_2.VIT_CIF)/1000,2) "import"
from
    AWUNADM.GEN_ITEM_N_2
where
    GEN_ITEM_N_2.IDE_RCP_DAT BETWEEN :date1 AND :date2
group by GEN_ITEM_N_2.GDS_ORG_CTY