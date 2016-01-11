void main()
{
    object oPC = GetPlaceableLastClickedBy();
    /*
    int iHP = GetCurrentHitPoints(oPC) - 1;
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDamage(iHP), oPC);
    */
        SetLocalString(oPC, "sConvScript", "conv_bardskills");
        ActionStartConversation(oPC, "bard_skills");
}
