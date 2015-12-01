#include "x2_inc_switches"
void main()
{
int nEvent = GetUserDefinedItemEventNumber();
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    object oPC = GetItemActivator();
    string sName = GetStringLeft(GetName(oPC), 7);
    if(sName != "Unebril")
        {
        SendMessageToPC(oPC, "This dog is not owned by you.");
        return;
        }
    if(GetObjectByTag("Zack_Dog") != OBJECT_INVALID)
        {
        SendMessageToPC(oPC, "Zack has already been summoned.");
        return;
        }
    int iAge = GetCampaignInt(GetName(GetModule()), "Zack_Age", oPC);
    if(iAge < 70)
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("zack_1", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
        }
    else if(iAge < 140)
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("zack_2", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
        }
    else if(iAge < 210)
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("zack_3", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
        }
    else
        {
        ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectSummonCreature("zack_4", VFX_IMP_UNSUMMON, 1.0, 1), oPC);
        }
    SetLocalInt(oPC, "haszack", 1);
    SetCampaignInt(GetName(GetModule()), "Zack_Age", iAge + 1, oPC);
    }
}
