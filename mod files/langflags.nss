void main()
{
object oPC = GetPCSpeaker();
int iLangFlag = GetLocalInt(oPC, "langflag");
if(iLangFlag == 0)
    {
    SetLocalInt(oPC, "langflag", 1);
    SetLocalInt(oPC, "langamount", GetAbilityModifier(ABILITY_INTELLIGENCE, oPC));
    }
}
