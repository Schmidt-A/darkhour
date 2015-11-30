void main()
{
    if (Random(25) != 0)
    {
        int nChoice = Random(28) + 1;
        string sClothing;
        if (nChoice < 10)
        {
            sClothing = "nw_cloth00" + IntToString(nChoice);
        }
        else
        {
        sClothing = "nw_cloth0" + IntToString(nChoice);
        }
        object oWear = CreateItemOnObject(sClothing);
        SetDroppableFlag(oWear,FALSE);
        ActionEquipItem(oWear,INVENTORY_SLOT_CHEST);
    }
    else
    {
        string sArmor;
        switch (Random(5))
        {
            case 0:
                sArmor = "nw_aarcl001";
                break;
            case 1:
                sArmor = "nw_aarcl002";
                break;
            case 2:
                sArmor = "nw_aarcl009";
                break;
            case 3:
                sArmor = "nw_aarcl012";
                break;
            case 4:
                switch (Random(5))
                {
                    case 0:
                        sArmor = "nw_aarcl008";
                        break;
                    case 1:
                        sArmor = "nw_aarcl004";
                        break;
                    case 2:
                        sArmor = "nw_aarcl010";
                        break;
                    case 3:
                        sArmor = "nw_aarcl003";
                        break;
                    case 4:
                        sArmor = "nw_aarcl006";
                        break;
                }
                break;
        }
        object oEquip = CreateItemOnObject(sArmor);
        ActionEquipItem(oEquip,INVENTORY_SLOT_CHEST);
    }
}
