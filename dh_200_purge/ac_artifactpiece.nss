void main()
{
    object oItem = GetItemActivated();
    object oPC = GetItemActivator();
    object oArtifact = GetFirstItemInInventory(oPC);
    int iCount = 0;

    // Note - this means if we make any other item start with resref
    // st_, this could break.
    while (GetIsObjectValid(oArtifact))
    {
        if(GetStringLeft(GetResRef(oArtifact), 3) == "st_")
            iCount ++;
        oArtifact = GetNextItemInInventory(oPC);
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
            FloatingTextStringOnCreature("You need all four parts before you can merge the artifact.",oPC,FALSE);

}
