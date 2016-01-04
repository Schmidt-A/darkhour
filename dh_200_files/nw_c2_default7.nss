// Code clean up by Zunath on July 22, 2007

#include "x2_inc_compon"
#include "x0_i0_spawncond"
#include "nw_i0_tool"

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
        //SendMessageToAllDMs(sZombie+" ATTEMPTED TO CREATE! AT "+GetName(oSpawn));
}

void RespawnZombie(object oSpawn, object oKiller)
{

float fDelay = GetLocalFloat(oSpawn,"SPAWN_DELAY");
object oArea = GetArea(oSpawn);
object oOriginalSpawn = oSpawn;
object oSecondSpawn = GetFirstObjectInArea(oArea);
float fDist = 0.0f;
while(oSecondSpawn != OBJECT_INVALID)
{
    if(GetTag(oSecondSpawn)=="ZOMBIE_SPAWN" && GetDistanceBetween(oSecondSpawn,oKiller) > fDist)
    {
        fDist = GetDistanceBetween(oSecondSpawn,oKiller);
        oSpawn = oSecondSpawn;
    }
oSecondSpawn = GetNextObjectInArea(oArea);
}

//SendMessageToAllDMs("Fired Script Respawn! on spawn-point "+GetName(oSpawn));
DelayCommand(fDelay,SpawnZombie(oSpawn,oOriginalSpawn));
}

void main()
{
    object oKiller = GetLastKiller();
    int DMX_SPAWNED = GetLocalInt(OBJECT_SELF,"DMX_SPAWNED");
    if(DMX_SPAWNED)
        {
        object oSpawn = GetLocalObject(OBJECT_SELF,"SPAWN_POINT");
        //if(oKiller!=OBJECT_INVALID)
        //     oSpawn = GetNearestObjectByTag("ZOMBIE_SPAWN",oKiller);//GetLocalObject(OBJECT_SELF,"SPAWN_POINT");
        // else
        //      oSpawn = GetNearestObjectByTag("ZOMBIE_SPAWN");
        AssignCommand(GetArea(OBJECT_SELF),RespawnZombie(oSpawn,oKiller));
        }
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);


    // If we're a good/neutral commoner,
    // adjust the killer's alignment evil
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    object oPC = GetLastKiller();

    if (!GetIsPC(oPC)) return;


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
    if ((GetIsPC(oDamager)) && (GetIsPossessedFamiliar(oDamager) == FALSE))
    {
        // Create a Zombie Kill token on the player.
        CreateItemOnObject("zombiekill",oDamager,1);

        // If the hour is 0, give the player a frenzy kill
        if (GetTimeHour() == 0)
        {CreateItemOnObject("frenzykill",oDamager,1);}

        // If the player has "golden roleplay", give them 3 exp for killing the
        // zombie.
        if (GetItemPossessedBy(oDamager, "greatroleplay")!= OBJECT_INVALID)
        {
        if (GetAbilityScore(OBJECT_SELF, ABILITY_STRENGTH)<= 14)
        {
        }
        else
        {
        int iZkc = GetLocalInt(oDamager, "zkxpcount");
        if(iZkc < 50)
            {
            iZkc += 1;
            SetLocalInt(oDamager, "zkxpcount", iZkc);
            RewardPartyXP(3, oDamager, FALSE);
            }
        }
        }

        // Give badge to player if they defeated "ZN_VIPER"
        // Also give 200 EXP.
        else if ((GetTag(OBJECT_SELF) == "ZN_VIPER") && (GetItemPossessedBy(oDamager,"badge26") == OBJECT_INVALID))
        {
            CreateItemOnObject("badge26",oDamager);
            FloatingTextStringOnCreature("You received a new badge!", oDamager, FALSE);
            GiveXPToCreature(oDamager,200);
        }

}
}
