////////////////////////////////////////////////////////////////////////////////
//  Olander's Sit On Chair - Single Seat
//  ors_ou_sit
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeable OnUsed Event
//
//  Thanks to: Jacob Holcomb
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oUser = GetLastUsedBy();
    object oChair = OBJECT_SELF;

    if(GetIsObjectValid(oUser))
    {
      if(GetIsObjectValid(oChair))
      {
        int nSit = 0;

        if ( !GetIsObjectValid( GetSittingCreature( oChair ) ) )
        {
          object oSurf = GetLocalObject( oChair, "SIT_SURF");
          if( GetIsObjectValid( oSurf ) )
          {
            object oSitter = GetSittingCreature( oSurf );
            if (!GetIsObjectValid(oSitter)
              || GetCurrentAction(oSitter) != ACTION_SIT
              || GetArea(oSitter) != GetArea(oSurf)
              || oSitter == oUser)
            {
              DestroyObject( oSurf );
              SetLocalObject( oChair, "SIT_SURF", OBJECT_INVALID );
              nSit = 1;
            }
          }
          else nSit = 1;
        }

        if(nSit)
        {
          vector vSurf = GetPosition(oChair);
          vSurf.z = 0.0;
          location lSurf = Location(GetArea(oChair), vSurf, GetFacing(oChair));

          object oNewSurf = CreateObject( OBJECT_TYPE_PLACEABLE, "plc_invisobj", lSurf, FALSE);
          SetLocalObject( oChair, "SIT_SURF", oNewSurf );
          AssignCommand( oUser, ActionSit( oNewSurf ) );
        }
        else ActionSpeakString("Someone else is sitting here!");
      }
    }
}
