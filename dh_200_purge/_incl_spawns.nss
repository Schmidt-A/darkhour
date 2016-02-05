#include "nwnx_funcs"
#include "_incl_location"

float DEFAULT_RESPAWN = 480.0; // 2 in-game hours

void ClearSpawns(float fRadius)
{
    location lLoc = GetLocation(OBJECT_SELF);
    object oObj = GetFirstObjectInShape(SHAPE_CUBE, fRadius, lLoc);
    object oNextObj;

    while(GetIsObjectValid(oObj))
    {
        // Grabing this here or the list might fuck up
        oNextObj = GetNextObjectInShape(SHAPE_CUBE, fRadius, lLoc);
        if(GetObjectType(oObj) == OBJECT_TYPE_CREATURE)
        {
            if(!GetIsPC(oObj) && !GetIsObjectValid(GetMaster(oObj)))
                DestroyObject(oObj);
        }
        oObj = oNextObj;
    }
}

int ActiveEnemyCount(float fRadius)
{
    location lLoc = GetLocation(OBJECT_SELF);
    object oObj = GetFirstObjectInShape(SHAPE_CUBE, fRadius, lLoc);
    int iCount = 0;

    // TODO: There's probably a better way to do this
    while(GetIsObjectValid(oObj))
    {
        if(GetObjectType(oObj) == OBJECT_TYPE_CREATURE)
        {
            // If it's not a summoned creature or PC, it's an enemy
            if(!GetIsPC(oObj) && !GetIsObjectValid(GetMaster(oObj)))
                iCount++;
        }
        oObj = GetNextObjectInShape(SHAPE_CUBE, fRadius, lLoc);
    }

    return iCount;
}

int MaxEnemyCount()
{
    struct LocalVariable var = GetFirstLocalVariable(OBJECT_SELF);
    int iMax = 0;

    while(var.obj != OBJECT_INVALID)
    {
        if(GetStringLeft(var.name, 12) == "sCreatureAmt")
            iMax += GetLocalInt(OBJECT_SELF, var.name);
        var = GetNextLocalVariable(var);
    }

    return iMax;
}

void SpawnSubArea()
{
    float fRadius               = GetLocalFloat(OBJECT_SELF, "fRadius");
    struct LocalVariable var    = GetFirstLocalVariable(OBJECT_SELF);
    location lCenter            = GetLocation(OBJECT_SELF);
    int bStationary             = GetLocalInt(OBJECT_SELF, "bStationary");

    int iAmt;
    int i;
    int iCount;
    string sCreatureIdx;
    string sCreatureRef;
    string sCreatureWP;
    location lLoc;

    while(var.obj != OBJECT_INVALID)
    {
        if(GetStringLeft(var.name, 9) == "sCreature")
        {
            sCreatureIdx = GetSubString(var.name, 9, 1);
            sCreatureWP  = GetLocalString(OBJECT_SELF, "sCreatureWP" + sCreatureIdx);
            sCreatureRef = GetLocalString(OBJECT_SELF, var.name);
            iAmt = GetLocalInt(OBJECT_SELF, "sCreatureAmt" + sCreatureIdx);
            for(i=0; i<iAmt; i++)
            {
                /* If a specific waypoint was provided as a spawn point, spawn
                   the creature there. Otherwise pick a random spot. */
                if(sCreatureWP != "")
                    lLoc = GetLocation(GetObjectByTag(sCreatureWP));
                else
                    lLoc = GetRandomWalkableLocation(lCenter, 1, FloatToInt(fRadius));

                object oCreature = CreateObject(OBJECT_TYPE_CREATURE, sCreatureRef, lLoc);
                if(!bStationary)
                    AssignCommand(oCreature, ActionRandomWalk());
            }
        }
        var = GetNextLocalVariable(var);
    }
}

void HBSecurableSubArea()
{
    // Set up space for the first time
    int bInitialized = GetLocalInt(OBJECT_SELF, "bInitialized");
    float fRadius   = GetLocalFloat(OBJECT_SELF, "fRadius");

    if(!bInitialized)
    {
        SetLocalInt(OBJECT_SELF, "bInitialized", TRUE);
        SpawnSubArea();
        return;
    }

    // If the encounter got started but PCs have all left the area, reset the
    // encounter.
    if(GetLocalInt(OBJECT_SELF, "bEngaged") &&
       GetLocalInt(GetArea(OBJECT_SELF), "iPCCount") < 1)
    {
        SetLocalInt(OBJECT_SELF, "bEngaged", FALSE);
        ClearSpawns(fRadius);
        SpawnSubArea();
        return;
    }

    int iEnemyCount = ActiveEnemyCount(fRadius);
    int iMaxCount   = MaxEnemyCount();

    // If this is true, mark that the encounter was started.
    if(iEnemyCount < iMaxCount)
        SetLocalInt(OBJECT_SELF, "bEngaged", TRUE);
    else if(iEnemyCount == 0)
    {
        float fClearedTime = GetLocalFloat(OBJECT_SELF, "fClearedTime");
        if(fClearedTime < 1.0)
            fClearedTime = DEFAULT_RESPAWN;

        // If clearing the area was supposed to open a door, do it
        string sDoorTag = GetLocalString(OBJECT_SELF, "sDoorTag");
        if(sDoorTag != "")
        {
            object oDoor = GetObjectByTag(sDoorTag);
            AssignCommand(oDoor, ActionOpenDoor(oDoor));
            SetLocked(oDoor, FALSE);

            DelayCommand(fClearedTime, AssignCommand(oDoor, ActionCloseDoor(oDoor)));
            DelayCommand(fClearedTime, SetLocked(oDoor, TRUE));
        }
        // TODO: Allow more situational secured behaviour

        DelayCommand(fClearedTime, SpawnSubArea());
    }
}
