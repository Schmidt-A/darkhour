void main()
{
int iChance = d8();
int iItem = d8();
object oWP = GetNearestObjectByTag("BossSpawn2");
FloatingTextStringOnCreature("Because this is a weaker version, reward is much less likely.", OBJECT_SELF, FALSE);
SetLocalInt(oWP, "canspawn", 1);
DelayCommand(7200.0, SetLocalInt(oWP, "canspawn", 0));
ApplyEffectAtLocation(DURATION_TYPE_TEMPORARY, EffectVisualEffect(VFX_FNF_SCREEN_SHAKE), GetLocation(OBJECT_SELF), 3.0);
ClearAllActions(TRUE);
PlaySound("as_an_dragonror1");
CreateItemOnObject("nw_it_gold001", OBJECT_SELF, Random(300));
int iRand1 = d4();
int iRand2 = d4();
int iRand3 = d4();
int iRand4 = d4();
int iRand5 = d4();
int iRand6 = d4();
int iRand7 = d4();
if(iRand1 == 2)
    {
    object oLoot1 = CreateItemOnObject("desolaterecall", OBJECT_SELF);
    SetDroppableFlag(oLoot1, TRUE);
    SetIdentified(oLoot1, TRUE);
    }
if(iRand2 == 2)
    {
    object oLoot2 = CreateItemOnObject("gemofshadow", OBJECT_SELF);
    SetDroppableFlag(oLoot2, TRUE);
    SetIdentified(oLoot2, TRUE);
    }
if(iRand3 == 2)
    {
    object oLoot3 = CreateItemOnObject("gemofcorruption", OBJECT_SELF);
    SetDroppableFlag(oLoot3, TRUE);
    SetIdentified(oLoot3, TRUE);
    }
if(iRand4 == 2)
    {
    object oLoot4 = CreateItemOnObject("gemofvalor", OBJECT_SELF);
    SetDroppableFlag(oLoot4, TRUE);
    SetIdentified(oLoot4, TRUE);
    }
if(iRand5 == 2)
    {
    object oLoot5 = CreateItemOnObject("nw_it_spdvscr501", OBJECT_SELF);
    SetDroppableFlag(oLoot5, TRUE);
    SetIdentified(oLoot5, TRUE);
    }
if(iRand6 == 2)
    {
    object oLoot6 = CreateItemOnObject("nw_it_mpotion008", OBJECT_SELF);
    SetDroppableFlag(oLoot6, TRUE);
    SetIdentified(oLoot6, TRUE);
    }
if(iRand7 == 2)
    {
    object oLoot7 = CreateItemOnObject("nw_it_mpotion004", OBJECT_SELF);
    SetDroppableFlag(oLoot7, TRUE);
    SetIdentified(oLoot7, TRUE);
    }
if(iChance == 3)
    {
    if(iItem == 1)
        {
        object oLoot = CreateItemOnObject("set_cha_cape", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 2)
        {
        object oLoot = CreateItemOnObject("set_cha_armor", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 3)
        {
        object oLoot = CreateItemOnObject("set_cha_gloves", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem ==4)
        {
        object oLoot = CreateItemOnObject("set_cha_boots", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 5)
        {
        object oLoot = CreateItemOnObject("set_cha_helm", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 6)
        {
        object oLoot = CreateItemOnObject("set_cha_ammy", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 7)
        {
        object oLoot = CreateItemOnObject("set_cha_ring", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 8)
        {
        object oLoot = CreateItemOnObject("set_cha_belt", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    }
}
