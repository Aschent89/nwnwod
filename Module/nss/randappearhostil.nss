#include "00_descriptions"
// Randomizes stats
void RandomizeStats(object oTarget, int iStat, int iIncreaseBy);
//void DressTheNPC(object oNPC);

void RandomizeStats(object oTarget, int iStat, int iIncreaseBy)
{
 int iIncreaseBy;
    iIncreaseBy = d12 (1);
    effect eEffect = EffectAbilityIncrease(iStat, iIncreaseBy);
    ApplyEffectToObject(DURATION_TYPE_PERMANENT, eEffect, oTarget);
}

/*void DressTheNPC(object oNPC)
{
 object oClothing;
 int nRandom = Random(59);
 object oTarget = oNPC;
 AssignCommand(oTarget, ClearAllActions(TRUE));
 switch (nRandom)
     {
      case 0:
          {
          oClothing = CreateItemOnObject("bb_vikingcomdoublet",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 1: //Common Man's Garb  ZEP_COMMON
          {
          oClothing = CreateItemOnObject("ZEP_COMMON",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
     case 2: //Commoner's Outfit CommonersOutfit
          {
          oClothing = CreateItemOnObject("bb_VikingCommonerGown",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 3: //Common Woman's Garb ZEP_COMMONW
          {
          oClothing = CreateItemOnObject("ZEP_COMMONW",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 4: //Arabian Nights Costume ZEP_ARABIAN
          {
          oClothing = CreateItemOnObject("ZEP_ARABIAN",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 5: //Bamboo Kimono  ZEP_KIMONO3
          {
          oClothing = CreateItemOnObject("ZEP_KIMONO3",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 6: //Bell Dress  ZEP_GOWN_BD
          {
          oClothing = CreateItemOnObject("ZEP_GOWN_BD",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 7: //Blacksmith Apron  ZEP_ASMITHY_001
          {
          oClothing = CreateItemOnObject("ZEP_ASMITHY_001",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
     case 8: //Butler's Clothes  ButlersClothes
          {
          oClothing = CreateItemOnObject("bb_vikingwealthydoublet",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 9: //Death Robes  crpi_deathrobe
          {
          oClothing = CreateItemOnObject("NebariYellowCommonerDress",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 10: //Dragon Kimono ZEP_KIMONO2
          {
          oClothing = CreateItemOnObject("ZEP_KIMONO2",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 11: //Evoker's Coat  ZEP_EVOKER
          {
          oClothing = CreateItemOnObject("ZEP_EVOKER",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 12: //Foppish Outfit  ZEP_FOPPISH
          {
          oClothing = CreateItemOnObject("ZEP_FOPPISH",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 13: //Formal Kilt  ZEP_FORMALKILT
          {
          oClothing = CreateItemOnObject("ZEP_FORMALKILT",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 14: //Innkeeper Clothes  InkeeperClothes
          {
          oClothing = CreateItemOnObject("NebariYellowCommonerDress",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 15: //Judoth's Clothing  JudothsClothing
          {
          oClothing = CreateItemOnObject("NebariYellowCommonerDress",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 16: // Lovic's Robes  LovicsRobes
          {
          oClothing = CreateItemOnObject("NebariYellowCommonerDress",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 17: //Monk's Habit  ZEP_MONK
          {
          oClothing = CreateItemOnObject("ZEP_MONK",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 18: //Noblewoman's Gown  ZEP_GOWN
          {
          oClothing = CreateItemOnObject("ZEP_GOWN",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 19: //Regal Kimono ZEP_KIMONO
          {
          oClothing = CreateItemOnObject("ZEP_KIMONO",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 20: //Ribbons Skirt  ZEP_GOWN5
          {
          oClothing = CreateItemOnObject("ZEP_GOWN5",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 21: //Slave's Garb  ZEP_SLAVE
          {
          oClothing = CreateItemOnObject("ZEP_SLAVE",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 22: //Warrior Monk's Outfit  ZEP_WARMONK
          {
          oClothing = CreateItemOnObject("ZEP_WARMONK",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 23: //Wizard's Robes  ZEP_WIZROBES
          {
          oClothing = CreateItemOnObject("ZEP_WIZROBES",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 24: //Adept's Tunic  NW_CLOTH027
          {
          oClothing = CreateItemOnObject("NW_CLOTH027",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 25: //Adventurer's Robe  NW_MCLOTH011
          {
          oClothing = CreateItemOnObject("NW_MCLOTH011",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 26: //Assassin's Garb  NW_CLOTH017
          {
          oClothing = CreateItemOnObject("NW_CLOTH017",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 27: //Barbarian's Outfit  NW_CLOTH015
          {
          oClothing = CreateItemOnObject("NW_CLOTH015",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 28: //Bard's Tunic  NW_CLOTH021
          {
          oClothing = CreateItemOnObject("NW_CLOTH021",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 29: //Cleric's Robe  X2_CLOTH008
          {
          oClothing = CreateItemOnObject("X2_CLOTH008",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 30: //Commoner's Outfit  NW_CLOTH022
          {
          oClothing = CreateItemOnObject("NW_CLOTH022",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 31: //Commoner's Tunic  NW_CLOTH024
          {
          oClothing = CreateItemOnObject("NW_CLOTH024",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 32: //Conjurer's Robe  NW_CLOTH012
          {
          oClothing = CreateItemOnObject("NW_CLOTH012",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 33: //Duergar Mage Robe  X2_MDEURAR010
          {
          oClothing = CreateItemOnObject("X2_MDEURAR010",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 34: //Gladiator's Outfit  NW_CLOTH011
          {
          oClothing = CreateItemOnObject("NW_CLOTH011",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 35: //Illusionist's Robe  NW_CLOTH020
          {
          oClothing = CreateItemOnObject("NW_CLOTH020",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 36: //Jester's Outfit  NW_CLOTH014
          {
          oClothing = CreateItemOnObject("NW_CLOTH014",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 37: //Last Words  x2_cus_lastwords
          {
          oClothing = CreateItemOnObject("vid_quarkclothes1a",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 38: //Monk's Outfit  NW_CLOTH016
          {
          oClothing = CreateItemOnObject("NW_CLOTH016",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 39: //Necromancer's Robe  NW_CLOTH026
          {
          oClothing = CreateItemOnObject("NW_CLOTH026",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 40: //Noble Guardsman Tunic  NW_CLOTH018
          {
          oClothing = CreateItemOnObject("NW_CLOTH018",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 41: //Noble Outfit  NW_CLOTH003
          {
          oClothing = CreateItemOnObject("NW_CLOTH003",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 42: //Noble's Tunic  NW_CLOTH028
          {
          oClothing = CreateItemOnObject("NW_CLOTH028",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 43: //Paladin's Tunic  NW_CLOTH010
          {
          oClothing = CreateItemOnObject("NW_CLOTH010",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
     case 44: //Palemaster's Robe  x2_it_pmrobe
          {
          oClothing = CreateItemOnObject("ZEP_KIMONO",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 45: //Performer's Outfit  NW_CLOTH002
          {
          oClothing = CreateItemOnObject("NW_CLOTH002",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 46: //Priest's Robe  NW_CLOTH007
          {
          oClothing = CreateItemOnObject("NW_CLOTH007",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 47: //Rogue's Tunic  NW_CLOTH004
          {
          oClothing = CreateItemOnObject("NW_CLOTH004",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
    case 48: //Sequencer Robe  x2_sequencer1
          {
          oClothing = CreateItemOnObject("ZEP_GOWN2",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 49: //Shifter Tunic  x2_cus_shiftertunic
          {
          oClothing = CreateItemOnObject("malestrip",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }

      case 50: //Soldier's Tunic  NW_CLOTH019
          {
          oClothing = CreateItemOnObject("NW_CLOTH019",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 51: //Sorcerer's Robe  NW_CLOTH008
          {
          oClothing = CreateItemOnObject("NW_CLOTH008",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 52: //Squire's Tunic  NW_CLOTH013
          {
          oClothing = CreateItemOnObject("NW_CLOTH013",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 53: //Urchin Rags  NW_CLOTH009
          {
          oClothing = CreateItemOnObject("NW_CLOTH009",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 54: //Vagabond Rags  NW_CLOTH023
          {
          oClothing = CreateItemOnObject("NW_CLOTH023",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 55: //Vest of Escape  X0_CLOTH004
          {
          oClothing = CreateItemOnObject("X0_CLOTH004",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 56: //Veteran's Outfit  NW_CLOTH006
          {
          oClothing = CreateItemOnObject("NW_CLOTH006",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 57: //Warrior's Tunic  NW_CLOTH025
          {
          oClothing = CreateItemOnObject("NW_CLOTH025",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      case 58: //Wizard's Robe  NW_CLOTH005
          {
          oClothing = CreateItemOnObject("NW_CLOTH005",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
          }
      default:   //Commoner's Outfit CommonersOutfit
         {
          oClothing = CreateItemOnObject("malestrip",oTarget);
          AssignCommand(oTarget, ActionEquipItem(oClothing,INVENTORY_SLOT_CHEST));
          SetDroppableFlag(oClothing, FALSE);
          break;
         }

     }
     }
 */


