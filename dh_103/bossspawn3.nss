// ChronusH
// This script will determine the highest leveled player in the area and then
//     spawn an appropriate creature for their level, to keep balance.

void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC) == FALSE)
    {
    return;
    }
int iLevel = GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC) + GetLevelByPosition(3, oPC);
object oSpawn = GetNearestObjectByTag("bossspawn", OBJECT_SELF);
int iSpawn = GetLocalInt(oSpawn, "canspawn");
location lLoc = GetLocation(oSpawn);
if(iSpawn != 0)
    {
    return;
    }
SendMessageToAllDMs(GetName(oPC) + " has spawned a boss monster.");
if(iLevel < 3)
    {
    object oBoss = CreateObject(OBJECT_TYPE_CREATURE, "lessertidalbeast", lLoc, TRUE);
    SetLocalInt(oSpawn, "canspawn", 1);
    DelayCommand(14390.0, DestroyObject(oBoss));
    DelayCommand(14400.0, SetLocalInt(OBJECT_SELF, "canspawn", 0));
    return;
    }else
        {
        object oBoss = CreateObject(OBJECT_TYPE_CREATURE, "thetidalbeast", lLoc, TRUE);
        SetLocalInt(oSpawn, "canspawn", 1);
        DelayCommand(14390.0, DestroyObject(oBoss));
        DelayCommand(14400.0, SetLocalInt(oSpawn, "canspawn", 0));
        return;
        }
}
