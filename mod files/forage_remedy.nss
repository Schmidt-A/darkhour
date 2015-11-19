void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    string sItem = GetTag(oItem);

    if (sItem == "Forager")
    {
        object oArea = GetArea(oUser);
        if (GetSubString(GetResRef(GetArea(oUser)),0,8) == "Ringwood")
        {
            if (GetIsSkillSuccessful(oUser,SKILL_SPOT,10) == TRUE)
            {
                AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oUser,2.0);
                object oRemedy = CreateItemOnObject("foragedremedy",oUser);
                FloatingTextStringOnCreature("Foraged remedy obtained.",oUser,FALSE);
            }
            else
            {
                FloatingTextStringOnCreature("You could not find any useful herbs.",oUser,FALSE);
            }
        }
        else
        {
            FloatingTextStringOnCreature("This can only be used in the Darkglade.",oUser,FALSE);
        }
    }
    else if (sItem == "HerbalForager")
    {
        object oArea = GetArea(oUser);
        if (GetSubString(GetResRef(GetArea(oUser)),0,8) == "Ringwoods")
        {
            if (GetIsSkillSuccessful(oUser,SKILL_SPOT,10) == TRUE)
            {
                AssignCommand(oUser,ActionPlayAnimation(ANIMATION_LOOPING_GET_LOW, 1.0, 2.0));
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY,EffectCutsceneImmobilize(),oUser,2.0);
                object oRemedy = CreateItemOnObject("diseaseremedy",oUser);
                FloatingTextStringOnCreature("Disease remedy obtained.",oUser,FALSE);
            }
            else
            {
                FloatingTextStringOnCreature("You could not find any useful herbs.",oUser,FALSE);
            }
        }
        else
        {
            FloatingTextStringOnCreature("This can only be used in the deepest parts of the woods.",oUser,FALSE);
        }
    }
}
