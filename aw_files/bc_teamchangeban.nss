void main()
{
if(GetLocalInt(GetModule(), "TeamChangeDisabled") == 0)
    {
    SetLocalInt(GetModule(), "TeamChangeDisabled", 1);
    SendMessageToPC(GetLastUsedBy(), "Team changing disabled.");
    ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    }
else
    {
    SetLocalInt(GetModule(), "TeamChangeDisabled", 0);
    SendMessageToPC(GetLastUsedBy(), "Team changing enabled.");
    ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }
}


