// Name     : Demo create object table
// Purpose  : Create a table for persistent object data
// Authors  : Ingmar Stieger
// Modified : January 14, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    SQLExecDirect("DROP TABLE pwobjdata");
    SendMessageToPC(GetLastUsedBy(), "Table 'pwobjdata' deleted.");

    // For SQLite
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwobjdata' for SQLite...");
    SQLExecDirect("CREATE TABLE pwobjdata (" +
        "player varchar(64) NOT NULL default '~'," +
        "tag varchar(64) NOT NULL default '~'," +
        "name varchar(64) NOT NULL default '~'," +
        "val blob," +
        "expire int(11) default NULL," +
        "last timestamp NOT NULL default current_timestamp," +
        "PRIMARY KEY (player,tag,name)" +
        ")");

    // For MySQL
    /*
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwobjdata' for MySQL...");
    SQLExecDirect("CREATE TABLE pwobjdata (" +
        "player varchar(64) NOT NULL default '~'," +
        "tag varchar(64) NOT NULL default '~'," +
        "name varchar(64) NOT NULL default '~'," +
        "val blob," +
        "expire int(11) default NULL," +
        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
        "PRIMARY KEY  (player,tag,name)" +
        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;");
    */

    SendMessageToPC(GetLastUsedBy(), "Table 'pwobjdata' created.");
}
