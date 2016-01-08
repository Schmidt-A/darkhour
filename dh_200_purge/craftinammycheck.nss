int StartingConditional()
{
object oPC = GetPCSpeaker();

if (GetItemPossessedBy(oPC, "CraftingNecklace") != OBJECT_INVALID)
    {
    return FALSE;
    }
return TRUE;
}

