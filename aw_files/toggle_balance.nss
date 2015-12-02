void main()
{
    if(GetLocalInt(GetModule(), "TeamBalance") == 0)
    {
        SetLocalInt(GetModule(), "TeamBalance", 1);
        SendMessageToPC(GetLastUsedBy(), "Team Balancing enabled.");
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }
    else
    {
        SetLocalInt(GetModule(), "TeamBalance", 0);
        SendMessageToPC(GetLastUsedBy(), "Team Balancing disabled.");
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    }
}

