void main()
{
object oZombieCorpse = GetNearestObjectByTag("feinzombie", OBJECT_SELF);
location lLocation = GetLocation(oZombieCorpse);
int iRoll = d100(1);
object oPC = GetEnteringObject();
int iFire = GetLocalInt(OBJECT_SELF, "hasfired");
if((iRoll <= 25) && (iFire != 5) && (GetIsDM(oPC) == FALSE) && (GetIsPC(oPC) == TRUE) && GetActionMode(oPC, ACTION_MODE_STEALTH) == FALSE)
    {
    SetLocalInt(OBJECT_SELF, "hasfired", 5);
    CreateObject(OBJECT_TYPE_CREATURE, "zn_zombie001", lLocation);
    SetUseableFlag(oZombieCorpse, 1);
    DestroyObject(oZombieCorpse);
    FloatingTextStringOnCreature("The corpse awakens in your presence and attacks!", oPC);
    }
}
