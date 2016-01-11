#include "x2_inc_switches"
void main()
{
object oPC = GetItemActivator();
object oTarget = GetItemActivatedTarget();
int iRand = Random(20) + 1;
int iStr = GetAbilityModifier(ABILITY_STRENGTH, oTarget);
int iRandTwo = Random(20) + 1;
int iStrTwo = GetAbilityModifier(ABILITY_STRENGTH, oPC);
int nEvent = GetUserDefinedItemEventNumber();
int iReady = GetLocalInt(OBJECT_SELF, "isready");
int iUsed = GetLocalInt(oPC, "hasdetained");
if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
    {
    if(GetIsPC(oTarget) == FALSE)
        {
        return;
        }
    if(GetDistanceBetweenLocations(GetLocation(oTarget), GetLocation(oPC)) > 5.0f)
        {
        SendMessageToPC(oPC, "You are too far to attempt to subdue.");
        return;
        }
    if(iReady > 0)
        {
        SendMessageToPC(oPC, "You cannot yet use this tool again.");
        return;
        }
    if(iUsed > 0 && GetLocalInt(oTarget, "isshackled") != 1)
        {
        SendMessageToPC(oPC, "You already have someone under arrest.");
        return;
        }
    int iLocked = GetLocalInt(oTarget, "isshackled");
    if(iLocked != 1)
        {
        SetLocalInt(OBJECT_SELF, "isready", 1);
        DelayCommand(60.0, SetLocalInt(OBJECT_SELF, "isready", 0));
        int iTotal = iRand + iStr;
        int iTotalTwo = iRandTwo + iStrTwo + 3;
        FloatingTextStringOnCreature("Strength check: " + IntToString(iRand) + " + " + IntToString(iStr) + " = " + IntToString(iTotal) + " vs DC:" + IntToString(iTotalTwo), oTarget, FALSE);
        FloatingTextStringOnCreature("Strength check: " + IntToString(iRandTwo) + " + " + IntToString(iStrTwo) + " = " + IntToString(iTotalTwo) + " + 3" + " vs DC:" + IntToString(iTotal), oPC, FALSE);
        if(iTotal >= iTotalTwo)
            {
            DelayCommand(1.5, FloatingTextStringOnCreature("Successful save.", oTarget, FALSE));
            DelayCommand(1.5, SendMessageToPC(oPC, "You failed to subdue " + GetName(oTarget)));
            }
            else
                {
                SetLocalInt(oPC, "hasdetained", 1);
                DelayCommand(1.5, SendMessageToPC(oTarget, "You failed to get away"));
                AssignCommand(oPC, ApplyEffectToObject(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_BEAM_CHAIN), oTarget));
                SetLocalInt(oTarget, "isshackled", 1);
                FloatingTextStringOnCreature("Now under arrest by " + GetName(oPC), oTarget, FALSE);
                DelayCommand(2.0f, AssignCommand(oTarget, ActionForceFollowObject(oPC, 2.0f)));
                SendMessageToPC(oPC, "You have successfully placed " + GetName(oTarget) + " under arrest. Use this tool again on them to release them.");
                }
        }
        else
            {
            SetLocalInt(OBJECT_SELF, "isready", 0);
            SetLocalInt(oTarget, "isshackled", 0);
            SetLocalInt(oPC, "hasdetained", 0);
            SendMessageToPC(oPC, "You have released " + GetName(oTarget));
            SendMessageToPC(oTarget, "You have been released");
            RemoveEffect(oPC, EffectVisualEffect(VFX_BEAM_CHAIN));
            RemoveEffect(oTarget, EffectVisualEffect(VFX_BEAM_CHAIN));
            RemoveEffect(oTarget, EffectCutsceneDominated());
            AssignCommand(oTarget, ClearAllActions());
            }
    }
}
