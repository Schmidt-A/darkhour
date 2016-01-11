// This script will boot all players out and save all MySQL data into the database and
// then reload the SERVER. NOTE: This reloads the SERVER, not the MODULE.
// Plugin by: Asmodae
// Script by: Rami_Ahmed

#include "aps_include"
void main()
{object oPC = GetFirstPC();
 while (GetIsObjectValid(oPC))
 {  if (!GetIsDM(oPC))
     {  BootPC(oPC);
     }
  oPC = GetNextPC();
 }
 DelayCommand(0.1, SQLExecDirect("COMMIT TRANSACTION")); // Not sure if this only works for SQLite
 DelayCommand(0.2, SQLExecDirect("BEGIN TRANSACTION"));  // Not sure if it's needed to start it up again
 AssignCommand(GetModule(), DelayCommand(5.0, SetLocalString(GetModule(),"NWNX!RESETPLUGIN!SHUTDOWN","1")));
}
