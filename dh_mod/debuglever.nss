void main()
{
ActionPlayAnimation(ANIMATION_PLACEABLE_ACTIVATE,1.0,1.0);
ActionPlayAnimation(ANIMATION_PLACEABLE_DEACTIVATE,1.0,1.0);
if(GetLocalInt(OBJECT_SELF, "debug") == 1)
    {
    SetLocalInt(OBJECT_SELF, "debug", 0);
    SendMessageToAllDMs("Search Debug Mode is no longer active.");
    return;
    }else
        {
        SetLocalInt(OBJECT_SELF, "debug", 1);
        SendMessageToAllDMs("Search Debug Mode is now active.");
        return;
        }
}
