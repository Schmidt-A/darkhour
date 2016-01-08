const int Damage = 25;

void main()
{
object oPC  = GetLastDamager();
    if (! GetIsPC(oPC))              return;
    if (GetIsPossessedFamiliar(oPC)) return;

    string sOre = GetLocalString(OBJECT_SELF, "OreType");
    if (sOre == "")
    return;

    int nChance      = GetLocalInt(OBJECT_SELF, "ChanceOfAcquire");
    if (nChance < 1)
    return;

    int nDamage = GetLocalInt(OBJECT_SELF, "Damage") + GetTotalDamageDealt();

    while (nDamage >= Damage)
    {
        object oItem = OBJECT_INVALID;

        if ((nChance + Random(100) >= 100) && (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)) == "professionminerh") + (GetTag(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC)) == "professionminerh"))
        {

            oItem = CreateItemOnObject(sOre, oPC);
            SetIdentified(oItem, TRUE);
            SetStolenFlag(oItem, FALSE);
        }

        nDamage -= Damage;
    }

    SetLocalInt(OBJECT_SELF, "Damage", nDamage);
}

