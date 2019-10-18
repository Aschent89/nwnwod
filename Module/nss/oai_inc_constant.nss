////////////////////////////////////////////////////////////////////////////////
//
//  Olander's AI
//  oai_inc_constant
//  by Don Anderson
//  dandersonru@msn.com
//
//  Main AI Script
//  Original script by Fallen
//
////////////////////////////////////////////////////////////////////////////////

object oArea = GetArea(OBJECT_SELF);
int MyHD = GetHitDice(OBJECT_SELF);

//10% Speed decrease for Small Creatures and Dwarves
const int SML_CREATURE_MOVEPEN = 10;

//From Deva Bryson Winblood - RTS
const int CAI_CHARM_NONE        =   0;
const int CAI_CHARM_PERSON      =   1;
const int CAI_CHARM_MONSTER     =   2;
const int CAI_CHARM_ANIMAL      =   3;

//Combat Classifications
string OAI_FACTION       = "OAI_FACTION";
string NEUTRAL           = "NEUTRAL";
string HOSTILE           = "HOSTILE";
string ALLY              = "ALLY";
string AXIS              = "AXIS";
string INDEPENDENT       = "INDEPENDENT";

//Mycon Spores
string OAI_SPORE_LARGE   = "me_lspore";
string OAI_SPORE_MED     = "me_mspore";
string OAI_SPORE_SMALL   = "me_sspore";

//Military Personnel Item Tag
string RANKINSIGNIA      = "RankInsignia";

//Guard Stuff (Originally By David Corrales)
string WARNING1          = "Please put away your weapon.";
string WARNING2          = "I said put away your weapon!";
string WARNING3          = "I will not tell you again! Put your WEAPON away!";
string ATTACK_MSG        = "I see you DO NOT wish to comply!!! Attack!!";
string COMPLY_REPLY      = "Good. Thank You.";
float  WARN_DISTANCE     = 20.0;//Distance in which to spot player
float  ANGER_DUR         = 120.0; //Length of time (sec) that will remain angry at the pc

//Horse Stuff
const int OAI_NORMAL_M = 3;
const int OAI_NORMAL_J = 6;
const int OAI_LARGE_M  = 5;
const int OAI_LARGE_J  = 8;

const int OAI_TAILTYPE_BRN_SADDLE   = 16;
const int OAI_TAILTYPE_BRN_RCLOTH   = 22;
const int OAI_TAILTYPE_BRN_PCLOTH   = 21;
const int OAI_TAILTYPE_BRN_LEATHER  = 18;
const int OAI_TAILTYPE_BRN_CHAIN    = 20;
const int OAI_TAILTYPE_BRN_SCAIL    = 19;

const int OAI_TAILTYPE_DPL_SADDLE   = 29;
const int OAI_TAILTYPE_DPL_RCLOTH   = 35;
const int OAI_TAILTYPE_DPL_PCLOTH   = 34;
const int OAI_TAILTYPE_DPL_LEATHER  = 31;
const int OAI_TAILTYPE_DPL_CHAIN    = 33;
const int OAI_TAILTYPE_DPL_SCAIL    = 32;

const int OAI_TAILTYPE_SPT_SADDLE   = 42;
const int OAI_TAILTYPE_SPT_RCLOTH   = 48;
const int OAI_TAILTYPE_SPT_PCLOTH   = 47;
const int OAI_TAILTYPE_SPT_LEATHER  = 44;
const int OAI_TAILTYPE_SPT_CHAIN    = 46;
const int OAI_TAILTYPE_SPT_SCAIL    = 45;

const int OAI_TAILTYPE_BLK_SADDLE   = 55;
const int OAI_TAILTYPE_BLK_RCLOTH   = 61;
const int OAI_TAILTYPE_BLK_PCLOTH   = 60;
const int OAI_TAILTYPE_BLK_LEATHER  = 57;
const int OAI_TAILTYPE_BLK_CHAIN    = 59;
const int OAI_TAILTYPE_BLK_SCAIL    = 58;

const int OAI_I_CAN_RAISE_DEAD                = 100;
const int OAI_I_CAN_CAST_MONSTER_ABILITIES    = 101;
const int OAI_I_CAN_POLYMORPH                 = 102;
const int OAI_I_CAN_SUMMON                    = 103;
const int OAI_I_HAVE_HEALING_POTIONS          = 104;
const int OAI_I_HAVE_BUFFING_POTIONS          = 105;
const int OAI_I_HAVE_HEALING_KITS             = 106;
const int OAI_I_HAVE_TRAP_KITS                = 107;
const int OAI_I_CAN_FIGHT_MELEE               = 108;
const int OAI_I_CAN_FIGHT_RANGED              = 109;
const int OAI_I_CAN_CAST_SPELLS               = 110;
const int OAI_I_CAN_RELIGIOUS_MELEE           = 111;
const int OAI_I_CAN_SMITE_MELEE               = 112;
const int OAI_I_CAN_SNEAK_MELEE               = 113;
const int OAI_I_CAN_DEX_MELEE                 = 114;
const int OAI_I_CAN_WM_MELEE                  = 115;
const int OAI_I_CAN_PM_MELEE                  = 116;
const int OAI_I_CAN_RDD_MELEE                 = 117;
const int OAI_I_CAN_SHIFTER_MELEE             = 118;
const int OAI_I_CAN_MONK_MELEE                = 119;

const int OAI_TRIGGER_HAS_BEEN_CAST           = 200;

const int OAI_FAST_BUFF_COMPLETE              = 300;
const int OAI_FAST_BUFF_ADVANCED              = 301;
const int OAI_FAST_BUFF_RANDOM                = 302;
const int OAI_FAST_BUFF_SUMMON                = 303;
const int OAI_CAST_AURAS_NOW                  = 304;
const int OAI_ROLE_GROUP_LEADER               = 305;
const int OAI_ROLE_HEALER                     = 306;
const int OAI_ROLE_BUFFER                     = 307;
const int OAI_ROLE_DRAGON                     = 308;
const int OAI_ROLE_STATUS_CASTER              = 309;
const int OAI_ROLE_ATTACK_CASTER              = 310;
const int OAI_ROLE_AOE_SPECIALIST             = 311;
const int OAI_BLINK_SELF                      = 312;
const int OAI_BLINK_OTHERS                    = 313;
const int OAI_RETURN_TO_SPAWNPOINT            = 314;
const int OAI_ROLE_BEHOLDER                   = 315;
const int OAI_ROLE_SUICIDE                    = 316;
const int OAI_ROLE_TROLL                      = 317;
const int OAI_ROLE_SPIDER                     = 318;
const int OAI_ROLE_MINDFLAYER                 = 319;
const int OAI_ROLE_SPEEDY                     = 320;
const int OAI_ROLE_NUMBEROFATTACKS            = 321;
const int OAI_ROLE_GHOST                      = 322;
const int OAI_ROLE_GUARD                      = 323;
const int OAI_ROLE_STRIPPER                   = 324;
const int OAI_ROLE_VAMPIRE                    = 325;
const int OAI_ROLE_WINGED                     = 336;
const int OAI_ROLE_STOMPER                    = 337;
const int OAI_ROLE_BURROWER                   = 338;
const int OAI_ROLE_LBURROWER                  = 339;
const int OAI_ROLE_SBURROWER                  = 340;
const int OAI_ROLE_GELATINOUSCUBE             = 341;
const int OAI_ROLE_OOZE                       = 342;
const int OAI_ROLE_PUDDING                    = 343;
const int OAI_ROLE_JELLY                      = 344;
const int OAI_ROLE_SLIME                      = 345;
const int OAI_ROLE_MYCON                      = 346;
const int OAI_ROLE_MYCONSPAWNER               = 347;
const int OAI_ROLE_TRANSFORMER                = 348;

const int OAI_COMBAT_FLAG_RANGED              = 400;
const int OAI_COMBAT_FLAG_DEFENSIVE           = 401;
const int OAI_COMBAT_FLAG_COWARDLY            = 402;
const int OAI_COMBAT_FLAG_AMBUSHER            = 403;

