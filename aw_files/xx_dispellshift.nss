int GetIsShifted(object oTarget)
{
effect eCheck = GetFirstEffect(oTarget);
while(GetIsEffectValid(eCheck))
    {
        if(GetEffectType(eCheck) == EFFECT_TYPE_POLYMORPH)
            return TRUE;
        else eCheck = GetNextEffect(oTarget);
    }
return FALSE;
}

void main()
{
object oTarget = GetItemActivatedTarget();
object oPC = GetItemActivator();
if(GetIsObjectValid(oTarget)) {
int Class1 = GetClassByPosition(1, oTarget);
int Class2 = GetClassByPosition(2, oTarget);
int Class3 = GetClassByPosition(3, oTarget);
if(Class1 == CLASS_TYPE_SHIFTER || Class3 == CLASS_TYPE_SHIFTER || Class2 == CLASS_TYPE_SHIFTER)
    {
    int iSave = WillSave(oTarget, GetHitDice(oPC) + d10(1), SAVING_THROW_TYPE_NONE, oPC);
    if(GetIsShifted(oTarget) && (iSave == 0 || iSave == 2))
        {
        if(iSave == 2) iSave = FortitudeSave(oTarget, GetHitDice(oPC) + d10(1), SAVING_THROW_TYPE_NONE, oPC);
        if(iSave == 0)
            {
            effect eRemove = GetFirstEffect(oTarget);
            while(GetIsEffectValid(eRemove))
                {
                RemoveEffect(oTarget, eRemove);
                eRemove = GetNextEffect(oTarget);
                }
            }
        }
    }
}
}
