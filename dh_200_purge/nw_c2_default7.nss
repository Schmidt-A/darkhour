// Code clean up by Zunath on July 22, 2007

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "nw_i0_tool"

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

    object oPC = GetLastKiller();
    if (!GetIsPC(oPC))
        return;

    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));

    craft_drop_items(oKiller);

    object oDamager = GetLastDamager();
    if ((GetIsPC(oDamager)) && (GetIsPossessedFamiliar(oDamager) == FALSE))
    {
        // Create a Zombie Kill token on the player.
        CreateItemOnObject("zombiekill",oDamager,1);

        // If the hour is 0, give the player a frenzy kill
        if (GetTimeHour() == 0)
        {CreateItemOnObject("frenzykill",oDamager,1);}

        // As long as they're not at the 50 kill cap, give them xp
        int iZkc = GetLocalInt(oDamager, "zkxpcount");
        if(iZkc < 75)
        {
            iZkc += 1;
            SetLocalInt(oDamager, "zkxpcount", iZkc);
            RewardPartyXP(2, oDamager, FALSE);
        }

        // Give badge to player if they defeated "ZN_VIPER"
        // Also give 200 EXP.
        else if ((GetTag(OBJECT_SELF) == "ZN_VIPER") && (GetItemPossessedBy(oDamager,"badge26") == OBJECT_INVALID))
        {
            CreateItemOnObject("badge26",oDamager);
            FloatingTextStringOnCreature("You received a new badge!", oDamager, FALSE);
            GiveXPToCreatureDH(oDamager,200);
        }

    }
}
