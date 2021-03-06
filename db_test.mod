MOD V1.0   F   )       ц     s   I  џџџџ                                                                                                                        >   This module shows how you can use APS/NWNX in your own module.aps_include         й  aps_onload         к  aps_onload         й  area001            м  area001            ў  area001            ч  creaturepalcus     ю  demo_createtable   к  demo_createtable   й  demo_loadvalue  	   к  demo_loadvalue  
   й  demo_obj_create    к  demo_obj_create    й  demo_obj_loadval   к  demo_obj_loadval   й  demo_obj_storval   к  demo_obj_storval   й  demo_storevalue    к  demo_storevalue    й  doorpalcus         ю  encounterpalcus    ю  food               щ  hashset_nwnx       й  heartbeat          к  heartbeat          й  itempalcus         ю  module             о  on_login           к  on_login           й  on_logout          к  on_logout          й  placeablepalcus    ю  Repute              і  soundpalcus     !   ю  storepalcus     "   ю  triggerpalcus   #   ю  waypointpalcus  $   ю  _incl_globvars  %   й  _incl_hunger    &   й  _incl_session   '   к  _incl_session   (   й                                                                                                                                                                                                                                                                                                                                          N  ЖV  ^  Ё  Ѕd  ?  фh  i2  M  А  §  L  ь  ј  ј  т  dњ  f  Ъ   е	 Л   ё   §  ~ Й  7   Ж   О" З  u% -  Ђ+ Њ  L- м  (0 Ј  а2 Я  5 Ѓ  BO q  Г_ $  з` у  Кp   Cx 0  s| i   м|   №~ j   Z ,   a  ч и  П ш  Ї l   ш  ћ &   ! x  Ђ    АЂ є  // Name     : Avlis Persistence System include
// Purpose  : Various APS/NWNX2 related functions
// Authors  : Ingmar Stieger, Adam Colon, Josh Simon
// Modified : January 1st, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/************************************/
/* Return codes                     */
/************************************/

const int SQL_ERROR = 0;
const int SQL_SUCCESS = 1;

/************************************/
/* Function prototypes              */
/************************************/

// Setup placeholders for ODBC requests and responses
void SQLInit();

// Execute statement in sSQL
void SQLExecDirect(string sSQL);

// Position cursor on next row of the resultset
// Call this before using SQLGetData().
// returns: SQL_SUCCESS if there is a row
//          SQL_ERROR if there are no more rows
int SQLFetch();

// * deprecated. Use SQLFetch instead.
// Position cursor on first row of the resultset and name it sResultSetName
// Call this before using SQLNextRow() and SQLGetData().
// returns: SQL_SUCCESS if result set is not empty
//          SQL_ERROR is result set is empty
int SQLFirstRow();

// * deprecated. Use SQLFetch instead.
// Position cursor on next row of the result set sResultSetName
// returns: SQL_SUCCESS if cursor could be advanced to next row
//          SQL_ERROR if there was no next row
int SQLNextRow();

// Return value of column iCol in the current row of result set sResultSetName
string SQLGetData(int iCol);

// Return a string value when given a location
string APSLocationToString(location lLocation);

// Return a location value when given the string form of the location
location APSStringToLocation(string sLocation);

// Return a string value when given a vector
string APSVectorToString(vector vVector);

// Return a vector value when given the string form of the vector
vector APSStringToVector(string sVector);

// Set oObject's persistent string variable sVarName to sValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentString(object oObject, string sVarName, string sValue, int iExpiration =
                         0, string sTable = "pwdata");

// Set oObject's persistent integer variable sVarName to iValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentInt(object oObject, string sVarName, int iValue, int iExpiration =
                      0, string sTable = "pwdata");

// Set oObject's persistent float variable sVarName to fValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
void SetPersistentFloat(object oObject, string sVarName, float fValue, int iExpiration =
                        0, string sTable = "pwdata");

// Set oObject's persistent location variable sVarName to lLocation
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts location to a string for storage in the database.
void SetPersistentLocation(object oObject, string sVarName, location lLocation, int iExpiration =
                           0, string sTable = "pwdata");

// Set oObject's persistent vector variable sVarName to vVector
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwdata)
//   This function converts vector to a string for storage in the database.
void SetPersistentVector(object oObject, string sVarName, vector vVector, int iExpiration =
                         0, string sTable = "pwdata");

// Set oObject's persistent object with sVarName to sValue
// Optional parameters:
//   iExpiration: Number of days the persistent variable should be kept in database (default: 0=forever)
//   sTable: Name of the table where variable should be stored (default: pwobjdata)
void SetPersistentObject(object oObject, string sVarName, object oObject2, int iExpiration =
                         0, string sTable = "pwobjdata");

// Get oObject's persistent string variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: ""
string GetPersistentString(object oObject, string sVarName, string sTable = "pwdata");

// Get oObject's persistent integer variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
int GetPersistentInt(object oObject, string sVarName, string sTable = "pwdata");

// Get oObject's persistent float variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
float GetPersistentFloat(object oObject, string sVarName, string sTable = "pwdata");

// Get oObject's persistent location variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
location GetPersistentLocation(object oObject, string sVarname, string sTable = "pwdata");

// Get oObject's persistent vector variable sVarName
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
// * Return value on error: 0
vector GetPersistentVector(object oObject, string sVarName, string sTable = "pwdata");

// Get oObject's persistent object sVarName
// Optional parameters:
//   sTable: Name of the table where object is stored (default: pwobjdata)
// * Return value on error: 0
object GetPersistentObject(object oObject, string sVarName, object oOwner = OBJECT_INVALID, string sTable = "pwobjdata");

// Delete persistent variable sVarName stored on oObject
// Optional parameters:
//   sTable: Name of the table where variable is stored (default: pwdata)
void DeletePersistentVariable(object oObject, string sVarName, string sTable = "pwdata");

// (private function) Replace special character ' with ~
string SQLEncodeSpecialChars(string sString);

// (private function)Replace special character ' with ~
string SQLDecodeSpecialChars(string sString);

/************************************/
/* Implementation                   */
/************************************/

// Functions for initializing APS and working with result sets

void SQLInit()
{
    int i;

    // Placeholder for ODBC persistence
    string sMemory;

    for (i = 0; i < 8; i++)     // reserve 8*128 bytes
        sMemory +=
            "................................................................................................................................";

    SetLocalString(GetModule(), "NWNX!ODBC!SPACER", sMemory);
}

void SQLExecDirect(string sSQL)
{
    SetLocalString(GetModule(), "NWNX!ODBC!EXEC", sSQL);
}

int SQLFetch()
{
    string sRow;
    object oModule = GetModule();

    SetLocalString(oModule, "NWNX!ODBC!FETCH", GetLocalString(oModule, "NWNX!ODBC!SPACER"));
    sRow = GetLocalString(oModule, "NWNX!ODBC!FETCH");
    if (GetStringLength(sRow) > 0)
    {
        SetLocalString(oModule, "NWNX_ODBC_CurrentRow", sRow);
        return SQL_SUCCESS;
    }
    else
    {
        SetLocalString(oModule, "NWNX_ODBC_CurrentRow", "");
        return SQL_ERROR;
    }
}

// deprecated. use SQLFetch().
int SQLFirstRow()
{
    return SQLFetch();
}

// deprecated. use SQLFetch().
int SQLNextRow()
{
    return SQLFetch();
}

string SQLGetData(int iCol)
{
    int iPos;
    string sResultSet = GetLocalString(GetModule(), "NWNX_ODBC_CurrentRow");

    // find column in current row
    int iCount = 0;
    string sColValue = "";

    iPos = FindSubString(sResultSet, "Ќ");
    if ((iPos == -1) && (iCol == 1))
    {
        // only one column, return value immediately
        sColValue = sResultSet;
    }
    else if (iPos == -1)
    {
        // only one column but requested column > 1
        sColValue = "";
    }
    else
    {
        // loop through columns until found
        while (iCount != iCol)
        {
            iCount++;
            if (iCount == iCol)
                sColValue = GetStringLeft(sResultSet, iPos);
            else
            {
                sResultSet = GetStringRight(sResultSet, GetStringLength(sResultSet) - iPos - 1);
                iPos = FindSubString(sResultSet, "Ќ");
            }

            // special case: last column in row
            if (iPos == -1)
                iPos = GetStringLength(sResultSet);
        }
    }

    return sColValue;
}

// These functions deal with various data types. Ultimately, all information
// must be stored in the database as strings, and converted back to the proper
// form when retrieved.

string APSVectorToString(vector vVector)
{
    return "#POSITION_X#" + FloatToString(vVector.x) + "#POSITION_Y#" + FloatToString(vVector.y) +
        "#POSITION_Z#" + FloatToString(vVector.z) + "#END#";
}

vector APSStringToVector(string sVector)
{
    float fX, fY, fZ;
    int iPos, iCount;
    int iLen = GetStringLength(sVector);

    if (iLen > 0)
    {
        iPos = FindSubString(sVector, "#POSITION_X#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fX = StringToFloat(GetSubString(sVector, iPos, iCount));

        iPos = FindSubString(sVector, "#POSITION_Y#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fY = StringToFloat(GetSubString(sVector, iPos, iCount));

        iPos = FindSubString(sVector, "#POSITION_Z#") + 12;
        iCount = FindSubString(GetSubString(sVector, iPos, iLen - iPos), "#");
        fZ = StringToFloat(GetSubString(sVector, iPos, iCount));
    }

    return Vector(fX, fY, fZ);
}

string APSLocationToString(location lLocation)
{
    object oArea = GetAreaFromLocation(lLocation);
    vector vPosition = GetPositionFromLocation(lLocation);
    float fOrientation = GetFacingFromLocation(lLocation);
    string sReturnValue;

    if (GetIsObjectValid(oArea))
        sReturnValue =
            "#AREA#" + GetTag(oArea) + "#POSITION_X#" + FloatToString(vPosition.x) +
            "#POSITION_Y#" + FloatToString(vPosition.y) + "#POSITION_Z#" +
            FloatToString(vPosition.z) + "#ORIENTATION#" + FloatToString(fOrientation) + "#END#";

    return sReturnValue;
}

location APSStringToLocation(string sLocation)
{
    location lReturnValue;
    object oArea;
    vector vPosition;
    float fOrientation, fX, fY, fZ;

    int iPos, iCount;
    int iLen = GetStringLength(sLocation);

    if (iLen > 0)
    {
        iPos = FindSubString(sLocation, "#AREA#") + 6;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        oArea = GetObjectByTag(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_X#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fX = StringToFloat(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_Y#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fY = StringToFloat(GetSubString(sLocation, iPos, iCount));

        iPos = FindSubString(sLocation, "#POSITION_Z#") + 12;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fZ = StringToFloat(GetSubString(sLocation, iPos, iCount));

        vPosition = Vector(fX, fY, fZ);

        iPos = FindSubString(sLocation, "#ORIENTATION#") + 13;
        iCount = FindSubString(GetSubString(sLocation, iPos, iLen - iPos), "#");
        fOrientation = StringToFloat(GetSubString(sLocation, iPos, iCount));

        lReturnValue = Location(oArea, vPosition, fOrientation);
    }

    return lReturnValue;
}

// These functions are responsible for transporting the various data types back
// and forth to the database.

void SetPersistentString(object oObject, string sVarName, string sValue, int iExpiration =
                         0, string sTable = "pwdata")
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    sValue = SQLEncodeSpecialChars(sValue);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val='" + sValue +
            "',expire=" + IntToString(iExpiration) + " WHERE player='" + sPlayer +
            "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SQLExecDirect(sSQL);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "','" +
            sValue + "'," + IntToString(iExpiration) + ")";
        SQLExecDirect(sSQL);
    }
}

string GetPersistentString(object oObject, string sVarName, string sTable = "pwdata")
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
        return SQLDecodeSpecialChars(SQLGetData(1));
    else
    {
        return "";
        // If you want to convert your existing persistent data to APS, this
        // would be the place to do it. The requested variable was not found
        // in the database, you should
        // 1) query it's value using your existing persistence functions
        // 2) save the value to the database using SetPersistentString()
        // 3) return the string value here.
    }
}

void SetPersistentInt(object oObject, string sVarName, int iValue, int iExpiration =
                      0, string sTable = "pwdata")
{
    SetPersistentString(oObject, sVarName, IntToString(iValue), iExpiration, sTable);
}

int GetPersistentInt(object oObject, string sVarName, string sTable = "pwdata")
{
    string sPlayer;
    string sTag;
    object oModule;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-2147483647");
    return StringToInt(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentFloat(object oObject, string sVarName, float fValue, int iExpiration =
                        0, string sTable = "pwdata")
{
    SetPersistentString(oObject, sVarName, FloatToString(fValue), iExpiration, sTable);
}

float GetPersistentFloat(object oObject, string sVarName, string sTable = "pwdata")
{
    string sPlayer;
    string sTag;
    object oModule;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    oModule = GetModule();
    SetLocalString(oModule, "NWNX!ODBC!FETCH", "-340282306073709650000000000000000000000.000000000");
    return StringToFloat(GetLocalString(oModule, "NWNX!ODBC!FETCH"));
}

void SetPersistentLocation(object oObject, string sVarName, location lLocation, int iExpiration =
                           0, string sTable = "pwdata")
{
    SetPersistentString(oObject, sVarName, APSLocationToString(lLocation), iExpiration, sTable);
}

location GetPersistentLocation(object oObject, string sVarName, string sTable = "pwdata")
{
    return APSStringToLocation(GetPersistentString(oObject, sVarName, sTable));
}

void SetPersistentVector(object oObject, string sVarName, vector vVector, int iExpiration =
                         0, string sTable = "pwdata")
{
    SetPersistentString(oObject, sVarName, APSVectorToString(vVector), iExpiration, sTable);
}

vector GetPersistentVector(object oObject, string sVarName, string sTable = "pwdata")
{
    return APSStringToVector(GetPersistentString(oObject, sVarName, sTable));
}

void SetPersistentObject(object oOwner, string sVarName, object oObject, int iExpiration =
                         0, string sTable = "pwobjdata")
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oOwner))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oOwner));
        sTag = SQLEncodeSpecialChars(GetName(oOwner));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oOwner);
    }
    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT player FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);

    if (SQLFetch() == SQL_SUCCESS)
    {
        // row exists
        sSQL = "UPDATE " + sTable + " SET val=%s,expire=" + IntToString(iExpiration) +
            " WHERE player='" + sPlayer + "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oObject);
    }
    else
    {
        // row doesn't exist
        sSQL = "INSERT INTO " + sTable + " (player,tag,name,val,expire) VALUES" +
            "('" + sPlayer + "','" + sTag + "','" + sVarName + "',%s," + IntToString(iExpiration) + ")";
        SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);
        StoreCampaignObject ("NWNX", "-", oObject);
    }
}

object GetPersistentObject(object oObject, string sVarName, object oOwner = OBJECT_INVALID, string sTable = "pwobjdata")
{
    string sPlayer;
    string sTag;
    object oModule;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }
    sVarName = SQLEncodeSpecialChars(sVarName);

    string sSQL = "SELECT val FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    if (!GetIsObjectValid(oOwner))
        oOwner = oObject;
    return RetrieveCampaignObject ("NWNX", "-", GetLocation(oOwner), oOwner);
}

void DeletePersistentVariable(object oObject, string sVarName, string sTable = "pwdata")
{
    string sPlayer;
    string sTag;

    if (GetIsPC(oObject))
    {
        sPlayer = SQLEncodeSpecialChars(GetPCPlayerName(oObject));
        sTag = SQLEncodeSpecialChars(GetName(oObject));
    }
    else
    {
        sPlayer = "~";
        sTag = GetTag(oObject);
    }

    sVarName = SQLEncodeSpecialChars(sVarName);
    string sSQL = "DELETE FROM " + sTable + " WHERE player='" + sPlayer +
        "' AND tag='" + sTag + "' AND name='" + sVarName + "'";
    SQLExecDirect(sSQL);
}

// Problems can arise with SQL commands if variables or values have single quotes
// in their names. These functions are a replace these quote with the tilde character

string SQLEncodeSpecialChars(string sString)
{
    if (FindSubString(sString, "'") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "'")
            sReturn += "~";
        else
            sReturn += sChar;
    }
    return sReturn;
}

string SQLDecodeSpecialChars(string sString)
{
    if (FindSubString(sString, "~") == -1)      // not found
        return sString;

    int i;
    string sReturn = "";
    string sChar;

    // Loop over every character and replace special characters
    for (i = 0; i < GetStringLength(sString); i++)
    {
        sChar = GetSubString(sString, i, 1);
        if (sChar == "~")
            sReturn += "'";
        else
            sReturn += sChar;
    }
    return sReturn;
}


NCS V1.0B  Ё      *     +  џџџј        2 EATING_HASHSET  ђ     џџџќ   2 PENALTIES_HASHSET  ђ    Y џџџќ 5SELECT max FROM hunger_const WHERE level = 'Peckish';      Ѓ        -      В  щ&џџџј  џџџќ    - Bp  &џџџј  џџџќBp  &џџџј  џџџќ 6SELECT max FROM hunger_const WHERE level = 'Ravenous';   и   ќ        -        щ&џџџќ  џџџќ    - A№  &џџџќ  џџџќ      џџџє  џџџќџџџј         Мџџџќ  ................................................................................................................................#џџџј  џџџќџџџј $џџџє џџџќ џџџ:џџџќ  NWNX!ODBC!SPACER  ђ   9 џџџј  џџџј  !#џџџ№   \# !# NWNX!HASHSET!CREATEџџџє   9   џџџь  џџџќ     џџџє  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ    ђ  NWNX!ODBC!SPACERџџџј   5 NWNX!ODBC!FETCHџџџє   9 NWNX!ODBC!FETCHџџџј   5џџџє  џџџќџџџј   ;         Sџџџј  NWNX_ODBC_CurrentRowџџџє   9   џџџ№  џџџє    W    K-    NWNX_ODBC_CurrentRowџџџє   9    џџџ№  џџџє     џџџј   NWNX_ODBC_CurrentRow  ђ   5           Ќџџџь   Bџџџь  џџџќџџџ№ џџџџ џџџќ     џџџш          "џџџє џџџј  џџџќ   >- џџџ№ џџџџ       џџџј  џџџќ   - џџџј џџџш      єџџџј $џџџє џџџќџџџј џџџш      /џџџ№ џџџ№   ?џџџј  џџџќ    h- џџџє   ;џџџь      џџџ№   >џџџ№  џџџќ     Ќџџџь   Bџџџь  џџџќџџџ№ џџџџ     !џџџє   ;џџџь  џџџќ џџџ џџџќ џџџф  џџџь     џџџ№ џџџќ  // Name     : Avlis Persistence System OnModuleLoad
// Purpose  : Initialize APS on module load event
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"
#include "_incl_globvars"
#include "hashset_nwnx"

void main()
{
    // Init placeholders for ODBC gateway
    SQLInit();

    // Initialize globals.
    HashSetCreate(GetModule(), "EATING_HASHSET", 50);
    HashSetCreate(GetModule(), "PENALTIES_HASHSET", 50);

    SQLExecDirect("SELECT max FROM hunger_const WHERE level = 'Peckish';");
    if(SQLFetch() == SQL_SUCCESS)
        HUNGRY_AT = StringToFloat(SQLGetData(1));
    else
        // This shouldn't have happened...
        HUNGRY_AT = 60.0;
    HUNGRY_AT = 60.0;

    SQLExecDirect("SELECT max FROM hunger_const WHERE level = 'Ravenous';");
    if(SQLFetch() == SQL_SUCCESS)
        RAVENOUS_AT = StringToFloat(SQLGetData(1));
    else
        // This shouldn't have happened...
        RAVENOUS_AT = 30.0;
}

ARE V3.28   A   D  Њ  <#  4   |&  =   Й&  Ј
  a1    џџџџ    *      Ј   
      а   
      ј   
         
      H  
      p  
        
      Р  
      ш  
        
      8  
      `  
        
      А  
      и  
         
      (  
      P  
      x  
         
      Ш  
      №  
        
      @  
      h  
        
      И  
      р  
        
      0  
      X  
        
      Ј  
      а  
      ј  
         
      H  
      p  
        
      Р  
      ш  
        
      8  
      `  
        
      А  
      и  
         
      (  
      P  
      x  
         
      Ш  
      №  
      	  
      @	  
      h	  
      	  
      И	  
      р	  
      
  
      0
  
      X
  
      
  
          џџџџ      џџџџ         
                         '   
      /                         	          
                       ddШ                  22d                 22d       џџџ                  h~                                        2           4B                                                                                      !          "         #         $   3      %   4      &   5      '   6      (   7      )         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3         *         +          ,           -           .           /           0           1          2          3         *         +         ,           -           .           /           0           1          2          3      ID              Creator_ID      Version         Tag             Name            ResRef          Comments        Expansion_List  Flags           ModSpotCheck    ModListenCheck  MoonAmbientColorMoonDiffuseColorMoonFogAmount   MoonFogColor    MoonShadows     SunAmbientColor SunDiffuseColor SunFogAmount    SunFogColor     SunShadows      IsNight         LightingScheme  ShadowOpacity   FogClipDist     SkyBox          DayNightCycle   ChanceRain      ChanceSnow      ChanceLightning WindPower       LoadScreenID    PlayerVsPlayer  NoRest          Width           Height          OnEnter         OnExit          OnHeartbeat     OnUserDefined   Tileset         Tile_List       Tile_ID         Tile_OrientationTile_Height     Tile_MainLight1 Tile_MainLight2 Tile_SrcLight1  Tile_SrcLight2  Tile_AnimLoop1  Tile_AnimLoop2  Tile_AnimLoop3     Area001   џџџџ          Area 001area001        tms01                            	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _   `   a   b   c   d   e   f   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~                                                                                                          Ё   Ђ   Ѓ   Є   Ѕ   І   Ї   Ј   Љ   Њ   Ћ   Ќ   ­   Ў   Џ   А   Б   В   Г   Д   Е   Ж   З   И   Й   К   Л   М   Н   О   П   Р   С   Т   У   Ф   Х   Ц   Ч   Ш   Щ   Ъ   Ы   Ь   Э   Ю   Я   а   б   в   г   д   е   ж   з   и   й   к   л   м   н   о   п   р   с   т   у   ф   х   ц   ч   ш   щ   ъ   ы   ь   э   ю   я   №   ё   ђ   ѓ   є   ѕ   і   ї   ј   љ   њ   ћ   ќ   §   ў   џ                      	  
                                               !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~                                                                       Ё  Ђ  Ѓ  Є  Ѕ  І  Ї  Ј  Љ  Њ  Ћ  Ќ  ­  Ў  Џ  А  Б  В  Г  Д  Е  Ж  З  И  Й  К  Л  М  Н  О  П  Р  С  Т  У  Ф  Х  Ц  Ч  Ш  Щ  Ъ  Ы  Ь  Э  Ю  Я  а  б  в  г  д  е  ж  з  и  й  к  л  м  н  о  п  р  с  т  у  ф  х  ц  ч  ш  щ  ъ  ы  ь  э  ю  я  №  ё  ђ  ѓ  є  ѕ  і  ї  ј  љ  њ  ћ  ќ  §  ў  џ                     	  
                                               !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~                                                                       Ё  Ђ  Ѓ  Є  Ѕ  І  Ї  Ј  Љ      @                           	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   GIC V3.28      ј        
   И  t  ,  $   P  `   џџџџ    	                                           	         	         	         	         	         	         	         	         	         	         	                                               
          
         
         
                         $         (         ,      	   0   
         
      7   
      ^   
         
         
      М   
      у   
      
  
        
      *  
      N  Creature List   Door List       Encounter List  List            Comment         SoundList       StoreList       TriggerList     WaypointList    Placeable List                  #   Freestanding Merchant's Placard - 1#   Freestanding Merchant's Placard - 3#   Freestanding Merchant's Placard - 4   Signpost - 1#   Freestanding Merchant's Placard - 1#   Freestanding Merchant's Placard - 3#   Freestanding Merchant's Placard - 4   Signpost - 3   Signpost - 3    Chest - 4 (High treasure script)"   Chest - 3 (Medium treasure script)                	   
                                                                   	   
                  GIT V3.28        c  8*     82    Q>    нK  А   џџџџ    
   d   (   	       L                     є          H     	     7   	   x  7   	   T  7   	   0  7   	     7   	   ш  7   	   Ф  7   	      7   	   |  7   	   X	  7   	   4
  8         /       а         ь                 d                           И        д         8         T         p                                                                     "                        	   _    
                                        ъB      Б B                            ?                                  #         /   
      ;                                                                                           !         "             
B      Г!B                            ?      C                  H         f         r   
      ~                                                                                           !         "   $         +"B      S7!B                            ?                                 Љ         Е   
      С                                                                                           !         "   (         A9&B      Г!B                            ?      Щ                  Ю         ь         ј   
                                                                                                !         "   ,      #   0      $   4      %   8      &   <      '   @   
           (   -        _        Џ      )           *          +   М      ,         -                     .           /           0           1         2   щ      3          4           5          6          7           8          9       
   :   Н      ;          <         =         >          ?          @          A           B          C   С     D   Т     E   У     F   Ф     G   Х     H   Ц     I   Ч     J   Ш     K   Щ     L   Ъ     M   Ы     N   Ь     O   Э      P           Q           R           S           T         U   Ю     V   Я     W   4rТA   X   3DB   Y      7   Z      
      р     (           /              )           *          +         ,         -                     .           /           0           1         2   ъ      3          4           5          6          7           8          9       
   :         ;          <         =         >          ?          @          A           B          C        D        E        F        G        H        I        J        K        L        M        N        O         P           Q           R           S           T         U        V        W   нA   X   ЄбDB   Y     5   Z      
      Џ     (   а        џ        O      )           *          +   \      ,         -                     .           /           0           1         2   ы      3          4           5          6          7           8          9       
   :   ]      ;          <         =         >          ?          @          A           B          C   a     D   b     E   c     F   d     G   e     H   f     I   g     J   h     K   i     L   j     M   k     N   l     O   m      P           Q           R           S           T         U   n     V   o     W   EіA   X   ЈDB   Y      7   Z      
      ~     (           Е        Й      )           *          +   Ц      ,         -                    .           /           0           1         2   Н      3          4           5          6          7           8          9       
   :   Ч      ;          <   W      =         >          ?          @          A           B          C   Ы     D   Ь     E   Э     F   Ю     G   Я     H   а     I   б     J   в     K   г     L   д     M   е     N   ж     O   з      P           Q           R           S           T         U   и     V   й     W   №ў#B   X   !1B   Y   9ЏЖ   Z      
      к     (   ћ        0              )           *          +         ,         -                     .           /           0           1         2   ь      3          4           5          6          7           8          9       
   :         ;          <         =         >          ?          @          A           B          C        D        E        F        G        H        I        J        K        L        M        N        O         P           Q           R           S           T         U        V         W   PB   X   каFB   Y      7   Z      
      А     (   б        ў        N      )           *          +   [      ,         -                     .           /           0           1         2   ъ      3          4           5          6          7           8          9       
   :   \      ;          <         =         >          ?          @          A           B          C   `     D   a     E   b     F   c     G   d     H   e     I   f     J   g     K   h     L   i     M   j     N   k     O   l      P           Q           R           S           T         U   m     V   n     W   ѕн]B   X   KGB   Y      7   Z      
           (            Ю              )           *          +   +      ,         -                     .           /           0           1         2   ы      3          4           5          6          7           8          9       
   :   ,      ;          <         =         >          ?          @          A           B          C   0     D   1     E   2     F   3     G   4     H   5     I   6     J   7     K   8     L   9     M   :     N   ;     O   <      P           Q           R           S           T         U   =     V   >     W   НujB   X   (хFB   Y      7   Z      
      O     (   \                Н      )           *          +   Ы      ,         -                     .           /          0           1          2   П      3          4           5          6           7           8          9      
   :   Ь      ;          <   Y      =         >          ?          @          A           B          C   а     D   б     E   в     F   г     G   д     H   е     I   ж     J   з     K   и     L   й     M   к     N   л     O   м      P           Q           R           S           T         U   н     V   о     W   жkBB   X   {єFB   Y      7   Z      
      п     (   ь        	        
      )           *          +   
      ,         -                     .           /          0           1          2   П      3          4           5          6           7           8          9      
   :   
      ;          <   Y      =         >          ?          @          A           B          C   
     D    
     E   Ё
     F   Ђ
     G   Ѓ
     H   Є
     I   Ѕ
     J   І
     K   Ї
     L   Ј
     M   Љ
     N   Њ
     O   Ћ
      P           Q           R           S           T         U   Ќ
     V   ­
     W   РйB   X   ЯDFB   Y      7   Z      
      Ў
     (   И
        г
        п
      )           *          +   ъ
      ,          -                     .           /           0           1         2   p      3          4           5          6          7           8          9       
   :   ы
      ;          <   
      =         >          ?          @          A           B          C   я
     D   №
     E   ё
     F   ђ
     G   ѓ
     H   є
     I   ѕ
     J   і
     K   ї
     L   ј
     M   љ
     N   њ
     O   ћ
      P          Q           R           S           T         U   ќ
     V   §
     W    Я~B   X   V7B   Y      7   Z   ОuП
      ў
     (           #        /      )           *          +   :      ,          -                     .           /           0           1         2   o      3          4           5          6          7           8          9       
   :   ;      ;          <   	      =         >          ?          @          A           B          C   ?     D   @     E   A     F   B     G   C     H   D     I   E     J   F     K   G     L   H     M   I     N   J     O   K      P          Q           R           S           T         U   L     V   M     W   яєwB   X   O,AB   Y      7   Z   ОuП   [   p           П        П        П                  ?      N                 [        g        s  
                         А                                                                      \          ]          ^          _          `   
       a   
       b          c          d          e          f          g          h          i          j          k          l          m          n           o   2       p   7       q          r          s   #       t         "         u         v           w         x          y   џ       z   џ       {   d      u   K      v           w          x           y   џ       z           {   d      |          }               П        П        П                  ?              K                  Ќ        И  
      Ф                                                                                         !         "         u         v   F      w         x          y   џ       z           {   d      u   ?      v          w          x           y   џ       z           {   d      u   ?      v   	       w          x           y   џ       z           {   d      u   ?      v   
       w          x           y   џ       z           {   d      |         }               П        П        П                  ?      и                 х        ё        §  
      	                   r^                                                                      !          ~                   "          u         v   ђ       w         x          y   џ       z   џ       {   d      u         v           w         x          y   џ       z   џ       {   d      u   ,      v           w         x          y   	       z          {   d      |         }       AreaProperties  AmbientSndDay   AmbientSndNight AmbientSndDayVolAmbientSndNitVolEnvAudio        MusicBattle     MusicDay        MusicNight      MusicDelay      Creature List   Door List       Encounter List  List            XPosition       YPosition       ZPosition       XOrientation    YOrientation    TemplateResRef  BaseItem        LocalizedName   Description     DescIdentified  Tag             Charges         Cost            Stolen          StackSize       Plot            AddCost         Identified      Cursed          ModelPart1      PropertiesList  SoundList       StoreList       TriggerList     WaypointList    Placeable List  LocName         AutoRemoveKey   CloseLockDC     Conversation    Interruptable   Faction         KeyRequired     Lockable        Locked          OpenLockDC      PortraitId      TrapDetectable  TrapDetectDC    TrapDisarmable  DisarmDC        TrapFlag        TrapOneShot     TrapType        KeyName         AnimationState  Appearance      HP              CurrentHP       Hardness        Fort            Ref             Will            OnClosed        OnDamaged       OnDeath         OnDisarm        OnHeartbeat     OnLock          OnMeleeAttacked OnOpen          OnSpellCastAt   OnTrapTriggered OnUnlock        OnUserDefined   OnClick         HasInventory    BodyBag         Static          Type            Useable         OnInvDisturbed  OnUsed          X               Y               Z               Bearing         ItemList        ArmorPart_RFoot ArmorPart_LFoot ArmorPart_RShin ArmorPart_LShin ArmorPart_LThighArmorPart_RThighArmorPart_PelvisArmorPart_Torso ArmorPart_Belt  ArmorPart_Neck  ArmorPart_RFArm ArmorPart_LFArm ArmorPart_RBicepArmorPart_LBicepArmorPart_RShoulArmorPart_LShoulArmorPart_RHand ArmorPart_LHand ArmorPart_Robe  Leather1Color   Leather2Color   Cloth1Color     Cloth2Color     Metal1Color     Metal2Color     PropertyName    Subtype         CostTable       CostValue       Param1          Param1Value     ChanceAppear    Repos_PosX      Repos_Posy      ModelPart2      ModelPart3      food   џџџџ       
   Small Meal   џџџџ       џџџџ       foodfood   џџџџ       
   Small Meal   џџџџ       џџџџ       foodfood   џџџџ       
   Small Meal   џџџџ       џџџџ       foodfood   џџџџ       
   Small Meal   џџџџ       џџџџ       food   FreestandingMerchantsPlacard2.   `9            Create database table "pwdata"L   _9         <   A carefully constructed marker denoting a point of interest.plc_placard1                   demo_createtable   FreestandingMerchantsPlacard3*   `9            Store variable in databaseL   b9         <   A carefully constructed marker denoting a point of interest.plc_placard3                   demo_storevalue   FreestandingMerchantsPlacard4+   `9            Load variable from databaseL   c9         <   A carefully constructed marker denoting a point of interest.plc_placard4                   demo_loadvalue   HASHOBJ(   d            Instructions: Look at me   {9         №   This is the APS demo module.

It demonstrates how to store two types of data: Strings and objects. Check out the signpost to the left to learn how to store string data, and the signpost to the right on how to store objects to the database.
plc_signpost                       FreestandingMerchantsPlacard21   `9         !   Create database table "pwobjdata"L   _9         <   A carefully constructed marker denoting a point of interest.plc_placard1                   demo_obj_create   FreestandingMerchantsPlacard3)   `9            Store objects in databaseL   b9         <   A carefully constructed marker denoting a point of interest.plc_placard3                   demo_obj_storval   FreestandingMerchantsPlacard4*   `9            Load objects from databaseL   c9         <   A carefully constructed marker denoting a point of interest.plc_placard4                   demo_obj_loadval	   Signpost3*   d            Instructions 2: Look at me/  }9           There are three items in the left chest. The test consists of storing these items in the database, and retrieve them to the chest on the right.

1) Create a table pwobjdata with the first sign
2) Store the items in the database with the second sign
3) Retrieve them with the third sign.
plc_signpost3                    	   Signpost3*   d            Instructions 1: Look at men  }9         ^  The signs to the left demonstrate how NWNX ODBC stores persistent data in an SQL database. The test consists of creating a table in the database to hold the data, storing a string value, and retrieving it.

1) Create a table pwdata with the leftmost sign
2) Store the variable in the database with the second sign
3) Retrieve it with the third sign.
plc_signpost3                       Chest2   ф            Chest 2   9      
plc_chest4                       Chest1   ф            Chest 1   9      
plc_chest3                    nw_maarcl054   ш5         џџџџ       щ5         NW_MAARCL054x2_it_sparscr602   Ц         џџџџ                X2_IT_SPARSCR602nw_wswmgs005   ђ7         џџџџ       ё7         NW_WSWMGS005    
            b   c   d   e   f                           	                                                             !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _   `   a   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~                                                                                                          Ё   Ђ   Ѓ   Є   Ѕ   І   Ї   Ј   Љ   Њ   Ћ   Ќ   ­   Ў   Џ   А   Б   В   Г   Д   Е   Ж   З   И   Й   К   Л   М   Н   О   П   Р   С   Т   У   Ф   Х   Ц   Ч   Ш   Щ   Ъ   Ы   Ь   Э   Ю   Я   а   б   в   г   д   е   ж   з   и   й   к   л   м   н   о   п   р   с   т   у   ф   х   ц   ч   ш   щ   ъ   ы   ь   э   ю   я   №   ё   ђ   ѓ   є   ѕ   і   ї   ј   љ   њ   ћ   ќ   §   ў   џ                      	  
                                               !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~                                                                       Ё  Ђ  Ѓ  Є  Ѕ  І  Ї  Ј  Љ  Њ  Ћ  Ќ  ­  Ў  Џ  А  Б  В  Г  Д  Е  Ж  З  И  Й  К  Л  М  Н  О  П  Р  С  Т  У  Ф  Х  Ц  Ч  Ш  Щ  Ъ  Ы  Ь  Э  Ю  Я  а  б  в  г  д  е  ж  з  и  й  к  л  м  н  о  п  р  с  т  у  ф  х  ц  ч  ш  щ  ъ  ы  ь  э  ю  я  №  ё  ђ  ѓ  є  ѕ  і  ї  ј  љ  њ  ћ  ќ  §  ў  џ                     	  
                                               !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  3  4  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H  I  J  K  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _  `  a  b  c  d  e  f  g  h  i  j  k  l  m  n  o  p  q  r  s  t  u  v  w  x  y  z  {  |  }  ~                                                                       Ё  Ђ  Ѓ  Є  Ѕ  І  Ї  Ј  Љ  Њ  Ћ  Ќ  ­  Ў  Џ  А  Б  В  Г  Д  Е  Ж  З  И  Й  К  Л  М  Н  О  П  Р  С  Т  У  Ф  Х  Ц  Ч  Ш  Щ  Ъ  Ы  Ь  Э  Ю  Я  а  б  в  г  д  е  ж  з  и  й  к  л  м  н  о  п  р  с  т  у  ф  х  ц  ч  ш  щ  ъ  ы  ь  э  ю  я  №  ё       ђ  ѓ  є  ѕ  і  ї  ј  љ  њ  ћ  ќ  §  ў  џ                	  
                          3  4                       !  "  #  $  %  &  '  (  )  *  +  ,  -  .  /  0  1  2  5  6  7  8  9  :  ;  <  =  >  ?  @  A  B  C  D  E  F  G  H  I  J  K  a  b  L  M  N  O  P  Q  R  S  T  U  V  W  X  Y  Z  [  \  ]  ^  _  `                                                                         	   
                                                                     ITP V3.28   =     y   Р      	       	  р  р
    џџџџ                                                               (          0          8          @          H          P          X          `          h          p          x                                                             Ј          А          И          Р          Ш          а          и          р          ш          №          ј                                                         (         0         8         @         H         P         X         `         h         p         x                                                       Ј         А         И         Р         Ш         а         и                      %                 ї         0         &        L         '                  (                  )                  *                  Щ          	         8                  9                  :                          d         G         "         H         #         I         $         J         %         1        x         2                  3                  4                  5                  6                                    Щ          2         ,                 -         
         .                  ї         1         8                  ;        Є         <                  =                  >                  +         /         ?                  /                  #        М         
                  B                  Щ                   D                  C                  k                   E         !         K        м                   &                   '                   (                   *                   )         !          +         #          ,         Щ          -                                              !                  "                  #                  $                  L         .   MAIN            STRREF          LIST            ID                                      	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _   `   a   b   c   d   e   f   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x         -   6   <            	   
                        $   %                                                                               !   "   #      &   '   (   )   *   +   ,      .   /   0   1   2   3   4   5      7   8   9   :   ;   NCS V1.0B  т       DROP TABLE pwdata    Table 'pwdata' deleted. J  v %Creating Table 'pwdata' for SQLite... J  v §CREATE TABLE pwdata (player varchar(64) NOT NULL default '~',tag varchar(64) NOT NULL default '~',name varchar(64) NOT NULL default '~',val text,expire int(11) default NULL,last timestamp NOT NULL default current_timestamp,PRIMARY KEY (player,tag,name))    - Table 'pwdata' created. J  v  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ  // Name     : Demo create table
// Purpose  : Create a table for persistent data
// Authors  : Ingmar Stieger
// Modified : February 02, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    SQLExecDirect("DROP TABLE pwdata");
    SendMessageToPC(GetLastUsedBy(), "Table 'pwdata' deleted.");

    // For SQLite
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwdata' for SQLite...");
    SQLExecDirect("CREATE TABLE pwdata (" +
        "player varchar(64) NOT NULL default '~'," +
        "tag varchar(64) NOT NULL default '~'," +
        "name varchar(64) NOT NULL default '~'," +
        "val text," +
        "expire int(11) default NULL," +
        "last timestamp NOT NULL default current_timestamp," +
        "PRIMARY KEY (player,tag,name)" +
        ")");

    // For MySQL
    /*
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwdata' for MySQL...");
    SQLExecDirect("CREATE TABLE pwdata (" +
        "player varchar(64) NOT NULL default '~'," +
        "tag varchar(64) NOT NULL default '~'," +
        "name varchar(64) NOT NULL default '~'," +
        "val text," +
        "expire int(11) default NULL," +
        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
        "PRIMARY KEY  (player,tag,name)" +
        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;");
    */

    // For Access
    /*
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwdata' for Access...");
    SQLExecDirect("CREATE TABLE pwdata (" +
                    "player text(64)," +
                    "tag text(64)," +
                    "name text(64)," +
                    "val memo," +
                    "expire text(4)," +
                    "last date)");
    */

    SendMessageToPC(GetLastUsedBy(), "Table 'pwdata' created.");
}
NCS V1.0B         pwdata demoName J     H "Retrieved variable from database: џџџј # J  v џџџќ  џџџє   й    Xџџџ№  s   џџџє  џџџќ    џџџь   §   _џџџј  џџџќ    6-  ~џџџє  џџџќџџџє   Јџџџј  џџџќџџџь    џџџь  џџџќ SELECT val FROM џџџш #  WHERE player='#џџџє # ' AND tag='#џџџј # ' AND name='#џџџь # '#џџџќ    Ж   к        6      ч   щџџџр  џџџ№    ,     -   џџџр  џџџ№     џџџє џџџє       'џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  '#    )џџџј  ~#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ    ђ  NWNX!ODBC!SPACERџџџј   5 NWNX!ODBC!FETCHџџџє   9 NWNX!ODBC!FETCHџџџј   5џџџє  џџџќџџџј   ;         Sџџџј  NWNX_ODBC_CurrentRowџџџє   9   џџџ№  џџџє    W    K-    NWNX_ODBC_CurrentRowџџџє   9    џџџ№  џџџє     џџџј   NWNX_ODBC_CurrentRow  ђ   5           Ќџџџь   Bџџџь  џџџќџџџ№ џџџџ џџџќ     џџџш          "џџџє џџџј  џџџќ   >- џџџ№ џџџџ       џџџј  џџџќ   - џџџј џџџш      єџџџј $џџџє џџџќџџџј џџџш      /џџџ№ џџџ№   ?џџџј  џџџќ    h- џџџє   ;џџџь      џџџ№   >џџџ№  џџџќ     Ќџџџь   Bџџџь  џџџќџџџ№ џџџџ     !џџџє   ;џџџь  џџџќ џџџ џџџќ џџџф  џџџь     џџџ№ џџџќ       ~џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  ~#    )џџџј  '#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  // Name     : Demo load value
// Purpose  : Load a value from the database
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    string sString = GetPersistentString(GetLastUsedBy(), "demoName");
    SendMessageToPC(GetLastUsedBy(), "Retrieved variable from database: " + sString);
}
NCS V1.0B  ё       DROP TABLE pwobjdata    Table 'pwobjdata' deleted. J  v (Creating Table 'pwobjdata' for SQLite... J  v CREATE TABLE pwobjdata (player varchar(64) NOT NULL default '~',tag varchar(64) NOT NULL default '~',name varchar(64) NOT NULL default '~',val blob,expire int(11) default NULL,last timestamp NOT NULL default current_timestamp,PRIMARY KEY (player,tag,name))    0 Table 'pwobjdata' created. J  v  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ  // Name     : Demo create object table
// Purpose  : Create a table for persistent object data
// Authors  : Ingmar Stieger
// Modified : January 14, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    SQLExecDirect("DROP TABLE pwobjdata");
    SendMessageToPC(GetLastUsedBy(), "Table 'pwobjdata' deleted.");

    // For SQLite
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwobjdata' for SQLite...");
    SQLExecDirect("CREATE TABLE pwobjdata (" +
        "player varchar(64) NOT NULL default '~'," +
        "tag varchar(64) NOT NULL default '~'," +
        "name varchar(64) NOT NULL default '~'," +
        "val blob," +
        "expire int(11) default NULL," +
        "last timestamp NOT NULL default current_timestamp," +
        "PRIMARY KEY (player,tag,name)" +
        ")");

    // For MySQL
    /*
    SendMessageToPC(GetLastUsedBy(), "Creating Table 'pwobjdata' for MySQL...");
    SQLExecDirect("CREATE TABLE pwobjdata (" +
        "player varchar(64) NOT NULL default '~'," +
        "tag varchar(64) NOT NULL default '~'," +
        "name varchar(64) NOT NULL default '~'," +
        "val blob," +
        "expire int(11) default NULL," +
        "last timestamp NOT NULL default CURRENT_TIMESTAMP," +
        "PRIMARY KEY  (player,tag,name)" +
        ") ENGINE=MyISAM DEFAULT CHARSET=latin1;");
    */

    SendMessageToPC(GetLastUsedBy(), "Table 'pwobjdata' created.");
}
NCS V1.0B  Й              Chest1  Ш     Chest2  Ш 3SELECT val FROM pwobjdata WHERE player='~'AND tag='џџџє   Ј# '#џџџќ  NWNX!ODBC!SETSCORCOSQL  ђ   9   џџџє џџџ№   е - NWNX [џџџь  џџџќџџџ№   *    c   џџџє џџџ№   е 	FETCHMODE NWNX [џџџь  џџџќџџџш $џџџф џџџќ џџџ 
Retrieved џџџф   \#  objects from database.# $  v џџџш  // Name     : Demo load value
// Purpose  : Load a value from the database
// Authors  : Ingmar Stieger
// Modified : January 1st, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    int iItem;
    int bContinue = TRUE;
    object oCreated;
    object oChest1 = GetObjectByTag("Chest1");
    object oChest2 = GetObjectByTag("Chest2");

    /* Method 1: GetPersistentObject
     *
     * Use this method for simplicity.

    while (bContinue)
    {
        oCreated = GetPersistentObject(oChest1, "Item_" + IntToString(iItem), oChest2);
        if (!GetIsObjectValid(oCreated))
            bContinue = FALSE;
        else
            iItem++;
    }
    */

    /* Method 2: Loop over resultset
     *
     * Use this method if you need the flexibility of SQL resultsets
    */

    string sSQL = "SELECT val FROM pwobjdata WHERE player='~'" +
        "AND tag='" + GetTag(oChest1) + "'";
    SetLocalString(GetModule(), "NWNX!ODBC!SETSCORCOSQL", sSQL);

    // The first call to RCO executes the SQL query and returns the first row.
    oCreated = RetrieveCampaignObject ("NWNX", "-", GetLocation(oChest2), oChest2);
    while (GetIsObjectValid(oCreated))
    {
        // "FETCHMODE" tells RCO to not execute the SQL statement again, but to
        // just advance to the next row in the resultset
        oCreated = RetrieveCampaignObject("NWNX", "FETCHMODE", GetLocation(oChest2), oChest2);
        iItem++;
    }


    SendMessageToPC(GetFirstPC(), "Retrieved " + IntToString(iItem) + " objects from database.");
}
NCS V1.0B             Chest1  Шџџџќ  Sџџџќ   *    | 	pwobjdata    џџџє  Item_џџџф   \#џџџш     џџџј  Tџџџј  џџџќџџџє $џџџ№ џџџќ џџџ} Stored џџџ№   \#  objects in database.# $  v џџџє  џџџє   й    Xџџџ№  s   @џџџє  џџџќ    џџџь   §   џџџј  џџџќ    6-  ~џџџє  џџџќџџџє   Јџџџј  џџџќџџџь    Уџџџь  џџџќ SELECT player FROM џџџр #  WHERE player='#џџџє # ' AND tag='#џџџј # ' AND name='#џџџь # '#џџџќ    k           UPDATE џџџм #  SET val=%s,expire=#џџџр   \#  WHERE player='#џџџ№ # ' AND tag='#џџџє # ' AND name='#џџџш # '#џџџј  џџџќџџџќ  NWNX!ODBC!SETSCORCOSQL  ђ   9   џџџф  - NWNX Z џџџќ   -  INSERT INTO џџџм # $ (player,tag,name,val,expire) VALUES# ('#џџџ№ # ','#џџџє # ','#џџџш # ',%s,#џџџр   \# )#џџџј  џџџќџџџќ  NWNX!ODBC!SETSCORCOSQL  ђ   9   џџџф  - NWNX Z џџџќ џџџє џџџь       'џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  '#    )џџџј  ~#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ    ђ  NWNX!ODBC!SPACERџџџј   5 NWNX!ODBC!FETCHџџџє   9 NWNX!ODBC!FETCHџџџј   5џџџє  џџџќџџџј   ;         Sџџџј  NWNX_ODBC_CurrentRowџџџє   9   џџџ№  џџџє    W    K-    NWNX_ODBC_CurrentRowџџџє   9    џџџ№  џџџє     џџџј  // Name     : Demo store object
// Purpose  : Store objects in the database
// Authors  : Ingmar Stieger
// Modified : January 1st, 2005

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    int iItem;
    object oChest = GetObjectByTag("Chest1");
    object oItem = GetFirstItemInInventory(oChest);

    while (GetIsObjectValid(oItem))
    {
        SetPersistentObject(oChest, "Item_" + IntToString(iItem), oItem);
        oItem = GetNextItemInInventory(oChest);
        iItem++;
    }

    SendMessageToPC(GetFirstPC(), "Stored " + IntToString(iItem) + " objects in database.");
}

NCS V1.0B  -       pwdata     	testValue demoName J     5 Stored 'testValue' in database. J  v  џџџє   й    Xџџџ№  s   іџџџє  џџџќ    џџџь   §   Эџџџј  џџџќ    6-  ~џџџє  џџџќџџџє   Јџџџј  џџџќџџџь    yџџџь  џџџќџџџш    [џџџш  џџџќ SELECT player FROM џџџр #  WHERE player='#џџџє # ' AND tag='#џџџј # ' AND name='#џџџь # '#џџџќ       '        в UPDATE џџџм # 
 SET val='#џџџф # 	',expire=#џџџр   \#  WHERE player='#џџџ№ # ' AND tag='#џџџє # ' AND name='#џџџш # '#џџџј  џџџќџџџќ    '    б-  INSERT INTO џџџм # $ (player,tag,name,val,expire) VALUES# ('#џџџ№ # ','#џџџє # ','#џџџш # ','#џџџф # ',#џџџр   \# )#џџџј  џџџќџџџќ    V џџџє џџџь       'џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  '#    )џџџј  ~#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ    ђ  NWNX!ODBC!SPACERџџџј   5 NWNX!ODBC!FETCHџџџє   9 NWNX!ODBC!FETCHџџџј   5џџџє  џџџќџџџј   ;         Sџџџј  NWNX_ODBC_CurrentRowџџџє   9   џџџ№  џџџє    W    K-    NWNX_ODBC_CurrentRowџџџє   9    џџџ№  џџџє     џџџј  // Name     : Demo store value
// Purpose  : Store a value in the database
// Authors  : Ingmar Stieger
// Modified : January 27, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

#include "aps_include"

void main()
{
    SetPersistentString(GetLastUsedBy(), "demoName", "testValue");
    SendMessageToPC(GetLastUsedBy(), "Stored 'testValue' in database.");
}
ITP V3.28      д            @      @  `      <   џџџџ                                                               (          0          8          @          H          P          X                                                            !                  "                  #                  $                  N                  O        (         P                  Щ          	         Q                  R            MAIN            STRREF          LIST            ID                                      	   
                                                                              	   
         ITP V3.28      Ш      м             X   t  4   џџџџ                                                               (          0          8          @          H          P                       Њ                  Ћ         	         б                  Љ                                                       !                  "                  #                  $                  Ї            MAIN            STRREF          ID              LIST                                    	   
                                                                        	   
   UTI V3.28      D           <  G     H   Ы     џџџџ                                          #         /   
      ;                                      	          
                                                                     
      C   TemplateResRef  BaseItem        LocalizedName   Description     DescIdentified  Tag             Charges         Cost            Stolen          StackSize       Plot            AddCost         Identified      Cursed          ModelPart1      PropertiesList  PaletteID       Comment         food   џџџџ       
   Small Meal   џџџџ       џџџџ       food                                	   
                            // Name     : hashset_nwnx
// Purpose  : A general purpose implementation combining a hash and a set (NWNX version)
// Author   : Ingmar Stieger
// Modified : December 18, 2003

// This file is licensed under the terms of the
// GNU GENERAL PUBLIC LICENSE (GPL) Version 2

/************************************/
/* Return codes                     */
/************************************/

int HASHSET_ERROR = FALSE;
int HASHSET_SUCCESS = TRUE;

/************************************/
/* Function prototypes              */
/************************************/

// create a new HashSet on oObject with name sHashSetName
// iSize is optional
int HashSetCreate(object oObject, string sHashSetName, int iSize = 500);

// Clear and delete sHashSetName on oObject
void HashSetDestroy(object oObject, string sHashSetName);

// return true if hashset sHashSet is valid
int HashSetValid(object oObject, string sHashSetName);

// return true if hashset sHashSet contains key sKey
int HashSetKeyExists(object oObject, string sHashSetName, string sKey);

// Set key sKey of sHashset to string sValue
int HashSetSetLocalString(object oObject, string sHashSetName, string sKey, string sValue);

// Retrieve string value of sKey in sHashset
string HashSetGetLocalString(object oObject, string sHashSetName, string sKey);

// Set key sKey of sHashset to integer iValue
int HashSetSetLocalInt(object oObject, string sHashSetName, string sKey, int iValue);

// Retrieve integer value of sKey in sHashset
int HashSetGetLocalInt(object oObject, string sHashSetName, string sKey);

// Delete sKey in sHashset
int HashSetDeleteVariable(object oObject, string sHashSetName, string sKey);

// Return the n-th key in sHashset
// note: this returns the KEY, not the value of the key;
string HashSetGetNthKey(object oObject, string sHashSetName, int i);

// Return the first key in sHashset
// note: this returns the KEY, not the value of the key;
string HashSetGetFirstKey(object oObject, string sHashSetName);

// Return the next key in sHashset
// note: this returns the KEY, not the value of the key;
string HashSetGetNextKey(object oObject, string sHashSetName);

// Return the current key in sHashset
// note: this returns the KEY, not the value of the key;
string HashSetGetCurrentKey(object oObject, string sHashSetName);

// Return the number of elements in sHashset
int HashSetGetSize(object oObject, string sHashSetName);

// Return TRUE if the current key is not the last one, FALSE otherwise
int HashSetHasNext(object oObject, string sHashSetName);

// public functions

int HashSetCreate(object oObject, string sHashSetName, int iSize = 500)
{
    SetLocalString(oObject, "NWNX!HASHSET!CREATE", sHashSetName + "!" + IntToString(iSize) + "!");
    return HASHSET_SUCCESS;
}

void HashSetDestroy(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!DESTROY", sHashSetName + "!!");
}

int HashSetValid(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!VALID", sHashSetName + "!!");
    return StringToInt(GetLocalString(oObject, "NWNX!HASHSET!VALID"));
}

int HashSetKeyExists(object oObject, string sHashSetName, string sKey)
{
    SetLocalString(oObject, "NWNX!HASHSET!EXISTS", sHashSetName + "!" + sKey + "!");
    return StringToInt(GetLocalString(oObject, "NWNX!HASHSET!EXISTS"));
}

int HashSetSetLocalString(object oObject, string sHashSetName, string sKey, string sValue)
{
    SetLocalString(oObject, "NWNX!HASHSET!INSERT", sHashSetName + "!" + sKey + "!" + sValue);
    return HASHSET_SUCCESS;
}

string HashSetGetLocalString(object oObject, string sHashSetName, string sKey)
{
    SetLocalString(oObject, "NWNX!HASHSET!LOOKUP", sHashSetName + "!" + sKey + "!                                                                                                                                          ");
    return GetLocalString(oObject, "NWNX!HASHSET!LOOKUP");
}

int HashSetSetLocalInt(object oObject, string sHashSetName, string sKey, int iValue)
{
    HashSetSetLocalString(oObject, sHashSetName, sKey, IntToString(iValue));
    return HASHSET_SUCCESS;
}

int HashSetGetLocalInt(object oObject, string sHashSetName, string sKey)
{
    string sValue = HashSetGetLocalString(oObject, sHashSetName, sKey);
    if (sValue == "")
        return 0;
    else
        return StringToInt(sValue);
}

int HashSetDeleteVariable(object oObject, string sHashSetName, string sKey)
{
    SetLocalString(oObject, "NWNX!HASHSET!DELETE", sHashSetName + "!" + sKey + "!");
    return HASHSET_SUCCESS;
}

string HashSetGetNthKey(object oObject, string sHashSetName, int i)
{
    SetLocalString(oObject, "NWNX!HASHSET!GETNTHKEY", sHashSetName + "!" + IntToString(i) + "!                                                                                                                                          ");
    return GetLocalString(oObject, "NWNX!HASHSET!GETNTHKEY");
}

string HashSetGetFirstKey(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!GETFIRSTKEY", sHashSetName + "!!                                                                                                                                          ");
    return GetLocalString(oObject, "NWNX!HASHSET!GETFIRSTKEY");
}

string HashSetGetNextKey(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!GETNEXTKEY", sHashSetName + "!!                                                                                                                                          ");
    return GetLocalString(oObject, "NWNX!HASHSET!GETNEXTKEY");
}

string HashSetGetCurrentKey(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!GETCURRENTKEY", sHashSetName + "!!                                                                                                                                          ");
    return GetLocalString(oObject, "NWNX!HASHSET!GETCURRENTKEY");
}

int HashSetGetSize(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!GETSIZE", sHashSetName + "!!           ");
    return StringToInt(GetLocalString(oObject, "NWNX!HASHSET!GETSIZE"));
}

int HashSetHasNext(object oObject, string sHashSetName)
{
    SetLocalString(oObject, "NWNX!HASHSET!HASNEXT", sHashSetName + "!!           ");
    return StringToInt(GetLocalString(oObject, "NWNX!HASHSET!HASNEXT"));
}

NCS V1.0B  q          *     +  џџџј  'џџџќ )џџџќ џџџќ'џџџќ              &џџџќ  џџџќ       SELECT 1 FROM player;   >   b          џџџш    >SELECT name, new_satisfaction, level FROM pc_willchange_hunger   д   ј                џџџє  џџџќ      у  щџџџш  џџџќ      Тџџџј  џџџќџџџє    юџџџ№  џџџќџџџь Bp  !    Е foodџџџ№      "    =  џџџ№  EATING_HASHSET  ђ     џџџќ    U- џџџь 'џџџј !    ;џџџј џџџ№  EATING_HASHSET  ђ    П џџџќ    K- џџџј  's hunger level is now #џџџј # .#џџџ№  v џџўa ЗUPDATE player, hunger_const SET satisfaction = satisfaction-hunger_const.loss_rate WHERE player.login_status = 1 AND player.satisfaction BETWEEN hunger_const.min AND hunger_const.max;    n EATING_HASHSET  ђ    ј            j COMMIT;    * START TRANSACTION;     џџџш  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ    ђ  NWNX!ODBC!SPACERџџџј   5 NWNX!ODBC!FETCHџџџє   9 NWNX!ODBC!FETCHџџџј   5џџџє  џџџќџџџј   ;         Sџџџј  NWNX_ODBC_CurrentRowџџџє   9   џџџ№  џџџє    W    K-    NWNX_ODBC_CurrentRowџџџє   9    џџџ№  џџџє     џџџј   NWNX_ODBC_CurrentRow  ђ   5           Ќџџџь   Bџџџь  џџџќџџџ№ џџџџ џџџќ     џџџш          "џџџє џџџј  џџџќ   >- џџџ№ џџџџ       џџџј  џџџќ   - џџџј џџџш      єџџџј $џџџє џџџќџџџј џџџш      /џџџ№ џџџ№   ?џџџј  џџџќ    h- џџџє   ;џџџь      џџџ№   >џџџ№  џџџќ     Ќџџџь   Bџџџь  џџџќџџџ№ џџџџ     !џџџє   ;џџџь  џџџќ џџџ џџџќ џџџф  џџџь     џџџ№ џџџќ       ~џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  ~#    )џџџј  '#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ   $ џџџќ   *    ^    џџџј   §џџџє #    "џџџќ џџџ№  џџџј    ? % џџџј  џџџќ џџџ   џџџ№  џџџј     џџџќ џџџќ  џџџј  !#џџџ№ # !#џџџь # NWNX!HASHSET!INSERTџџџє   9   џџџш  џџџќ     џџџ№  џџџј  !!           # NWNX!HASHSET!GETSIZEџџџє   9 NWNX!HASHSET!GETSIZEџџџј   5  шџџџ№  џџџќ     џџџј   EATING_HASHSET  ђ     Ш In DoEating  џџџє  џџў3џџџј  џџџќ In hash thing  џџџј    ќџџџј     EATING_HASHSET  ђ    Фџџџє  џџџќ EATING_HASHSET  ђ    % џџџb џџџј  џџџј  !!                                                                                                                                          # NWNX!HASHSET!GETFIRSTKEYџџџє   9 NWNX!HASHSET!GETFIRSTKEYџџџј   5џџџ№  џџџќ     џџџј  џџџј  !!           # NWNX!HASHSET!HASNEXTџџџє   9 NWNX!HASHSET!HASNEXTџџџј   5  шџџџ№  џџџќ     џџџј   foodџџџј   џџџє  џџџќ     џџџќ      џџџє   §    џџџє   § In DBEatFood   CUPDATE player SET satisfaction = satisfaction + 15.0 WHERE name = 'џџџє     і# ';# џџі NSELECT level from player, hunger_const WHERE satisfaction BETWEEN min AND max; џџі= џџіa џџџќџџџќ   ate their #џџџє #  and now has a hunger level of #    џџї0# .#џџџ№  v џџџј џџџј       'џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  '#    )џџџј  ~#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  џџџј  !!                                                                                                                                          # NWNX!HASHSET!GETNEXTKEYџџџє   9 NWNX!HASHSET!GETNEXTKEYџџџј   5џџџ№  џџџќ     џџџј  #include "_incl_hunger"

// There's 40 heartbeat calls in an in-game hour.
int iHourCounter = 0;

void main()
{
    // Check if we need to do an hourly hunger pulse
    iHourCounter++;
    if(iHourCounter == 1)
    {
        iHourCounter = 0;
        DBUpdateHunger();
    }
}
ITP V3.28   P   ј      x     и     ы  |  g  |  џџџџ                                                               (          0          8          @          H          P          X          `          h          p          x                                                             Ј          А          И          Р          Ш          а          и          р          ш          №          ј                                                         (         4         <         D         L         T         \         d         l         t         |                                             Є         Ќ         Д         М         Ф         Ь         д         м         ф         ь         є         ќ                                             $         ,         4         <         D         L         T         \         d         l         t                      O                  К                   в                  S         	         Я                                             :         T        @         І                  U         
         V                  W        P                  7         X                  Џ         ?                  ;                                    8         8        l                  <         К                  Y                  №                  Z                  [                  њ                  F        @                  9         ]        Ќ         ^                  _                  \                  +                  a                  b                           6                 И                             а   
                         !                  "                  #                  $                  L         5         є        и         d                e                  f                  g                  ъ                j                   h                  i                  k        $        l         !         m         "         n         #         o         $         +         %         p         &         ы        @        q         '         r         (         s         )         t         *         Ё         =         w         .         x         /         y        X        z         0         {         1         |         2         щ         3         Ђ        h        v         +         Ѓ         ,         Є         -         Ѕ         >         ю         4   MAIN            STRREF          LIST            ID              NAME            RESREF          
   Small Mealfood                        	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   A   B   C   D   E   F   G   H   I   J   K   L   M   N   O   P   Q   R   S   T   U   V   W   X   Y   Z   [   \   ]   ^   _   `   a   b   c   d   e   f   g   h   i   j   k   l   m   n   o   p   q   r   s   t   u   v   w   x   y   z   {   |   }   ~                                                                                                                  $   %   ,   -                              	   
                           	                      !   "   #                                 &   (   )   *   +      '   
   .   2   6   =   C   D   E   I   J   O      /   0   1      3   4   5      7   8   9   :   ;   <      >   ?   @   A   B      F   G   H      K   L   M   N   IFO V3.28      P   2   Ј  2   Ш  с   Љ  Ф   m     џџџџ    1      /                 
                                             
      8         D              
   	         
               B        B                ­
ЩМ      Cь?                                                                            \         
         Ђ         Ќ         З         И         С         Ы         Ь          Э      !   Ю      "   Я      #   а      $   б      %   в      &   г      '   д      (   е      )   ж      *   з      +   и      ,         -         .         /   й      0         1      Mod_ID          Mod_MinGameVer  Mod_Creator_ID  Mod_Version     Expansion_Pack  Mod_Name        Mod_Tag         Mod_Description Mod_IsSaveGame  Mod_CustomTlk   Mod_Entry_Area  Mod_Entry_X     Mod_Entry_Y     Mod_Entry_Z     Mod_Entry_Dir_X Mod_Entry_Dir_Y Mod_Expan_List  Mod_DawnHour    Mod_DuskHour    Mod_MinPerHour  Mod_StartMonth  Mod_StartDay    Mod_StartHour   Mod_StartYear   Mod_XPScale     Mod_OnHeartbeat Mod_OnModLoad   Mod_OnModStart  Mod_OnClientEntrMod_OnClientLeavMod_OnActvtItem Mod_OnAcquirItemMod_OnUsrDefinedMod_OnUnAqreItemMod_OnPlrDeath  Mod_OnPlrDying  Mod_OnPlrEqItm  Mod_OnPlrLvlUp  Mod_OnSpawnBtnDnMod_OnPlrRest   Mod_OnPlrUnEqItmMod_OnCutsnAbortMod_OnPlrChat   Mod_StartMovie  Mod_CutSceneListMod_GVar_List   Mod_Area_list   Area_Name       Mod_HakList     Mod_CacheNSSList   c!ЊKЇъ*ЇњЏю   1.69   џџџџ          aps_demo   aps_demoN   џџџџ       >   This module shows how you can use APS/NWNX in your own module.    area001	heartbeat
aps_onload on_login	on_logout              area001                            	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   0   1                             NCS V1.0B  0         џџџќ      џџџќ      џџџє   §   R !SELECT 1 FROM player WHERE name='џџџј # ';#џџџќ    O   s          FINSERT INTO player (name, satisfaction, login_status, is_ic) VALUES ('џџџє # ', 100.0, 1, 1);#џџџј  џџџќ    ]-  1UPDATE player SET login_status = 1 WHERE name = 'џџџє # ';#џџџј  џџџќџџџќ    V џџџј џџџќ       'џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  '#    )џџџј  ~#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ    ђ  NWNX!ODBC!SPACERџџџј   5 NWNX!ODBC!FETCHџџџє   9 NWNX!ODBC!FETCHџџџј   5џџџє  џџџќџџџј   ;         Sџџџј  NWNX_ODBC_CurrentRowџџџє   9   џџџ№  џџџє    W    K-    NWNX_ODBC_CurrentRowџџџє   9    џџџ№  џџџє     џџџј  #include "_incl_session"

void main()
{
    object oPC = GetEnteringObject();
    DBLogin(oPC);
}
NCS V1.0B           џџџќ      џџџќ      џџџє   §    a 1UPDATE player SET login_status = 0 WHERE name = 'џџџј # ';#   V џџџќ џџџќ       'џџџє   Bџџџџ     "џџџќ џџџє  џџџќ    ў      џџџ№  џџџќџџџє џџџь   ;     Ѓ   џџџ№ џџџш   Aџџџј  џџџќџџџќ  '#    )џџџј  ~#џџџє  џџџќ    (- џџџј џџџј #џџџє  џџџќџџџє $џџџ№ џџџќ џџџLџџџј џџџш  џџџ№     џџџє џџџќ  џџџќ  NWNX!ODBC!EXEC  ђ   9 џџџќ  #include "_incl_session"

void main()
{
    object oPC = GetEnteringObject();
    DBLogout(oPC);
}
ITP V3.28      d  2   М     ќ      ќ  Ф   Р  l   џџџџ                                                               (          0          8          @          H          P          X          `          h          p          x                                                  Є          Ќ          Д          М                                         /Д                 ~                                    8         	                  
                                             Ђ#                  Ј#                          <                             !                  "                  #                  $                                    К                 T         є                  Ь                                   Я                  <                 }            MAIN            STRREF          ID              LIST                                    	   
                                                                      !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1                              	   
                                                   FAC V3.28      p  M          5   С  4  ѕ  l   џџџџ<                                      $         0          D         P         \         h         t                                    Є      	   А      
   М         Ш         д         р         ь         ј                                 (                      џџџџ
                         џџџџ
                        џџџџ
                        џџџџ
                        џџџџ
      )                                                                           2                            2                            2                           d                                                                                                                                           d                           2                           d                                                       2                           d                           d                                                       2                           d                           d   FactionList     FactionParentID FactionName     FactionGlobal   RepList         FactionID1      FactionID2      FactionRep         PC   Hostile   Commoner   Merchant   Defender                        	   
                                                                          !   "   #   $   %   &   '   (   )   *   +   ,   -   .   /   0   1   2   3   4   5   6   7   8   9   :   ;   <   =   >   ?   @   A   B   C   D   E   F   G   H   I   J   K   L                                 	   
                                                ITP V3.28      д            @      @  `      8   џџџџ                                                               (          0          8          @          H          P          X                       &                  9ї                  є                  є                  є                                                        !                  "                  #                  $                  є            MAIN            STRREF          ID              LIST                                    	   
                                                                              	   
      ITP V3.28            L             8   Ф  $   џџџџ                                                               (          0                                                                              !                  "                  #                  $            MAIN            STRREF          ID              LIST                                    	   
                                          ITP V3.28      ј      l     Ќ      Ќ  x   $  H   џџџџ                                                               (          0          8          @          H          P          X          `          h          p                       :                                    Љ#                                                       !                  "                  #                  $                  Л        0         НЯ                  Я                  а                  б                  ОЯ            MAIN            STRREF          ID              LIST                                    	   
                                                                              
                  	                     ITP V3.28            L             8   Ф  $   џџџџ                                                               (          0                                                            !                  "                  #                  $                              MAIN            STRREF          LIST            ID                                      	   
                                          float HUNGRY_AT;
float RAVENOUS_AT;
#include "aps_include"
#include "hashset_nwnx"
#include "_incl_session"
#include "_incl_globvars"

void DBUpdateHunger();
void DoEating();
void DoPenalties();

object GetBestFood(object oPC)
{
    return GetItemPossessedBy(oPC, "food");
}

void DBEatFood(object oPC, object oFood)
{
    string sFood = GetName(oFood);
    string sName = GetName(oPC);
    PrintString("In DBEatFood");

    //TODO: actual values
    SQLExecDirect("UPDATE player " +
                  "SET satisfaction = satisfaction + 15.0 " +
                  "WHERE name = '" + SQLEncodeSpecialChars(sName) +"';"
                  );
    SQLExecDirect("SELECT level from player, hunger_const " +
                  "WHERE satisfaction BETWEEN min AND max;"
                  );
    SQLFetch();
    SendMessageToPC(oPC, (sName + " ate their " + sFood +
                   " and now has a hunger level of " + SQLGetData(1) + ".")
                   );

}

void DoEating()
{
    string sKey = HashSetGetFirstKey(GetModule(), "EATING_HASHSET");
    object oPC;
    PrintString("In DoEating");
    do
    {
        oPC = GetPCObjectByName(sKey);
        PrintString("In hash thing");
        DBEatFood(oPC, GetBestFood(oPC));
        // todo - delete key here
        sKey = HashSetGetNextKey(GetModule(), "EATING_HASHSET");
    } while(HashSetHasNext(GetModule(), "EATING_HASHSET"));
}

void DBUpdateHunger()
{
    float   fHungryAt;
    float   fSatisfaction;
    int     bHasFood;
    object  oPC;
    string  sName;
    string  sLevel;

    // Sanity check - make sure we're not doing this if we have no player records.
    SQLExecDirect("SELECT 1 FROM player;");
    if(SQLFetch() == SQL_ERROR)
        return;

    // First, figure out who's switching to a new hunger tier.
    // We have to handle eating + penalties after we're doing because we can't
    // have nested SQL commands.
    SQLExecDirect("SELECT name, new_satisfaction, level FROM pc_willchange_hunger");
    while(SQLFetch() == SQL_SUCCESS)
    {
        sName = SQLDecodeSpecialChars(SQLGetData(1));
        fSatisfaction = StringToFloat(SQLGetData(2));
        sLevel = SQLGetData(3);
        oPC = GetPCObjectByName(sName);
        if(fSatisfaction <= 60.0)
        {
            if(GetItemPossessedBy(oPC, "food") != OBJECT_INVALID)
                HashSetSetLocalString(GetModule(), "EATING_HASHSET", sName, "");
            else if(fSatisfaction < RAVENOUS_AT)
                HashSetSetLocalString(GetModule(), "EATING_HASHSET", sName, sLevel);
        }
        else
            SendMessageToPC(oPC, sName + "'s hunger level is now " + sLevel + ".");
    }

    SQLExecDirect("UPDATE player, hunger_const " +
                  "SET satisfaction = satisfaction-hunger_const.loss_rate " +
                  "WHERE " +
                         "player.login_status = 1 " +
                         "AND player.satisfaction BETWEEN hunger_const.min AND hunger_const.max;"
    );

    if(HashSetGetSize(GetModule(), "EATING_HASHSET") > 0)
        DoEating();
    //DoPenalties();

    SQLExecDirect("COMMIT;");
    SQLExecDirect("START TRANSACTION;");
}
NCS V1.0B           #include "aps_include"

void DBLogin(object oPC);
void DBLogout(object oPC);
object GetPCObjectByName(string sName);

void DBLogin(object oPC)
{
    string sSafeName = SQLEncodeSpecialChars(GetName(oPC));
    string sQuery = "SELECT 1 FROM player WHERE name='" + sSafeName + "';";

    // See if this is the player's first login. First case = first login.
    SQLExecDirect(sQuery);
    if(SQLFetch() == SQL_ERROR)
    {
        sQuery = "INSERT INTO player (name, satisfaction, login_status, is_ic) " +
                 "VALUES ('" + sSafeName + "', 100.0, 1, 1);";
    }
    else
    {
        sQuery = "UPDATE player " +
                 "SET login_status = 1 " +
                 "WHERE name = '" + sSafeName + "';";
    }
    SQLExecDirect(sQuery);
}

void DBLogout(object oPC)
{
    string sSafeName = SQLEncodeSpecialChars(GetName(oPC));
    SQLExecDirect("UPDATE player " +
                  "SET login_status = 0 " +
                  "WHERE name = '" + sSafeName + "';"
    );
}

object GetPCObjectByName(string sName)
{
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        if(GetName(oPC) == sName)
            return oPC;
        oPC = GetNextPC();
    }
    return OBJECT_INVALID;
}
