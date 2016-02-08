#include "_incl_xp"
#include "_incl_pc_data"
#include "nwnx_odbc"

void main()
{
    object oPC          = OBJECT_SELF;
    string sName        = PCDGetFirstName(oPC);
    string sConvPos     = IntToString(GetLocalInt(oPC, "iConvPos"));

    // Conversational positions are mapped to different artifact resrefs
    SQLExecDirect("SELECT resref, adv_resref FROM conv_artifacts " +
                  "WHERE conv_id = " + sConvPos + ";");
    if(SQLFetch() == SQL_ERROR)
    {
        WriteTimestampedLogEntry("ERROR: SQL failure when " + sName + "(" + 
                GetPCPlayerName(oPC) + ") tried to assemble an artifact " +
                "with sConvPos = " + sConvPos);
        return;
    }
    string sRef     = SQLGetData(1);
    string sAdvRef  = SQLGetData(2);
    int iHasArtiXP  = GetCampaignInt(GetName(GetModule()), "hasartifxp", oPC);
    int bAdvanced   = FALSE;
    effect eEffect  = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);

    int i;
    string sMsg;

    // Get rid of their artifact pieces
    for(i=1; i<5; i++)
        DestroyObject(GetItemPossessedBy(oPC, "ArtifactPiece"+IntToString(i)));

    // Check to see if we should make an advanced artifact
    object oItem = GetFirstItemInInventory(oPC);
    object oNextItem;
    while(GetIsObjectValid(oItem))
    {
        oNextItem = GetNextItemInInventory(oPC);
        if(GetResRef(oItem) == sRef)
        {
            DestroyObject(oItem);
            bAdvanced = TRUE;
        }
        oItem = oNextItem;
    }

    if(!bAdvanced)
    {
        if(!iHasArtiXP)
        {
            SetCampaignInt(GetName(GetModule()), "hasartifxp", oPC);
            GiveXPToCreatureDH(oPC, 1000);
            sMsg = "<c þ >A thrill of otherworldly power courses " +
                "though " + sName + "'s body. They realize that the artifact " +
                "has bound to their very being, leaving them stronger for it. " +
                "This is followed by an overwhelming sense of relief - as if " +
                "the very pieces themselves had grown weary of being fractured.</c>";
        }
        else
        {
            sMsg = "<c þ >" + sName + " has assembled an artifact! They can tell " +
                "that their bond with this one is not so strong as the first, but " + 
                "they should still be able to make use of its magic. The familiar " +
                "sensation of relief returns, as though the artifact is glad to be" +
                "whole once more.</c>";
        }
        CreateItemOnObject(sRef, oPC);
    }
    else
    {
        sMsg = "<c þ >" + sName + " watches as their two identical tablets " +
            "combine of their own volition, to form one more powerful than " +
            "either before. They realize they are now one of the few owners " +
            "of an Advanced Artifact.</c>";
        CreateItemOnObject(sAdvRef, oPC);
    }
    SendMessageToPC(oPC, sMsg);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, eEffect, oPC);
}
