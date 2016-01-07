//void main(){}
//::///////////////////////////////////////////////
//:: String Tokenizer v1.1
//:: tokenizer_inc
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*

   This small library of functions helps you with all kind of data management
   and data consolidation. Be it dynamic arrays, multidimensional arrays or stuff like
   linked lists..

   It uses string-tokens to store data. with the use of data conversion (IntToString etc.),
   any kind of systematic data storage is now very easy. it also helps you to establish a standardized
   way of data manipulation throughout all your scripts.

   with the use of a simple caching algorithm, data access is nearly as fast as
   a normal GetLocal.. function call.

   if you need more imformation, check the bioware forums. tokenizer functions
   are common in most modern compilers, why not using them with the aurora engine ?
   it's key/value based data access is ideally suited for such a system.

   the implementation is very small and should be bug-free (i know, that's never the
   case, but i want you to try it)

   This script is an isolated part of the upcoming "VDM PW Framework"
   www.versuchungdermacht.de (german language)

   history:
   --------

   v1.1

     - added ReplaceTokenInString
        this function was incorporated on request of the nwn board users.
        it does NOT take use of the cache, so don't use it too heavily.

     - added VDM_GetTokenCache()
        you can retrieve the cache object with this command and delete
        it with DestroyObject if you want. it will then auto-create a new
        one if you continue to use the tokenizer.. don't delete it too often
        because it would slow the tokenizer down tremendously.

     - caching does not use the GetModule() object any longer. it auto-creates
       its own special cache object.

     - minor speed optimizations

   v1.0 initial release

*/

//:://////////////////////////////////////////////
//:: Created By:   Knat
//:: Created On:   July 02
//:: Last Change:  20.10.02
//:://////////////////////////////////////////////

// Declarations

// Tokenizer functions, allround functions for string based arrays/memory-management

// Add delimited Token to String
string AddTokenToString(string sToken, string sTargetString, string Delimiter = "|");
// Delete delimited Token from String
string DeleteTokenFromString(string sToken, string sTargetString, string sDelimiter = "|");
// Get specific Token from String
string GetTokenFromString(int nTokenNumber,string sTargetString, string sDelimiter = "|");
// Get number of Tokens from String
int GetTokenCount(string sTargetString,string sDelimiter = "|");
// Get Token position from String
int GetTokenPosition(string sToken, string sTargetString, string sDelimiter ="|");
// Checks if Token is present
int GetIsTokenInString(string sToken, string sTargetString, string sDelimiter ="|");
// Replace Token in String expanded by hermyt
// if you wish to replace a token at a specific index instead of
// passing the command like this
// ReplaceTokenInString("tokenI'mreplacing", sMyTokenString, "tokenI'minserting");
// pass the command like this
// ReplaceTokenInString("", sMyTokenString, "tokenI'minserting", indexforinsertion);
// easy like cake, this function has been updated to maintain caching of token
// information and indexes as well.
string ReplaceTokenInString(string sToken, string sTargetString, string sNewToken, int Index = 0, string sDelimiter = "|");
// Returns cache object
object GetTokenCache();

// auto-create cache if needed
object oCache = GetTokenCache();

// retrieve cache object
// auto create if non-existant
object GetTokenCache()
{
  if(GetLocalObject(GetModule(),"#TOKENIZER_CACHE#") == OBJECT_INVALID)
  {
    // retrieve start area
    object oArea = GetAreaFromLocation(GetStartingLocation());
    // create cache vector ( bottom-left corner )
    vector vCacheVector = Vector(1.0f, 1.0f, 1.0f);
    // create cache location
    location lCacheLocation = Location(oArea, vCacheVector, 1.0f);
    // create invisible object
    object oCache = CreateObject(OBJECT_TYPE_PLACEABLE, "plc_invisobj", lCacheLocation);
    // use it as the cache container
    SetLocalObject(GetModule(),"#TOKENIZER_CACHE#",oCache);
  }
  return GetLocalObject(GetModule(),"#TOKENIZER_CACHE#");
}

string AddTokenToString(string sToken, string sTargetString, string sDelimiter = "|")
{
  if(sTargetString != "")
    return sTargetString += sDelimiter + sToken;
  else
    return sToken;
}

string DeleteTokenFromString(string sToken, string sTargetString, string sDelimiter = "|")
{
  string s;
  int nTokenPos = FindSubString(sDelimiter+sTargetString+sDelimiter,sDelimiter+sToken+sDelimiter);
  if(nTokenPos >= 0) // Token Found
  {
    s = GetStringLeft(sTargetString, nTokenPos-1) + GetStringRight(sTargetString, GetStringLength(sTargetString) - (nTokenPos + GetStringLength(sToken)));
    if(GetStringLeft(s,1) == sDelimiter) s = GetStringRight(s,GetStringLength(s)-1); // cut additional Delimiter if first token got deleted
    return s;
  }
  else
    return sTargetString; // Token not found
}

// auto caching function
// translates tokenstring into separate variables for fastest possible access.
// todo:
//   - add statistical functions
void BuildCache(string sTargetString, string sDelimiter = "|")
{
  string s = sTargetString;
  if(s == "") return;

  int c = 0;
  int pos = 0;
  string sToken;
  //Debug("Cache: "+sTargetString);
  while(pos != -1)
  {
    c++;
    pos = FindSubString(s,sDelimiter);
    if(pos == -1) // last token ?
    {
      SetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+s, c);
      SetLocalString(oCache,"CACHE#"+sDelimiter+sTargetString+IntToString(c),s);
      SetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString,c);
      return; // no more delimiters ? return
    }
    sToken = GetStringLeft(s,pos);
    SetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+sToken, c);
    SetLocalString(oCache,"CACHE#"+sDelimiter+sTargetString+IntToString(c),sToken);
    s = GetStringRight(s,GetStringLength(s)-(pos+1)); // cut off leading token+delimiter
  }
}

