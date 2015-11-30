/*   script to remove and destroy henchmen    */

//Put this on action taken in the conversation editor
void main()
{

object oPC = GetPCSpeaker();

object oTarget;
oTarget=GetHenchman(oPC);

RemoveHenchman(oPC, oTarget);

DestroyObject(oTarget);

}
