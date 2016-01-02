void main()
{
int iChance = Random(500);
int iItem = d8();
if(iChance == 55)
    {
    if(iItem == 1)
        {
        object oLoot = CreateItemOnObject("set_dex_cape", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 2)
        {
        object oLoot = CreateItemOnObject("set_dex_armor", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 3)
        {
        object oLoot = CreateItemOnObject("set_dex_gloves", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem ==4)
        {
        object oLoot = CreateItemOnObject("set_dex_boots", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 5)
        {
        object oLoot = CreateItemOnObject("set_dex_helm", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 6)
        {
        object oLoot = CreateItemOnObject("set_dex_ammy", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 7)
        {
        object oLoot = CreateItemOnObject("set_dex_ring", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    else if(iItem == 8)
        {
        object oLoot = CreateItemOnObject("set_dex_belt", OBJECT_SELF);
        SetDroppableFlag(oLoot, TRUE);
        SetIdentified(oLoot, TRUE);
        return;
        }
    }
}
