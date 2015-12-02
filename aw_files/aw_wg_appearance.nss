void main()
{
object oNPC = OBJECT_SELF;
string sNumber = GetMatchedSubstring(0);
int nNumber = StringToInt(sNumber);
 if(   nNumber == 206    // Penguin, not allowed
    || nNumber == 298 //Null Human
    || nNumber == 473 // Boat (huge)
   //as long as they are not huge and they display the flag I am allowing them
   // || nNumber == 450
   // || nNumber == 33
   // || nNumber == 32
   // || nNumber == 16
   // || nNumber == 75   //Ogre Elite
   // || nNumber == 118  //mist dragon
   // || nNumber == 143
   // || nNumber == 149
   // ||  nNumber == 169
   // || nNumber == 173
      || nNumber == 178  //snake, does not show flag
      || nNumber == 183  //snake, does not show flag
      || nNumber == 194  //snake, does not show flag
  //  || nNumber == 299   //beholder has flag but is not visible
      || (nNumber >= 307 && nNumber <= 349) //empty
      || (nNumber >= 371 && nNumber <= 373) //empty
      || (nNumber >= 561 && nNumber <= 868) //empty
  //  || nNumber == 395
  //  || nNumber == 397
  //  || Number == 399
  //  ||  nNumber == 400
  //  || nNumber == 417
      || nNumber == 463 // too huge!
      || (nNumber >= 496 && nNumber <= 561) //all horses, they have no flag
      || nNumber > 870 //last value
      )
  {
    SetCustomToken(79999, sNumber +" is not allowed plz try another one.");
  }
 else
  {
   SetLocalInt(oNPC, "Number", nNumber);
   SetCustomToken(79999,"was it "+sNumber+" I Heard?");
  }
}

