void main()
{
   object oPC = GetLastSpeaker();
   object oItem = GetItemPossessedBy(oPC,"craftingitem");
   int iCraftingPoints = GetLocalInt(oItem, "crafting");
   int iCraftingSkill = GetLocalInt(oItem, "skill");
   SetCustomToken(905, "<cþ× >"+IntToString(iCraftingPoints)+"</c>");
   SetCustomToken(906, "<c þ >"+IntToString(iCraftingSkill)+"</c>");
}
//Crafting points will now appear in GOLD
//Crafting Skill will appear in GREEN

//V: I'm putting in ALT coding to color code these. Should work fine.
//For reference, I put them in dh_onplrest, and on dh_crspeaker.
//A master list can be found in dh_modload
