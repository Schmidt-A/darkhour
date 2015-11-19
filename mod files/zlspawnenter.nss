void main()
{
object oPC = GetEnteringObject();
int nDoOnce = GetLocalInt(oPC,"ZLSPAWNED");
if(nDoOnce != TRUE)
{
FloatingTextStringOnCreature("As you reach the top of the Spire, the sense of accomplishment and glory escapes you... Instead, you feel the dreaded oncome of imminent doom.",oPC,FALSE);
SetLocalInt(oPC,"ZLSPAWNED",TRUE);
}
}
