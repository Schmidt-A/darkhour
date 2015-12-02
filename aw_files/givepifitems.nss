#include "inc_bs_module"
#include "aw_include"
void main()
{
object oUser = GetPCSpeaker();
string sName = GetPCPlayerName(oUser);
string sChar = GetName(oUser);
   if (sName == "PDPuma")
   {
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "Furry Ranger")) )
        {
           object oSpawn = CreateItemOnObject("furryranger", oUser,1);
        }
   FloatingTextStringOnCreature("Use your Politically Incorrect Fringe items wisely...", oUser, FALSE);
   }
   else if (sName == "heart-" && sChar == "Furry Erotic Ranger")
   {
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "Furry Ranger")) )
        {
           object oSpawn = CreateItemOnObject("furryranger", oUser,1);
        }
   FloatingTextStringOnCreature("Use your Politically Incorrect Fringe items wisely...", oUser, FALSE);
   }
   else if (sName == "Terminer" && sChar == "Cthulhu Ranger")
   {
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "Cthulhu Ranger")) )
        {
           object oSpawn = CreateItemOnObject("cthulhuranger", oUser,1);
        }
   FloatingTextStringOnCreature("Use your Politically Incorrect Fringe items wisely...", oUser, FALSE);
   }
   else if (sName == "VvV-Aez" && sChar == "White Anglo-Saxon Protestant Ranger")
   {
        if(!GetIsObjectValid(GetItemPossessedBy(oUser, "WASP Ranger")) )
        {
           object oSpawn = CreateItemOnObject("waspranger", oUser,1);
        }
   FloatingTextStringOnCreature("Use your Politically Incorrect Fringe items wisely...", oUser, FALSE);
   }
   else
   {
   FloatingTextStringOnCreature("Aez has not finished on your PIF Ranger items yet. Sorry...", oUser, FALSE);
   }
}
