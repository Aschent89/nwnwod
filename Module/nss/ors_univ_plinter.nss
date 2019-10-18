////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems - Universal Placeable Ineractive
//  ors_univ_plinter
//  by Don Anderson
//  dandersonru@msn.com
//
//  Use this on a Placeable to ::
/*
Credits: 9fires for the Idea of Float Text to get rid of the Names of Placeables

Set Up in Variables of the Placeable

Mode =>  ORS_ONUSED

Mode 0 - Float a Colored Description of the Placeable for the Player
Mode 1 - Examine a Sign with a Colored Name Floated above Player
Mode 2 - Open the Conversation Attached
Mode 3 - Open a Merchant with a Colored Name Floated above Player

Colors => ORS_COLOR   example  ORS_COLOR  string   RED

//Color Variables
RED = "<cσ  >";
BLUE = "<c  σ>";
GRAY = "<c°°°>";
GREEN = "<c σ >";
WHITE = "<cσσσ>";
CYAN = "<c σσ>";
YELLOW = "<cσσ >";
BLUISHG = "<c °°>";
BLUISHR = "<c °σ>";

Description => ORS_DESCRIPTION

This will be the Floated Text on the Player

*/
//
////////////////////////////////////////////////////////////////////////////////

#include "ors_inc"

void main()
{
  object oSelf = OBJECT_SELF;
  object oPC = GetLastUsedBy();

  //Modes
  int nORS_ONUSED = GetLocalInt(oSelf,"ORS_ONUSED");
  if(nORS_ONUSED < 1) nORS_ONUSED = 0;

  //Color of Float Text
  string sColor = YELLOW;
  string sORS_COLOR = GetLocalString(oSelf,"ORS_COLOR");
  if(sORS_COLOR == "RED") sColor = RED;
  if(sORS_COLOR == "BLUE") sColor = BLUE;
  if(sORS_COLOR == "GRAY") sColor = GRAY;
  if(sORS_COLOR == "GREEN") sColor = GREEN;
  if(sORS_COLOR == "WHITE") sColor = WHITE;
  if(sORS_COLOR == "CYAN") sColor = CYAN;
  if(sORS_COLOR == "BLUISHG") sColor = BLUISHG;
  if(sORS_COLOR == "BLUISHR") sColor = BLUISHR;

  //Something to Float
  string sORS_DESCRIPTION = GetLocalString(oSelf,"ORS_DESCRIPTION");

  //Float a Description
  if(nORS_ONUSED == 0)
  {
    ORS_FloatColorString(oPC, sORS_DESCRIPTION, sColor);
    return;
  }

  //Examine Placable
  if(nORS_ONUSED == 1)
  {
    ORS_FloatColorString(oPC, sORS_DESCRIPTION, sColor);
    AssignCommand(oPC, ActionExamine(oSelf));
    return;
  }

  //Open up the Conversation Attached to Placeable
  if(nORS_ONUSED == 2)
  {
    ActionStartConversation(oPC,"",TRUE,FALSE);
    return;
  }

  //Open up the Merchant Attached to Placeable
  if(nORS_ONUSED == 3)
  {
    string sTag = GetTag(oSelf);

    //Find the Store and Open it
    string sStore; int nNth = 1;
    object oStore = GetNearestObject(OBJECT_TYPE_STORE, oSelf, nNth);
    while(GetIsObjectValid(oStore))
    {
      sStore = GetTag(oStore);
      if(sStore == sTag) break;

      nNth++;
      oStore = GetNearestObject(OBJECT_TYPE_STORE, oSelf, nNth);
    }

    if(GetObjectType(oStore) == OBJECT_TYPE_STORE)
    {
      string sName = GetName(oStore);
      ORS_FloatColorString(oPC, sName, sColor);

      PlaySound ("as_sw_chestop1");
      AssignCommand(oSelf, PlayAnimation (ANIMATION_PLACEABLE_OPEN, 1.0, 0.0));
      DelayCommand(30.0, AssignCommand (oSelf, PlayAnimation (ANIMATION_PLACEABLE_CLOSE, 1.0, 0.0f)));

      gplotAppraiseOpenStore(oStore, oPC);
    }
  }
}
