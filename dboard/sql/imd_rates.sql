select 
    distinct(UN_TAR.TAR_T1) "IMD_Rates"
from
    (select 
                To_number(UNTARTAB.TAR_T01) "TAR_T1"
    from 
        AWUNADM.UNTARTAB 
    where 
        UNTARTAB.VALID_TO is null
        AND UNTARTAB.TAR_T01 <> '   '
        AND UNTARTAB.TAR_T01 < '9999'
    ) UN_TAR
    order by 1