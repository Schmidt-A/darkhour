void main()
{
    object oPC = GetEnteringObject();

    effect eLoop = GetFirstEffect(oPC);
    while(GetIsEffectValid(eLoop))
    {
       if(GetEffectType(eLoop) == EFFECT_TYPE_MOVEMENT_SPEED_DECREASE)
       {
           RemoveEffect(oPC, eLoop);
           return;
       }
       eLoop = GetNextEffect(oPC);
    }
}
