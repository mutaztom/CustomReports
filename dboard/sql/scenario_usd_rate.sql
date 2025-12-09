select 
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
and AWCURUPDATE_GEN.VDAT <sysdate)
and rownum=1