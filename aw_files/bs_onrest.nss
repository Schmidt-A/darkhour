#include "inc_bs_module"
#include "ld_inc_gwshp"

 //the misterious item keeps track of all the spells they cast from items and it's used int eh aw_spellhook

void main()
{
     object oPC = GetLastPCRested();
     if (GetLastRestEventType() == REST_EVENTTYPE_REST_STARTED)
     {
     // ClearShifterStored(oPC);
     SetLocalInt(oPC, "nHeal",0);
     //Destroy item mysterious object
     DestroyObject(GetLocalObject(oPC,"spelltracker"));
     }
    if (GetLastRestEventType() == REST_EVENTTYPE_REST_FINISHED || GetLastRestEventType() == REST_EVENTTYPE_REST_CANCELLED )
     {
     SetLocalObject (oPC,"spelltracker",CreateItemOnObject("mysteriousobject",oPC));
     }



}