void main()
{

object oTarget;
oTarget = OBJECT_SELF;

    int iIncreaseBy1;
    iIncreaseBy1 = d12 (1);
    int iIncreaseBy2;
    iIncreaseBy2 = d12 (1);
    int iIncreaseBy3;
    iIncreaseBy3 = d12 (1);
    int iIncreaseBy4;
    iIncreaseBy4 = d12 (1);
    int iIncreaseBy5;
    iIncreaseBy5 = d12 (1);
    int iIncreaseBy6;
    iIncreaseBy6 = d12 (1);

    RandomizeStats(oTarget, ABILITY_STRENGTH, iIncreaseBy1);
    RandomizeStats(oTarget, ABILITY_DEXTERITY, iIncreaseBy2);
    RandomizeStats(oTarget, ABILITY_WISDOM, iIncreaseBy3);
    RandomizeStats(oTarget, ABILITY_INTELLIGENCE, iIncreaseBy4);
    RandomizeStats(oTarget, ABILITY_CHARISMA, iIncreaseBy5);
    RandomizeStats(oTarget, ABILITY_CONSTITUTION,iIncreaseBy6);

int iFirst, iLast, nRandomHead, iAppearAs;

if (GetGender(oTarget)==GENDER_MALE)
   {
   iAppearAs = APPEARANCE_TYPE_HALFLING;
   iFirst = Random(NAME_FIRST_HALFLING_MALE);
   iLast = Random(NAME_LAST_HALFLING);
   nRandomHead = Random(25)+1;


   iAppearAs = APPEARANCE_TYPE_HUMAN;
   iFirst = Random(NAME_FIRST_HUMAN_MALE);
   iLast = Random(NAME_LAST_HUMAN);
   nRandomHead = Random(99)+1;
   if (nRandomHead>= 49 && nRandomHead<=99)
   {
   nRandomHead = nRandomHead+50;
   }

   iAppearAs = APPEARANCE_TYPE_ELF;
   iFirst = Random(NAME_FIRST_ELF_MALE);
   iLast = Random(NAME_LAST_ELF);
   nRandomHead = Random(34)+1;

   iAppearAs = APPEARANCE_TYPE_HALF_ELF;
   iFirst = Random(NAME_FIRST_HALFELF_MALE);
   iLast = Random(NAME_LAST_HALFELF);
   nRandomHead = Random(48)+1;

   iAppearAs = APPEARANCE_TYPE_HALF_ORC;
   iFirst = Random(NAME_FIRST_HALFORC_MALE);
   iLast = Random(NAME_LAST_HALFORC);
   nRandomHead = Random(24)+1;

   iAppearAs = APPEARANCE_TYPE_GNOME;
   iFirst = Random(NAME_FIRST_GNOME_MALE);
   iLast = Random(NAME_LAST_GNOME);
   nRandomHead = Random(34)+1;

   iAppearAs = APPEARANCE_TYPE_DWARF;
   iFirst = Random(NAME_FIRST_DWARF_MALE);
   iLast = Random(NAME_LAST_DWARF);
   nRandomHead = Random(23)+1;
   }
else if (GetGender(oTarget)==GENDER_FEMALE)
   {
   iAppearAs = APPEARANCE_TYPE_HUMAN;
   iFirst = Random(NAME_FIRST_HUMAN_FEMALE);
   iLast = Random(NAME_LAST_HUMAN);
   nRandomHead = Random(48)+1;

   iAppearAs = APPEARANCE_TYPE_ELF;
   iFirst = Random(NAME_FIRST_ELF_FEMALE);
   iLast = Random(NAME_LAST_ELF);
   nRandomHead = Random(48)+1;

   iAppearAs = APPEARANCE_TYPE_HALF_ELF;
   iFirst = Random(NAME_FIRST_HALFELF_FEMALE);
   iLast = Random(NAME_LAST_HALFELF);
   nRandomHead = Random(48)+1;

   iAppearAs = APPEARANCE_TYPE_HALF_ORC;
   iFirst = Random(NAME_FIRST_HALFORC_FEMALE);
   iLast = Random(NAME_LAST_HALFORC);
   nRandomHead = Random(11)+1;

   iAppearAs = APPEARANCE_TYPE_GNOME;
   iFirst = Random(NAME_FIRST_GNOME_FEMALE);
   iLast = Random(NAME_LAST_GNOME);
   nRandomHead = Random(9)+1;

   iAppearAs = APPEARANCE_TYPE_HALFLING;
   iFirst = Random(NAME_FIRST_HALFLING_FEMALE);
   iLast = Random(NAME_LAST_HALFLING);
   nRandomHead = Random(14)+1;

   iAppearAs = APPEARANCE_TYPE_DWARF;
   iFirst = Random(NAME_FIRST_DWARF_FEMALE);
   iLast = Random(NAME_LAST_DWARF);
   nRandomHead = Random(22)+1;
   }

string sMeBeCalled;
sMeBeCalled = RandomName(iFirst)+" "+RandomName(iLast);
int nRandomSkin;
nRandomSkin = d8 (1);
int nRandomHair;
nRandomHair = Random (24);
int nTatooColor1;
nTatooColor1 = Random (175);
int nTatooColor2;
nTatooColor2 = Random (175);
int nRandomTatoo0;
nRandomTatoo0 = d2(1);
int nRandomTatoo1;
nRandomTatoo1 = d2(1);
int nRandomTatoo2;
nRandomTatoo2 = d2(1);
int nRandomTatoo3;
nRandomTatoo3 = d2(1);
int nRandomTatoo4;
nRandomTatoo4 = d2(1);
int nRandomTatoo5;
nRandomTatoo5 = d2(1);
int nRandomTatoo6;
nRandomTatoo6 = d2(1);
int nRandomTatoo7;
nRandomTatoo7 = d2(1);
int nRandomTatoo8;
nRandomTatoo8 = d2(1);

DelayCommand(1.1, SetCreatureBodyPart(CREATURE_PART_HEAD, nRandomHead, oTarget));
DelayCommand(1.1, SetCreatureBodyPart(CREATURE_PART_LEFT_BICEP, nRandomTatoo0, oTarget));
DelayCommand(1.1, SetCreatureBodyPart(CREATURE_PART_LEFT_FOOT, CREATURE_MODEL_TYPE_SKIN, oTarget));
DelayCommand(1.1, SetCreatureBodyPart(CREATURE_PART_LEFT_FOREARM, nRandomTatoo1, oTarget));
DelayCommand(1.1, SetCreatureBodyPart(CREATURE_PART_LEFT_HAND, CREATURE_MODEL_TYPE_SKIN, oTarget));
DelayCommand(1.2, SetCreatureBodyPart(CREATURE_PART_LEFT_SHIN, nRandomTatoo2, oTarget));
DelayCommand(1.2, SetCreatureBodyPart(CREATURE_PART_LEFT_THIGH, nRandomTatoo3, oTarget));
DelayCommand(1.2, SetCreatureBodyPart(CREATURE_PART_NECK, CREATURE_MODEL_TYPE_SKIN, oTarget));
DelayCommand(1.2, SetCreatureBodyPart(CREATURE_PART_PELVIS, CREATURE_MODEL_TYPE_SKIN, oTarget));
DelayCommand(1.2, SetCreatureBodyPart(CREATURE_PART_RIGHT_BICEP, nRandomTatoo4, oTarget));
DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_RIGHT_FOOT, CREATURE_MODEL_TYPE_SKIN, oTarget));
DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_RIGHT_FOREARM, nRandomTatoo5, oTarget));
DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_RIGHT_HAND, CREATURE_MODEL_TYPE_SKIN, oTarget));
DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_RIGHT_SHIN, nRandomTatoo6, oTarget));
DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_RIGHT_THIGH, nRandomTatoo7, oTarget));
DelayCommand(1.3, SetCreatureBodyPart(CREATURE_PART_TORSO, nRandomTatoo8, oTarget));
SetColor(oTarget, COLOR_CHANNEL_SKIN, nRandomSkin);
SetColor(oTarget, COLOR_CHANNEL_TATTOO_1, nTatooColor1);
SetColor(oTarget, COLOR_CHANNEL_TATTOO_2, nTatooColor2);
SetColor(oTarget, COLOR_CHANNEL_HAIR, nRandomHair);
SetName(oTarget, sMeBeCalled);
DelayCommand(1.0,SetRandomNPCDescription(oTarget));
if (d100()<=33)
   {
   CreateItemOnObject("CommonDirk", oTarget);
   }
if (d100()<=5)
   {
   SetPhenoType(PHENOTYPE_BIG, oTarget);
   }
    object oNPC = oTarget;
//    AssignCommand(oTarget, DressTheNPC(oNPC));

   ExecuteScript("j_def_spawn2", OBJECT_SELF); return;   //Injury system without life bar.  j_def_spawn has the life bar.
 }