const int OAI_ROLE_COHORT                     = 500;
const int OAI_ROLE_COHORT_COMBAT              = 501;
const int OAI_ROLE_COHORT_WORKING             = 502;
const int OAI_ROLE_COHORT_SPECIALTY           = 503;
const int OAI_ROLE_COHORT_ARCANE              = 504;
const int OAI_ROLE_COHORT_DIVINE              = 505;
const int OAI_ROLE_COHORT_STEALTH             = 510;
const int OAI_ROLE_COHORT_SEARCH              = 511;
const int OAI_ROLE_COHORT_DISARM_TRAP         = 512;
const int OAI_ROLE_COHORT_UNLOCK_DOOR         = 513;
const int OAI_ROLE_COHORT_SCOUTING            = 514;
const int OAI_ROLE_COHORT_FOLLOW              = 515;
const int OAI_ROLE_COHORT_RIDING              = 516;

const int OAI_ROLE_HORSEMAN                   = 600;
const int OAI_ROLE_HORSEMAN_RANDOM            = 601;
const int OAI_ROLE_HORSEMAN_SADDLE            = 602;
const int OAI_ROLE_HORSEMAN_RCLOTH            = 603;
const int OAI_ROLE_HORSEMAN_PCLOTH            = 604;
const int OAI_ROLE_HORSEMAN_LEATHER           = 605;
const int OAI_ROLE_HORSEMAN_CHAIN             = 606;
const int OAI_ROLE_HORSEMAN_SCAIL             = 607;
const int OAI_ROLE_HORSEMAN_BLACK             = 608;
const int OAI_ROLE_HORSEMAN_WALNUT            = 609;
const int OAI_ROLE_HORSEMAN_DAPPLE            = 610;
const int OAI_ROLE_HORSEMAN_SPOTTED           = 611;


/******************************************************************************/
//:: ORIGINALLY FROM LEGACY AI V1.19 BY CENOTAPH

//Missing visual effects.
const int VFX_COM_GIB = 119;
const int VFX_IMP_LEAF = 132;
const int VFX_IMP_CLOUD = 133;
const int VFX_DUR_LIGHT_GREEN_5 = 177;
const int VFX_DUR_LIGHT_GREEN_10 = 178;
const int VFX_DUR_LIGHT_GREEN_15 = 179;
const int VFX_DUR_LIGHT_GREEN_20 = 180;
const int VFX_DUR_GHOSTLY_PULSE_QUICK = 295;

//Missing spell constants.
const int SPELL_PROTECTION_FROM_ALIGNMENT = 321;
const int SPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT = 322;
const int SPELL_AURA_VERSUS_ALIGNMENT = 323;
const int SPELL_GREATER_SHADOW_CONJURATION_GHOSTLY_VISAGE = 351;
const int SPELL_ULTRAVISION = 365;
const int SPELL_SUMMON_CELESTIAL = 379;
const int SPELLABILITY_BARD_SONGS = 411;
const int SPELLABILITY_HARPER_SLEEP = 480;
const int SPELLABILITY_HARPER_CATS_GRACE = 481;
const int SPELLABILITY_HARPER_EAGLE_SPLENDOR = 482;
const int SPELLABILITY_HARPER_INVISIBILITY = 483;
const int SPELLABILITY_SUMMON_SHADOW_X2 = 564;
const int SPELL_EVIL_BLIGHT = 566;
const int SPELLABILITY_CURSE_SONG = 644;
const int SPELLABILITY_WYRMLING_BREATH_COLD = 663;
const int SPELLABILITY_WYRMLING_BREATH_ACID = 664;
const int SPELLABILITY_WYRMLING_BREATH_FIRE = 665;
const int SPELLABILITY_WYRMLING_BREATH_GAS = 666;
const int SPELLABILITY_WYRMLING_BREATH_LIGHTNING = 667;
const int SPELLABILITY_HARPY_CAPTIVATING_SONG = 686;
const int SPELLABILITY_SHIFTER_MEDU_BASILISK_PETRI_GAZE = 687;
const int SPELLABILITY_SHIFTER_DROW_DRIDER_DARKNESS = 688;
const int SPELLABILITY_RED_DRAGON_DISCIPLE_BREATH = 690;
const int SPELLABILITY_GREATER_WILDSHAPE_MINDFLAYER = 691;
const int SPELLABILITY_SHIFTER_MINDFLAYER_MINDBLAST = 693;
const int SPELLABILITY_GREATER_WILDSHAPE_DIRETIGER = 694;
const int SPELLABILITY_SUMMON_BAATEZU = 701;
const int SPELLABILITY_EYEBALL_COLD_RAY = 710;
const int SPELLABILITY_EYEBALL_WOUND_RAY = 711;
const int SPELLABILITY_EYEBALL_FIRE_RAY = 712;
const int SPELLABILITY_MINDFLAYER_MINDBLAST_10 = 713;
const int SPELLABILITY_BEHOLDER_ANTIMAGIC_CONE = 727;
const int SPELLABILITY_BEHOLDER_SPECIAL_SPELL_AI = 736;
const int SPELLABILITY_PSIONIC_INERTIAL_BARRIER = 741;
const int SPELL_HELL_INFERNO = 762;
const int SPELLABILITY_PSIONIC_MASS_CONCUSSION = 763;
const int SPELLABILITY_SHADOW_TOUCH = 769;
const int SPELLABILTIY_SLAAD_CHAOS_SPITTLE = 770;
const int SPELLABILITY_HURL_ROCK = 775;
const int SPELLABILITY_BEHOLDER_DEATH_RAY = 776;
const int SPELLABILITY_BEHOLDER_KNOCKDOWN_RAY = 777;
//Only beholder ray that can be blocked by an immunity.
const int SPELLABILITY_BEHOLDER_PETRIFY_RAY = 778;
const int SPELLABILITY_BEHOLDER_CHARM_RAY = 779;
const int SPELLABILITY_BEHOLDER_SLOW_RAY = 780;
const int SPELLABILITY_BEHOLDER_WOUND_RAY = 783;
const int SPELLABILITY_BEHOLDER_FEAR_RAY = 784;
const int SPELLABILITY_SHIFTER_DRAGON_BREATH_LIGHTNING = 796;
const int SPELLABILITY_SHIFTER_DRAGON_BREATH_FIRE = 797;
const int SPELLABILITY_SHIFTER_DRAGON_BREATH_GAS = 798;
//Appears are "Invisibility" under "Monster Abilities" in the Toolset.
const int SPELLABILITY_VAMPIRE_INVISIBILITY = 799;
const int SPELLABILITY_VAMPIRE_DOMINATION_GAZE = 800;
const int SPELLABILITY_AZER_FIRE_STREAM = 801;
const int SPELLABILITY_SHIFTER_SPECTRE_ATTACK = 802;

//Missing feat constants.
const int FEAT_BLACKGUARD_CREATE_UNDEAD = 474;
const int FEAT_BLACKGUARD_FIENDISH_SERVANT = 475;
const int FEAT_EPIC_PLANAR_TURNING = 854;

//:: ORIGINALLY FROM LEGACY AI V1.19 BY CENOTAPH
/******************************************************************************/

/******************************************************************************/
//:: Floating Role Play Combat Text Messages

//Glancing is Generic for All
const string HEAD_GLANCE1 = "Blow glances off side of head.";
const string HEAD_GLANCE2 = "Glancing blow to the top of head.";
const string NECK_GLANCE1 = "Blow glances off shoulder barely touching the neck.";
const string NECK_GLANCE2 = "Glancing blow to the Neck.";
const string CHEST_GLANCE1 = "Blow glances off arm barely touching the chest.";
const string CHEST_GLANCE2 = "Glancing blow to the chest.";
const string WAIST_GLANCE1 = "Blow glances off hip.";
const string WAIST_GLANCE2 = "Blow slighly hits waistline.";
const string ARM_GLANCE1 = "Blow glances off arm.";
const string ARM_GLANCE2 = "Blow ripples armor.";
const string LEG_GLANCE1 = "Blow glances off thigh.";
const string LEG_GLANCE2 = "Blow brushes off leg.";

