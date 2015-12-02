// This program is free software; you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation; either version 2 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program; if not, write to the Free Software
// Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

/*
Use:
    string output = leto_script(script);
    string bicfile = GetBicFileName(oPC); Returns the name of a .bic file.
    string bicpath = GetBicPath(oPC); Retruns the full path to a .bic file.
*/

#include "aps_include"
#include "aw_include"
//Please make sure to Set correct NWNPATH in Settings table

string LetoScript(string script) {
    // Stores a var in the module which NWNX LETO then takes and works with.
    SetLocalString(GetModule(), "NWNX!LETO!SCRIPT", script);
    // Gets the var now changed by NWNX LETO back from the module and returns it.
    return GetLocalString(GetModule(), "NWNX!LETO!SCRIPT");
}

string LetoOpen(string file, string handler = "") {
    if(handler == "") handler = "TEMP";
    return "<file:open "+handler+" <qq:"+file+">>";
}

string LetoClose(string handler = "") {
    if(handler == "") handler = "TEMP";
    return "<file:close "+handler+">";
}

string LetoSave(string file = "", string handler = "") {
    if(handler == "") handler = "TEMP";
    if (file == "")
    {
        return "<file:save "+handler+">";
    }
    else
    {
        return "<file:save "+handler+" <qq:"+file+">>";
    }
}

string ModifyProperty(string property, string modifier) {
    return "<gff:set '"+property+"' {value=<qq:"+modifier+">}>";
}

string GetBicPath(object oPC, string purpose) {
    string NWNPATH = "C://NeverwinterNights//NWN"; //use default if sql fetch fails
    SQLExecDirect("SELECT value FROM Settings WHERE name='NWNPATH'");
    if (SQLFetch() == SQL_SUCCESS)
    {
        NWNPATH = SQLGetData(1);
    }
    if (GetDeity(oPC) == "")
    {
        SetDeity(oPC, purpose);
        ExportSingleCharacter(oPC);
    }

    string script =
        "<var:playerlist=[]>"+
        "<vault:<var:playerlist> <qq:"+NWNPATH+"//servervault//"+GetPCPlayerName(oPC)+"//*.bic>>"+
        "<for:vault <var:playerlist>>"+
            "<if:<Deity> eq '"+purpose+"'><~><break></if>"+
        "</for>";
    WriteTimestampedLogEntry(script);
    return LetoScript(script);

/*    string script =
        "<var:playerlist=[]>"+
        "<vault:<var:playerlist> <qq:"+NWNPATH+"//servervault//"+GetPCPlayerName(oPC)+"//*.bic>>"+
        "<for:vault <var:playerlist>>"+
            "<if:<FirstName> && <LastName>><var:space = ' '></if>"+
            "<if:<qq:<FirstName><var:space><LastName>> eq <qq:"+GetName(oPC)+">>"+
            "<if:<Experience> eq "+IntToString(GetXP(oPC))+">"+
            "<if:<Gold> eq "+IntToString(GetGold(oPC))+">"+
            "<if:<GoodEvil> eq "+IntToString(GetGoodEvilValue(oPC))+">"+
            "<if:<LawfulChaotic> eq "+IntToString(GetLawChaosValue(oPC))+">"+
                "<~><break>"+
            "</if>"+
            "</if>"+
            "</if>"+
            "</if>"+
            "</if>"+
        "</for>";
    WriteTimestampedLogEntry(script);
    return LetoScript(script);
*/
/*
    return LetoScript(
        "<var:playerlist=[]>"+
        "<vault:<var:playerlist> <qq:"+NWNPATH+"//servervault//"+GetPCPlayerName(oPC)+"//*.bic>>"+
        "<for:vault <var:playerlist>>"+
            "<if:<qq:<Tag>> eq <qq:"+GetTag(oPC)+">><~><break></if>"+
        "</for>"
    );
*/
}

string GetBicFileName(object oPC) {
    string sChar, sBicName;
    string sPCName = GetStringLowerCase(GetName(oPC));
    int i, iNameLength = GetStringLength(sPCName);

    for(i=0; i < iNameLength; i++) {
        sChar = GetSubString(sPCName, i, 1);
        if (TestStringAgainstPattern("(*a|*n|*w|'|-|_)", sChar)) {
            if (sChar != " ") sBicName += sChar;
        }
    }
    return GetStringLeft(sBicName, 16);
}

void QueueDeleteBio(object oDM, object oPC);
void ProcessDeleteBio(object oDM, object oPC); //private function
void DeleteBio(string BicFile); //private function

void QueueDeleteBio(object oDM, object oPC)
{
   SetDeity(oPC, "delete_bio");
   ExportSingleCharacter(oPC);
   SetLocalInt( GetItemPossessedBy(oPC,"itemsremoved1"),"char_checks",200);
   DelayCommand(10.0, ProcessDeleteBio(oDM, oPC)); //how long could it take to save a bic?
}

//private function
void ProcessDeleteBio(object oDM, object oPC)
{
   //should have saved bic by now
   string BicFile = GetBicPath(oPC, "delete_bio");
   if (BicFile == "") //even if it wasn't saved... try again
   {
      SendMessageToPC(oDM, "Could not find player bic file for "+ GetPCPlayerName(oPC) + " ["+GetName(oPC)+"]");
      WriteTimestampedLogEntry("Could not find player bic file for "+ GetPCPlayerName(oPC) + " ["+GetName(oPC)+"]");
      return;
   }

   int nTeam = GetPlayerTeam(oPC);
   if(nTeam != TEAM_NONE) RemovePlayerFromTeam(nTeam, oPC);

   FloatingTextStringOnCreature(GetPCPlayerName(oPC)+" ["+GetName(oPC)+"] is booted to delete bio.",oDM, FALSE);
   WriteTimestampedLogEntry(GetName(oDM)+" booted "+GetPCPlayerName(oPC)+" ["+GetName(oPC)+"] to delete bio");
   SendMessageToAllDMs(GetName(oDM)+" booted "+GetPCPlayerName(oPC)+" ["+GetName(oPC)+"] to delete bio");
   BroadcastMessage(GetName(oDM)+" booted "+GetPCPlayerName(oPC)+" ["+GetName(oPC)+"] to delete bio");

   BootPC(oPC);
   DelayCommand(10.0, DeleteBio(BicFile)); //delay actually deleting the bio
}

//private function
void DeleteBio(string BicFile)
{
//SetLocalString(GetModule(), "NWNX!LETO!LOG_ENABLE", "1");
    WriteTimestampedLogEntry("editing bic file: "+BicFile);
    string LetoCmd = "";
    LetoCmd += LetoOpen(BicFile);
    LetoCmd += ModifyProperty("Description", "");
    LetoCmd += ModifyProperty("Deity", ""); //reset Deity
    LetoCmd += LetoSave();
    LetoCmd += LetoClose();
    LetoScript(LetoCmd);
}

