void main()
{

    //Declare major variables
    location lTarget = GetLocation(OBJECT_SELF);
    effect eVis = EffectVisualEffect(VFX_FNF_TIME_STOP);
    effect eTime = EffectTimeStop();
    int nRoll = 1 + d4();


    {
        //Fire cast spell at event for the specified target
        SignalEvent(OBJECT_SELF, EventSpellCastAt(OBJECT_SELF, SPELL_TIME_STOP, FALSE));

        //Apply the VFX impact and effects
        DelayCommand(0.75, ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eTime, OBJECT_SELF, 9.0));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eVis, lTarget);
    }

}