//Bludgeoning
const string BHEAD_HEAVY1 = "Blast to the Head shatters bone into brain. SPLAT.";
const string BHEAD_HEAVY2 = "Blow to jaw drives bone into the brain! Yikes.";
const string BHEAD_HEAVY3 = "Head almost gets knocked off the neck! That'll make ya sick.";

const string BNECK_HEAVY1 = "Throat crushed! Out of air.";
const string BNECK_HEAVY2 = "Blast to the back of neck! Goner.";
const string BNECK_HEAVY3 = "Head almost gets knocked off the neck! Ooo...not good.";

const string BCHEST_HEAVY1 = "Blast to the chest sends rib cage through lungs! Vicious.";
const string BCHEST_HEAVY2 = "Blow to side crushes chest cavity! Hmm...looks finished.";
const string BCHEST_HEAVY3 = "Blast to Spine! Not gonna live.";

const string BWAIST_HEAVY1 = "Hip crushed! Massive internal bleeding.";
const string BWAIST_HEAVY2 = "Blast to groin! Uhh....not fair?";
const string BWAIST_HEAVY3 = "Lower Spine crushed! Nasty.";

const string BARM_HEAVY1 = "Bicep crushed! Looks like Hamburger.";
const string BARM_HEAVY2 = "Forearm crushed! Looks like that hurts.";
const string BARM_HEAVY3 = "Hand crushed! Won't be using that again.";

const string BLEG_HEAVY1 = "Bone shattered in Thigh! Gruesome.";
const string BLEG_HEAVY2 = "Knee shattered! Bet that hurts.";
const string BLEG_HEAVY3 = "Foot crushed! Yeewww.";

//Piercing
const string PHEAD_HEAVY1 = "Blade goes straight through head! Vicious.";
const string PHEAD_HEAVY2 = "Blade shoots through eye! Interesting.";
const string PHEAD_HEAVY3 = "No way to describe that head shot! Gruesome.";

const string PNECK_HEAVY1 = "Neck severed! Blood everywhere.";
const string PNECK_HEAVY2 = "Stab through side of neck! Goner.";
const string PNECK_HEAVY3 = "Blade pierces Brain. Dead...period.";

const string PCHEST_HEAVY1 = "Blade sinks deep into lungs! Not gonna make it.";
const string PCHEST_HEAVY2 = "Heart strike! Dead.";
const string PCHEST_HEAVY3 = "Misses Lungs but hits Spleen! Not gonna live.";

const string PWAIST_HEAVY1 = "Intestines severed! Massive internal bleeding.";
const string PWAIST_HEAVY2 = "Groin! Uh...what is that?";
const string PWAIST_HEAVY3 = "Lower Spine severed! A real heap.";

const string PARM_HEAVY1 = "Bicep pierced through! Will not use that soon.";
const string PARM_HEAVY2 = "Forearm pierced through! No good.";
const string PARM_HEAVY3 = "Hand pierced through! Ugly.";

const string PLEG_HEAVY1 = "Thigh pierced...muscle severed! Gruesome.";
const string PLEG_HEAVY2 = "Tendons severed! Not good.";
const string PLEG_HEAVY3 = "Foot punctured! A Real gusher.";

//Slashing
const string SHEAD_HEAVY1 = "Blade sinks deeply into brain. Death will soon follow.";
const string SHEAD_HEAVY2 = "Top of head lopped off. Now that is nasty.";
const string SHEAD_HEAVY3 = "Canyon opened across face. A real eye full.";

const string SNECK_HEAVY1 = "Throat opened wide! Gusher.";
const string SNECK_HEAVY2 = "Head separated from neck! Nice.";
const string SNECK_HEAVY3 = "Half of neck sliced clean! Hmm...now what.";

const string SCHEST_HEAVY1 = "Gorge opened across chest! Tough.";
const string SCHEST_HEAVY2 = "Blade rips through liver! That hurts.";
const string SCHEST_HEAVY3 = "Back muscles severed! Down and out.";

const string SWAIST_HEAVY1 = "Disemboweled! Guts all over.";
const string SWAIST_HEAVY2 = "Blade sinks deeply into groin! Ugggh.";
const string SWAIST_HEAVY3 = "Blade sinks deeply into waist! Like a Seasoned Ham.";

const string SARM_HEAVY1 = "Bicep sliced badly! Not good.";
const string SARM_HEAVY2 = "Forearm sliced through! Oooo....Sorry.";
const string SARM_HEAVY3 = "Hand sliced off! Hey Stumpy.";

const string SLEG_HEAVY1 = "Thigh opened to the bone! Lots of Blood.";
const string SLEG_HEAVY2 = "Tendons severed. Not gonna walk soon.";
const string SLEG_HEAVY3 = "Lower leg severed. Uh....gonna die soon.";


//Horse Trampling
const string HHEAD_HEAVY1 = "Hoof cleaves half of face off. Uhh....Dead.";
const string HHEAD_HEAVY2 = "Horseshoe crushes skull. Ouch....that had to hurt.";
const string HHEAD_HEAVY3 = "Hoof rips jaw off. NOT going to speak any more.";

const string HNECK_HEAVY1 = "Hoof mashes throat. Blood everywhere.";
const string HNECK_HEAVY2 = "Hoof rips head from neck. A real fountain.";
const string HNECK_HEAVY3 = "Neck opens like a box from a Hoof! Hmm...now what?";

const string HCHEST_HEAVY1 = "Hoof print to the chest sends rib cage through lungs! Vicious.";
const string HCHEST_HEAVY2 = "Horse Kick to side crushes chest cavity! Hmm...looks finished.";
const string HCHEST_HEAVY3 = "Horseshoe in the Spine! This is not good.";

const string HWAIST_HEAVY1 = "Hoof crushes Hip! Massive internal bleeding.";
const string HWAIST_HEAVY2 = "Hoof mashes groin! Oi!";
const string HWAIST_HEAVY3 = "Hoof obliterates Lower Spine! Look at the quiverring.";

const string HARM_HEAVY1 = "Hoof crushes Bicep! Looks like Hamburger.";
const string HARM_HEAVY2 = "Hoof crushes Forearm! Looks like that hurts.";
const string HARM_HEAVY3 = "Hoof mashes Hand! Won't be using that again.";

const string HLEG_HEAVY1 = "Hoof shatters Bone in Thigh! Hear that crack? Nasty.";
const string HLEG_HEAVY2 = "Hoof shatters Knee! Bet that hurts.";
const string HLEG_HEAVY3 = "Hoof mashes Foot! Never saw so much blood.";

const string HORSE_GLANCE = "Horse Trample! Ouch.";

/******************************************************************************/
//: OAI ANIMAL CONFIGS

