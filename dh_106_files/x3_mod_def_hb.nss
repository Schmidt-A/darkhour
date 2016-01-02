//::///////////////////////////////////////////////
//:: Heartbeat Event
//:: x3_mod_def_hb
//:: (c) 2008 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This heartbeat exists only to make sure it
    handles in its own way the benefits of having
    the feat Mounted Combat.   See the script
    x3_inc_horse for complete details of variables
    and flags that can be used with this.   This script
    is also used to provide support for persistence.
*/
//:://////////////////////////////////////////////
//:: Created By: Deva Winblood
//:: Created On: April 2nd, 2008
//:://////////////////////////////////////////////

#include "x3_inc_horse"
#include "_incl_rndloc"

void DoCatalystSearch(object oPC);

void DelayedCreateItemOnObject(string sResref, object oTarget, int nStacksize)
{
    CreateItemOnObject(sResref, oTarget, nStacksize);
}

void DoCatalystSearch(object oPC)
{
    // Ignore player if they're in a transition or something, or the safehouse
    if(!GetIsObjectValid(GetArea(oPC)) || GetTag(GetArea(oPC)) == "Sundered")
        return;

    float fFindRoll = Random(100)/1.0;
    fFindRoll = 1.0;

    // Rolled too high - move on to next player
    if(fFindRoll > GetLocalFloat(GetModule(), "MOD_BASIC_CATALYST_SPAWN_CHANCE"))
        return;

    // Otherwise they found one!
    location lRandom = RndLoc(GetLocation(oPC), 25, 25);

    // We're creating a temporary NPC here because it will spawn the NPC as close as possible
    // to our random location while making sure it is walkable. A pure random location resulted
    // in inaccessible object spawn locations.
    // TODO: Replace with placeable spawn so people can't tab find it
    object oTemp = CreateObject(OBJECT_TYPE_CREATURE, "CATALYST_SPAWNPOINT", lRandom);
    location lTarget = GetLocation(oTemp);
    DestroyObject(oTemp);
    // TODO: actually spawn an item here
    CreateObject(OBJECT_TYPE_ITEM, "", lTarget);
    SendMessageToPC(oPC, "The hairs on the back of your neck stand up as you sense a powerful magical fragment nearby...");
}


/////////////////////////////////////////////////////////////[ MAIN ]///////////
void main()
{
    object oPC=GetFirstPC();
    int nRoll;
    int bNoCombat=GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT");
    while(GetIsObjectValid(oPC))
    { // PC traversal
        if (GetLocalInt(oPC,"bX3_STORE_MOUNT_INFO"))
        { // store
            DeleteLocalInt(oPC,"bX3_STORE_MOUNT_INFO");
            HorseSaveToDatabase(oPC,X3_HORSE_DATABASE);
        } // store
        if (!bNoCombat&&GetHasFeat(FEAT_MOUNTED_COMBAT,oPC)&&HorseGetIsMounted(oPC))
        { // check for AC increase
            nRoll=d20()+GetSkillRank(SKILL_RIDE,oPC);
            nRoll=nRoll-10;
            if (nRoll>4)
            { // ac increase
                nRoll=nRoll/5;
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectACIncrease(nRoll),oPC,7.0);
            } // ac increase
        } // check for AC increase
        int iZkten = GetLocalInt(oPC, "zombkill10");
        int iZkhun = GetLocalInt(oPC, "zombkill100");
        int iZktho = GetLocalInt(oPC, "zombkill1000");
        int iZktto = GetLocalInt(oPC, "zombkill10k");
        int iFkten = GetLocalInt(oPC, "frenzykill10");
        int iFkhun = GetLocalInt(oPC, "frenzykill100");
        int iFktho = GetLocalInt(oPC, "frenzykill1000");
        if(iZkten > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("zombiekillx10", oPC, 1));
            DeleteLocalInt(oPC, "zombkill10");
            }
        if(iZkhun > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("zombiekhundred", oPC, 1));
            DeleteLocalInt(oPC, "zombkill100");
            }
        if(iZktho > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("zombiekthousand", oPC, 1));
            DeleteLocalInt(oPC, "zombkill1000");
            }
        if(iZktto > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("zombiektenthous", oPC, 1));
            DeleteLocalInt(oPC, "zombkill10k");
            }
        if(iFkten > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("frenzykillx10", oPC, 1));
            DeleteLocalInt(oPC, "frenzykill10");
            }
        if(iFkhun > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("frenzykillhund", oPC, 1));
            DeleteLocalInt(oPC, "frenzykill100");
            }
        if(iFktho > 0)
            {
            DelayCommand(3.0, DelayedCreateItemOnObject("frenzykillthous", oPC, 1));
            DeleteLocalInt(oPC, "frenzykill1000");
            }
//        object oZkone = GetItemPossessedBy(oPC, "ZombieKill");
//        int iZkone = GetItemStackSize(oZkone)
//        if(iZkone == 10)
//            {
//            CreateItemOnObject("zombiekillx10", oPC);
//            DestroyObject(oZkone);
//            }
        DoCatalystSearch(oPC);
        oPC=GetNextPC();
    } // PC traversal
    ExecuteScript("hungerscript", OBJECT_SELF);
}
/////////////////////////////////////////////////////////////[ MAIN ]///////////
