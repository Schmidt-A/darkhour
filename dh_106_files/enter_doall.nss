void main()
{
object oPC = GetEnteringObject();
//ExecuteScript("enter_antiuber", oPC);
DelayCommand(1.0, ExecuteScript("takemagic", oPC));
DelayCommand(1.5, ExecuteScript("enter_scriptsafe", oPC));
if((GetItemPossessedBy(oPC, "professionbaker") == OBJECT_INVALID) && GetItemPossessedBy(oPC, "professioncook") == OBJECT_INVALID)
    {
    CreateItemOnObject("professionbaker", oPC);
    }
if(GetItemPossessedBy(oPC, "DyeKit") != OBJECT_INVALID)
    {
    SetPlotFlag(GetItemPossessedBy(oPC, "DyeKit"), TRUE);
    }
if(GetItemPossessedBy(oPC, "ReaperToken") != OBJECT_INVALID)
    {
    location lLoc = GetLocation(GetWaypointByTag("GoToFugue"));
    AssignCommand(oPC, JumpToLocation(lLoc));
    }
if((GetSkillRank(SKILL_HEAL, oPC, FALSE) >= 10) && GetItemPossessedBy(oPC, "ressurecttool") == OBJECT_INVALID)
    {
    CreateItemOnObject("ressurecttool", oPC);
    SendMessageToPC(oPC, "Your heal skill is high enough to use the healing tool. Please read its description");
    }
}