int OAI_GetIsBear(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 12: nCheck = TRUE; break;
     case 13: nCheck = TRUE; break;
     case 14: nCheck = TRUE; break;
     case 15: nCheck = TRUE; break;
     case 204: nCheck = TRUE; break;
     case 1292: nCheck = TRUE; break;
     case 1293: nCheck = TRUE; break;
     case 1294: nCheck = TRUE; break;
     case 1295: nCheck = TRUE; break;
     case 1822: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_BEAR")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsBison(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 1015: nCheck = TRUE; break;
     case 1016: nCheck = TRUE; break;
     case 416: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_BISON")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsBovine(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 34: nCheck = TRUE; break;
     case 1005: nCheck = TRUE; break;
     case 1006: nCheck = TRUE; break;
     case 1007: nCheck = TRUE; break;
     case 1008: nCheck = TRUE; break;
     case 1009: nCheck = TRUE; break;
     case 1010: nCheck = TRUE; break;
     case 1011: nCheck = TRUE; break;
     case 1012: nCheck = TRUE; break;
     case 1013: nCheck = TRUE; break;
     case 1017: nCheck = TRUE; break;
     case 1018: nCheck = TRUE; break;
     case 1019: nCheck = TRUE; break;
     case 1020: nCheck = TRUE; break;
     case 1255: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_BOVINE")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsDeer(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 35: nCheck = TRUE; break;
     case 37: nCheck = TRUE; break;
     case 1332: nCheck = TRUE; break;
     case 1333: nCheck = TRUE; break;
     case 1334: nCheck = TRUE; break;
     case 1802: nCheck = TRUE; break;
     case 1803: nCheck = TRUE; break;
     case 1804: nCheck = TRUE; break;
     case 1805: nCheck = TRUE; break;
     case 1853: nCheck = TRUE; break;
     case 1865: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_DEER")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsSwine(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 21: nCheck = TRUE; break;
     case 22: nCheck = TRUE; break;
     case 1025: nCheck = TRUE; break;
     case 1026: nCheck = TRUE; break;
     case 1027: nCheck = TRUE; break;
     case 1028: nCheck = TRUE; break;
     case 1029: nCheck = TRUE; break;
     case 1051: nCheck = TRUE; break;
     case 1821: nCheck = TRUE; break;
     case 1884: nCheck = TRUE; break;
     case 1944: nCheck = TRUE; break;
     case 1945: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_SWINE")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsBird(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 7: nCheck = TRUE; break;
     case 144: nCheck = TRUE; break;
     case 145: nCheck = TRUE; break;
     case 1891: nCheck = TRUE; break;
     case 1947: nCheck = TRUE; break;
     case 1948: nCheck = TRUE; break;
     case 1949: nCheck = TRUE; break;
     case 1950: nCheck = TRUE; break;
     case 1951: nCheck = TRUE; break;
     case 1952: nCheck = TRUE; break;
     case 1956: nCheck = TRUE; break;
     case 1957: nCheck = TRUE; break;
     case 1958: nCheck = TRUE; break;
     case 1959: nCheck = TRUE; break;
     case 1960: nCheck = TRUE; break;
     case 1961: nCheck = TRUE; break;
     case 1962: nCheck = TRUE; break;
     case 1963: nCheck = TRUE; break;
     case 1964: nCheck = TRUE; break;
     case 1965: nCheck = TRUE; break;
     case 1975: nCheck = TRUE; break;
     case 1976: nCheck = TRUE; break;
     case 1977: nCheck = TRUE; break;
     case 1978: nCheck = TRUE; break;
     case 1979: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_BIRD")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsCrab(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 1427: nCheck = TRUE; break;
     case 1428: nCheck = TRUE; break;
     case 1429: nCheck = TRUE; break;
     case 1430: nCheck = TRUE; break;
     case 1984: nCheck = TRUE; break;
     case 1985: nCheck = TRUE; break;
     case 1986: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_CRAB")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsLobster(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 1980: nCheck = TRUE; break;
     case 1981: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_LOBSTER")) nCheck = TRUE;

   return nCheck;
}

int OAI_GetIsFish(object oCreature)
{
   int nCheck = FALSE;
   int nApp = GetAppearanceType(oCreature);
   switch(nApp)
   {
     case 447: nCheck = TRUE; break;
     case 448: nCheck = TRUE; break;
     case 449: nCheck = TRUE; break;
     case 1876: nCheck = TRUE; break;
     case 1877: nCheck = TRUE; break;
     case 1879: nCheck = TRUE; break;
     case 1880: nCheck = TRUE; break;
     case 1881: nCheck = TRUE; break;
     case 1882: nCheck = TRUE; break;
   }

   if(GetLocalInt(oCreature,"OAI_FISH")) nCheck = TRUE;

   return nCheck;
}

/******************************************************************************/
//: OAI SPECIAL BATTLE ROLES

