void DelayedCreateItemOnObject(string sResref, object oTarget, int nStacksize)
{
    CreateItemOnObject(sResref, oTarget, nStacksize);
}
void main()
{
object oPC = GetPCSpeaker();
int iGold = GetGold(oPC);
int iOrbs = GetItemStackSize(GetItemPossessedBy(oPC, "orbofallur"));
int iQuit = 0;
if(iGold < 750)
    {
    SendMessageToPC(oPC, "You do not have enough gold to complete this operation.");
    iQuit = 1;
    }
if(iOrbs < 1)
    {
    SendMessageToPC(oPC, "You do not have enough orbs of alluring to complete this operation.");
    iQuit = 1;
    }
if(GetItemPossessedBy(oPC, "set_cha_belt") == OBJECT_INVALID)
    {
    SendMessageToPC(oPC, "You do not possess the necessary piece of equipment.");
    iQuit = 1;
    }
if(iQuit != 0)
    {
    return;
    }
TakeGoldFromCreature(750, oPC, TRUE);
DestroyObject(GetItemPossessedBy(oPC, "set_cha_belt"));
if(iOrbs > 1)
    {
    int iStack = iOrbs - 1;
    DelayCommand(0.3, DestroyObject(GetItemPossessedBy(oPC, "orbofallur")));
    DelayCommand(0.5, DelayedCreateItemOnObject("orbofallur", oPC, iStack));
    }else
        {
        DestroyObject(GetItemPossessedBy(oPC, "orbofallur"));
        }
object oCreate = CreateItemOnObject("set_cha_belt001", oPC);
SendMessageToPC(oPC, "A(n) " + GetName(oCreate) + " has been successfully amalgamated!");
}
