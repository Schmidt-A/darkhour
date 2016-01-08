// This Function Drops nHowMany random items from the Player-Killed character
void DropRandomItems(int nHowMany, object oPlayer, object oKiller);

//This Function Awakes the Player-Killed Character after nTime, if he is not Perma-Killed within nTime
void Awake(object oKnocked, object oDeathToken);

//This is the Main Function for PVP-Kills, it is a combination and control of the latter two functions.
void PVPKill(object oDying, object oKiller, object oDeathToken);

void DropRandomItems(int nHowMany, object oPlayer, object oKiller)
{
location lLoc = GetLocation(oKiller);
object oLoot = CreateObject(OBJECT_TYPE_PLACEABLE,"knockloot",lLoc);
object oItems = GetFirstItemInInventory(oPlayer);
int nItems, nRandom;
while(oItems != OBJECT_INVALID && nItems != nHowMany)
    {
    nRandom = Random(3);
    if(nRandom == 1 && GetItemCursedFlag(oItems) == FALSE && GetItemStackSize(oItems) == 1)
        {
        AssignCommand(oLoot,ActionTakeItem(oItems,oPlayer));
        nItems =nItems+1;
        }
    oItems = GetNextItemInInventory(oPlayer);
    }
if(nItems != nHowMany)
    {
    oItems = GetFirstItemInInventory(oPlayer);
    if(GetItemCursedFlag(oItems) == FALSE && GetItemStackSize(oItems) == 1)
        {
        AssignCommand(oLoot,ActionTakeItem(oItems,oPlayer));
        }
    }
}

void Awake(object oKnocked, object oDeathToken)
{
DestroyObject(oDeathToken);
while(GetCurrentHitPoints(oKnocked)<=0)
{
ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectHeal(1),oKnocked);
}
SetLocalInt(oKnocked,"KnockedOut",0);
}

void PVPKill(object oDying, object oKiller, object oDeathToken)
{
if(GetLocalInt(oDying,"KnockedOut")==1)
{
    PlayVoiceChat(VOICE_CHAT_DEATH); /* scream one last time */
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_IMP_DEATH), OBJECT_SELF); /* make death dramatic */
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), oDying); /* now kill them */
}
SetLocalInt(oDying,"KnockedOut",1);
FloatingTextStringOnCreature("You have been temporarily knocked-out!",oDying,FALSE);
ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectBlindness(),oDying,120.0);
int nRandom = Random(3)+1;
DropRandomItems(nRandom, oDying, oDying);
DelayCommand(120.0,Awake(oDying,oDeathToken));
}
