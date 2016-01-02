void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC) == FALSE)
    {
    return;
    }
int iLevel = GetLevelByPosition(1, oPC) + GetLevelByPosition(2, oPC) + GetLevelByPosition(3, oPC);
int iSpawn = GetLocalInt(OBJECT_SELF, "canspawn");
location lLoc = GetLocation(GetNearestObjectByTag("spawnhere", OBJECT_SELF));
location lLocTwo = GetLocation(GetNearestObjectByTag("spawnhere2", OBJECT_SELF));
if(iSpawn != 0)
    {
    return;
    }
if(iLevel == 1)
    {
    CreateObject(OBJECT_TYPE_CREATURE, "lesserlightbeast", lLoc, TRUE);
    SetLocalInt(OBJECT_SELF, "canspawn", 1);
    DelayCommand(300.0, SetLocalInt(OBJECT_SELF, "canspawn", 0));
    return;
    }
else if(iLevel == 2)
    {
    CreateObject(OBJECT_TYPE_CREATURE, "lesserlightbeast", lLoc, TRUE);
    CreateObject(OBJECT_TYPE_CREATURE, "lesserlightbeast", lLocTwo, TRUE);
    SetLocalInt(OBJECT_SELF, "canspawn", 1);
    DelayCommand(300.0, SetLocalInt(OBJECT_SELF, "canspawn", 0));
    }
else if(iLevel == 3)
    {
    CreateObject(OBJECT_TYPE_CREATURE, "greatlightbeast", lLoc, TRUE);
    SetLocalInt(OBJECT_SELF, "canspawn", 1);
    DelayCommand(300.0, SetLocalInt(OBJECT_SELF, "canspawn", 0));
    }
else if(iLevel > 3)
    {
    CreateObject(OBJECT_TYPE_CREATURE, "greatlightbeast", lLoc, TRUE);
    CreateObject(OBJECT_TYPE_CREATURE, "greatlightbeast", lLocTwo, TRUE);
    SetLocalInt(OBJECT_SELF, "canspawn", 1);
    DelayCommand(300.0, SetLocalInt(OBJECT_SELF, "canspawn", 0));
    }
// trigger traps
object oObject = GetObjectByTag("HGD4");
object oObject2 = GetObjectByTag("HGD3");
AssignCommand(oObject, ActionPlayAnimation(ANIMATION_DOOR_CLOSE));
SetLocked(oObject, TRUE);
SetLockKeyRequired(oObject, TRUE);
DelayCommand(5.0, AssignCommand(oObject2, ActionPlayAnimation(ANIMATION_DOOR_CLOSE)));
DelayCommand(5.0, SetLocked(oObject2, TRUE));
DelayCommand(5.0, SetLockKeyRequired(oObject2, TRUE));
DelayCommand(15.0, SetLocked(oObject, FALSE));
DelayCommand(15.0, SetLockKeyRequired(oObject, FALSE));
DelayCommand(15.0, AssignCommand(oObject, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));
DelayCommand(15.0, SetLocked(oObject2, FALSE));
DelayCommand(15.0, SetLockKeyRequired(oObject2, FALSE));
DelayCommand(15.0, AssignCommand(oObject2, ActionPlayAnimation(ANIMATION_DOOR_OPEN1)));
}
