int KALARAM   = 0;
int ELEDHRETH = 1;
int FAELOTH   = 2;
int BARABAN   = 3;
int ANNEDHEL  = 4;
int SISPARA   = 5;

void KalaramVaultEffects(object oPC)
{
    // Vomit
    if(FortitudeSave(oPC, 14, SAVING_THROW_TYPE_NONE) < 1)
    {
        SendMessageToPC(GetName(oPC) + " is overwhelmed by the foul stench and " + 
                "fetid fumes of the sewers. They can't keep themselves from " + 
                "doubling over and throwing up.");
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                EffectKnockdown(), oPC, 4.0);

        /* We'll be nice and not keep infinitely reducing fort saves for
         * future puking. */
        effect eLoop = GetFirstEffect(oPC);
        int bCanPuke = TRUE;
        while(GetIsEffectValid(eLoop))
        {
           if(GetEffectType(eLoop) == EFFECT_TYPE_SAVING_THROW_DECREASE)
               bCanPuke = FALSE;
           eLoop = GetNextEffect(oPC);
        }

        if(bCanPuke)
        {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, 
                    EffectSavingThrowDecrease(SAVING_THROW_FORTITUDE), 120.0);
            object oPuke = CreateObject(OBJECT_TYPE_PLACEABLE, "puke_pile",
                    GetLocation(oPC));

        }

    }
}

// I guess this probably has to go on area heartbeat.
void main()
{
    int iVault = GetLocalInt(OBJECT_SELF, "iVault");
    object oPC = GetFirstObjectInArea();

    if(!GetIsPC(oPC))
        return;

    while(oPC != OBJECT_INVALID)
    {
        // TODO: How frequently do we want these hazards to happen?
        // Need to add a frequency counter and an OR case if they're near puke.

        switch(iVault)
        {
            case KALARAM:
                KalaramVaultEffects(oPC);
                break;
        }
    }
}
