void main()
{
object oPC = GetEnteringObject();
if(GetIsPC(oPC) == TRUE)
    {
    ExploreAreaForPlayer(OBJECT_SELF, oPC, TRUE);
    }
}
