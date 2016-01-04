// --------------------------------------------------------
// Sparky Spawner   include
//
// original version by Sparky1479
// recode and expansion by Malishara
// --------------------------------------------------------

#include "sparky_inc"

//
int fnArePCsInArea(object oArea)
{   object oPc = GetFirstObjectInArea(OBJECT_SELF);

    while (GetIsObjectValid(oPc))
    { if ((GetIsPC(oPc)) && (!GetIsDM(oPc)))
      { return(TRUE); }
      oPc = GetNextObjectInArea();
    }

    return(FALSE);
}


void main()
{
    object oArea = OBJECT_SELF;
    int bArePCsInTheArea = fnArePCsInArea(oArea);

    if (bArePCsInTheArea)
    { return; }

    Despawn(oArea);
}

