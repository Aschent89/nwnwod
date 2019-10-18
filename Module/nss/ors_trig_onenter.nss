////////////////////////////////////////////////////////////////////////////////
//  Olander's Realistic Systems - Seemless Area Transitions On Enter
//  ors_trig_onenter
//  By Don Anderson
//  dandersonru@msn.com
//
//  Place this in the Trigger On Enter Event
//  Edit Variable with Destination Area Tag
//
//  See Builder's Guide on How to Set Up Each
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
  object oCreature  = GetEnteringObject();
  object oArea      = GetArea(oCreature);
  object oCurAT     = OBJECT_SELF;

  //Destination Area Object Checks
  string sDestAT    = GetLocalString(oCurAT,"DestAreaTag");
  if(sDestAT == "") return;
  object oDestArea = GetObjectByTag(sDestAT);
  if(!GetIsObjectValid(oDestArea)) return;

  //Trigger Location in From/Current Area
  string sCompassLoc = GetLocalString(oCurAT,"CompassLocation");
  if(sCompassLoc == "") return;

  //No Need to Continue
  if(!GetIsObjectValid(oCreature)) return;
  int nCurTrans = GetLocalInt(oCreature,"ORS_TRANSITIONING");
  if(nCurTrans > 0) return;

  SetLocalInt(oCreature,"ORS_TRANSITIONING",1);
  int nText = FALSE;
  if(GetIsPC(oCreature)) nText = TRUE;
  if(GetIsDM(oCreature)) nText = TRUE;
  if(GetIsDMPossessed(oCreature)) nText = TRUE;
  if(GetIsPossessedFamiliar(oCreature)) nText = TRUE;

  string sDestAreaName = GetName(oDestArea);
  if(nText == TRUE) FloatingTextStringOnCreature("Moving to : " + sDestAreaName,oCreature);

  float fMaxAreaDim = 160.0f;
  float fDestOffset = 1.0f;    // Distance out from edge in destination Area that PC will land

  vector vCurVector = GetPosition(oCreature);
  float fFacing = GetFacingFromLocation(GetLocation(oCreature));

  //Destination Area Location
  location lLoc;
  if(sCompassLoc == "N")
  {
    //North
    lLoc = Location(oDestArea,Vector(vCurVector.x,fDestOffset),fFacing);
  }

  if(sCompassLoc == "NE")
  {
    //North East
    lLoc = Location(oDestArea,Vector(fDestOffset,fDestOffset),fFacing);
  }

  if(sCompassLoc == "NW")
  {
    //North West
    lLoc = Location(oDestArea,Vector(fMaxAreaDim - fDestOffset,fDestOffset),fFacing);
  }

  if(sCompassLoc == "S")
  {
    //South
    lLoc = Location(oDestArea,Vector(vCurVector.x,fMaxAreaDim - fDestOffset),fFacing);
  }

  if(sCompassLoc == "SE")
  {
    //South East
    lLoc = Location(oDestArea,Vector(fDestOffset,fMaxAreaDim - fDestOffset),fFacing);
  }

  if(sCompassLoc == "SW")
  {
    //South West
    lLoc = Location(oDestArea,Vector(fMaxAreaDim - fDestOffset,fMaxAreaDim - fDestOffset),fFacing);
  }

  if(sCompassLoc == "E")
  {
    //East
    lLoc = Location(oDestArea,Vector(fDestOffset,vCurVector.y),fFacing);
  }

  if(sCompassLoc == "W")
  {
    //West
    lLoc = Location(oDestArea,Vector(fMaxAreaDim - fDestOffset,vCurVector.y),fFacing);
  }

  //Transition Creature
  float fDelay = 2.0;
  DelayCommand(fDelay,AssignCommand(oCreature,JumpToLocation(lLoc)));
  DelayCommand(fDelay + 20.0,SetLocalInt(oCreature,"ORS_TRANSITIONING",0));
  //DelayCommand(fDelay + 30.0,SendMessageToPC(oCreature,"ORS Clickless Transition Ready for Another Transition."));
}
