//::///////////////////////////////////////////////
//:: Name Things that go boom
//:: FileName xs_catapult_use

//:: Copyright (c) 2003 NWNZone.com
//:://////////////////////////////////////////////
/*
 This is the on use event for the catapults
 [Version .5a]
*/ //  ON USE Catapults
//:://////////////////////////////////////////////
//:: Created By: Jantima
//:: Created On: 11 Aug 2003
//:://////////////////////////////////////////////
#include "inc_bs_module"
#include "aw_detonate_loc"
//int iTurnToFaceTarget=FALSE;//Shall the catapult rotate towards target?
//Do not edit below this line.
void main()
{
if (GetLocalInt(OBJECT_SELF,"InUse") == 1)
    {
    return;
    }
else
    {
    SetLocalInt(OBJECT_SELF,"InUse",1);
 object oUser = GetLastUsedBy();
 int nTeam = GetPlayerTeam(oUser);
 SetLocalInt(OBJECT_SELF, "nTeam",nTeam);
 int iReloading = GetLocalInt(OBJECT_SELF,"reloading");
 if(iReloading==TRUE)
    return;
 SetLocalInt(OBJECT_SELF,"reloading",TRUE);
 //Do stuff
location lFinalTarget = GetLocation(GetObjectByTag("WP_hill"));
 //Set explosion delay
 float fRange = GetDistanceBetweenLocations(lFinalTarget, GetLocation(OBJECT_SELF));
 float fDelay = fRange / 12.0;
 //Do stuff
 AssignCommand(OBJECT_SELF, ActionCastFakeSpellAtLocation(SPELL_FIREBALL, lFinalTarget, PROJECTILE_PATH_TYPE_BALLISTIC));
 PlaySound("sim_explsun");
 DelayCommand(fDelay, BlastArea(lFinalTarget));
 DelayCommand(fDelay, SetLocalInt(OBJECT_SELF,"reloading",FALSE));
 DelayCommand(fDelay*5,SetLocalInt(OBJECT_SELF,"InUse",0));
 }
}
