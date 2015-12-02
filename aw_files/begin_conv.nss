void main()
{
    object oPost = GetNearestObjectByTag("POST_"+GetTag(OBJECT_SELF));
    JumpToObject(oPost);
    SetFacing(GetFacing(oPost));

    ClearAllActions();
    ActionStartConversation(GetLastSpeaker(), "", TRUE, FALSE);
}
