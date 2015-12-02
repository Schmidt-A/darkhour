int StartingConditional() {
    object oPC = GetPCSpeaker();
    if (GetIsObjectValid(GetLocalObject(oPC, "STX_CR_NPC")))
        return FALSE;

    return TRUE;
}
