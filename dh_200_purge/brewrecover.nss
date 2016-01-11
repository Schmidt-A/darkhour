void main()
{
object oPC = OBJECT_SELF;
int iUses = GetLocalInt(oPC, "brewuses");
iUses = iUses - 1;
SetLocalInt(oPC, "brewuses", iUses);
if(iUses == 0)
    {
    SendMessageToPC(oPC, "You have completely recovered from the effects of the brew.");
    }
else if(iUses == 1)
    {
    SendMessageToPC(oPC, "You have slightly recovered from the effects of the brew, but you are still feeling it.");
    }
else if(iUses == 2)
    {
    SendMessageToPC(oPC, "You have slightly recovered from the effects of the brew, but you are still feeling it.");
    }
else if(iUses == 3)
    {
    SendMessageToPC(oPC, "You have slightly recovered from the effects of the brew, but you are still feeling it.");
    }
if(iUses > 0)
    {
    DelayCommand(500.0, ExecuteScript("brewrecover", oPC));
    }
}