// Replace Token in String expanded by hermyt
// if you wish to replace a token at a specific index instead of
// passing the command like this
// ReplaceTokenInString("tokenI'mreplacing", sMyTokenString, "tokenI'minserting");
// pass the command like this
// ReplaceTokenInString("", sMyTokenString, "tokenI'minserting", indexforinsertion);
// easy like cake, this function has been updated to maintain caching of token
// information and indexes as well.
string ReplaceTokenInString(string sToken, string sTargetString, string sNewToken, int Index = 0, string sDelimiter = "|")
{
    string sLeft, sRight, sOldToken, sNewString;
    int nTokenPos = FindSubString(sDelimiter+sTargetString+sDelimiter,sDelimiter+sToken+sDelimiter);
    if (Index == 0)
    {
        if (nTokenPos >= 0) // Token found
        {
          sLeft = GetStringLeft(sTargetString, nTokenPos);
          sRight = GetStringRight(sTargetString, GetStringLength(sTargetString) - ( nTokenPos + GetStringLength(sToken) ) );
          sNewString = sLeft + sNewToken + sRight;
          nTokenPos = GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+sToken);
          DeleteLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+sToken);
          SetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+sNewToken, nTokenPos);
          SetLocalString(oCache,"CACHE#"+sDelimiter+sTargetString+IntToString(nTokenPos),sNewToken);
          return sNewString;
        }
        else
          return sTargetString;
    }
    else
    {
        sOldToken = GetLocalString(oCache,"CACHE#"+sDelimiter+sTargetString
                    +IntToString(Index));
        nTokenPos = FindSubString(sDelimiter+sTargetString+sDelimiter, sDelimiter
                    +sOldToken+sDelimiter);
        if (sOldToken != "" && nTokenPos >= 0)
        {
            sLeft = GetStringLeft(sTargetString,nTokenPos);
            sRight = GetStringRight(sTargetString, GetStringLength(sTargetString) - ( nTokenPos + GetStringLength(sOldToken) ) );
            sNewString = sLeft + sNewToken + sRight;
            DeleteLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+sOldToken);
            SetLocalInt(oCache,"CACHE#"+sDelimiter+sNewString+sNewToken, Index);
            SetLocalString(oCache,"CACHE#"+sDelimiter+sNewString+IntToString(Index),sNewToken);
            return sNewString;
        }
        else
            return sTargetString;
    }
}

string GetTokenFromString(int nTokenNumber,string sTargetString, string sDelimiter = "|")
{

  // Tokenstring not cached ?
  if(GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString) == 0) BuildCache(sTargetString, sDelimiter);
  //Debug(IntToString(nTokenNumber)+":"+sTargetString+"!!!!"+GetLocalString(oCache,"CACHE#"+sDelimiter+"#"+sTargetString+"#"+IntToString(nTokenNumber)+"#"));
  return GetLocalString(oCache,"CACHE#"+sDelimiter+sTargetString+IntToString(nTokenNumber));
}

int GetTokenCount(string sTargetString,string sDelimiter = "|")
{
  // Tokenstring not cached ?
  if(GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString) == 0) BuildCache(sTargetString, sDelimiter);
  return GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString);
}

int GetTokenPosition(string sToken, string sTargetString, string sDelimiter ="|")
{

  // Tokenstring not cached ?
  if(GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString) == 0) BuildCache(sTargetString, sDelimiter);
  // get token from cache
  return GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString+sToken);
}

int GetIsTokenInString(string sToken, string sTargetString, string sDelimiter ="|")
{
  if(FindSubString(sDelimiter+sTargetString+sDelimiter,sDelimiter+sToken+sDelimiter) >= 0 )
    return TRUE;
  else
    return FALSE;
}



/*

  this function updates the cache, too.. i need to further test it before i add it
  officially to the package...

string ReplaceTokenInString(string sToken, string sTargetString, string sNewToken, string sDelimiter = "|", int nAllInstances = FALSE)
{

  if(sTargetString == "") return "";

  // Tokenstring not cached ?
  if(GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString) == 0) BuildCache(sTargetString, sDelimiter);

  string s,sCachedToken;
  int nCount = GetLocalInt(oCache,"CACHE#"+sDelimiter+sTargetString);
  int nFirst = FALSE;

  int i;
  for(i=1;i<=nCount;i++)
  {
    sCachedToken = GetLocalString(oCache, "CACHE#"+sDelimiter+sTargetString+IntToString(i));
    if(sCachedToken == sToken && !nFirst)
    {
      s += sDelimiter + sNewToken;
      // update cache
      SetLocalString(oCache, "CACHE#"+sDelimiter+sTargetString+IntToString(i),sNewToken);
      // only 1 instance ?
      if(!nAllInstances) nFirst = TRUE;
    }
    else
      s += sDelimiter + sCachedToken;
  }
  return GetStringRight(s,GetStringLength(s)-1); // cut initial delimiter
}
*/

//void main(){}
