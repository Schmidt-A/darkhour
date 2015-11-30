// Name     : Demo store value
// Purpose  : Store a value in the database
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    SetPersistentString(GetLastUsedBy(), "demoName", "testValue");
    SendMessageToPC(GetLastUsedBy(), "Stored 'testValue' in database.");
}
