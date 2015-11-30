// Name     : Avlis Persistence System OnModuleLoad
// Purpose  : Initialize APS on module load event
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"
#include "_incl_globvars"
#include "hashset_nwnx"

void main()
{
    // Init placeholders for ODBC gateway
    SQLInit();

    // Initialize globals.
    HashSetCreate(GetModule(), "EATING_HASHSET", 50);
    HashSetCreate(GetModule(), "PENALTIES_HASHSET", 50);

    SQLExecDirect("SELECT max FROM hunger_const WHERE level = 'Peckish';");
    if(SQLFetch() == SQL_SUCCESS)
        HUNGRY_AT = StringToFloat(SQLGetData(1));
    else
        // This shouldn't have happened...
        HUNGRY_AT = 60.0;
    HUNGRY_AT = 60.0;

    SQLExecDirect("SELECT max FROM hunger_const WHERE level = 'Ravenous';");
    if(SQLFetch() == SQL_SUCCESS)
        RAVENOUS_AT = StringToFloat(SQLGetData(1));
    else
        // This shouldn't have happened...
        RAVENOUS_AT = 30.0;
}