/*
  Creatures who have the Ability to Fly...like Winged Beasts or some Ghosts
  and a few others who Float and Hover.
*/
int OAI_GetIsWinged(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 7: nCheck = TRUE; break;
    case 10: nCheck = TRUE; break;
    case 11: nCheck = TRUE; break;
    case 38: nCheck = TRUE; break;
    case 52: nCheck = TRUE; break;
    case 53: nCheck = TRUE; break;
    case 55: nCheck = TRUE; break;
    case 60: nCheck = TRUE; break;
    case 61: nCheck = TRUE; break;
    case 68: nCheck = TRUE; break;
    case 69: nCheck = TRUE; break;
    case 73: nCheck = TRUE; break;
    case 100: nCheck = TRUE; break;
    case 103: nCheck = TRUE; break;
    case 104: nCheck = TRUE; break;
    case 105: nCheck = TRUE; break;
    case 106: nCheck = TRUE; break;
    case 107: nCheck = TRUE; break;
    case 108: nCheck = TRUE; break;
    case 109: nCheck = TRUE; break;
    case 110: nCheck = TRUE; break;
    case 111: nCheck = TRUE; break;
    case 112: nCheck = TRUE; break;
    case 113: nCheck = TRUE; break;
    case 114: nCheck = TRUE; break;
    case 115: nCheck = TRUE; break;
    case 116: nCheck = TRUE; break;
    case 118: nCheck = TRUE; break;
    case 144: nCheck = TRUE; break;
    case 145: nCheck = TRUE; break;
    case 156: nCheck = TRUE; break;
    case 163: nCheck = TRUE; break;
    case 186: nCheck = TRUE; break;
    case 187: nCheck = TRUE; break;
    case 291: nCheck = TRUE; break;
    case 364: nCheck = TRUE; break;
    case 365: nCheck = TRUE; break;
    case 374: nCheck = TRUE; break;
    case 375: nCheck = TRUE; break;
    case 376: nCheck = TRUE; break;
    case 377: nCheck = TRUE; break;
    case 378: nCheck = TRUE; break;
    case 379: nCheck = TRUE; break;
    case 380: nCheck = TRUE; break;
    case 381: nCheck = TRUE; break;
    case 382: nCheck = TRUE; break;
    case 383: nCheck = TRUE; break;
    case 384: nCheck = TRUE; break;
    case 385: nCheck = TRUE; break;
    case 392: nCheck = TRUE; break;
    case 404: nCheck = TRUE; break;
    case 419: nCheck = TRUE; break;
    case 471: nCheck = TRUE; break;
    case 1050: nCheck = TRUE; break;
    case 1072: nCheck = TRUE; break;
    case 1073: nCheck = TRUE; break;
    case 1077: nCheck = TRUE; break;
    case 1087: nCheck = TRUE; break;
    case 1088: nCheck = TRUE; break;
    case 1089: nCheck = TRUE; break;
    case 1093: nCheck = TRUE; break;
    case 1094: nCheck = TRUE; break;
    case 1097: nCheck = TRUE; break;
    case 1099: nCheck = TRUE; break;
    case 1100: nCheck = TRUE; break;
    case 1101: nCheck = TRUE; break;
    case 1104: nCheck = TRUE; break;
    case 1122: nCheck = TRUE; break;
    case 1123: nCheck = TRUE; break;
    case 1124: nCheck = TRUE; break;
    case 1259: nCheck = TRUE; break;
    case 1275: nCheck = TRUE; break;
    case 1281: nCheck = TRUE; break;
    case 1282: nCheck = TRUE; break;
    case 1290: nCheck = TRUE; break;
    case 1291: nCheck = TRUE; break;
    case 1307: nCheck = TRUE; break;
    case 1324: nCheck = TRUE; break;
    case 1331: nCheck = TRUE; break;
    case 1342: nCheck = TRUE; break;
    case 1343: nCheck = TRUE; break;
    case 1344: nCheck = TRUE; break;
    case 1345: nCheck = TRUE; break;
    case 1346: nCheck = TRUE; break;
    case 1347: nCheck = TRUE; break;
    case 1354: nCheck = TRUE; break;
    case 1355: nCheck = TRUE; break;
    case 1356: nCheck = TRUE; break;
    case 1357: nCheck = TRUE; break;
    case 1358: nCheck = TRUE; break;
    case 1359: nCheck = TRUE; break;
    case 1366: nCheck = TRUE; break;
    case 1367: nCheck = TRUE; break;
    case 1368: nCheck = TRUE; break;
    case 1372: nCheck = TRUE; break;
    case 1373: nCheck = TRUE; break;
    case 1374: nCheck = TRUE; break;
    case 1375: nCheck = TRUE; break;
    case 1376: nCheck = TRUE; break;
    case 1377: nCheck = TRUE; break;
    case 1381: nCheck = TRUE; break;
    case 1382: nCheck = TRUE; break;
    case 1383: nCheck = TRUE; break;
    case 1384: nCheck = TRUE; break;
    case 1385: nCheck = TRUE; break;
    case 1386: nCheck = TRUE; break;
    case 1387: nCheck = TRUE; break;
    case 1388: nCheck = TRUE; break;
    case 1389: nCheck = TRUE; break;
    case 1419: nCheck = TRUE; break;
    case 1449: nCheck = TRUE; break;
    case 1493: nCheck = TRUE; break;
    case 1494: nCheck = TRUE; break;
    case 1495: nCheck = TRUE; break;
    case 1501: nCheck = TRUE; break;
    case 1502: nCheck = TRUE; break;
    case 1503: nCheck = TRUE; break;
    case 1566: nCheck = TRUE; break;
    case 1567: nCheck = TRUE; break;
    case 1568: nCheck = TRUE; break;
    case 1569: nCheck = TRUE; break;
    case 1570: nCheck = TRUE; break;
    case 1731: nCheck = TRUE; break;
    case 1807: nCheck = TRUE; break;
    case 1808: nCheck = TRUE; break;
    case 1809: nCheck = TRUE; break;
    case 1810: nCheck = TRUE; break;
    case 1812: nCheck = TRUE; break;
    case 1813: nCheck = TRUE; break;
    case 1814: nCheck = TRUE; break;
    case 1815: nCheck = TRUE; break;
    case 1816: nCheck = TRUE; break;
    case 1817: nCheck = TRUE; break;
    case 1818: nCheck = TRUE; break;
    case 1819: nCheck = TRUE; break;
    case 1834: nCheck = TRUE; break;
    case 1835: nCheck = TRUE; break;
    case 1836: nCheck = TRUE; break;
    case 1837: nCheck = TRUE; break;
    case 1838: nCheck = TRUE; break;
    case 1839: nCheck = TRUE; break;
    case 1840: nCheck = TRUE; break;
    case 1841: nCheck = TRUE; break;
    case 1842: nCheck = TRUE; break;
    case 1843: nCheck = TRUE; break;
    case 1844: nCheck = TRUE; break;
    case 1845: nCheck = TRUE; break;
    case 1846: nCheck = TRUE; break;
    case 1847: nCheck = TRUE; break;
    case 1848: nCheck = TRUE; break;
    case 1849: nCheck = TRUE; break;
    case 1872: nCheck = TRUE; break;
    case 1891: nCheck = TRUE; break;
    case 1892: nCheck = TRUE; break;
    case 1893: nCheck = TRUE; break;
    case 1917: nCheck = TRUE; break;
    case 1947: nCheck = TRUE; break;
    case 1948: nCheck = TRUE; break;
    case 1949: nCheck = TRUE; break;
    case 1950: nCheck = TRUE; break;
    case 1951: nCheck = TRUE; break;
    case 1952: nCheck = TRUE; break;
    case 1956: nCheck = TRUE; break;
    case 1957: nCheck = TRUE; break;
    case 1958: nCheck = TRUE; break;
    case 1959: nCheck = TRUE; break;
    case 1960: nCheck = TRUE; break;
    case 1961: nCheck = TRUE; break;
    case 1962: nCheck = TRUE; break;
    case 1963: nCheck = TRUE; break;
    case 1964: nCheck = TRUE; break;
    case 1965: nCheck = TRUE; break;
    case 1975: nCheck = TRUE; break;
    case 1976: nCheck = TRUE; break;
    case 1977: nCheck = TRUE; break;
    case 1978: nCheck = TRUE; break;
    case 1979: nCheck = TRUE; break;
    case 1988: nCheck = TRUE; break;
    case 1990: nCheck = TRUE; break;
    case 1991: nCheck = TRUE; break;
    case 1992: nCheck = TRUE; break;
    case 1993: nCheck = TRUE; break;
    case 1994: nCheck = TRUE; break;
    case 1995: nCheck = TRUE; break;
    case 1996: nCheck = TRUE; break;
    case 1997: nCheck = TRUE; break;
    case 1998: nCheck = TRUE; break;
    case 3120: nCheck = TRUE; break;
    case 3121: nCheck = TRUE; break;
    case 3122: nCheck = TRUE; break;
    case 3123: nCheck = TRUE; break;
    case 3124: nCheck = TRUE; break;
    case 3129: nCheck = TRUE; break;
    case 3130: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_WINGED")) nCheck = TRUE;

  return nCheck;
}

