void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oArtifact = GetFirstItemInInventory(oPC);
    string sRef = GetResRef(oArtifact);
    int iCount = 0;
    while (GetIsObjectValid(oArtifact))
        {
        if(GetStringLeft(sRef, 3) == "st_" || GetStringLeft(sRef, 6) == "advtab")
            {
            iCount += 1;
            }
        oArtifact = GetNextItemInInventory(oPC);
        sRef = GetResRef(oArtifact);
        }
    if(iCount >= 4)
        {
        SendMessageToPC(oPC, "You already have the maximum allowed amount of artifacts.");
        return;
        }
        if ((OBJECT_INVALID != GetItemPossessedBy(oPC, "ArtifactPiece1"))
            && (OBJECT_INVALID != GetItemPossessedBy(oPC, "ArtifactPiece2"))
            && (OBJECT_INVALID != GetItemPossessedBy(oPC, "ArtifactPiece3"))
            && (OBJECT_INVALID != GetItemPossessedBy(oPC, "ArtifactPiece4")))
        {
            AssignCommand(oPC, ActionStartConversation(oPC, "artifactconvo", TRUE, FALSE));
        }
        else
        {
            FloatingTextStringOnCreature("You need all four parts before you can merge the artifact.",oPC,FALSE);
        }

}
