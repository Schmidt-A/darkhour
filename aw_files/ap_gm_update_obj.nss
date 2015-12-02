void main()
{
object oPC;
oPC = GetPCSpeaker();
object oObject;

//Ban update
oObject = GetItemPossessedBy(oPC,"banplayer");
DestroyObject(oObject);
CreateItemOnObject("banplayer001", oPC);
//Bio update
oObject = GetItemPossessedBy(oPC,"delete_bio");
DestroyObject(oObject);
CreateItemOnObject("delete_bio", oPC);
//Delete update
oObject = GetItemPossessedBy(oPC,"deletechar");
DestroyObject(oObject);
CreateItemOnObject("deletechar", oPC);
//Freeze update
oObject = GetItemPossessedBy(oPC,"freezeunfreeze");
DestroyObject(oObject);
CreateItemOnObject("freezeunfreeze", oPC);
//Jail update
oObject = GetItemPossessedBy(oPC,"jailplayer");
DestroyObject(oObject);
CreateItemOnObject("jailplayer", oPC);
//Jail+Jump update
oObject = GetItemPossessedBy(oPC,"jailplayeranme");
DestroyObject(oObject);
CreateItemOnObject("jailplayeranme", oPC);
//Jump back update
oObject = GetItemPossessedBy(oPC,"jumpusback");
DestroyObject(oObject);
CreateItemOnObject("jumpusback", oPC);
//Kill update
oObject = GetItemPossessedBy(oPC,"kill_npc");
DestroyObject(oObject);
CreateItemOnObject("kill_npc", oPC);
//One Rod update
oObject = GetItemPossessedBy(oPC,"TheOneRod");
DestroyObject(oObject);
CreateItemOnObject("theonerod", oPC);
//Swap team update
oObject = GetItemPossessedBy(oPC,"teamchangewand");
DestroyObject(oObject);
CreateItemOnObject("gmteambalanceite", oPC);
//boot_player update
oObject = GetItemPossessedBy(oPC,"boot_player");
DestroyObject(oObject);
CreateItemOnObject("boot_player", oPC);



}
