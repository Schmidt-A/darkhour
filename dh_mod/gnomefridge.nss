void main()
{
object oPC = GetPCSpeaker();
int iTime = GetCampaignInt(GetName(GetModule()), "fridgetimeleft", GetNearestObjectByTag("GnomishRefrigerator"));
object oItem = GetItemPossessedBy(oPC, "X1_IT_MSMLMISC01");
if (GetIsObjectValid(oItem))
    {
    if (iTime <= 86400)
        {
        DestroyObject(oItem);
        iTime += 11520;
        SendMessageToPC(oPC, "Your coldstone fuels as a gnomish refrigerant.");
        AssignCommand(OBJECT_SELF, ActionCastSpellAtObject(SPELL_RAY_OF_FROST, GetNearestObjectByTag("ZEP_CRYSTAL001"), METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE));
        DelayCommand(0.8, AssignCommand(GetNearestObjectByTag("ZEP_CRYSTAL001"), ActionCastSpellAtObject(SPELL_SPELL_MANTLE, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        DelayCommand(1.4, AssignCommand(GetNearestObjectByTag("ZEP_CRYSTAL001"), ActionCastSpellAtObject(SPELL_GREATER_DISPELLING, OBJECT_SELF, METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        DelayCommand(1.6, AssignCommand(GetNearestObjectByTag("ZEP_CRYSTAL001"), ActionCastSpellAtObject(SPELL_RAY_OF_FROST, GetNearestObjectByTag("GRS"), METAMAGIC_NONE, TRUE, 0,  PROJECTILE_PATH_TYPE_DEFAULT, TRUE)));
        if (iTime >= 86400)
            {
            iTime = 86400;
            SendMessageToPC(oPC, "The contraption's reserves are now at full capacity.");
            }
        SetCampaignInt(GetName(GetModule()), "fridgetimeleft", iTime, GetNearestObjectByTag("GnomishRefrigerator"));
        return;
        }else
            {
            SendMessageToPC(oPC, "The contraption's reserves are already at full capacity.");
            }
    }else
        {
        SendMessageToPC(oPC, "You do not possess a coldstone.");
        }
}
