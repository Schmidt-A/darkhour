// First Version:    0.1
//
// Modified by:
// Date:
// Modified Version:
//
////////////////////////////////////////////////////////////////////////
//
// OnActive Script
//
////////////////////////////////////////////////////////////////////////
//
// This script is to be merged with a modules existing OnActivate
// script. If one doesn't exist, this will work.
//
////////////////////////////////////////////////////////////////////////
void main()
{
    object oUser    = GetItemActivator();
    object oTarget  = GetItemActivatedTarget();
    string sItemTag = GetTag(GetItemActivated());
    object oItem    = GetItemActivated();

    if (sItemTag == "WandofEquipping")
    {
        ExecuteScript("wand_equip", oUser);
        return;
    }
    if (sItemTag == "wand_equip_1")
    {
        ExecuteScript("reequip", oUser);
        return;
    }
    if (sItemTag == "wand_equip_2")
    {
        ExecuteScript("reequip", oUser);
        return;
    }
    if (sItemTag == "wand_equip_3")
    {
        ExecuteScript("reequip", oUser);
        return;
    }
}
