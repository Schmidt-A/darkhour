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

SetLocalInt(GetModule(),"PriDragonStone2",1);
///Reward the killer(s)///
int nReward = 500;
int nPlayersNear = 0;
object oPlayer = GetFirstObjectInArea();
     while ( GetIsObjectValid(oPlayer))
     {
        if (GetIsPC(oPlayer)&& GetDistanceToObject(oPlayer) < 14.0)
        {
        nPlayersNear = nPlayersNear+1;
        SetXP(oPlayer,(GetXP(oPlayer)+ 200));
         GiveGoldToCreature(oPlayer,200);
        }
     oPlayer = GetNextObjectInArea();
     }

SetXP(oKiller,(GetXP(oKiller)+ nReward/nPlayersNear));
 GiveGoldToCreature(oKiller,nReward/nPlayersNear);
}
