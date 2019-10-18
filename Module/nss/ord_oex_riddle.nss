////////////////////////////////////////////////////////////////////////////////
//
//  Olander's - Riddle Doors
//  ord_oex_riddle
//  By:Don Anderson
//  dandersonru@msn.com
//
//  This is a Trigger OnExit Script that runs on the Riddle Door. This actually
//  Destroys the Riddle Listener object. Paint this around the Riddle Door.
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oPC = GetExitingObject();
  object oLis = GetNearestObjectByTag("Listener");
  if(GetIsObjectValid(oLis)) {DestroyObject(oLis,0.1);}
}
