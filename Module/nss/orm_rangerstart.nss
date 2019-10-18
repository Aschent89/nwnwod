////////////////////////////////////////////////////////////////////////////////
//
//  Olander's Realistic Systems Resting Menu
//  orm_rangerstart
//  By Don Anderson
//  dandersonru@msn.com
//
//  Called from ORM Convo
//
////////////////////////////////////////////////////////////////////////////////

#include "orm_inc"

string lessdetailedrace(object oTarg)
{
  string type;
  switch(GetRacialType(oTarg))
  {
    case RACIAL_TYPE_HUMAN:type="humanoid";break;
    case RACIAL_TYPE_HALFORC:type="humanoid";break;
    case RACIAL_TYPE_HALFLING:type="humanoid";break;
    case RACIAL_TYPE_HALFELF:type="humanoid";break;
    case RACIAL_TYPE_GNOME:type="humanoid";break;
    case RACIAL_TYPE_GIANT:type="giant";break;
    case RACIAL_TYPE_FEY:type="humanoid";break;
    case RACIAL_TYPE_ELF:type="humanoid";break;
    case RACIAL_TYPE_DWARF:type="humanoid";break;
    case RACIAL_TYPE_DRAGON:type="dragon";break;
    case RACIAL_TYPE_CONSTRUCT:type="golem";break;
    case RACIAL_TYPE_BEAST: type=GetName(oTarg);break;
    case RACIAL_TYPE_ANIMAL:type=GetName(oTarg);break;
    case RACIAL_TYPE_UNDEAD:type="humanoid";break;
    case RACIAL_TYPE_VERMIN:type="rodent";break;
    case RACIAL_TYPE_HUMANOID_GOBLINOID:type="goblin";break;
    case RACIAL_TYPE_HUMANOID_MONSTROUS:type="monster";break;
    case RACIAL_TYPE_HUMANOID_ORC:type="humanoid";break;
    case RACIAL_TYPE_OOZE:"slime";break;
    default: type="unknown creature";break;
  }
  return type;
}

string race(object oTarg)
{
  string type;
  switch(GetRacialType(oTarg))
  {
    case RACIAL_TYPE_HUMAN:type="human";break;
    case RACIAL_TYPE_HALFORC:type="half-orc";break;
    case RACIAL_TYPE_HALFLING:type="halfling";break;
    case RACIAL_TYPE_HALFELF:type="half-elf";break;
    case RACIAL_TYPE_GNOME:type="gnome";break;
    case RACIAL_TYPE_GIANT:type="giant";break;
    case RACIAL_TYPE_FEY:type="fey";break;
    case RACIAL_TYPE_ELF:type="elf";break;
    case RACIAL_TYPE_DWARF:type="dwarf";break;
    case RACIAL_TYPE_DRAGON:type="dragon";break;
    case RACIAL_TYPE_CONSTRUCT:type="golem";break;
    case RACIAL_TYPE_BEAST: type=GetName(oTarg);break;
    case RACIAL_TYPE_ANIMAL:type=GetName(oTarg);break;
    case RACIAL_TYPE_UNDEAD:type="undead humanoid";break;
    case RACIAL_TYPE_VERMIN:type="rodent";break;
    case RACIAL_TYPE_HUMANOID_GOBLINOID:type="goblin";break;
    case RACIAL_TYPE_HUMANOID_MONSTROUS:type="monster";break;
    case RACIAL_TYPE_HUMANOID_ORC:type="orc";break;
    case RACIAL_TYPE_OOZE:"slime";break;
    default: type="unknown creature";break;
  }
  return type;
}

void main()
{
  object oPC=GetPCSpeaker();
  object currentarea=GetArea(oPC);

  if(currentarea==GetLocalObject(oPC,"oldarea"))
  {
    SetCustomToken(8100,"You cannot use this ability more than twice in a row in the same area.");
    return;
  }
  else SetLocalObject(oPC,"oldarea",currentarea);

  location lTarget = GetLocation(oPC);
  int rangerlevels=GetLevelByClass(CLASS_TYPE_RANGER,oPC);
  float trackdist=24.0f+IntToFloat(4*rangerlevels);
  int maxtypes=3+(rangerlevels*2);
  int types=1;

  string message="",oldmessage="old",newmessage;
  string size;
  string type;
  string pronoun1;
  string pronoun2;
  string verb;
  string newresref;
  string oldresref;
  string armed;
  string armor;
  message+="";
  object oTarget = GetFirstObjectInShape(SHAPE_SPHERE, trackdist, lTarget, TRUE, OBJECT_TYPE_CREATURE);
  while (oTarget!=OBJECT_INVALID && types<maxtypes)
  {
    armor=".";
    int targLevel=GetHitDice(oTarget);
    if(targLevel>20) size="huge";
    else if(targLevel>15) size="large";
    else if(targLevel>10) size="moderate sized";
    else if(targLevel>5) size="typical";
    else size="common";

    if(rangerlevels>=3) type=race(oTarget);
    else type=lessdetailedrace(oTarget);

    int weaponvalue=GetGoldPieceValue(GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oTarget));
    if(weaponvalue>75) armed="heavily ";
    else if(weaponvalue>50) armed="well ";
    else armed="un";

    newresref=GetResRef(oTarget);
    if(newresref==oldresref)
    {
      pronoun1="a group of";
      pronoun2="s";
      verb="they are";
      if(type=="elf") type="elve";
    }
    else
    {
      pronoun1="a";
      pronoun2="";
      verb="it is";
    }

    if(rangerlevels>=8)
    {
      if(GetHasFeat(FEAT_ARMOR_PROFICIENCY_HEAVY,oTarget)) armor=" and "+verb+" obviously clad in heavy metal armor.";
      else if(GetHasFeat(FEAT_ARMOR_PROFICIENCY_MEDIUM,oTarget)) armor=" and "+verb+" probably wearing lightweight, leathery armor.";
      else armor=" and "+verb+" wearing little or no armor at all.";
    }

    newmessage="tracks of "+pronoun1+" "+size+" "+type+pronoun2+" are here, "+verb+" probably "+armed+"armed"+armor+"\n\n";
    if(newmessage!=oldmessage)
    {
      oldmessage=newmessage;
      message+=newmessage;
    }

    types++;
    oTarget = GetNextObjectInShape(SHAPE_SPHERE, trackdist, lTarget, TRUE, OBJECT_TYPE_CREATURE | OBJECT_TYPE_DOOR | OBJECT_TYPE_PLACEABLE);
  }

  SetCustomToken(8100,message);
}
