void main()
{
int iCharges = GetLocalInt(OBJECT_SELF, "charges");
object oPC = GetLastAttacker();
object oWep = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND, oPC);
string sWep = GetTag(oWep);
int iHit = d4();
int iChance = d12();
if(iCharges <= 0)
    {
    SendMessageToPC(oPC, "<cþ  >This deposite has been recently mined and has not yet recovered.</c>");
    return;
    }
    else
        {
        if((sWep == "professionminerh") | (sWep == "profminerl"))
            {
            iCharges = iCharges - 1;
            SetLocalInt(OBJECT_SELF, "charges", iCharges);
            if(iHit != 1)
                {
                SendMessageToPC(oPC, "Your " + GetName(oWep) + " clangs off of the " + GetName(OBJECT_SELF) + " but nothing was found. you should try again.");
                }
            else
                {
            if(iChance >= 11)
                {
                object oItem = CreateItemOnObject("ore_adam", oPC);
                SendMessageToPC(oPC, "<c þ >You successfully mined a(n) " + GetName(oItem) + "</c>");
                SetLocalInt(OBJECT_SELF, "isready", 1);
                DelayCommand(7200.0, SetLocalInt(OBJECT_SELF, "isready", 0));
                }
            else if(iChance >= 8)
                {
                object oItem = CreateItemOnObject("ore_mith", oPC);
                SendMessageToPC(oPC, "<c þ >You successfully mined a(n) " + GetName(oItem) + "</c>");
                SetLocalInt(OBJECT_SELF, "isready", 1);
                DelayCommand(7200.0, SetLocalInt(OBJECT_SELF, "isready", 0));
                }
            else if(iChance >= 4)
                {
                object oItem = CreateItemOnObject("ore_iron", oPC);
                SendMessageToPC(oPC, "<c þ >You successfully mined a(n) " + GetName(oItem) + "</c>");
                SetLocalInt(OBJECT_SELF, "isready", 1);
                DelayCommand(7200.0, SetLocalInt(OBJECT_SELF, "isready", 0));
                }
            else
                {
                SendMessageToPC(oPC, "<cþ  >You have failed to recover any viable materials.</c>");
                SetLocalInt(OBJECT_SELF, "isready", 1);
                DelayCommand(7200.0, SetLocalInt(OBJECT_SELF, "isready", 0));
                }
                }
            }
            else
                {
                SendMessageToPC(oPC, "<cþ  >You are not using the necessary tools. You must equip a pickaxe!</c>");
                }
        }
}
