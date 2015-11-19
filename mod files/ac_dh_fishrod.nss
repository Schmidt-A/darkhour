#include "x2_inc_switches"
void CatchFish(object oPC,int nDC)
{
if(GetIsSkillSuccessful(oPC,SKILL_DISCIPLINE,nDC))
    {
    int iRand = Random(200);
    if(iRand == 50)
        {
        CreateItemOnObject("deadbaby",oPC);
        }
    else
        {
        FloatingTextStringOnCreature("You've caught a fish!",oPC,FALSE);
        CreateItemOnObject("fish",oPC);
        }
    }
else
    {
    FloatingTextStringOnCreature("You let it get away...",oPC,FALSE);
    }
}
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    object oItem = GetItemActivated();
    int nFishing = GetLocalInt(oPC,"FishingPossible");
    if(nFishing != 1)
        {FloatingTextStringOnCreature("This is not a proper place to fish!",oPC,FALSE);}
    else
        {
        object oFishingSpot = GetNearestObjectByTag("FishingSpot",oPC);
        int nFishDC = GetLocalInt(oFishingSpot,"FishDC");
        int nFishSTR = GetLocalInt(oFishingSpot,"FishSTR");
        if(d100(1)>=65)
            {
            SetLocalInt(oFishingSpot,"FishDC",nFishDC+1);
            SetLocalInt(oFishingSpot,"FishSTR",nFishSTR+1);
            }
        if(GetName(oItem)=="Gnomish Fishing Rod")
            {nFishSTR = nFishSTR-10;}
        if(nFishSTR < 1)
            {nFishSTR = 1;}
        if(GetIsSkillSuccessful(oPC,SKILL_SEARCH,nFishDC))
            {
            FloatingTextStringOnCreature("You've got a bite! Hold on!",oPC,FALSE);
            DelayCommand(5.0,CatchFish(oPC,nFishSTR));
            }
        }
    }
}
