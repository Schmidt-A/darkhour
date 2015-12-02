void main()
{
    if(GetLocalInt(GetModule(), "DisableAttackNotice") == 0)
    {
        SetLocalInt(GetModule(), "DisableAttackNotice", 1);
        SendMessageToPC(GetLastUsedBy(), "Attack notice disabled.");
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    }
    else
    {
        SetLocalInt(GetModule(), "DisableAttackNotice", 0);
        SendMessageToPC(GetLastUsedBy(), "Attack notice enabled.");
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }
}

