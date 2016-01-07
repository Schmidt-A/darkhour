#include "_incl_xp"
void main()
{
object oPC = GetPCSpeaker();
DestroyObject(GetItemPossessedBy(oPC, "ArtifactPiece1"));
DestroyObject(GetItemPossessedBy(oPC, "ArtifactPiece2"));
DestroyObject(GetItemPossessedBy(oPC, "ArtifactPiece3"));
DestroyObject(GetItemPossessedBy(oPC, "ArtifactPiece4"));
int iCheck = 0;
object oItem = GetFirstItemInInventory(oPC);
string sRef = GetResRef(oItem);
int iArti = GetCampaignInt(GetName(GetModule()), "hasartifxp", oPC);
while(GetIsObjectValid(oItem) == TRUE)
    {
    if(sRef == "st_gmw")
        {
        iCheck = 1;
        DestroyObject(oItem);
        }
    if((GetStringLeft(sRef, 3) == "st_") | (GetStringLeft(sRef, 3) == "adv"))
        {
        SetCampaignInt(GetName(GetModule()), "hasartifxp", 1, oPC);
        }
    oItem = GetNextItemInInventory(oPC);
    sRef = GetResRef(oItem);
    }
if(GetCampaignInt(GetName(GetModule()), "hasartifxp", oPC) == 0)
    {
    GiveXPToCreatureDH(oPC, 1000);
    SendMessageToPC(oPC, "<c þ >You have assembled your first artifact and been rewarded 1,000 experience!</c>");
    }
if(iCheck == 0)
    {
    CreateItemOnObject("st_gmw",oPC);
    SendMessageToPC(oPC, "<c þ >You have successfully completed an artifact!</c>");
    effect eSuccess = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eSuccess,oPC);
    }else
        {
        CreateItemOnObject("advtab8",oPC);

        SendMessageToPC(oPC, "<c þ >Your identical tablets have combined to form an Advanced Artifact!</c>");
        effect eSuccess = EffectVisualEffect(VFX_IMP_DIVINE_STRIKE_HOLY);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eSuccess,oPC);
        }
}
