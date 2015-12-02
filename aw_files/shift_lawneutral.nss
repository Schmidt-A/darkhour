void main()
{
object oPC = GetPCSpeaker();
int iLawful_Chaotic = GetLawChaosValue(oPC);
int iGood_Evil = GetGoodEvilValue(oPC);
int iShift_Law_Chaotic= iLawful_Chaotic-85;
int iShift_Good_Evil = iGood_Evil-50;


    {

     AdjustAlignment(oPC,ALIGNMENT_CHAOTIC,iShift_Law_Chaotic);
     AdjustAlignment(oPC,ALIGNMENT_EVIL,iShift_Good_Evil);
    }

}
