//NX's Wing Convo
//Ne0nx3r0@gmail.com

void main()
{
object oPC       = GetPCSpeaker();
int iCurrentHead = GetCreatureBodyPart(CREATURE_PART_HEAD, oPC) +1;
if (iCurrentHead > 34) iCurrentHead = 1;
SetCreatureBodyPart(CREATURE_PART_HEAD,  iCurrentHead, oPC);
SendMessageToPC(oPC,IntToString(iCurrentHead));
}

