//:://////////////////////////////////////////////////
//:: NW_C2_DEFAULT7
/*
  Default OnDeath event handler for NPCs.

  Adjusts killer's alignment if appropriate and
  alerts allies to our death.
 */
//:://////////////////////////////////////////////////
//:: Copyright (c) 2002 Floodgate Entertainment
//:: Created By: Naomi Novik
//:: Created On: 12/22/2002
//:://////////////////////////////////////////////////
//Player has killed an Ice Wyvern

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "_incl_xp"
void DelayedCreateObject(int nObjectType, string sTemplate, location lLocation, int bUseAppearAnimation=FALSE, string sNewTag="")
{
    CreateObject(nObjectType, sTemplate, lLocation, FALSE, "");
}
void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }
    craft_drop_items(oKiller);
    if(GetName(GetArea(OBJECT_SELF)) == "Stonepeaks")
        {
        location lLoc = GetLocation(GetWaypointByTag("wyvspawnhere"));
        DelayCommand(10800.0, DelayedCreateObject(OBJECT_TYPE_CREATURE, "icewyvernnew", lLoc, FALSE, ""));
        }

    object oArea = GetArea(OBJECT_SELF);
    object oPeople = GetFirstObjectInArea(oArea);
    while (oPeople != OBJECT_INVALID)
    {
        if ((GetIsPC(oPeople) == TRUE) && (GetIsDM(oPeople) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPeople,4.0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d8(2),DAMAGE_TYPE_NEGATIVE),oPeople);
            if (GetItemPossessedBy(oPeople,"badge32") == OBJECT_INVALID)
            {
                CreateItemOnObject("badge32",oPeople);
                FloatingTextStringOnCreature("You received a new badge!", oPeople, FALSE);
                GiveXPToCreatureDH(oPeople, 100, "XP_BOSS");
            }
        }
        oPeople = GetNextObjectInArea(oArea);
    }
}
