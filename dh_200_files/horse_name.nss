//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
object oItem;
oTarget = oPC;
object oWyrmling;
oWyrmling=GetHenchman(oPC);
SetName (oTarget, GetName(GetItemPossessedBy(oTarget, "Name_Horse")) + " the " + " Pony");
}

