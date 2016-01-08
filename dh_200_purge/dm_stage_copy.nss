void main()
{
   object oWidget = GetLocalObject(OBJECT_SELF, "DM_SM_oWidget");

   object oNewWidget = CopyItem(oWidget, OBJECT_SELF, TRUE);
   if( oNewWidget == OBJECT_INVALID)
   { SendMessageToPC(OBJECT_SELF, "ERROR: Could not copy DM Stage Manager widget."); }
   else
   { SetDescription(oNewWidget, GetDescription(oWidget, FALSE, FALSE), FALSE); }
}
