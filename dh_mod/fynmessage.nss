void main()
{

object oPC = GetEnteringObject();

if (!GetIsPC(oPC)) return;

int DoOnce = GetLocalInt(oPC, GetTag (OBJECT_SELF));

if (DoOnce==TRUE) return;

SetLocalInt(oPC, GetTag(OBJECT_SELF), TRUE);

FloatingTextStringOnCreature("As you trek along the last bridge, past abandoned and looted wagons... the glorious Castle Siranda can be seen in the far distance. The island known as 'Fyn Island' coming into clear view as well. They say this island was created by Lathander himself, hundreds of years ago... as a blessing to his loyal followers. As such, many devouts refer to this place as the Island of Dawn.", oPC);

}
