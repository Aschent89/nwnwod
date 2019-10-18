////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Camping and Resting
//  ocf_roast
//  By Don Anderson
//  dandersonru@msn.com
//
//  Cooks Fresh Meat into Cooked Meat
//  There is a Chance to Burn Something WIS + Cooking Skill vs D8 Roll
//
//  To add more meats follow the examples below
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
   object oPC           = GetLastClosedBy();
   object oSelf         = OBJECT_SELF;
   object oItem;
   string sFBear        = "Fresh Bear";
   string sRBear        = "roastedbear";
   string sFBeef        = "Fresh Beef";
   string sRBeef        = "roastedbeef";
   string sFBison       = "Fresh Bison";
   string sRBison       = "roastedbison";
   string sFChicken     = "Fresh Bird";
   string sRChicken     = "roastedchicken";
   string sFPork        = "Fresh Pork";
   string sRPork        = "roastedpork";
   string sFVenison     = "Fresh Venison";
   string sRVenison     = "roastedvenison";
   string sFTrout       = "Fresh Trout";
   string sFBass        = "Fresh Bass";
   string sFPike        = "Fresh Pike";
   string sRFillet      = "roastedfish";
   string sFCrab        = "Fresh Crab";
   string sRCrab        = "roastedcrab";
   string sFLobster     = "Fresh Lobster";
   string sRLobster     = "roastedlobster";
   string sFSalmon      = "Fresh Salmon";
   string sFTuna        = "Fresh Tuna";
   string sFLhimil      = "Fresh Lhimil";

   //Burned Types
   string sBMeat        = "burnedmeat";
   string sBFish        = "burnedfish";
   string sRBread       = "burnedbread";

   int nWis = GetAbilityModifier(ABILITY_WISDOM,oPC);
   if(nWis < 0) nWis = 0;
   //int nSkill = GetLocalInt(oPC,"COOKING_SKILL");
   int nSkill = 0;
   int nBurn = Random(4);//9 when Cooking Skill is Implemented

   //Wisdom Based Cooking is Turn On from  ors_mod_onload
   int nWISCOOK = GetLocalInt(GetModule(),"WISCOOK");
   if(nWISCOOK == 0) nSkill = 100; //Equal to d100 Roll...Guaranteed Cooking

   //Nothing on Spit so Make Campfire Again
   if(!GetIsObjectValid(GetFirstItemInInventory(oSelf)))
   {
     //Destroys CookSpit and Sets up Campfire
     object oCookSpit = GetNearestObjectByTag("CookSpit",oPC);
     int nLC = GetLocalInt(oCookSpit,"LIFECYCLE");

     object oCF = CreateObject(OBJECT_TYPE_PLACEABLE, "campfire", GetLocation(oCookSpit));
     SetLocalInt(oCF,"LIFECYCLE",nLC);

     DestroyObject(oCookSpit);

     //Set Lighting
     effect eLight = EffectVisualEffect(VFX_DUR_LIGHT_YELLOW_20);
     ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLight, oCF);
     DelayCommand(1.5,RecomputeStaticLighting(GetArea(oCF)));

     AssignCommand(oCF,ExecuteScript("ocf_lifecycle",oCF));
     return;
   }

/******************************************************************************/
//: UNBURNED FOOD

   //Success
   if((nWis + nSkill) >= nBurn)
   {
     SpeakString("Good Roasting!!");

     oItem = GetFirstItemInInventory(oSelf);
     while(GetIsObjectValid(oItem))
     {
       if (GetName(oItem) == sFBear)
       { //Bear 3
         CreateItemOnObject(sRBear, oPC, 1);
         CreateItemOnObject(sRBear, oPC, 1);
         CreateItemOnObject(sRBear, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFBeef)
       { //Beef 9
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         CreateItemOnObject(sRBeef, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFBison)
       { //Bison 7
         CreateItemOnObject(sRBison, oPC, 1);
         CreateItemOnObject(sRBison, oPC, 1);
         CreateItemOnObject(sRBison, oPC, 1);
         CreateItemOnObject(sRBison, oPC, 1);
         CreateItemOnObject(sRBison, oPC, 1);
         CreateItemOnObject(sRBison, oPC, 1);
         CreateItemOnObject(sRBison, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFChicken)
       { //Chicken 1
         CreateItemOnObject(sRChicken, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFPork)
       { //Pork 5
         CreateItemOnObject(sRPork, oPC, 1);
         CreateItemOnObject(sRPork, oPC, 1);
         CreateItemOnObject(sRPork, oPC, 1);
         CreateItemOnObject(sRPork, oPC, 1);
         CreateItemOnObject(sRPork, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFVenison)
       { //Venison 3
         CreateItemOnObject(sRVenison, oPC, 1);
         CreateItemOnObject(sRVenison, oPC, 1);
         CreateItemOnObject(sRVenison, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFTrout)
       { //Trout 2
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFBass)
       { //Bass 5
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFPike)
       { //Pike 6
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFCrab)
       { //Crab 1
         CreateItemOnObject(sRCrab, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFLobster)
       { //Lobster 1
         CreateItemOnObject(sRLobster, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFSalmon)
       { //Salmon 8
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFTuna)
       { //Tuna 12
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFLhimil)
       { //Lhimil 6
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         CreateItemOnObject(sRFillet, oPC, 1);
         DestroyObject(oItem);
       }

       oItem = GetNextItemInInventory(oSelf);
     }
   }

//: UNBURNED FOOD
/******************************************************************************/

/******************************************************************************/
//: BURNED FOOD

   if((nWis + nSkill) < nBurn)
   {
     SpeakString("You MIGHT be able to eat that!!");

     oItem = GetFirstItemInInventory(oSelf);
     while(GetIsObjectValid(oItem))
     {
       if (GetName(oItem) == sFBear)
       { //Bear 3
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFBeef)
       { //Beef 9
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFBison)
       { //Bison 7
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFChicken)
       { //Chicken 1
         CreateItemOnObject(sBMeat, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFPork)
       { //Pork 5
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFVenison)
       { //Venison 3
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         CreateItemOnObject(sBMeat, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFTrout)
       { //Trout 2
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFBass)
       { //Bass 5
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFPike)
       { //Pike 10
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFCrab)
       { //Crab 1
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFLobster)
       { //Lobster 1
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFSalmon)
       { //Salmon 8
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFTuna)
       { //Tuna 12
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }
       if (GetName(oItem) == sFLhimil)
       { //Lhimil 6
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         CreateItemOnObject(sBFish, oPC, 1);
         DestroyObject(oItem);
       }

       oItem = GetNextItemInInventory(oSelf);
     }
   }

//: BURNED FOOD
/******************************************************************************/
}