/*
  Creatures who classify themselves as Dragons for the sake of Combat AI.
  Wyrmlings are Not classified as Dragon Kind.
*/
int OAI_GetIsDragon(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 41: nCheck = TRUE; break;
    case 42: nCheck = TRUE; break;
    case 43: nCheck = TRUE; break;
    case 44: nCheck = TRUE; break;
    case 45: nCheck = TRUE; break;
    case 46: nCheck = TRUE; break;
    case 47: nCheck = TRUE; break;
    case 48: nCheck = TRUE; break;
    case 49: nCheck = TRUE; break;
    case 50: nCheck = TRUE; break;
    case 418: nCheck = TRUE; break;
    case 425: nCheck = TRUE; break;
    case 455: nCheck = TRUE; break;
    case 456: nCheck = TRUE; break;
    case 457: nCheck = TRUE; break;
    case 458: nCheck = TRUE; break;
    case 1031: nCheck = TRUE; break;
    case 1320: nCheck = TRUE; break;
    case 1321: nCheck = TRUE; break;
    case 1322: nCheck = TRUE; break;
    case 1323: nCheck = TRUE; break;
    case 1412: nCheck = TRUE; break;
    case 1413: nCheck = TRUE; break;
    case 1512: nCheck = TRUE; break;
    case 1537: nCheck = TRUE; break;
    case 1538: nCheck = TRUE; break;
    case 1539: nCheck = TRUE; break;
    case 1540: nCheck = TRUE; break;
    case 1541: nCheck = TRUE; break;
    case 1542: nCheck = TRUE; break;
    case 1543: nCheck = TRUE; break;
    case 1585: nCheck = TRUE; break;
    case 1586: nCheck = TRUE; break;
    case 1587: nCheck = TRUE; break;
    case 1588: nCheck = TRUE; break;
    case 1589: nCheck = TRUE; break;
    case 1590: nCheck = TRUE; break;
    case 1591: nCheck = TRUE; break;
    case 1592: nCheck = TRUE; break;
    case 1593: nCheck = TRUE; break;
    case 1594: nCheck = TRUE; break;
    case 1595: nCheck = TRUE; break;
    case 1597: nCheck = TRUE; break;
    case 1598: nCheck = TRUE; break;
    case 1599: nCheck = TRUE; break;
    case 1600: nCheck = TRUE; break;
    case 1601: nCheck = TRUE; break;
    case 1602: nCheck = TRUE; break;
    case 1603: nCheck = TRUE; break;
    case 1604: nCheck = TRUE; break;
    case 1605: nCheck = TRUE; break;
    case 1606: nCheck = TRUE; break;
    case 1607: nCheck = TRUE; break;
    case 1609: nCheck = TRUE; break;
    case 1610: nCheck = TRUE; break;
    case 1611: nCheck = TRUE; break;
    case 1612: nCheck = TRUE; break;
    case 1613: nCheck = TRUE; break;
    case 1614: nCheck = TRUE; break;
    case 1615: nCheck = TRUE; break;
    case 1616: nCheck = TRUE; break;
    case 1617: nCheck = TRUE; break;
    case 1618: nCheck = TRUE; break;
    case 1619: nCheck = TRUE; break;
    case 1621: nCheck = TRUE; break;
    case 1622: nCheck = TRUE; break;
    case 1623: nCheck = TRUE; break;
    case 1624: nCheck = TRUE; break;
    case 1625: nCheck = TRUE; break;
    case 1626: nCheck = TRUE; break;
    case 1627: nCheck = TRUE; break;
    case 1628: nCheck = TRUE; break;
    case 1629: nCheck = TRUE; break;
    case 1630: nCheck = TRUE; break;
    case 1631: nCheck = TRUE; break;
    case 1633: nCheck = TRUE; break;
    case 1634: nCheck = TRUE; break;
    case 1635: nCheck = TRUE; break;
    case 1636: nCheck = TRUE; break;
    case 1637: nCheck = TRUE; break;
    case 1638: nCheck = TRUE; break;
    case 1639: nCheck = TRUE; break;
    case 1640: nCheck = TRUE; break;
    case 1641: nCheck = TRUE; break;
    case 1642: nCheck = TRUE; break;
    case 1643: nCheck = TRUE; break;
    case 1645: nCheck = TRUE; break;
    case 1646: nCheck = TRUE; break;
    case 1647: nCheck = TRUE; break;
    case 1648: nCheck = TRUE; break;
    case 1649: nCheck = TRUE; break;
    case 1650: nCheck = TRUE; break;
    case 1651: nCheck = TRUE; break;
    case 1652: nCheck = TRUE; break;
    case 1653: nCheck = TRUE; break;
    case 1654: nCheck = TRUE; break;
    case 1655: nCheck = TRUE; break;
    case 1657: nCheck = TRUE; break;
    case 1658: nCheck = TRUE; break;
    case 1659: nCheck = TRUE; break;
    case 1660: nCheck = TRUE; break;
    case 1661: nCheck = TRUE; break;
    case 1662: nCheck = TRUE; break;
    case 1663: nCheck = TRUE; break;
    case 1664: nCheck = TRUE; break;
    case 1665: nCheck = TRUE; break;
    case 1666: nCheck = TRUE; break;
    case 1667: nCheck = TRUE; break;
    case 1669: nCheck = TRUE; break;
    case 1670: nCheck = TRUE; break;
    case 1671: nCheck = TRUE; break;
    case 1672: nCheck = TRUE; break;
    case 1673: nCheck = TRUE; break;
    case 1674: nCheck = TRUE; break;
    case 1675: nCheck = TRUE; break;
    case 1676: nCheck = TRUE; break;
    case 1677: nCheck = TRUE; break;
    case 1678: nCheck = TRUE; break;
    case 1679: nCheck = TRUE; break;
    case 1681: nCheck = TRUE; break;
    case 1682: nCheck = TRUE; break;
    case 1683: nCheck = TRUE; break;
    case 1684: nCheck = TRUE; break;
    case 1685: nCheck = TRUE; break;
    case 1686: nCheck = TRUE; break;
    case 1687: nCheck = TRUE; break;
    case 1688: nCheck = TRUE; break;
    case 1689: nCheck = TRUE; break;
    case 1690: nCheck = TRUE; break;
    case 1691: nCheck = TRUE; break;
    case 1693: nCheck = TRUE; break;
    case 1694: nCheck = TRUE; break;
    case 1695: nCheck = TRUE; break;
    case 1696: nCheck = TRUE; break;
    case 1697: nCheck = TRUE; break;
    case 1698: nCheck = TRUE; break;
    case 1699: nCheck = TRUE; break;
    case 1700: nCheck = TRUE; break;
    case 1701: nCheck = TRUE; break;
    case 1702: nCheck = TRUE; break;
    case 1703: nCheck = TRUE; break;
    case 1923: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_DRAGON")) nCheck = TRUE;

  return nCheck;
}

/*
  Creatures who classify themselves as Wyrmling Dragons for the sake of Combat AI.
*/
int OAI_GetIsMiniDragon(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 374: nCheck = TRUE; break;
    case 375: nCheck = TRUE; break;
    case 376: nCheck = TRUE; break;
    case 377: nCheck = TRUE; break;
    case 378: nCheck = TRUE; break;
    case 379: nCheck = TRUE; break;
    case 380: nCheck = TRUE; break;
    case 381: nCheck = TRUE; break;
    case 382: nCheck = TRUE; break;
    case 383: nCheck = TRUE; break;
    case 384: nCheck = TRUE; break;
    case 385: nCheck = TRUE; break;
    case 1072: nCheck = TRUE; break;
    case 1087: nCheck = TRUE; break;
    case 1419: nCheck = TRUE; break;
    case 1584: nCheck = TRUE; break;
    case 1596: nCheck = TRUE; break;
    case 1608: nCheck = TRUE; break;
    case 1620: nCheck = TRUE; break;
    case 1632: nCheck = TRUE; break;
    case 1644: nCheck = TRUE; break;
    case 1656: nCheck = TRUE; break;
    case 1668: nCheck = TRUE; break;
    case 1680: nCheck = TRUE; break;
    case 1692: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_MINIDRAGON")) nCheck = TRUE;

  return nCheck;
}

/*
  Lycans
*/
int OAI_GetIsLycan(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 99: nCheck = TRUE; break;
    case 170: nCheck = TRUE; break;
    case 171: nCheck = TRUE; break;
    case 467: nCheck = TRUE; break;
    case 1092: nCheck = TRUE; break;
    case 1166: nCheck = TRUE; break;
    case 1414: nCheck = TRUE; break;
    case 1415: nCheck = TRUE; break;
    case 1450: nCheck = TRUE; break;
    case 1452: nCheck = TRUE; break;
    case 1493: nCheck = TRUE; break;
    case 1530: nCheck = TRUE; break;
    case 1531: nCheck = TRUE; break;
    case 1770: nCheck = TRUE; break;
    case 1771: nCheck = TRUE; break;
    case 1772: nCheck = TRUE; break;
    case 1773: nCheck = TRUE; break;
    case 1774: nCheck = TRUE; break;
    case 1775: nCheck = TRUE; break;
    case 1776: nCheck = TRUE; break;
    case 1777: nCheck = TRUE; break;
    case 1790: nCheck = TRUE; break;
    case 1793: nCheck = TRUE; break;
    case 1799: nCheck = TRUE; break;
    case 1811: nCheck = TRUE; break;
    case 1818: nCheck = TRUE; break;
    case 1819: nCheck = TRUE; break;
    case 1823: nCheck = TRUE; break;
    case 1824: nCheck = TRUE; break;
    case 1825: nCheck = TRUE; break;
    case 1826: nCheck = TRUE; break;
    case 1828: nCheck = TRUE; break;
    case 1829: nCheck = TRUE; break;
    case 1830: nCheck = TRUE; break;
    case 1831: nCheck = TRUE; break;
    case 1832: nCheck = TRUE; break;
    case 1833: nCheck = TRUE; break;
    case 1851: nCheck = TRUE; break;
    case 1852: nCheck = TRUE; break;
    case 1864: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_LYCAN")) nCheck = TRUE;

  return nCheck;
}

/*
  Vampires
*/
int OAI_GetIsVampire(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 16: nCheck = TRUE; break;
    case 288: nCheck = TRUE; break;
    case 289: nCheck = TRUE; break;
    case 1807: nCheck = TRUE; break;
    case 1808: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_VAMPIRE")) nCheck = TRUE;

  return nCheck;
}

