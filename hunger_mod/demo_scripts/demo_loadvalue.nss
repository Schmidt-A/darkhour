// Name     : Demo load value
// Purpose  : Load a value from the database
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    string sString = GetPersistentString(GetLastUsedBy(), "demoName");
    SendMessageToPC(GetLastUsedBy(), "Retrieved variable from database: " + sString);
}
