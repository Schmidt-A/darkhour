#include "_incl_location"

string APPLIER_TAG = "Disease_Applier";

void ReduceDiseaseEffects(object oPC, int iDisease);
void CureDisease(object oPC, int iHowMany=10);
void ApplyDisease(object oPC);
void HBDiseaseCheck(object oPC, object oPCToken);


void ReduceDiseaseEffects(object oPC, int iDisease)
{
    object oApplier = GetObjectByTag(APPLIER_TAG);
    effect eEffect = GetFirstEffect(oPC);

    while(GetIsEffectValid(eEffect))
    {
        if(GetEffectCreator(eEffect) == oApplier)
            RemoveEffect(eEffect);
        eEffect = GetNextEffect(oPC);
    }

    /* This isn't great but it'll do for now. Redo this because we've removed
       all of the disease effects. */
    if(iDisease >= 2)
        ApplyDisease(oPC);
}

void CureDisease(object oPC, int iHowMany=10)
{
    object oPCToken = GetItemPossessedBy(oPC, "token_pc");
    int iDisease = GetLocalInt(oPCToken, "iDisease");
    if(iDisease < 1)
    {
        FloatingTextStringOnCreature("There was no disease to cure", oPC, FALSE);
        return;
    }

    ApplyEffectToObject(DURATION_TYPE_INSTANT,
                        EffectVisualEffect(VFX_IMP_REMOVE_CONDITION), oPC);

    int iDisease = iDisease-iHowMany;
    if(iDisease < 0)
        iDisease = 0;

    ReduceDiseaseEffects(oPC, iDisease);
    SetLocalInt(oPCToken, "iDisease", iDisease);
}

void ApplyDisease(object oPC)
{
    object oPCToken = GetObjectPossessedBy(oPC, "token_pc");
    object oApplier = GetObjectByTag(APPLIER_TAG);
    int iDisease = GetLocalInt(oPCToken, "iDisease");
    int iAbility;
    effect eEffect;

    switch(iDisease)
    {
        case 2:
            iAbility = ABILITY_CONSTITUTION;
            break;
        case 3:
            iAbility = ABILITY_DEXTERITY;
            break;
        case 4:
            iAbility = ABILITY_STRENGTH;
            break;
        case 5:
            iAbility = ABILITY_INTELLIGENCE;
            break;
        case 6:
            iAbility = ABILITY_WISDOM;
            break;
        case 7:
            iAbility = ABILITY_CHARISMA;
            break;
        case 8:
            eEffect = SupernaturalEffect(EffectAbilityDecrease(ABILITY_STRENGTH, 2));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));

            eEffect = SupernaturalEffect(EffectAbilityDecrease(ABILITY_DEXTERITY, 2));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));

            eEffect = SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION, 2));
            AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));
            break;
        case 9:
            eEffect = EffectConfused();
            int iDuration = IntToFloat(Random(60)+1);
            AssignCommand(oApplier, 
                    ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eEffect, oPC,
                    iDuration));
            break;
        default:
            break;
    }

    if(iDisease < 8)
    {
        eEffect = SupernaturalEffect(EffectAbilityDecrease(iAbility, 2));
        AssignCommand(oApplier, ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oPC));
    }
}

void HBDiseaseCheck(object oPC, object oPCToken)
{
    int iDisease = GetLocalInt(oPCToken, "iDisease");
    if(iDisease < 1)
        return;

    // We'll only ever gain more disease if we're injured.
    if(GetCurrentHitPoints(oPC) < GetMaxHitPoints(oPC))
    {
        SetLocalInt(oPC,"heltimer", 0); // Can't bother trying to heal.
        int nDisTimer = GetLocalInt(oPC,"distimer") + 1;
        if (nDisTimer >= 5)
        {
            nDisTimer = 0;
            if (FortitudeSave(oPC,(7 + nTotalDisease),SAVING_THROW_TYPE_DISEASE) == 0)
            {
                iDisease += 1;
                if (iDisease >= 9)
                {
                    CreateItemOnObject("deathtoken",oPC);
                    ExecuteScript("zombieclone",oPC);
                    PortToWaypoint(oPC, "lostsoularrive");
                    DelayCommand(0.3,FloatingTextStringOnCreature("Your body has become a zombie.",oPC,FALSE));
                    DelayCommand(0.5,FloatingTextStringOnCreature("You are now a lost soul.",oPC,FALSE));
                }
                else
                {
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectVisualEffect(VFX_IMP_DISEASE_S),oPC);
                    ApplyDisease(oPC);
                    FloatingTextStringOnCreature("The disease continues to spread...", oPC, FALSE);
                }
                SetLocalInt(oPCToken, "iDisease", iDisease);
            }
            else
                FloatingTextStringOnCreature("You resist the disease for now...", oPC, FALSE);
        }
        SetLocalInt(oPC, "distimer", nDisTimer);
    }
    // Otherwise we can try to start healing from it.
    else if(GetCurrentHitPoints(oPC) >= GetMaxHitPoints(oPC))
    {
        string sMsg = "";
        SetLocalInt(oPC, "distimer", 0);
        int nHelTimer = GetLocalInt(oPC,"heltimer") + 1;
        if (nHelTimer >= 160)
        {
            nHelTimer = 0;
            if (FortitudeSave(oPC,(7 + nTotalDisease), SAVING_THROW_TYPE_DISEASE) == 1)
            {
                iDisease -= 1;
                ReduceDiseaseEffects(oPC, iDisease);
                if (nTotalDisease == 1)
                {
                    RemoveDiseaseEffects(oPC);
                    sMsg = "The disease has completely passed.";
                }
                else
                    sMsg = "The disease fades a little.";
            }
            else
                sMsg = "Your disease condition remains stable, but does not improve.";
            FloatingTextStringOnCreature(sMsg, oPC, FALSE);
            SetLocalInt(oPCToken, "iDisease", iDisease);
        }
        SetLocalInt(oPC, "heltimer", nHelTimer);
    }
}