/*
  Trolls
*/
int OAI_GetIsTroll(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 164: nCheck = TRUE; break;
    case 165: nCheck = TRUE; break;
    case 166: nCheck = TRUE; break;
    case 167: nCheck = TRUE; break;
    case 1058: nCheck = TRUE; break;
    case 1296: nCheck = TRUE; break;
    case 1297: nCheck = TRUE; break;
    case 1298: nCheck = TRUE; break;
    case 1938: nCheck = TRUE; break;
    case 1939: nCheck = TRUE; break;
    case 1943: nCheck = TRUE; break;
    case 1946: nCheck = TRUE; break;
    case 1954: nCheck = TRUE; break;
    case 1955: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_TROLL")) nCheck = TRUE;

  return nCheck;
}

/*
  Beholders
*/
int OAI_GetIsBeholder(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 299: nCheck = TRUE; break;
    case 401: nCheck = TRUE; break;
    case 402: nCheck = TRUE; break;
    case 403: nCheck = TRUE; break;
    case 472: nCheck = TRUE; break;
    case 1046: nCheck = TRUE; break;
    case 1508: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_BEHOLDER")) nCheck = TRUE;

  return nCheck;
}

/*
  Mindlfayers
*/
int OAI_GetIsMindFlayer(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 413: nCheck = TRUE; break;
    case 414: nCheck = TRUE; break;
    case 415: nCheck = TRUE; break;
    case 1052: nCheck = TRUE; break;
    case 1219: nCheck = TRUE; break;
    case 1220: nCheck = TRUE; break;
    case 1221: nCheck = TRUE; break;
    case 1222: nCheck = TRUE; break;
    case 1223: nCheck = TRUE; break;
    case 1224: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_MINDFLAYER")) nCheck = TRUE;

  return nCheck;
}

/*
  Spiders
*/
int OAI_GetIsSpider(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 157: nCheck = TRUE; break;
    case 158: nCheck = TRUE; break;
    case 159: nCheck = TRUE; break;
    case 160: nCheck = TRUE; break;
    case 161: nCheck = TRUE; break;
    case 162: nCheck = TRUE; break;
    case 166: nCheck = TRUE; break;
    case 422: nCheck = TRUE; break;
    case 1142: nCheck = TRUE; break;
    case 1168: nCheck = TRUE; break;
    case 1197: nCheck = TRUE; break;
    case 1198: nCheck = TRUE; break;
    case 1199: nCheck = TRUE; break;
    case 1200: nCheck = TRUE; break;
    case 1201: nCheck = TRUE; break;
    case 1202: nCheck = TRUE; break;
    case 1203: nCheck = TRUE; break;
    case 1204: nCheck = TRUE; break;
    case 1205: nCheck = TRUE; break;
    case 1206: nCheck = TRUE; break;
    case 1207: nCheck = TRUE; break;
    case 1208: nCheck = TRUE; break;
    case 1209: nCheck = TRUE; break;
    case 1210: nCheck = TRUE; break;
    case 1211: nCheck = TRUE; break;
    case 1212: nCheck = TRUE; break;
    case 1213: nCheck = TRUE; break;
    case 1214: nCheck = TRUE; break;
    case 1248: nCheck = TRUE; break;
    case 1256: nCheck = TRUE; break;
    case 1284: nCheck = TRUE; break;
    case 1311: nCheck = TRUE; break;
    case 1312: nCheck = TRUE; break;
    case 1313: nCheck = TRUE; break;
    case 1314: nCheck = TRUE; break;
    case 1315: nCheck = TRUE; break;
    case 1433: nCheck = TRUE; break;
    case 1894: nCheck = TRUE; break;
    case 1895: nCheck = TRUE; break;
    case 1896: nCheck = TRUE; break;
    case 1897: nCheck = TRUE; break;
    case 1898: nCheck = TRUE; break;
    case 1899: nCheck = TRUE; break;
    case 1900: nCheck = TRUE; break;
    case 1901: nCheck = TRUE; break;
    case 1902: nCheck = TRUE; break;
    case 1903: nCheck = TRUE; break;
    case 1904: nCheck = TRUE; break;
    case 1906: nCheck = TRUE; break;
    case 1907: nCheck = TRUE; break;
    case 1908: nCheck = TRUE; break;
    case 1909: nCheck = TRUE; break;
    case 1910: nCheck = TRUE; break;
    case 1912: nCheck = TRUE; break;
    case 1913: nCheck = TRUE; break;
    case 1914: nCheck = TRUE; break;
    case 1915: nCheck = TRUE; break;
    case 1916: nCheck = TRUE; break;
    case 1918: nCheck = TRUE; break;
    case 1919: nCheck = TRUE; break;
    case 1920: nCheck = TRUE; break;
    case 1921: nCheck = TRUE; break;
    case 1922: nCheck = TRUE; break;
    case 1935: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_SPIDER")) nCheck = TRUE;

  return nCheck;
}

/*
  Geletanous Cube
*/
int OAI_GetIsGelCube(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 470: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_GELCUBE")) nCheck = TRUE;

  return nCheck;
}

/*
  All manner of Oozes, Puddings, Jellys, Slimes, and Slithering Trackers
*/
int OAI_GetIsOoze(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 393: nCheck = TRUE; break;
    case 394: nCheck = TRUE; break;
    case 396: nCheck = TRUE; break;
    case 398: nCheck = TRUE; break;
    case 1453: nCheck = TRUE; break;
    case 1454: nCheck = TRUE; break;
    case 1455: nCheck = TRUE; break;
    case 1456: nCheck = TRUE; break;
    case 1457: nCheck = TRUE; break;
    case 1458: nCheck = TRUE; break;
    case 1459: nCheck = TRUE; break;
    case 1460: nCheck = TRUE; break;
    case 1461: nCheck = TRUE; break;
    case 1462: nCheck = TRUE; break;
    case 1463: nCheck = TRUE; break;
    case 1464: nCheck = TRUE; break;
    case 1465: nCheck = TRUE; break;
    case 1466: nCheck = TRUE; break;
    case 1467: nCheck = TRUE; break;
    case 1468: nCheck = TRUE; break;
    case 1469: nCheck = TRUE; break;
    case 1470: nCheck = TRUE; break;
    case 1471: nCheck = TRUE; break;
    case 1472: nCheck = TRUE; break;
    case 1473: nCheck = TRUE; break;
    case 1474: nCheck = TRUE; break;
    case 1475: nCheck = TRUE; break;
    case 1476: nCheck = TRUE; break;
    case 1477: nCheck = TRUE; break;
    case 1478: nCheck = TRUE; break;
    case 1479: nCheck = TRUE; break;
    case 1480: nCheck = TRUE; break;
    case 1481: nCheck = TRUE; break;
    case 1482: nCheck = TRUE; break;
    case 1483: nCheck = TRUE; break;
    case 1484: nCheck = TRUE; break;
    case 1485: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_OOZE")) nCheck = TRUE;

  return nCheck;
}

/*
  Puddings
*/
int OAI_GetIsOozePudding(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 1465: nCheck = TRUE; break;
    case 1466: nCheck = TRUE; break;
    case 1467: nCheck = TRUE; break;
    case 1468: nCheck = TRUE; break;
    case 1469: nCheck = TRUE; break;
    case 1470: nCheck = TRUE; break;
    case 1471: nCheck = TRUE; break;
    case 1472: nCheck = TRUE; break;
    case 1473: nCheck = TRUE; break;
    case 1474: nCheck = TRUE; break;
    case 1475: nCheck = TRUE; break;
    case 1476: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_OOZE_PUDDING")) nCheck = TRUE;

  return nCheck;
}

/*
  Jellys
*/
int OAI_GetIsOozeJelly(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 394: nCheck = TRUE; break;
    case 396: nCheck = TRUE; break;
    case 398: nCheck = TRUE; break;
    case 1453: nCheck = TRUE; break;
    case 1454: nCheck = TRUE; break;
    case 1455: nCheck = TRUE; break;
    case 1456: nCheck = TRUE; break;
    case 1457: nCheck = TRUE; break;
    case 1458: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_OOZE_JELLY")) nCheck = TRUE;

  return nCheck;
}

