// Code clean up by Zunath on July 22, 2007
// More cleanup by Tweek Jan 2016. TODO: needs more.

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "nw_i0_tool"

const int MAX_ZOMBIE_KILLS  = 50;
const int ZOMBIE_KILL_XP    = 3;

void SpawnZombie(object oSpawn, object oWaypoint)
{
    int nCount = 1;
    string sZombie = GetLocalString(oSpawn,"Zombie"+IntToString(nCount));
    while(sZombie != "")
    {
        nCount++;
        sZombie = GetLocalString(oSpawn,"Zombie"+IntToString(nCount));
    }
    nCount--;
    sZombie = GetLocalString(oSpawn,"Zombie"+IntToString(Random(nCount)+1));

    object oZombie;
    int nChance = Random(100)+1;
    if(GetLocalInt(oSpawn,"BEHEMOTH")>=nChance)
         oZombie = CreateObject(OBJECT_TYPE_CREATURE,"zn_zombie017",GetLocation(oSpawn));
    else
         oZombie = CreateObject(OBJECT_TYPE_CREATURE,sZombie,GetLocation(oSpawn));

    SetLocalInt(oZombie,"DMX_SPAWNED",TRUE);
    SetLocalObject(oZombie,"SPAWN_POINT",oWaypoint);
    AssignCommand(oZombie,ClearAllActions());
    AssignCommand(oZombie,ActionMoveToObject(oWaypoint));
}

void RespawnZombie(object oSpawn, object oKiller)
{
    float fDelay = GetLocalFloat(oSpawn,"SPAWN_DELAY");
    float fDist = 0.0f;
    object oArea = GetArea(oSpawn);
    object oOriginalSpawn = oSpawn;
    object oSecondSpawn = GetFirstObjectInArea(oArea);
    
    while(oSecondSpawn != OBJECT_INVALID)
    {
        if(GetTag(oSecondSpawn)=="ZOMBIE_SPAWN" && GetDistanceBetween(oSecondSpawn,oKiller) > fDist)
        {
            fDist = GetDistanceBetween(oSecondSpawn,oKiller);
            oSpawn = oSecondSpawn;
        }
        oSecondSpawn = GetNextObjectInArea(oArea);
    }
    DelayCommand(fDelay,SpawnZombie(oSpawn,oOriginalSpawn));
}

void main()
{
    object oKiller = GetLastKiller();

    int DMX_SPAWNED = GetLocalInt(OBJECT_SELF,"DMX_SPAWNED");
    if(DMX_SPAWNED)
    {
        object oSpawn = GetLocalObject(OBJECT_SELF,"SPAWN_POINT");
        AssignCommand(GetArea(OBJECT_SELF),RespawnZombie(oSpawn,oKiller));
    }

    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);

    // If we're a good/neutral commoner, adjust the killer's alignment evil
    // Tweek: Do we really want script-triggered alignment changes?
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);

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
        
    CreateItemOnObject("zombiekill", oDamager, 1);
    if (GetTimeHour() == 0)
        CreateItemOnObject("frenzykill", oDamager, 1);

    int iZombieKills = GetLocalInt(oDamager, "zkxpcount");
    if(iZombieKills < MAX_ZOMBIE_KILLS)
    {
        SetLocalInt(oDamager, "zkxpcount", iZombieKills+1);
        GiveXPToCreatureDH(ZOMBIE_KILL_XP, oDamager);
    }
}
