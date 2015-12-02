//Utility functions by Vladiat0r

int arGetCount(string sName);
void arDeleteArray(string sName);
string arCreateArray();

void arAppendString(string sName, string s);
string arGetString(string sName, int i);

void arAppendObject(string sName, object o);
object arGetObject(string sName, int i);

int arGetInt(string sName, int i);


void arAppendString(string sName, string s)
{
    int nCount = arGetCount(sName);
    SetLocalString(OBJECT_SELF, sName + IntToString(nCount), s);
    SetLocalInt(OBJECT_SELF, sName, nCount+1); //SetStringCount
}

string arGetString(string sName, int i)
{
    return GetLocalString(OBJECT_SELF, sName + IntToString(i));
}

void arAppendObject(string sName, object o)
{
    int nCount = arGetCount(sName);
    SetLocalObject(OBJECT_SELF, sName + IntToString(nCount), o);
    //WriteTimestampedLogEntry("DEBUG: [arAppendObject] " + sName + " " + IntToString(nCount) + " = " + GetName(o));
    SetLocalInt(OBJECT_SELF, sName, nCount+1); //SetStringCount
}

object arGetObject(string sName, int i)
{
    object o = GetLocalObject(OBJECT_SELF, sName + IntToString(i));
    //WriteTimestampedLogEntry("DEBUG: [arGetObject] " + sName + IntToString(i) + " = " + GetName(o));
    return o;
}

void arDeleteObject(string sName, int i)
{
    DeleteLocalObject(OBJECT_SELF, sName + IntToString(i));
}

int arGetInt(string sName, int i)
{
    return GetLocalInt(OBJECT_SELF, sName + IntToString(i));
}

int arGetCount(string sName)
{
    int nCount = GetLocalInt(OBJECT_SELF, sName);
    //WriteTimestampedLogEntry("DEBUG: [arGetCount] " + sName + " = " + IntToString(nCount));
    return nCount;
}

string arCreateArray()
{
    string sName;
    do
    {
        sName = IntToString(Random(65534)*Random(32769));
        //WriteTimestampedLogEntry("DEBUG: [arCreateArray] " + sName);
    }
    while (GetLocalInt(OBJECT_SELF, sName) > 0); //make sure name is unique
    SetLocalInt(OBJECT_SELF, sName, 0);
    return sName;
}

void arDeleteArray(string sName)
{
    int nCount = arGetCount(sName);
    int i;
    for(i = 0; i < nCount; i++)
    {
        DeleteLocalString(OBJECT_SELF, sName + IntToString(i));
        DeleteLocalObject(OBJECT_SELF, sName + IntToString(i));
        DeleteLocalInt(OBJECT_SELF, sName + IntToString(i));
    }
    //WriteTimestampedLogEntry("DEBUG: [arDeleteArray] " + sName + " " + IntToString(nCount));
    SetLocalInt(OBJECT_SELF, sName, 0);
    DeleteLocalInt(OBJECT_SELF, sName);
}
