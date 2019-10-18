////////////////////////////////////////////////////////////////////////////////
//  Olander's 2 People Sit On Couch
//  ors_ou_2sit
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this script in the Placeable OnUsed Event
//
//  Thanks to: Khaly
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPlayer = GetLastUsedBy();
    object oBench  = OBJECT_SELF;

    object oPillow1 = GetLocalObject( OBJECT_SELF, "Pillow 1" );
    object oPillow2 = GetLocalObject( OBJECT_SELF, "Pillow 2" );

    //If the sitting places do not exist, create them
    if(!GetIsObjectValid(oPillow1))
    {
      object oArea = GetArea( oBench );
      vector locBench = GetPosition( oBench );
      float fOrient  = GetFacing( oBench );

      //Calculate locations of each pillow
      location locPillow1 = Location( oArea, locBench + AngleToVector( fOrient + 90.0f ) / 2.0f, fOrient );
      location locPillow2 = Location( oArea, locBench + AngleToVector( fOrient - 90.0f ) / 2.0f, fOrient );

      //Create 2 pillows
      oPillow1 = CreateObject( OBJECT_TYPE_PLACEABLE, "plc_invisobj", locPillow1 );
      oPillow2 = CreateObject( OBJECT_TYPE_PLACEABLE, "plc_invisobj", locPillow2 );

      //Remember Them
      SetLocalObject( OBJECT_SELF, "Pillow 1", oPillow1 );
      SetLocalObject( OBJECT_SELF, "Pillow 2", oPillow2 );
    }

    // Chose the nearest pillow if not used and sit
    if( GetDistanceBetween( oPlayer, oPillow1 ) < GetDistanceBetween( oPlayer, oPillow2 ) )
    {
      if(!GetIsObjectValid(GetSittingCreature(oPillow1))) AssignCommand( oPlayer, ActionSit( oPillow1 ) );
      else AssignCommand(oPlayer,ActionSit(oPillow2));
    }
    else
    {
      if(!GetIsObjectValid(GetSittingCreature(oPillow2))) AssignCommand(oPlayer,ActionSit(oPillow2));
      else AssignCommand(oPlayer,ActionSit(oPillow1));
    }
}
