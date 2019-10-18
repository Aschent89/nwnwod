#include "x2_inc_toollib"
//#include "nw_i0_henchman"
#include "nw_i0_plot"
#include "x2_inc_itemprop"
#include "nw_i0_spells"
#include "nbde_inc"

/* This first section is used to set up the lycanthrope ability to
    sense (scent) a being's true form
  The facing value (0-360) sets the compass direction.

*/
void GetDirection(float fFacing, object oDCreature, object oCritter)
{
    if (fFacing >= 360.0)
        fFacing  =  720.0 - fFacing;
    if (fFacing <    0.0)
        fFacing += (360.0);
    int iFacing = FloatToInt(fFacing);
    string sDirection = "";
    if((iFacing >= 359) && (iFacing <=   2))
        sDirection = "East";
    if((iFacing >=   3) && (iFacing <=  45))
        sDirection = "East NorthEast";
    if((iFacing >=  46) && (iFacing <=  87))
        sDirection = "North NorthEast";
    if((iFacing >=  88) && (iFacing <=  92))
        sDirection = "North";
    if((iFacing >=  93) && (iFacing <= 135))
        sDirection = "North NorthWest";
    if((iFacing >= 136) && (iFacing <= 177))
        sDirection = "West NorthWest";
    if((iFacing >= 178) && (iFacing <= 182))
        sDirection = "West";
    if((iFacing >= 183) && (iFacing <= 225))
        sDirection = "West SouthWest";
    if((iFacing >= 226) && (iFacing <= 267))
        sDirection = "South SouthWest";
    if((iFacing >= 268) && (iFacing <= 272))
        sDirection = "South";
    if((iFacing >= 273) && (iFacing <= 315))
        sDirection = "South SouthEast";
    if((iFacing >= 316) && (iFacing <= 358))
        sDirection = "East SouthEast";
    string sRace;
    if (GetRacialType(oCritter) == RACIAL_TYPE_ABERRATION) sRace="An aberration";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ALL) sRace="A creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ANIMAL) sRace="An animal";
    if (GetRacialType(oCritter) == RACIAL_TYPE_BEAST) sRace="A beast";
    if (GetRacialType(oCritter) == RACIAL_TYPE_CONSTRUCT) sRace="A construct";
    if (GetRacialType(oCritter) == RACIAL_TYPE_DRAGON) sRace="A dragon";
    if (GetRacialType(oCritter) == RACIAL_TYPE_DWARF) sRace="A dwarf";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ELEMENTAL) sRace="An elemental";
    if (GetRacialType(oCritter) == RACIAL_TYPE_ELF) sRace="An elf";
    if (GetRacialType(oCritter) == RACIAL_TYPE_FEY) sRace="A fey";
    if (GetRacialType(oCritter) == RACIAL_TYPE_GIANT) sRace="A giant";
    if (GetRacialType(oCritter) == RACIAL_TYPE_GNOME) sRace="A gnome";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HALFELF) sRace="A half-elf";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HALFLING) sRace="A halfling";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HALFORC) sRace="A half-orc";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMAN) sRace="A human";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_GOBLINOID) sRace="A goblinlike creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_MONSTROUS) sRace="A monstrous creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_ORC) sRace="An orclike creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_HUMANOID_REPTILIAN) sRace="A reptilianlike creature";
    if (GetRacialType(oCritter) == RACIAL_TYPE_INVALID) sRace="An odd thing";
    if ((GetRacialType(oCritter) == RACIAL_TYPE_MAGICAL_BEAST) && (GetStringLeft(GetTag(oCritter), 5) != "Plant")) sRace="A very unusual creature";
    if ((GetRacialType(oCritter) == RACIAL_TYPE_MAGICAL_BEAST) && (GetStringLeft(GetTag(oCritter), 5) == "Plant")) sRace="A sentient plantform";
    if (GetRacialType(oCritter) == RACIAL_TYPE_OUTSIDER) sRace="An outsider";
    if (GetRacialType(oCritter) == RACIAL_TYPE_SHAPECHANGER) sRace="A possible shapechanger";
    if (GetRacialType(oCritter) == RACIAL_TYPE_UNDEAD) sRace="An undead";
    if (GetRacialType(oCritter) == RACIAL_TYPE_VERMIN) sRace="A vermin";
    if (GetRacialType(oCritter) == RACIAL_TYPE_OOZE) sRace="An ooze";
    SendMessageToPC(oDCreature,sRace+" is to the "+sDirection);
    if (HasItem(oCritter, "FALLEN_VAMPIRE_FANGS"))
    {
    SendMessageToPC(oDCreature," and they are cursed with vampirism.");
    }
    if (HasItem(oCritter, "Lycanthropy"))
    {
    SendMessageToPC(oDCreature," and they are blessed with lycanthropy.");
    }
    if (HasItem(oCritter, "Ghoul"))
    {
    SendMessageToPC(oDCreature," and they are a ghoul.");
    }
    if (HasItem(oCritter, "TheSickness"))
    {
    SendMessageToPC(oDCreature," and they are tainted with The Sickness.");
    }
    if (HasItem(oCritter, "Wraith"))
    {
    SendMessageToPC(oDCreature," and they are long dead.");
    }
if (GetTag(oItem)=="gar_phillvl2")
                    {

                        int nDC;
                        object oDCreature=GetItemActivator();
                        object oCritter;
                        object oCritter2;
                        int nLevel=GetHitDice(oDCreature);
                        int nCnt=1;
                        int nCnt2=1;
                        float fDistance;
                        int nDCAdj;
                        vector vCritter;
                        vector vCritter2;
                        oCritter=GetNearestObject(OBJECT_TYPE_CREATURE, oDCreature, nCnt);
                        while(GetIsObjectValid(oCritter) &&  (GetArea(oCritter)==oArea))
                        {
                            //Set overall difficulty of detecting here
                            fDistance=GetDistanceBetween(oCritter, oDCreature);
                            if  (GetIsAreaAboveGround(oArea) &&
                              GetIsAreaNatural(oArea))
                              {
                              nDCAdj=FloatToInt(fDistance/10.0);
                              }
                            else    //Harder when not in natural setting
                            {
                            nDCAdj=FloatToInt(fDistance/5.0);
                            }


                            if((d20()+nLevel) > (nDC+nDCAdj))
                            {
                                vCritter=GetPosition(oCritter);
                                AssignCommand(oDCreature,SetFacingPoint (vCritter));
                                AssignCommand(oDCreature,GetDirection(GetFacing(oDCreature),oDCreature,
                                    oCritter));
                            }
                            nCnt++;
                            oCritter=GetNearestObject(OBJECT_TYPE_CREATURE, oDCreature, nCnt);
                        }
                        oCritter2=GetNearestObject(OBJECT_TYPE_CREATURE, oDCreature, nCnt2);
                        vCritter2=GetPosition(oCritter2);
                        AssignCommand(oDCreature,SetFacingPoint (vCritter2));

                   }


    return ;
}
