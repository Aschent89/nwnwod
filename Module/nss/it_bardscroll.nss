//::///////////////////////////////////////////////
//:: Bard Scroll
//:: it_bardscroll
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*


*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-10
//:://////////////////////////////////////////////
#include "x2_inc_switches"

string DescribeHelpSong(int nSong)
{ string sResult= "Inspire Ally";
  switch(nSong)
  { case 0: sResult="Inspire Ally"; break;
    case 1: sResult="Sharp Note - Pierce/Slashing become Keen"; break;
    case 2: sResult="Crescendo - Attack Increase"; break;
    case 3: sResult="Allegro - Movement Speed Increase"; break;
    case 4: sResult="Hymn of Praise - AC Bonus vs. Evil"; break;
    case 5: sResult="Infernal Threnody - AC Bonus vs. Good"; break;
    case 6: sResult="Song of Fury - Induce Rage in Allies"; break;
    case 7: sResult="Burning Bravura - Fire Damage Bonus"; break;
    case 8: sResult="Icy Ayre - Cold Damage Bonus"; break;
    case 9: sResult="Lyrical Lightning - Electrical Damage Bonus"; break;
    case 10: sResult="Corrosive Chorus - Acid Damage Bonus"; break;
    case 11: sResult="Sonorous Sequence - Sonic Damage Bonus"; break;
    case 12: sResult=""; break;  //No Song
    case 13: sResult="Absonant Echos - Immunity vs. Sonic"; break;
    case 14: sResult="Heat of Harmony - Immunity vs. Fire"; break;
    case 15: sResult="Temperate Concord - Immunity vs. Cold"; break;
    case 16: sResult="Insulating Aria - Immunity vs. Electricity"; break;
    case 17: sResult="Bravura of Bases - Immunity vs. Acid"; break;
    case 18: sResult="Celestial Concerto - Regenerate Health"; break;
    case 19: sResult="Bombastic Brawl - Bludge gain Massive Crit/Gauntlets gain Damage"; break;
  }

return sResult;
}

string DescribeCurseSong(int nSong)
{ string sResult = "Curse Song";
  switch(nSong)
  { case 0: sResult="Curse Song"; break;
    case 1: sResult="Revealing Melody - Reduce Stealth"; break;
    case 2: sResult="Fortissimo - Weaken vs. Sonic"; break;
    case 3: sResult="Jarring Tune - Spell Interrupt"; break;
    case 4: sResult="Discordant Air - Enhancement Penalty"; break;
    case 5: sResult="Insidious Rhythm - Spell Failure"; break;
    case 6: sResult="Unceremonius Rhapsody - Sonic Damage"; break;
    case 7: sResult="Calumny - Blacken Reputation"; break;
    case 8: sResult="Immolating Libretto - Weaken vs. Fire"; break;
    case 9: sResult="Freezing Ayre - Weaken vs. Cold"; break;
    case 10: sResult="Cantata of Conduction - Weaken vs. Electricity"; break;
    case 11: sResult="Stinging Lament - Weaken vs. Acid"; break;
    case 12: sResult="Psalm of Dawn - Weaken vs. Divine"; break;
    case 13: sResult="Fouling Chant - Weaken vs. Negative"; break;
    case 14: sResult="Dissonant Dirge - Reduce Spell Resist"; break;
    case 15: sResult="Insipid Oration - Reduce Turn Resist"; break;
    case 16: sResult="Animal Anthem - Polymorph Animals"; break;
  }
return sResult;
}

