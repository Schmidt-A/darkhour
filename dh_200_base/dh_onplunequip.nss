void DoubleCheck(object oPC)
{
    effect eSearch = GetFirstEffect(oPC);
        while(GetIsEffectValid(eSearch))
            {
            if(GetEffectType(eSearch) == EFFECT_TYPE_SKILL_INCREASE && GetEffectCreator(eSearch) == GetModule() && GetEffectSubType(eSearch) == SUBTYPE_SUPERNATURAL)
                {
                RemoveEffect(oPC,eSearch);
                SetLocalInt(oPC, "torchbuff", 0);
                DelayCommand(2.0, DoubleCheck(oPC));
                }
            eSearch = GetNextEffect(oPC);
            }
}
void main()
{
    object oPC = GetPCItemLastUnequippedBy();
    effect eSearch = GetFirstEffect(oPC);
    string sRes = GetResRef(GetPCItemLastEquipped());
    if((sRes == "lantern") | (sRes == "zep_lantern") | (sRes == "zn_torch"))
        {
        while(GetIsEffectValid(eSearch))
            {
            if(GetEffectType(eSearch) == EFFECT_TYPE_SKILL_INCREASE && GetEffectCreator(eSearch) == GetModule() && GetEffectSubType(eSearch) == SUBTYPE_SUPERNATURAL)
                {
                RemoveEffect(oPC,eSearch);
                SetLocalInt(oPC, "torchbuff", 0);
                DelayCommand(2.0, DoubleCheck(oPC));
                }
            eSearch = GetNextEffect(oPC);
            }
        }
    if(GetTag(GetPCItemLastEquipped()) == "Candle")
        {
        DestroyObject(GetPCItemLastEquipped());
        }
}
