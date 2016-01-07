void main()
{

object oPC = GetLastUsedBy();
if (!GetIsPC(oPC)) return;

object oTarget;
oTarget = GetObjectByTag("miningwellrogue4");

SoundObjectPlay(oTarget);

location lTarget;
oTarget = GetWaypointByTag("miningwellrogue3");

lTarget = GetLocation(oTarget);

//only do the jump if the location is valid.
//though not flawless, we just check if it is in a valid area.
//the script will stop if the location isn't valid - meaning that
//nothing put after the teleport will fire either.
//the current location won't be stored, either

if (GetAreaFromLocation(lTarget)==OBJECT_INVALID) return;

AssignCommand(oPC, ClearAllActions());

AssignCommand(oPC, ActionJumpToLocation(lTarget));

oTarget = GetObjectByTag("miningwellrogue4");

SoundObjectStop(oTarget);
      ActionPlayAnimation(ANIMATION_PLACEABLE_CLOSE);
      DelayCommand(5.0, ActionPlayAnimation(ANIMATION_PLACEABLE_OPEN));
}

