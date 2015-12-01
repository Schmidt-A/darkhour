//NX's Wing Convo
//Ne0nx3r0@gmail.com

void main()
{
object oPC              = GetPCSpeaker();
int iCurrentWing        = GetCreatureWingType(oPC);

//Current Wing
SetCustomToken(5706,Get2DAString("wingmodel","LABEL",iCurrentWing));
//Next Wing
SetCustomToken(5707,Get2DAString("wingmodel","LABEL",iCurrentWing +1));
//Previous Wing
SetCustomToken(5708,Get2DAString("wingmodel","LABEL",iCurrentWing -1));

}
