// Code clean up by Zunath on July 22, 2007
// More cleanup by Tweek Jan 2016. TODO: needs more.

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "nw_i0_tool"

const int MAX_ZOMBIE_KILLS  = 50;
const int ZOMBIE_KILL_XP    = 3;

void main()
{
    // Call to allies to let them know we're dead
    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);

    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);

    // NOTE: the OnDeath user-defined event does not
    // trigger reliably and should probably be removed
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
         SignalEvent(OBJECT_SELF, EventUserDefined(1007));

    object oDamager = GetLastDamager();

    // If this is a summoned creature/familiar, get its master so we can give
    // them the XP and the kill token.
    if(!GetIsPC(oDamager))
    {
        while(GetIsObjectValid(GetMaster(oDamager)))
            oDamager = GetMaster(oDamager);        
    }

    // Couldn't find an owner for this creature - bail.
    if(!GetIsPC(oDamager))
        return;
        
    SetLocalInt(oDamager, "iZombieKills", GetLocalInt(oDamager,"iZombieKills")+1);
    // TODO: kill badges
    if (GetTimeHour() == 0)
        CreateItemOnObject("frenzykill", oDamager, 1);

    int iZombieKills = GetLocalInt(oDamager, "zkxpcount");
    if(iZombieKills < MAX_ZOMBIE_KILLS)
    {
        SetLocalInt(oDamager, "zkxpcount", iZombieKills+1);
        GiveXPToCreatureDH(ZOMBIE_KILL_XP, oDamager);
    }
}
