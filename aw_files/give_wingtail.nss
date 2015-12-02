#include "inc_bs_module"
void main()
{
    object oPC = GetPCSpeaker();
    DestroyObject(GetItemPossessedBy(oPC,"specialitem"));
    DestroyObject(GetItemPossessedBy(oPC,"specialitemf"));

    SetLocalInt(oPC, "MVMWinner", TRUE); //prevents getting kicked out of wingery

    AssignCommand(oPC, ClearAllActions(TRUE));
    RemovePlayerFromTeam(GetPlayerTeam(oPC),oPC);
    AssignCommand(oPC, JumpToLocation(GetLocation(GetObjectByTag("wp_Wingery"))));
}
