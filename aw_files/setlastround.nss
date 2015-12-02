void main()
{
    int nActiveRound = GetLocalInt(GetModule(), "nRound");
    object oPC = GetFirstPC();
    int nTimer = GetLocalInt(GetModule(), "timer");
    while (GetIsObjectValid(oPC))
    {
        SetLocalInt(oPC, "LastTimer", nTimer);
        SetLocalInt(oPC, "LastRound", nActiveRound);
        DeleteLocalInt(oPC, "LoopTest");
        oPC = GetNextPC();
    }
}
