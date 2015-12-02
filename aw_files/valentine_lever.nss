#include "inc_bs_module"
void main()
{
object oModule = GetModule();
int nValentineStatus = GetLocalInt(oModule,"ValentineDay");

ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
if (nValentineStatus == 1) //DM Activate / Deactivate
   {
   SetLocalInt(oModule,"ValentineDay",0);
   FloatingTextStringOnCreature ("Valentine's Day Disabled",GetLastUsedBy(),FALSE);
   BroadcastMessage("<cß×@>Valentine's Day Party is Finished!</c>");
   //remove Cupids
   //NPC TAG = Cupid
   //Waypoint =  WP_Cupid
   //NB: The Number One/Zero ? is In DM Area
   object oCupid = GetObjectByTag("Cupid",0);
   SetPlotFlag(oCupid,FALSE);
   DestroyObject(oCupid);
   oCupid = GetObjectByTag("Cupid",1);
   SetPlotFlag(oCupid,FALSE);
   DestroyObject(oCupid);
   oCupid = GetObjectByTag("Cupid",2);
   SetPlotFlag(oCupid,FALSE);
   DestroyObject(oCupid);
   oCupid = GetObjectByTag("Cupid",3);
   SetPlotFlag(oCupid,FALSE);
   DestroyObject(oCupid);
   //Remove All stored var/object on the player .. hmm too lazy to script this, they'll lose on logout
   }
else if (nValentineStatus  == 0)
    {
   SetLocalInt(oModule,"ValentineDay",1);
   FloatingTextStringOnCreature ("Valentine's Day Enabled",GetLastUsedBy(),FALSE);
   BroadcastMessage("<cø.>Valentine's Day Party is started!</c>");
   //spawn cupids ...
   CreateObject(OBJECT_TYPE_CREATURE,"cupid",GetLocation(GetObjectByTag("WP_Cupid",0)), TRUE);
   CreateObject(OBJECT_TYPE_CREATURE,"cupid",GetLocation(GetObjectByTag("WP_Cupid",1)), TRUE);
   CreateObject(OBJECT_TYPE_CREATURE,"cupid",GetLocation(GetObjectByTag("WP_Cupid",2)), TRUE);
   CreateObject(OBJECT_TYPE_CREATURE,"cupid",GetLocation(GetObjectByTag("WP_Cupid",3)), TRUE);
   }
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);

}
