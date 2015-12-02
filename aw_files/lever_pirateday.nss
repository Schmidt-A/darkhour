#include "aw_include"

void main()
{
object oPC = GetLastUsedBy();
///NO Spam check!!!!/////
if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
{
    return;
}
object oModule = GetModule();
int nPirateStatus = GetLocalInt(oModule,"PirateDay");
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
if (nPirateStatus == 1)
{
    SetLocalInt(oModule,"PirateDay",0);
   FloatingTextStringOnCreature ("Pirate Day Disabled",GetLastUsedBy(),FALSE);
   BroadcastMessage("<cß×@>International Talk Like a Pirate Day Party is Finished!</c>");
   object oPirate = GetObjectByTag("antiworld_pirate",0);
   SetPlotFlag(oPirate,FALSE);
   DelayCommand(2.0,DestroyObject(oPirate));
   object oParrot = GetObjectByTag("SwordJugglinGus",0);
   SetPlotFlag(oParrot,FALSE);
   DelayCommand(2.0,DestroyObject(oParrot));
   object oAw = GetObjectByTag("antiworld_npc");
   SetName(oAw,"Antiworld");
   AssignCommand(oAw,ClearAllActions());
   AssignCommand(oAw,ActionJumpToLocation(GetLocation(GetWaypointByTag("POST_antiworld_npc"))));
}
else if (nPirateStatus  == 0)
    {
   SetLocalInt(oModule,"PirateDay",1);
   FloatingTextStringOnCreature ("Pirate Day Enabled",GetLastUsedBy(),FALSE);
   BroadcastMessage("<cø.>International Talk Like a Pirate Day Party is started!</c>");
   object oAw = GetObjectByTag("antiworld_npc");
   AssignCommand(oAw,ClearAllActions());
   AssignCommand(oAw,ActionJumpToLocation(GetLocation(GetWaypointByTag("aw_teleport"))));
   SetName(oAw,"Frownin' Hank Morgan");

   //SetPlotFlag(oAw,FALSE);
   //DelayCommand(2.0,DestroyObject(oAw));
   CreateObject(OBJECT_TYPE_CREATURE,"antiworld003",GetLocation(GetObjectByTag("POST_antiworld_npc",0)), TRUE);
   CreateObject(OBJECT_TYPE_CREATURE,"pirateparrot",GetLocation(GetObjectByTag("POST_parrot_npc",0)), TRUE);
   }
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

}