/*
  Ooze, Slimes, and Slithering Trackers
*/
int OAI_GetIsOozeSlime(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 393: nCheck = TRUE; break;
    case 1459: nCheck = TRUE; break;
    case 1460: nCheck = TRUE; break;
    case 1461: nCheck = TRUE; break;
    case 1462: nCheck = TRUE; break;
    case 1463: nCheck = TRUE; break;
    case 1464: nCheck = TRUE; break;
    case 1477: nCheck = TRUE; break;
    case 1478: nCheck = TRUE; break;
    case 1479: nCheck = TRUE; break;
    case 1480: nCheck = TRUE; break;
    case 1481: nCheck = TRUE; break;
    case 1482: nCheck = TRUE; break;
    case 1483: nCheck = TRUE; break;
    case 1484: nCheck = TRUE; break;
    case 1485: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_OOZE_SLIME")) nCheck = TRUE;

  return nCheck;
}

/*
  Natural Blinking Creatures
*/
int OAI_GetIsBlinker(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 160: nCheck = TRUE; break;
    case 174: nCheck = TRUE; break;
    case 1315: nCheck = TRUE; break;
    case 1906: nCheck = TRUE; break;
    case 1907: nCheck = TRUE; break;
    case 1908: nCheck = TRUE; break;
    case 1909: nCheck = TRUE; break;
    case 1910: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_BLINKER")) nCheck = TRUE;

  return nCheck;
}

/*
  Zombies and Ghouls
*/
int OAI_GetIsZombie(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 76: nCheck = TRUE; break;
    case 77: nCheck = TRUE; break;
    case 88: nCheck = TRUE; break;
    case 195: nCheck = TRUE; break;
    case 196: nCheck = TRUE; break;
    case 197: nCheck = TRUE; break;
    case 198: nCheck = TRUE; break;
    case 199: nCheck = TRUE; break;
    case 1048: nCheck = TRUE; break;
    case 1059: nCheck = TRUE; break;
    case 1439: nCheck = TRUE; break;
    case 1443: nCheck = TRUE; break;
    case 1444: nCheck = TRUE; break;
    case 1448: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_ZOMBIE")) nCheck = TRUE;

  return nCheck;
}

/*
  Ghosts
*/
int OAI_GetIsGhost(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 162: nCheck = TRUE; break;
    case 186: nCheck = TRUE; break;
    case 187: nCheck = TRUE; break;
    case 1066: nCheck = TRUE; break;
    case 1095: nCheck = TRUE; break;
    case 1096: nCheck = TRUE; break;
    case 1099: nCheck = TRUE; break;
    case 1100: nCheck = TRUE; break;
    case 1256: nCheck = TRUE; break;
    case 1259: nCheck = TRUE; break;
    case 1449: nCheck = TRUE; break;
    case 1918: nCheck = TRUE; break;
    case 1919: nCheck = TRUE; break;
    case 1920: nCheck = TRUE; break;
    case 1921: nCheck = TRUE; break;
    case 1922: nCheck = TRUE; break;
    case 3100: nCheck = TRUE; break;
    case 3101: nCheck = TRUE; break;
    case 3102: nCheck = TRUE; break;
    case 3103: nCheck = TRUE; break;
    case 3104: nCheck = TRUE; break;
    case 3105: nCheck = TRUE; break;
    case 3106: nCheck = TRUE; break;
    case 3107: nCheck = TRUE; break;
    case 3108: nCheck = TRUE; break;
    case 3109: nCheck = TRUE; break;
    case 3110: nCheck = TRUE; break;
    case 3111: nCheck = TRUE; break;
    case 3112: nCheck = TRUE; break;
    case 3113: nCheck = TRUE; break;
    case 3114: nCheck = TRUE; break;
    case 3115: nCheck = TRUE; break;
    case 3116: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_GHOST")) nCheck = TRUE;

  return nCheck;
}

/*
  Beetles and Other Burrowing Creatures
*/
int OAI_GetIsBurrower(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 17: nCheck = TRUE; break;
    case 18: nCheck = TRUE; break;
    case 19: nCheck = TRUE; break;
    case 20: nCheck = TRUE; break;
    case 168: nCheck = TRUE; break;
    case 360: nCheck = TRUE; break;
    case 361: nCheck = TRUE; break;
    case 362: nCheck = TRUE; break;
    case 363: nCheck = TRUE; break;
    case 1169: nCheck = TRUE; break;
    case 1170: nCheck = TRUE; break;
    case 1185: nCheck = TRUE; break;
    case 1186: nCheck = TRUE; break;
    case 1187: nCheck = TRUE; break;
    case 1188: nCheck = TRUE; break;
    case 1189: nCheck = TRUE; break;
    case 1190: nCheck = TRUE; break;
    case 1191: nCheck = TRUE; break;
    case 1192: nCheck = TRUE; break;
    case 1193: nCheck = TRUE; break;
    case 1194: nCheck = TRUE; break;
    case 1195: nCheck = TRUE; break;
    case 1196: nCheck = TRUE; break;
    case 1243: nCheck = TRUE; break;
    case 1244: nCheck = TRUE; break;
    case 1245: nCheck = TRUE; break;
    case 1246: nCheck = TRUE; break;
    case 1247: nCheck = TRUE; break;
    case 1263: nCheck = TRUE; break;
    case 1283: nCheck = TRUE; break;
    case 1416: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_BURROWER")) nCheck = TRUE;

  return nCheck;
}

/*
  Beetles and Other Burrowing Creatures
*/
int OAI_GetIsLargeBurrower(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 17: nCheck = TRUE; break;
    case 18: nCheck = TRUE; break;
    case 19: nCheck = TRUE; break;
    case 20: nCheck = TRUE; break;
    case 168: nCheck = TRUE; break;
    case 360: nCheck = TRUE; break;
    case 361: nCheck = TRUE; break;
    case 362: nCheck = TRUE; break;
    case 363: nCheck = TRUE; break;
    case 1187: nCheck = TRUE; break;
    case 1190: nCheck = TRUE; break;
    case 1193: nCheck = TRUE; break;
    case 1196: nCheck = TRUE; break;
    case 1263: nCheck = TRUE; break;
    case 1416: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_LARGE_BURROWER")) nCheck = TRUE;

  return nCheck;
}

/*
  Beetles and Other Burrowing Creatures
*/
int OAI_GetIsSmallBurrower(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 1169: nCheck = TRUE; break;
    case 1170: nCheck = TRUE; break;
    case 1185: nCheck = TRUE; break;
    case 1186: nCheck = TRUE; break;
    case 1188: nCheck = TRUE; break;
    case 1189: nCheck = TRUE; break;
    case 1191: nCheck = TRUE; break;
    case 1192: nCheck = TRUE; break;
    case 1194: nCheck = TRUE; break;
    case 1195: nCheck = TRUE; break;
    case 1243: nCheck = TRUE; break;
    case 1244: nCheck = TRUE; break;
    case 1245: nCheck = TRUE; break;
    case 1246: nCheck = TRUE; break;
    case 1247: nCheck = TRUE; break;
    case 1283: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_SMALL_BURROWER")) nCheck = TRUE;

  return nCheck;
}

/*
  Myconid and Other Spore Type Creatures
*/
int OAI_GetIsMycon(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 1055: nCheck = TRUE; break;
    case 1056: nCheck = TRUE; break;
    case 1057: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_MYCON")) nCheck = TRUE;

  return nCheck;
}

/*
  Myconid and Other Spore Type Creatures That Spawn Little Spores
*/
int OAI_GetIsMyconSpawner(object oCreature)
{
  int nCheck = FALSE;
  int nApp = GetAppearanceType(oCreature);
  switch(nApp)
  {
    case 1055: nCheck = TRUE; break;
    case 1057: nCheck = TRUE; break;
  }

  if(GetLocalInt(oCreature,"OAI_MYCON_SPAWNER")) nCheck = TRUE;

  return nCheck;
}

//void main (){}
