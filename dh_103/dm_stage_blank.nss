void main()
{
   object oNewWidget = CreateItemOnObject("mali_dm_stage", OBJECT_SELF);
   if( oNewWidget == OBJECT_INVALID)
   { SendMessageToPC(OBJECT_SELF, "ERROR: Could not create a DM Stage Manager widget."); }
}
