void main()
{
    object oPC = GetPCItemLastEquippedBy();
    string sRes = GetResRef(GetPCItemLastEquipped());
    int iTorch = GetLocalInt(oPC, "torchbuff");
    if((sRes == "lantern") || (sRes == "zep_lantern") || (sRes == "zn_torch") && iTorch == 0)
        {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(EffectSkillIncrease(SKILL_SEARCH, 1)), oPC);
        SetLocalInt(oPC, "torchbuff", 1);
        }
}
