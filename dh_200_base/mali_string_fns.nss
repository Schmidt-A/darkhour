//------------------------------------------------------------------------------
//  String functions include
//  by Malishara
//------------------------------------------------------------------------------


//------------------------------------------------------------------------------
// Returns the first word in sString, delimited by sDelimiter
//------------------------------------------------------------------------------
string FirstWord(string sString, string sDelimiter = " ");

//------------------------------------------------------------------------------
// Returns sString, starting with the second word, delimited by sDelimiter
//------------------------------------------------------------------------------
string RestWords(string sString, string sDelimiter = " ");

//------------------------------------------------------------------------------
// Replaces all occurences of sSearch within sString with sReplace
//------------------------------------------------------------------------------
string SearchAndReplace(string sString, string sSearch, string sReplace);

//------------------------------------------------------------------------------
// Return the nth word of sString, delimited by sDelimiter
//------------------------------------------------------------------------------
string FetchWord(string sString, string sDelimiter, int n);


string FirstWord(string sString, string sDelimiter = " ")
{ if (FindSubString(sString, sDelimiter) == -1)
  { return sString; }
  else
  { return GetStringLeft(sString, FindSubString(sString, sDelimiter)); }
}

string RestWords(string sString, string sDelimiter = " ")
{ if (FindSubString(sString, sDelimiter) == -1)
  { return ""; }
  else
  { return GetStringRight(sString, GetStringLength(sString) - FindSubString(sString, sDelimiter) - GetStringLength(sDelimiter)); }
}

string SearchAndReplace(string sString, string sSearch, string sReplace)
{ string sNewString = "";
  int iOffset = FindSubString(sString, sSearch);
  while (iOffset != -1)
  {   sNewString += FirstWord(sString, sSearch) + sReplace;
      sString = RestWords(sString, sSearch);
      iOffset = FindSubString(sString, sSearch);
  }
  return sNewString + sString;
}

string FetchWord(string sString, string sDelimiter, int n)
{ int iLoop = 0;
  string sWord = "";
  while (iLoop < n)
  {   sWord = FirstWord(sString, sDelimiter);
      sString = RestWords(sString, sDelimiter);
      iLoop++;
  }
  return sWord;
}

int CountWords(string sString, string sDelimiter)
{ int iCount = 0;
  int iPos = 0;

  while (iPos != -1)
  { iPos = FindSubString(sString, sDelimiter, iPos);
    if (iPos != -1)
    { iCount++;
      iPos = iPos + GetStringLength(sDelimiter);
    }
  }

  return iCount;
}

int FindWord(string sString, string sSubString, string sDelimiter)
{ int iPos = FindSubString(sDelimiter + sString + sDelimiter, sDelimiter + sSubString + sDelimiter);
  if (iPos == -1)
  { return FALSE; }

  iPos = iPos - GetStringLength(sDelimiter);
  sString = GetSubString(sString, 0, iPos);

  return CountWords(sString, sDelimiter);
}

string LastWord(string sString, string sDelimiter)
{ int iDelLen = GetStringLength(sDelimiter);
  int iPos = GetStringLength(sString) - iDelLen;

  while ((iPos > 0) && (GetSubString(sString, iPos, iDelLen) != sDelimiter))
  { iPos--; }

  if (GetSubString(sString, iPos, iDelLen) == sDelimiter)
  { iPos += iDelLen; }

  return GetStringRight(sString, GetStringLength(sString) - iPos);
}

