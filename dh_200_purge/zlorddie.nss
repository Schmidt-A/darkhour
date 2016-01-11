#include "_incl_xp"
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

#include "x2_inc_compon"
#include "x0_i0_spawncond"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_MIND),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_HOWL_WAR_CRY),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_IMPLOSION),OBJECT_SELF);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_FNF_MYSTICAL_EXPLOSION),OBJECT_SELF);
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

    object oDamager = GetLastDamager();
    if (GetIsPC(oDamager))
    {
        CreateItemOnObject("zombiekill",oDamager,1);
        if (GetTimeHour() == 0)
        {
            CreateItemOnObject("frenzykill",oDamager,1);
        }
    }

    object oArea = GetArea(OBJECT_SELF);
    object oPeople = GetFirstObjectInArea(oArea);
    while (oPeople != OBJECT_INVALID)
    {
        if ((GetIsPC(oPeople) == TRUE) && (GetIsDM(oPeople) == FALSE))
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectKnockdown(),oPeople,4.0);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(d8(2),DAMAGE_TYPE_NEGATIVE),oPeople);
            if (GetItemPossessedBy(oPeople,"badge25") == OBJECT_INVALID)
            {
                CreateItemOnObject("badge25",oPeople);
                FloatingTextStringOnCreature("You received a new badge!", oPeople, FALSE);
                GiveXPToCreatureDH(oPeople,300);;
            }
        }
        oPeople = GetNextObjectInArea(oArea);
    }

    location lLoc = GetLocation(GetWaypointByTag("zlspawn"));
    effect eAppear = EffectVisualEffect(VFX_FNF_DISPEL_DISJUNCTION);
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eAppear,lLoc);
    object oPortal1 = CreateObject(OBJECT_TYPE_PLACEABLE,"spireportal",lLoc);
}
