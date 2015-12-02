//started new include as was getting conflicts with VectorToString and some other functions
//riddler7 9/12/2006
#include "inc_bs_module"
#include "x3_inc_horse"
//returns true if players are in range or either have flag
int DoApplyEffects(object oPlayer,object oTarget);

//remove temporary properties on item e.g holy sword
void RemoveTempProp(object oItem);

//return true if object is an ammo maker
void GetAmmoMakerValue(object oMaker);

//kill that damn horse
void DestroyHorse(object oHorse,object oOwner,string sHorseTag);

//kill horse by tag - cycle through players and find it
void DestroyHorseByTag(string sHorseTag);
//:://///////////////////////////////////////////////////
//::DoApplyEffects
//:://///////////////////////////////////////////////////
//::check if player is in range or has flag
//:://///////////////////////////////////////////////////
//::   Created by riddler7
//::   Created on 9/12/2006
//:://///////////////////////////////////////////////////
int DoApplyEffects(object oPlayer,object oTarget)
{
    //see if target has flag
    int nTeam = GetPlayerTeam(oTarget);
    int nEnemyTeam = 3 - nTeam;
    string szEnemyHasFlag = "oHasFlag_" + IntToString(nEnemyTeam);
    //see if barbarian has flag
    int nPlayerTeam = GetPlayerTeam(oPlayer);
    int nPlayerEnemyTeam = 3 - nPlayerTeam;
    string szPlayerEnemyHasFlag = "oHasFlag_" + IntToString(nPlayerEnemyTeam);


    int nTargetLvl = GetHitDice(oTarget);
    int nPlayerLvl = GetHitDice(oPlayer);

    if (oTarget == GetLocalObject(GetModule(), szEnemyHasFlag))
    {
         return TRUE;
    }
    else if (oPlayer == GetLocalObject(GetModule(), szPlayerEnemyHasFlag))
    {
         return TRUE;
    }
    else if (((nPlayerLvl-nTargetLvl) >= -5) &&((nPlayerLvl - nTargetLvl) <= 5))
    {
         return TRUE;
    }
    else return FALSE;


}

void RemoveTempProp(object oItem)
{

    itemproperty ip = GetFirstItemProperty(oItem);
    //FloatingTextStringOnCreature("Remove properties started....",oPC,FALSE);
    while (GetIsItemPropertyValid(ip))
    {

         // FloatingTextStringOnCreature("subtype: "  + IntToString(GetItemPropertySubType(ip)) + " item property:" + IntToString(GetItemPropertyType(ip)) + " attack bonus:" + IntToString(ITEM_PROPERTY_ATTACK_BONUS),oPC,FALSE);
           if (GetItemPropertyDurationType(ip) == DURATION_TYPE_INSTANT)
           {

                             RemoveItemProperty(oItem,ip);


            }



            ip = GetNextItemProperty(oItem);
    }

}

void DestroyHorse(object oHorse,object oOwner,string sHorseTag = "")
{
    if (oOwner == OBJECT_INVALID)
    {
        oOwner = HorseGetOwner(oHorse);
    }


    if (oOwner != OBJECT_INVALID)
    {
        if (HorseGetIsMounted(oOwner))
        {
            HorseInstantDismount(oOwner);

        }

        if (oHorse != OBJECT_INVALID)
        {
            HorseRemoveOwner(oHorse);
            DestroyObject(oHorse);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oHorse);
        }
        else
        {
            DestroyHorseByTag(sHorseTag);
        }
    }
    else
    {
        if (oHorse != OBJECT_INVALID)
        {
            DestroyObject(oHorse);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oHorse);
        }
        else
        {
            DestroyHorseByTag(sHorseTag);
        }
    }
}

void DestroyHorseByTag(string sHorseTag)
{
    object oHorse = GetObjectByTag(sHorseTag);
    object oPC;
    string sFoundHorseTag;

    BroadcastMessage(sHorseTag);

    if (oHorse != OBJECT_INVALID)
    {
        DestroyObject(oHorse);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oHorse);
    }
    else //horse is mounted, find, dismount owner, then destroy
    {
        object oPC = GetFirstPC();

        while (oPC != OBJECT_INVALID)
        {
            sFoundHorseTag = GetSkinString(oPC,"sX3_HorseMountTag");
            BroadcastMessage(GetName(oPC));
            BroadcastMessage(sFoundHorseTag);
            if (sFoundHorseTag == sHorseTag)
            {
                //PC is riding horse
                if (HorseGetIsMounted(oPC))
                {
                    HorseInstantDismount(oPC);
                }

                oHorse = GetObjectByTag(sHorseTag);
                HorseRemoveOwner(oHorse);
                DestroyObject(oHorse);
                ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDeath(),oHorse);
            }

            oPC = GetNextPC();
        }
    }
}
