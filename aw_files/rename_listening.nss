void main()
{
object oPC = GetPCSpeaker();
object oPenguListener =  OBJECT_SELF;

SetListening( OBJECT_SELF, TRUE);
SetListenPattern( OBJECT_SELF,"name: **",12345);
}
