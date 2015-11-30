void main()
{
object oItem = GetInventoryDisturbItem();
object oPC = GetLastDisturbed();


object oCrafting = GetItemPossessedBy(oPC, "craftingitem");
int nAmount = GetWeight(oItem);
int iSkillCraftA = GetSkillRank(SKILL_CRAFT_ARMOR, oPC);
int iSkillCraftB = GetSkillRank(SKILL_CRAFT_WEAPON, oPC);
int nFigure = nAmount / 20;
int nFinal = (nFigure + iSkillCraftA + iSkillCraftB) * (Random(4) + 1);
string sFigure = IntToString(nFinal);


int iAmount = GetLocalInt(oCrafting, "crafting");



if(GetWeight(oItem) < 30)
{
SendMessageToPC(oPC, "You cannot salvage this item.");
return;
}
else
{
DestroyObject(oItem);
SendMessageToPC(oPC, "You have salvaged an item and gained " + sFigure + " crafting points");
SetLocalInt(oCrafting, "crafting", iAmount + nFinal);
int iAmount = GetLocalInt(oCrafting, "crafting");
string sAmount = "<cþ× >" + IntToString(iAmount) + "</c>";
string sFinalAmount = "You currently have " + sAmount + " crafting points.";
SendMessageToPC(oPC, sFinalAmount);
}
}



