////////////////////////////////////////////////////////////////////////////////
//  Olander's Sit On Chair
//  ors_ondeath_sit
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeable OnDeath Event
//
//  Thanks to: Jacob Holcomb
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oChair = OBJECT_SELF;
    if(GetIsObjectValid(oChair))
    {
      object oSurf = GetLocalObject( oChair, "SIT_SURF");
      if(GetIsObjectValid(oSurf)) DestroyObject( oSurf );
    }
}


