void main()
{
    object oItem = GetItemActivated();
    object oActivator = GetItemActivator();
    location lActivator = GetLocation(oActivator);
    string sItemTag = GetTag(oItem);

    if (sItemTag == "RB_DiceBag")
    {
        object oPlaceable = CreateObject(OBJECT_TYPE_PLACEABLE, "rb_make_a_roll", lActivator);
        DelayCommand(1.0, AssignCommand(oPlaceable, ActionStartConversation(oActivator, "", TRUE)));
        return;
    }

}
