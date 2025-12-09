select 
    distinct(UN_TAR.TAR_T3) "VAT_Rates"
from
    (select 
        To_number(UNTARTAB.TAR_T03) "TAR_T3"
    from 
        AWUNADM.UNTARTAB 
    where 
        UNTARTAB.VALID_TO is null
        AND UNTARTAB.TAR_T03 <> '   '
        AND UNTARTAB.TAR_T03 < '9999'
    ) UN_TAR
    order by 1
    
