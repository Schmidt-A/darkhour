//::///////////////////////////////////////////////
//::
//:: Authorization
//::
//:: authorization.nss
//::
//:: Written for the persistant world of Brynsaar
//:: visit us at http://brynsaar.com/
//::
//:://////////////////////////////////////////////
//::
//:: This script is an include file. It's used to
//:: check if the object oPC is authorized.
//:: There are currently three different authorizations:
//:: SuperAdmin, Admin and Authorized DM
//::
//:: See the different functions for more details
//::
//:: To use this, don't forget to add:
//:: #include "authorization"
//:: in the beginning of a script
//::
//:://////////////////////////////////////////////
//::
//:: Created By: Nordavind
//::         On: May 9, 2004
//::
//:://////////////////////////////////////////////

// Super Admins:
const string sCDSuperAdmin1 = "CDKEYGOESHERE";
const string sCDSuperAdmin2 = "CDKEYGOESHERE";

// Also see the script "dm_itm_rem_start" and "dm_itm_getproprt" as you'll
// need to modify them to.
// Admins:
const string sCDAdmin1 = "CDKEYGOESHERE";
const string sCDAdmin2 = "CDKEYGOESHERE";
const string sCDAdmin3 = "CDKEYGOESHERE";
const string sCDAdmin4 = "CDKEYGOESHERE";

// Authorized DMs
const string sCDDM1 = "CDKEYGOESHERE";
const string sCDDM2 = "CDKEYGOESHERE";
const string sCDDM3 = "CDKEYGOESHERE";
const string sCDDM4 = "CDKEYGOESHERE";

//:://////////////////////////////////////////////
//::
//:: FUNCTION: int GetIsSuperAdmin(object oPC)
//::
//:: This function checks if the object oPC is
//:: a super admin. It will return TRUE if the object
//:: matches the authorized CD key. If it's not authorized
//:: it will return FALSE
//::
//:: Created By: Nordavind
//::         On: May 9, 2004
//::
//:://////////////////////////////////////////////
int GetIsSuperAdmin(object oPC);
int GetIsSuperAdmin(object oPC)
{
    int nResult = FALSE;
    string sCDKey = GetPCPublicCDKey(oPC);

    if (sCDKey == sCDSuperAdmin1 ||
        sCDKey == sCDSuperAdmin2)
        return TRUE;

    return nResult;
}


//:://////////////////////////////////////////////
//::
//:: FUNCTION: int GetIsAdmin(object oPC)
//::
//:: This function checks if the object oPC is
//:: an admin. It will return TRUE if the object
//:: matches the authorized CD key. If it's not authorized
//:: it will return FALSE
//::
//:: Created By: Nordavind
//::         On: May 9, 2004
//::
//:://////////////////////////////////////////////
int GetIsAdmin(object oPC);
int GetIsAdmin(object oPC)
{
    int nResult = FALSE;
    string sCDKey = GetPCPublicCDKey(oPC);
    if (sCDKey == sCDSuperAdmin1 ||
        sCDKey == sCDSuperAdmin2 ||
        sCDKey == sCDAdmin1 ||
        sCDKey == sCDAdmin2 ||
        sCDKey == sCDAdmin3 ||
        sCDKey == sCDAdmin4)
        return TRUE;

    return nResult;
}


//:://////////////////////////////////////////////
//::
//:: FUNCTION: int GetIsAuthorizedDM(object oPC)
//::
//:: This function checks if the object oPC is
//:: an authorized DM. It will return TRUE if the object
//:: matches the authorized CD key. If it's not authorized
//:: it will return FALSE
//::
//:: Created By: Nordavind
//::         On: May 9, 2004
//::
//:://////////////////////////////////////////////
int GetIsAuthorizedDM(object oPC);
int GetIsAuthorizedDM(object oPC)
{
    int nResult = FALSE;
    string sCDKey = GetPCPublicCDKey(oPC);
    if (sCDKey == sCDSuperAdmin1 ||
        sCDKey == sCDSuperAdmin2 ||
        sCDKey == sCDAdmin1 ||
        sCDKey == sCDAdmin2 ||
        sCDKey == sCDAdmin3 ||
        sCDKey == sCDAdmin4 ||
        sCDKey == sCDDM1 ||
        sCDKey == sCDDM2 ||
        sCDKey == sCDDM3 ||
        sCDKey == sCDDM4)
        return TRUE;

    return nResult;
}

//void main(){}
