void main()
{
    if(GetLocalInt(GetModule(), "DisableAutosave") == 0)
    {
        SetLocalInt(GetModule(), "DisableAutosave", 1);
        SendMessageToPC(GetLastUsedBy(), "Autosave disabled.");
        ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE);
    }
    else
    {
        SetLocalInt(GetModule(), "DisableAutosave", 0);
        SendMessageToPC(GetLastUsedBy(), "Autosave enabled.");
        ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE);
    }
}


