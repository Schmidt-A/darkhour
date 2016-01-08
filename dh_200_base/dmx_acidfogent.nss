void DoAcidFogDamage(object oPC, object oTrigger)
{
int nDmg = GetLocalInt(oTrigger,"DAMAGE");
int nDmgType;
string sDmgType = GetLocalString(oTrigger,"DAMAGE_TYPE");
if(sDmgType == "ACID")
   nDmgType = DAMAGE_TYPE_ACID;
else if(sDmgType == "FIRE")
   nDmgType = DAMAGE_TYPE_FIRE;
else if(sDmgType == "COLD")
   nDmgType = DAMAGE_TYPE_COLD;
else if(sDmgType == "ELECTRICAL")
   nDmgType = DAMAGE_TYPE_ELECTRICAL;
else if(sDmgType == "MAGICAL")
   nDmgType = DAMAGE_TYPE_MAGICAL;
else if(sDmgType == "DIVINE")
   nDmgType = DAMAGE_TYPE_DIVINE;
else if(sDmgType == "SONIC")
   nDmgType = DAMAGE_TYPE_SONIC;
else if(sDmgType == "POSITIVE")
   nDmgType = DAMAGE_TYPE_POSITIVE;
else if(sDmgType == "NEGATIVE")
   nDmgType = DAMAGE_TYPE_NEGATIVE;
else if(sDmgType == "SLASHING")
   nDmgType = DAMAGE_TYPE_SLASHING;
else if(sDmgType == "PIERCING")
   nDmgType = DAMAGE_TYPE_PIERCING;
else if(sDmgType == "BLUDGEONING")
   nDmgType = DAMAGE_TYPE_BLUDGEONING;
else if(sDmgType == "BASEWEAPON")
   nDmgType = DAMAGE_TYPE_BASE_WEAPON;

int isFogged = GetLocalInt(oPC,"DMX_ACID_FOG");
if(isFogged)
    {
    object oHelm = GetItemInSlot(INVENTORY_SLOT_HEAD,oPC);
    if(GetTag(oHelm)=="breather_helm" && GetLocalString(oHelm,"DAMAGE_TYPE") == sDmgType)
        {}// do nothing
    else
        ApplyEffectToObject(DURATION_TYPE_INSTANT,EffectDamage(nDmg,nDmgType),oPC);
    DelayCommand(12.0f,DoAcidFogDamage(oPC,oTrigger));
    }
}

void main()
{
object oPC = GetEnteringObject();
string sMsg = GetLocalString(OBJECT_SELF,"MESSAGE");
int isFogged = GetLocalInt(oPC,"DMX_ACID_FOG");
if(!isFogged && GetIsPC(oPC))
{
FloatingTextStringOnCreature(sMsg,oPC,FALSE);
SetLocalInt(oPC,"DMX_ACID_FOG",TRUE);
DoAcidFogDamage(oPC,OBJECT_SELF);
}
}
