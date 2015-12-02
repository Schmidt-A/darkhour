#include "aps_include"
void main()
{
object oPC = GetPCSpeaker();
//Set the value of the persistant informations in the christmas table //
// object OPC,
//string "information" : SantaJudgement(0=null 1= 1 error 2 = bad 3 = good)
//                     : Quiz ( 0 = undone , 1 = done )   ?? perhaps
//
// well if the value of SantaJudgement is = 0 mean the test is undone,
//                                     if the value is 1 mena he did not finished the test
//                                     if the value is 2 mean he is BAD
//                                     if the value is 3 Mean he is GOOD

///example :: SetPersistentInt(oPC,"SantaJudgement",int nValue,0,"christmas");
// Antiworld Persistant Christmas values////
   ////////// check for Judgement - ON CONVERSATION CHECK////////////
   int nType = GetPersistentInt(oPC,"SantaJudgement","christmas"); //Check the value
   if (nType != 0 && nType != 0)
      {
      // you cannot do the test cause
      if (nType != 2)
         {
         //you're bad
          }
      if (nType != 3)
         {
         //you're good
         }
      }
}
