///////////////////////////////////////////////////
// FILE NAME:   think_once
// CREATED BY:  Amy Carlstrom (aka LucidTaint)
// CREATED ON:  December 23, 2003
// UPDATED BY:
// UPDATED ON:
// DESCRIPTION: Attached to a trigger's OnEnter
// hook. Will make a PC say (think aloud) whatever
// string is in the trigger's Name field. It will
// only do this once for each PC that enters the
// trigger area. Use 'think_aloud' for triggers
// that go off every time a PC enters the trigger
// area, even if they've been there before.
//////////////////////////////////////////////////

void main()
{
   object oPC = GetEnteringObject();

   if(GetIsPC(oPC) == TRUE) {
      string sThought = GetName(OBJECT_SELF);
      string sVar = GetTag(OBJECT_SELF);
      int iVal = GetLocalInt(oPC, sVar);

      if(iVal != 1) {
         SetLocalInt(oPC, sVar, 1);
         AssignCommand(oPC, SpeakString(sThought, TALKVOLUME_TALK));
      }
   }
}
