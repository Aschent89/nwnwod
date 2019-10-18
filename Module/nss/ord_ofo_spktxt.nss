////////////////////////////////////////////////////////////////////////////////
//
//  Olander's - Riddle Doors
//  ord_ofo_spktxt
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is a On Failed to Open Script that runs on the Riddle Door.
//
//  Requires to Set the String Variables on the Door:
//   RIDDLE_TEXT then text.
//   RIDDLE_ANSWER then text.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oDoor = OBJECT_SELF;
  string sRiddle = GetLocalString(oDoor,"RIDDLE_TEXT");
  SpeakString(sRiddle);
}
