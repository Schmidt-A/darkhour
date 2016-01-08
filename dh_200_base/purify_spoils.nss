void main()
{
    object oItem = GetItemActivated();
    object oUser = GetItemActivator();
    object oTarget = GetItemActivatedTarget();
    string sItem = GetTag(oItem);

    if (sItem == "FoodPurifier")
    {
        if (GetTag(oTarget) == "Spoiled")
        {
            DestroyObject(oTarget);
            CreateItemOnObject("purifiedfood");
        }
        else
        {
            SendMessageToPC(oUser,"You can only use the purifier on spoiled food.");
        }
    }
}
