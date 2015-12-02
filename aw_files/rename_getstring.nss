int StartingConditional()
{
object oPC = GetPCSpeaker();
object oPenguListener =  OBJECT_SELF;


string sNewItemName = GetSubString(GetMatchedSubstring(1),0,30);

//int sNewItemName = StringToInt(sNumber);
 if(sNewItemName == "" || sNewItemName == " " )
  {
  SetCustomToken(12345, sNewItemName +" Empty name is not allowed plz try another one. ");
  DeleteLocalString(oPC, "NewItemName");
  }
 else
  {
   SetLocalString(oPC, "NewItemName", sNewItemName);
   SetCustomToken(12345,sNewItemName);
  }

  SetListening(oPenguListener, FALSE);
  return TRUE;
}
