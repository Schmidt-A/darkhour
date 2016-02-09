#include "_incl_pc_data"

void main()
{
    object oPC      = GetItemActivator();
    string sName    = PCDGetFirstName(oPC);
    int i;

    // If we have 4 artifacts, we can't make another
    if(PCDGetArtifactCount(oPC) > 3)
    {
        SendMessageToPC(oPC, "No more than four artifacts will bind to a given " +
            "soul. " + sName + " already has four.");
        return;
    }

    // See if we have all 4 pieces
    for(i=1; i<5; i++)
    {
        if(GetItemPossessedBy(oPC, "ArtifactPiece"+IntToString(i)) == OBJECT_INVALID)
        {
            SendMessageToPC(oPC, sName + " requires all four parts of the artifact " +
                "in order to merge them.");
            return;
        }
    }
    SetLocalString(oPC, "sConvScript", "conv_artifact");
    AssignCommand(oPC, ActionStartConversation(oPC, "artifact", TRUE, FALSE));
}
