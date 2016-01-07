void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC) == FALSE)
    {
    return;
    }
string sName = GetName(oPC);
if(sName == "Grumarol")
    {
    int iCheck = GetCampaignInt(GetName(GetModule()), "givehideonce", oPC);
    if(iCheck == 0)
        {
        object oWep = CreateItemOnObject("yeafist", oPC);
        object oHide = CreateItemOnObject("yeahide", oPC);
        DelayCommand(0.5, AssignCommand(oPC, ActionEquipItem(oHide, INVENTORY_SLOT_CARMOUR)));
        DelayCommand(0.6, AssignCommand(oPC, ActionEquipItem(oWep, INVENTORY_SLOT_CWEAPON_R)));
        SetCampaignInt(GetName(GetModule()), "givehideonce", 1, oPC);
        }
    }
}
