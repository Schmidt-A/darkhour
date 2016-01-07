#include "_incl_disease"

void main()
{
    object oPC = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sMsg = "";

    if(!GetIsPC(oTarget))
    {
        sMsg = "This item can only be used on players";
        FloatingTextStringOnCreature(sMsg, oPC, FALSE);
        return;
    }

    if(GetIsSkillSuccessful(oPC, SKILL_HEAL, 10) == TRUE)
    {
        CureDisease(oTarget, 1);
        sMsg = "You have cured some of the disease.";

        if(oPC != oTarget)
        {
            FloatingTextStringOnCreature("Some of your disease has been cured.",
                    oTarget, FALSE);
        }
    }
    else
    {
        sMsg = "Your healing knowledge was insufficient to alleviate any " +
            "of the plague.";
    }
    FloatingTextStringOnCreature(sMsg, oPC, FALSE);
}
