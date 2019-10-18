////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Horses
//  oho_onspawn
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnSpawn
//
////////////////////////////////////////////////////////////////////////////////

//NWN Bases
#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"

//#include "oai_inc_ai"
//#include "oai_inc_spawn"

#include "oho_inc"

void main()
{
    object oNPC = OBJECT_SELF;

/******************************************************************************/
//: MAIN SETUP

// * LEAVE THESE ALONE!!

//Sets up the Shouts the NPC Will Listen To
//SetListeningPatterns();

//Sets up Personal Characteristics of Each NPC
//WhoAmI();

//: MAIN SETUP
/******************************************************************************/

    //Olander's Horses
    string sTag = GetTag(oNPC);
    if(sTag == "Horse")
    {
      SetLocalInt(oNPC,"HORSE",1);

      //Reset Alignments
      OHOAdjustAlign(oNPC);
    }
}
