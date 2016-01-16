/* These miserable vault additions written by Tweek 2016. */

const int KALARAM   = 0;
const int ELEDHRETH = 1;
const int FAELOTH   = 2;
const int BARABAN   = 3;
const int ANNEDHEL  = 4;
const int SISPARA   = 5;

void VaultSaveFail(object oPC, int iSave)
{
    // We'll be nice and not keep infinitely reducing saves.
    effect eLoop = GetFirstEffect(oPC);
    int bFullFort = TRUE;
    while(GetIsEffectValid(eLoop))
    {
       if(GetEffectType(eLoop) == EFFECT_TYPE_SAVING_THROW_DECREASE)
           bFullFort = FALSE;
       eLoop = GetNextEffect(oPC);
    }
    if(bFullFort)
    {
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                EffectSavingThrowDecrease(iSave, 2), oPC, 120.0);

    }
}

void FaelothVaultEffects(object oPC)
{
    if(ReflexSave(oPC, 12, SAVING_THROW_TYPE_NONE) < 1)
    {
        string sName = GetName(oPC);
        SendMessageToPC(oPC, sName + " fails to keep their footing and slips." +
                " Their joints ache for a short while after slamming into the " +
                "unforgiving icy floor.");
        VaultSaveFail(oPC, SAVING_THROW_REFLEX);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 4.0);
    }
    if(FortitudeSave(oPC, 14, SAVING_THROW_TYPE_NONE) < 1)
    {
        SendMessageToPC(oPC, "The frigid air of this frozen passage chills blood " +
                "and flesh alike.");
        effect eDamage = EffectDamage(5, DAMAGE_TYPE_COLD, DAMAGE_POWER_NORMAL);
        ApplyEffectToObject(DURATION_TYPE_INSTANT, eDamage, oPC);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                            EffectVisualEffect(VFX_IMP_FROST_S), oPC);
    }
}

void VomitCheck(object oPC, string sMsg)
{
    if(FortitudeSave(oPC, 14, SAVING_THROW_TYPE_NONE) < 1)
    {
        SendMessageToPC(oPC, sMsg);
        VaultSaveFail(oPC, SAVING_THROW_FORT);
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectKnockdown(), oPC, 4.0);

        object oPuke = CreateObject(OBJECT_TYPE_PLACEABLE, "hazard_puke",
                                    GetLocation(oPC));
        /* Our own vomit won't make us puke, so we don't get stuck in some barf loop */
        SetLocalInt(oPuke, GetName(oPC), 1);
        DelayCommand(120.0, DestroyObject(oPuke));
    }
}

void KalaramVaultEffects(object oPC)
{
    if(GetLocalInt(OBJECT_SELF, "iHBTicks") == GetLocalInt(OBJECT_SELF, "iHBInterval"))
    {
        string sMsg = GetName(oPC) + " is overwhelmed by the foul stench and " +
                "fetid fumes of the sewers. They can't keep themselves from " +
                "doubling over and throwing up.";
        VomitCheck(oPC, sMsg);
    }
    else
    {
        location lLoc = GetLocation(oPC);
        object oPuke = GetFirstObjectInShape(SHAPE_SPHERE, 10.0, lLoc, FALSE,
                                                        OBJECT_TYPE_PLACEABLE);
        while(GetIsObjectValid(oPuke))
        {
            if(GetResRef(oPuke) == "hazard_puke")
            {
                string sName = GetName(oPC);
                if(!GetLocalInt(oPuke, sName))
                {
                    string sMsg = GetName(oPC) + " can't handle the disgusting pile " +
                            "of a companion's vomit nearby, driving them to be sick " +
                            "themselves.";
                    VomitCheck(oPC, sMsg);
                }
            }
            oPuke = GetNextObjectInShape(SHAPE_SPHERE, 10.0, lLoc);
        }
    }
}

void main()
{
    int iPCCount = GetLocalInt(OBJECT_SELF, "iPCCount");
    // Don't waste time on this if there are no PCs in the area.
    if(iPCCount < 1)
        return;

    // Keep track of HB interval so we only apply effects when we want to.
    int iHBTicks = GetLocalInt(OBJECT_SELF, "iHBTicks");
    if(iHBTicks <= GetLocalInt(OBJECT_SELF, "iHBInterval"))
        SetLocalInt(OBJECT_SELF, "iHBTicks", iHBTicks+1);
    else
        SetLocalInt(OBJECT_SELF, "iHBTicks", 1);

    int iVault = GetLocalInt(OBJECT_SELF, "iVault");
    object oObject = GetFirstObjectInArea();

    while(GetIsObjectValid(oObject))
    {
        WriteTimestampedLogEntry(GetTag(oObject));
        if(GetIsPC(oObject) && !GetLocalInt(oObject, "iHazardsChecked"))
        {
            switch(iVault)
            {
                case KALARAM:
                    SetLocalInt(oObject, "iHazardsChecked", TRUE);
                    KalaramVaultEffects(oObject);
                    break;
                case ELEDHRETH: // Need updated miners
                    break;
                case FAELOTH:
                    FaelothVaultEffects(oObject);
                    break;
            }
        }
        oObject = GetNextObjectInArea();
    }

    /* Ok at first glance this looks like: wtf are you doing Tweek.
     * Because we might create puke piles in the middle of doing the loop over
     * objects in an area, it can totally break the list (list iteration screws
     * up really hard if you modify it in the middle of an iteration). That's
     * why that iHazardsChecked flag gets set. We have to un-set it here once
     * the loop is done though, so that the check can happen on the next interval. */
    if(iVault == KALARAM)
    {
        oObject = GetFirstObjectInArea();
        while(GetIsObjectValid(oObject))
        {
             if(GetIsPC(oObject))
                SetLocalInt(oObject, "iHazardsChecked", FALSE);
             oObject = GetNextObjectInArea();
        }
    }
}
