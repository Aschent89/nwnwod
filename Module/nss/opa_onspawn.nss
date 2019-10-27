////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  nw_c2_default9
//  by Don Anderson
//  dandersonru@msn.com
//
//  OnSpawn
//
////////////////////////////////////////////////////////////////////////////////
/*
//NWN Bases
#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"

//NPC Faction Setup for Allegiance System
#include "oai_inc_ai"
#include "oai_inc_spawn"
/*
void main()
{
    object oNPC = OBJECT_SELF;

/******************************************************************************/
//: MAIN SETUP

// * LEAVE THESE ALONE!!
/*
//Sets up the Shouts the NPC Will Listen To
SetListeningPatterns();

//Sets up Personal Characteristics of Each NPC
WhoAmI();

//: MAIN SETUP
/******************************************************************************/
/*
    //Olander's Pack Animals
    string sPA = GetTag(oNPC);
    if(sPA == "PackAnimal")
    {
      SetLocalInt(oNPC,"PACKANIMAL",1);
    }
}