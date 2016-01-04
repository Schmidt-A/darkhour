  void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC))
    {
    int iSkill = GetSkillRank(SKILL_SEARCH, oPC, FALSE);
    effect eSearch = ExtraordinaryEffect(EffectSkillIncrease(SKILL_SEARCH, 10 - iSkill));
    object oTorch = GetItemInSlot(INVENTORY_SLOT_LEFTHAND, oPC);
    if ((GetResRef(oTorch) == "lantern") || (GetResRef(oTorch) == "zep_lantern") || (GetResRef(oTorch) == "zn_torch"))
       {
        iSkill += 1;
       }
    if(iSkill < 10)
        {
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eSearch,oPC);
        }
    }
}

