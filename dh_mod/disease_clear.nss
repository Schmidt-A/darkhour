#include "disease_inc"
void main()
{
    object oItem = GetItemActivated();
    object oTarget = GetItemActivatedTarget();
    object oPC = GetItemActivator();
    effect eClense = EffectVisualEffect(VFX_IMP_REMOVE_CONDITION);
    int nDiseased = FALSE;

    if (GetTag(oItem) == "SirandaHerb")
    {

        object oCheck = GetFirstItemInInventory(oPC);
        while (oCheck != OBJECT_INVALID)
        {
            if (GetTag(oCheck) == "ZombieDisease")
            {
                DestroyObject(oCheck);
                nDiseased = TRUE;
            }
            oCheck = GetNextItemInInventory(oPC);

        }
        if (nDiseased == TRUE)
        {
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eClense,oPC);
            FloatingTextStringOnCreature("The disease has been cured.",oPC,FALSE);
            RemoveDiseasedEffects(oPC);
        }
        else
        {
            FloatingTextStringOnCreature("There was no disease to cure.",oPC,FALSE);
        }
    }
    else if (GetTag(oItem) == "DiseaseRemedy")
    {
        if (GetIsPC(oTarget) == TRUE)
        {
            object oOne = GetItemPossessedBy(oTarget,"ZombieDisease");
            if (oOne == OBJECT_INVALID)
            {
                FloatingTextStringOnCreature("There was no disease to cure.",oPC,FALSE);
            }
            else
            {
                if (GetIsSkillSuccessful(oPC,SKILL_HEAL,10) == TRUE)
                {
                    DestroyObject(oOne);
                    ApplyEffectToObject(DURATION_TYPE_INSTANT,eClense,oPC);
                    FloatingTextStringOnCreature("You have cured some disease.",oPC,FALSE);
                    FloatingTextStringOnCreature("Some of your disease has been cured.",oTarget,FALSE);
                    RemoveDiseaseEffects(oPC);
                }
                else
                {
                    FloatingTextStringOnCreature("You failed to cure the disease.",oPC,FALSE);
                    FloatingTextStringOnCreature("Your disease has failed to be cured.",oPC,FALSE);
                }
            }
        }
        else
        {
            FloatingTextStringOnCreature("Invalid target.",oPC,FALSE);
        }
    }
}
