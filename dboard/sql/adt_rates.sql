select 
       distinct(UN_TAR.TAR_T2) "ADT_Rates"
from
    (select 
               To_number(UNTARTAB.TAR_T02) "TAR_T2"
    from 
        AWUNADM.UNTARTAB 
    where 
        UNTARTAB.VALID_TO is null
        AND UNTARTAB.TAR_T02 <> '   '
        AND UNTARTAB.TAR_T02 < '9999'
    ) UN_TAR
    order by 1