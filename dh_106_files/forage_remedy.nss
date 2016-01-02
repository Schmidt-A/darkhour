void main()
{
    object oPC = GetItemActivator();
    string sTag = GetTag(GetItemActivated());

    string sMsg = "Remedial herbs can only be found in the deepest part of the woods.";
    string sRemedy = "diseaseremedy";

    if(sTag == "Forager" || sTag == "HerbalForager")
    {
        if(GetLocalInt(oPC, "bCanForage") == TRUE)
        {
            if(sTag == "Forager")
                sRemedy = "foragedremedy";

            // Rangers/druids can only carry one remedy
            if(GetResRef(GetItemPossessedBy(oPC, sRemedy)) != sRemedy)
            {
                sMsg = "You could not find any useful herbs.";
                FloatingTextStringOnCreature(sMsg, oPC, FALSE);
                return;
            }

            if(GetIsSkillSuccessful(oPC, SKILL_SPOT, 10) == TRUE)
            {
                sMsg = "You've found some herbs that can help cure the plague!";


                AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW,
                                                       1.0, 2.0));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,
                                    EffectCutsceneImmobilize(), oPC, 2.0);
                object oRemedy = CreateItemOnObject(sRemedy, oPC);
            }
            else
                sMsg = "You could not find any useful herbs.";
        }
        FloatingTextStringOnCreature(sMsg, oPC, FALSE);
    }
}