void main()
{ int nEvent =GetUserDefinedItemEventNumber();

  if (nEvent ==  X2_ITEM_EVENT_ACTIVATE)
  { object oPC   = GetItemActivator();
    object oItem = GetItemActivated();
    string sName = GetName(oItem);

    if(sName=="Verses of the Goddess") //All Help Songs
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==19) nCycle = 0;
      else if(nCycle==12) nCycle = 13;
      else nCycle++;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Dissenting Voices") //All Curse Songs
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==16) nCycle = 0;
      else nCycle++;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Sharp Note") //Sharp Note Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==1) nCycle=0;
      else nCycle=1;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Celia's Crescendo") //Crescendo Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==2) nCycle=0;
      else nCycle=2;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Allegro") //Allegro Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==3) nCycle=0;
      else nCycle=3;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Hymn of Praise") //Hymn of Praise Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==4) nCycle=0;
      else nCycle=4;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Infernal Threnody") //Infernal Threnody Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==5) nCycle=0;
      else nCycle=5;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Song of Fury") //Song of Fury Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==6) nCycle=0;
      else nCycle=6;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Bann's Burning Bravura") //Burning Bravura Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==7) nCycle=0;
      else nCycle=7;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Ilia's Icy Ayre") //Icy Ayre Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==8) nCycle=0;
      else nCycle=8;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Lupin's Lyrical Lightning") //Lyrical Lightning Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==9) nCycle=0;
      else nCycle=9;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Carlin's Corrosive Chorus") //Corrosive Chorus Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==10) nCycle=0;
      else nCycle=10;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Celine's Sonorous Sequence") //Sonorous Sequence Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==11) nCycle=0;
      else nCycle=11;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="  ") //No Song ---------------
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==12) nCycle=0;
      else nCycle=12;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Alicia's Absonant Echo") //Absonant Echos Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==13) nCycle=0;
      else nCycle=13;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Kilana's Heat of Harmony") //Heat of Harmony Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==14) nCycle=0;
      else nCycle=14;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Towal's Temperate Concord") //Temperate Concord Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==15) nCycle=0;
      else nCycle=15;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Liam's Insulating Aria") //Insulating Aria Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==16) nCycle=0;
      else nCycle=16;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Bravura of Bases") //Bravura of Bases Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==17) nCycle=0;
      else nCycle=17;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Celestial Concerto") //Celestial Concerto Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==18) nCycle=0;
      else nCycle=18;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
    else if(sName=="Bard Song: Bruno's Bombastic Brawl") //Bombastic Brawl Toggle
    { int nCycle = GetLocalInt(oPC, "HELPSONG");
      if(nCycle==19) nCycle=0;
      else nCycle=19;
      SetLocalInt(oPC, "HELPSONG", nCycle);
      SendMessageToPC(oPC, DescribeHelpSong(nCycle));
      return;
    }
//::  Curse Songs
    else if(sName=="Curse Song: Revealing Melody") //Revealing Melody Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==1) nCycle=0;
      else nCycle=1;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Fortissimo") //Fortissimo Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==2) nCycle=0;
      else nCycle=2;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Jarring Tune") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==3) nCycle=0;
      else nCycle=3;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Discordant Air") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==4) nCycle=0;
      else nCycle=4;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Insidious Rhythm") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==5) nCycle=0;
      else nCycle=5;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Unceremonius Rhapsody") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==6) nCycle=0;
      else nCycle=6;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Calumny") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==7) nCycle=0;
      else nCycle=7;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Immolating Libretto") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==8) nCycle=0;
      else nCycle=8;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Freezing Ayre") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==9) nCycle=0;
      else nCycle=9;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Cantata of Conduction") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==10) nCycle=0;
      else nCycle=10;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Stinging Lament") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==11) nCycle=0;
      else nCycle=11;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Psalm of Dawn") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==12) nCycle=0;
      else nCycle=12;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Fouling Chant") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==13) nCycle=0;
      else nCycle=13;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Dissonant Dirge") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==14) nCycle=0;
      else nCycle=14;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Igor's Insipid Oration") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==15) nCycle=0;
      else nCycle=15;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
    else if(sName=="Curse Song: Argot's Animal Anthem") // Toggle
    { int nCycle = GetLocalInt(oPC, "CURSESONG");
      if(nCycle==16) nCycle=0;
      else nCycle=16;
      SetLocalInt(oPC, "CURSESONG", nCycle);
      SendMessageToPC(oPC, DescribeCurseSong(nCycle));
      return;
    }
  }
}

