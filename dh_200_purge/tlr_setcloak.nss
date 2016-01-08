//Created by 420 for the CEP
//Set cloak number manually
//Based on script tlr_setitem.nss by Jake E. Fitch

//Get Spoken Body Part for CEP
string GetSpokenPart()
{
int iCount = 0;
int iMax = GetMatchedSubstringsCount();
string sName;

if(GetListenPatternNumber() == 8888)
    {
    while(iCount<iMax)
        {
        sName = sName+GetMatchedSubstring(iCount);
        iCount++;
        }
    }
SetListening(OBJECT_SELF, FALSE);
return sName;
}

void main()
{
object oPC = GetPCSpeaker();
int iNewApp = StringToInt(GetSpokenPart());

if (iNewApp < 1) iNewApp = 1;
if (iNewApp > 99) iNewApp = 99;

object oItem = GetItemInSlot(INVENTORY_SLOT_CLOAK);

object oNewItem = CopyItemAndModify(oItem, ITEM_APPR_TYPE_SIMPLE_MODEL, 0, iNewApp, TRUE);

DestroyObject(oItem);
SendMessageToPC(oPC, "New Appearance: " + IntToString(iNewApp) +" "+ Get2DAString("cloakmodel", "LABEL", iNewApp));

AssignCommand(OBJECT_SELF, ActionEquipItem(oNewItem, INVENTORY_SLOT_CLOAK));
}
