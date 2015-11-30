//NX's Wing Convo
//Ne0nx3r0@gmail.com

void main()
{
object oPC              = GetPCSpeaker();
int iCurrentTail        = GetCreatureTailType(oPC);

//Current Tail
SetCustomToken(5709,Get2DAString("tailmodel","LABEL",iCurrentTail));
//Next Tail
SetCustomToken(5710,Get2DAString("tailmodel","LABEL",iCurrentTail +1));
//Previous Tail
SetCustomToken(5711,Get2DAString("tailmodel","LABEL",iCurrentTail -1));

}
