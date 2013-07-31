create tablespace SB_MBackUp datafile 'DATA1.dbf' size 5 M LOGGING

create user SB_MBackUp identified by pass default tablespace SB_MBackUp quota unlimited on SB_MBackUp

grant select any table to SB_MBackUp

grant connect, resource to SB_MBackUp