//These are the switches to control the various aspects of the pc vampires

//Vampire Transformation Options
  //This will apply vampirism to anyone entering the module with 'Vampire' as
  //there subrace. I personally don't like this and think they need to catch it
  //on purpose or by accident.
    const int UseSubRaceField = TRUE;
  //This will set the pc's subrace field to be 'Vampire' if/when they catch
  //Vampirism. The old subrace information will be stored and replaced if they
  //ever lose their vampirism.
    const int AlterSubRaceField = TRUE;
  //This will check to see if there are any npc friends of the victim near
  //when the vampire attempts to bite them. If this is set to TRUE the
  //friend will attack the vampire, if false then the friend will ignore
  //the vampire sucking the blood of their friend
    const int CheckForVampireSeen = TRUE;

//Sunlight heartbeat damage
  //The actual damage applied is a random value from 1 to SunDamage + 1. The
  //damage is applied every 30 seconds and is partially divine and partially fire.
  const int SunDamage = 200;
  //Do vampires take damage when it is daylight and Raining or Snowing
    const int DamageInBadWeather = TRUE;

//Spell Option
  //This is a personal thing, since vampires live on blood then they must have moisture
  //in their bodies, thus a vampire should be hurt by horrid wilting since it dries
  //out the targets. Feel free to set it to false if it bothers you though =)
    const int HorridWiltingHurts = TRUE;

//Item Options
  //No touching silver
    const int CannotTouchSilver = TRUE;
  //Holy Water explodes if you touch it
    const int HolyWaterExplodes = TRUE;
  //Wild roses burn you
    const int WildRosesBurn = TRUE;

//Blood Options
  //This will switch all blood creation to use the guaranteed blood types that include
  //the exact type of blood that it is. The default of FALSE, will have all blood types
  //(except for vampires blood) look the same. With this set to FALSE you can have a
  //blood expert or blood shop test and label the quality of your blood for a price.
  //The shop and bloodmonger in the test module will read this setting and identify
  //bloods for a price if this is set to FALSE.
    const int UseGuaranteedBloodTypes = FALSE;
  //This option will require the vampire to have vials of preservation available to
  //store blood from the victims they bite. This will also make it so after using
  //a vial of blood they get an empty vial of preservation in their inventory.
      //Note: One shop included in the test module uses vials of preservation as
            //a part of their system for selling blood.
    const int UseVialOfPreservationSystem = TRUE;

//Blood Need
  //Ah, the cornerstone of the 1.1 update this will make a vampire need to drain blood
  //or they will slowly lose their vampiric abilities (vampire level by vampire
  //level), becomming no more than a human with fangs if they have too long a
  //dry spell. Many options here to customize it to your needs.
    //Here is the master switch for the blood need system to turn it on or off
      const int UseBloodNeedSystem = TRUE;
    //This determines how often they must drink blood, this is in neverwinter hours.
    //Note: the default nwn day is 2 minutes per hour or 48 real life minutes.
    //      If your module uses a different time scale make sure to take that into
    //      account.
      const int BloodNeedDelay = 36;
    //Next is how many hours after the BloodNeedDelay passes until they lose a
    //vampire level. This time loops so after this many hours pass they
    //will lose yet another vampire level. I use 6 hours as a default to give
    //a sense of urgency. Warning: this must not be equal to BloodNeedDelay!!!!
      const int BloodNeedPenalty = 6;
    //If the following is set to true (default) then if a pc's vampire level
    //drops below 21 they lose all their epic abilities until they drink blood
    //again.
      const int BloodNeedAffectEpics = TRUE;

//Coffin Management
  //This will let you disable the picking up of coffins making them permanent
  //fixtures. Choosing 1 below
    const int CannotPickUpCoffins = FALSE;
  //Next we need to determine what to do when a person leaves the module. There
  //are several options here:
    //1. Destroy the coffin and put it in the players inventory for them to place
       //next time they enter the module.
    //2. Destroy the coffin and replace it there the next time the player enters
       //the game. The player will start at the coffin. (if they have one,
       //otherwise they will not be moved)
    //3. Destroy the coffin and replace it there the next time the player enters
       //the game. The player will not be moved from wherever they log into.
    //4. Leave the coffin where it is, it will become unclaimed and the pc will
       //have to find a new coffin once they log back in. They will be moved to
       //the location of that coffin when they enter the game again.
    //5. Leave the coffin where it is, it will become unclaimed and the pc will
       //have to find a new coffin once they log back in. They will not be moved.
    //6. Destroy the coffin, they will have to find/buy another. They will not
       //be moved.
    const int WhatToDoWithTheCoffin = 3;
  //Note: you can change the file the persistant information is stored to in
  //      f_vampirepersist. You can also setup your own persistancy system in
  //      that file.

//Aura Options
  //If UseAuraItem is set to false then the auras will be permanent, otherwise
  //the vampire will have an item that will turn them on or off at will.
    const int UseAuraItem = TRUE;
  //The following are the AOE_ constants to be used in creating the auras
    const int SmallAuraType = AOE_MOB_UNNATURAL;
    const int LargeAuraType = AOE_MOB_DRAGON_FEAR;

//Mist form
  //This allows you to choose what AOE_ to use for the mist form.
    const int MistAOEType = AOE_PER_FOG_OF_BEWILDERMENT;

//Vampire Bite Options
  //This is how many spare hp per bottle of blood (from biting)
    const int HPPerBottle = 45;
  //This is the switch for allowing a PC vampire to turn an npc into a thrall
    const int CanMakeThralls = TRUE;
  //This is what level a pc can begin making thralls at
    const int MakeThrallLevel = 10;
  //This will allow a PC vampire to make more vampires
    const int CanSpreadVampirism = TRUE;
  //This is what level a pc can begin making vampires at
    const int SpreadVampirismLevel = 12;
  //Can drain levels via vampire bite (Adds 1 to every statistic of the vampire
   //and fills their health while leaving their victim alive). Since the victim
   //will stay stunned, asleep, or paralyzed the vampire can then bite them again.
    const int CanDrainLevels = TRUE;
  //This is what level a pc can begin draining levels (default 21)
    const int DrainLevelsLevel = 21;
  //This will allow a pc vampire to give a token to friendly PC's that
  //will turn them into vampires if they use it. The token will destroy
  //itself after 30 seconds if it is not used. Upon use the PC is bitable
  //for 30 seconds, but the rule about not being seen while biting is
  //still in effect.
    const int AllowVampirismToken = TRUE;

//Vampire Leveling

//This will set their vampire level = their character level (no matter what)
  const int UseCharacterLevel = TRUE;
//This will cap their vampire level to their character level
  const int CapVampireLevel = TRUE;
//This is the level that new vampires start at (does not do anything if
//UseCharacterLevel is set to TRUE) Make a call to VampireLevelUp(); in
//the include file f_vampire_h to increase this by one.
  const int VampireStartLevel = 2;

//Epic Vampire Abilities
//These switches will let you turn on or off the vampire epic abilities, a pc
//vampire that has an ability that you have shut off will not get a new ability
//to replace it, they will just no longer be able to use the ability. If your
//feeling kind as a dm you can give them a book of elder vampire advancement
//(located in custom 1) and they can choose another ability. You can also give
//the books as prizes as well, remember the epic abilities are very powerful so
//make the event subtably epic! There is also a book of epic ability reset that
//you as a dm can use to remove all epic abilities from a pc and give them
//the proper number of advancement books at the same time. That book is also in
//custom 1.

//        Improved Thrall - Not just a standard zombie anymore, this thrall will
//                          retain all the abilities of it's original self with
//                          boosted stats based upon your epic vampire level
  const int UseImprovedThrall = TRUE; //setting this to false will disable all epic
                                      //thralls...
//        Unholy Thrall - The best thrall you can make, it not only retains it's
//                        abilities, but will have boosted stats, an aura (or 2,
//                        or 3...), special damage immunities, and even more as
//                        your vampire level increases. You can take this feat a
//                        second time to always maximize the abilities of the
//                        thrall.
  const int UseUnholyThrall = TRUE; //Setting this to false will also disable the
                                    //upgraded unholy thrall...
  const int UseUnholyThrallLevel2 = TRUE;
//        Children of the Night - Summon a creature to assist you. This is a
//                                prequisite for Children of the Damnned. It will
//                                randomly summon a spider lord, plague rat, or
//                                ancient bat.
  const int UseChildrenOfTheNight = TRUE; //setting this to false will disable the
                                          //kin of the damned and twin of the abyss
                                          //as well...
//        Kin of the Damned - Summon an unholy creature to assist you. This is
//                            a prequisite for Children of the Abyss. It will
//                            randomly summon Vengence, Hate or Pain
  const int UseKinOfTheDamned = TRUE; //setting this to false will disable twin
                                      //of the abyss as well...
//        Twin of the Abyss - Summon a kindred spirit from the depths of the abyss
//                            to fight with you. It will randomly summon an Ancient
//                            Shadow Dragon, an Undead Slime, or a Hand of Evil.
  const int UseTwinOfTheAbyss = TRUE;
//        Sunproof - You have aquired enough power to prevent sunlight from harming
//                   you, this makes you rather noticable though as all light will
//                   stay away from you...
  const int UseSunproof = TRUE;
//        Blood of the Land - You will never need to worry about thirsting for
//                            blood again, in fact you absorb the blood spilt in
//                            ages past from the soil giving you a constant regen.
//                            You may take this again to double the regen.
  const int UseBloodOfTheLand = TRUE; //setting this to false will also disable
                                      //the level 2 blood of the land.
  const int UseBloodOfTheLandLevel2 = TRUE;
//        Holy Vampire - If you have managed to work yourself back to good alignment
//                       you may be healed by healing potions and spells again by
//                       taking this ability. In fact you will get the best of
//                       both worlds and can be healed by both negative and positive
//                       energy.
  const int UseHolyVampire = TRUE;
//        Look of Hunger - With a glance you can pull the blood of the wounded to
//                         you. Healing yourself half of the damage that your
//                         target has taken, as with using your fangs the extra
//                         blood will be stored automatically. You may take
//                         this ability a second time to double the uses per day.
  const int UseLookOfHunger = TRUE;
  const int UseLookOfHungerLevel2 = TRUE;
//        Refuge - You can be instantly teleported to your coffin once a day. The
//                 teleport will leave behind a rather annoying going away present
//                 for whomever was bothering you.
  const int UseRefuge = TRUE;
//        Unturnable - You can never be turned by turn undead.
  const int UseTurnProof = TRUE;

//Levels for vampire abilities.
  //Note: Level is capped at 40 so setting a value above 40 will shut it off.

//Statistic boosters (Boost is = [Vampire Level / 4] + 1)
    //Always Active
//Speed increase (Vampire Level * 2)
    //Always Active
//Ultravision
  const int UltravisionLevel = 1;
//Weaknesses
  //Fire weakness (70 - Level)
    //Always Active
  //Divine weakness (90 - Level)
    //Always Active
//Resistances
  //Cold Resist (50 + Level)
    //Always Active
  //Negative Resist (80 + Level) [Note: many spells have been changed to heal you instead already]
    //Always Active
//Immunities
  //Death spells (default level 3)
    const int ImmuneDeathLevel = 3;
  //Negative Level (default level 6)
    const int ImmuneNegLvlLevel = 6;
  //Disease (default level 9) [Note: makes you immune to some effects of bad blood, poisons are the others]
    const int ImmuneDiseaseLevel = 9;
  //Poison (default level 12) [Note: makes you immune to most effects of bad blood, diseases are the others]
    const int ImmunePoisonLevel = 12;
  //Sneak Attack (default level 15)
    const int ImmuneSnkAttkLevel = 41;
  //Critical Hits (default level 18)
    const int ImmuneCrtHitLevel = 41;
//Damage Resist (default level 20) [Note: 5/-]
  const int ImmuneDmgResistLevel = 20;
//Negative Damage Bonus to Attacks (only the highest value will be in effect)
  //+1
    const int NegDmg1Level = 2;
  //+2
    const int NegDmg2Level = 5;
  //+1d4
    const int NegDmg1d4Level = 8;
  //+1d6
    const int NegDmg1d6Level = 11;
  //+1d8
    const int NegDmg1d8Level = 14;
  //+1d10
    const int NegDmg1d10Level = 17;
  //+2d6
    const int NegDmg2d6Level = 20;
  //+2d8
    const int NegDmg2d8Level = 25;
  //+2d10
    const int NegDmg2d10Level = 30;
  //+2d12
    const int NegDmg2d12Level = 35;
//Vampire aura (Dominate or paralyze lower level undead, on other races causes fear
//or paralyze DC = 10 + [Vampire Level/3]). Bonus of ([Vampire Level / 10] + 1)
//against opposite gender.
  //Note: the large aura overrides the small
  //small aura (default level 4)
    const int SmallAuraLevel = 8;
  //large aura (default level 19) [Note: Dragon fear aura size]
    const int LargeAuraLevel = 19;
//Vampire Items (these are the activatable items for vampire special abilities)
  //Sunstone (let's the vampire know if it is daylight outside) [default level 1]
    const int SunstoneLevel = 1;
  //Bat Ability (allows the vampire to turn into a bat and fly to their coffin or
  //             another location that they have memorized.) [default level 7]
    const int BatLevel = 15;
  //Wolf Ability (polymorph into a wolf) [default level 10]
    const int WolfLevel = 10;
    //Dire Wolf Upgrade
      //instead of a wolf they will become a dire wolf at a level you specify
      //(must be >= than wolf) [default level 13]
      const int DireWolfLevel = 26;
  //Mist Ability (turn into a mist that can travel through locked doors and is
  //              ignored by enemies) [default level 16]
    const int MistLevel = 23;


// Added by Sitrius for Natural Regen.
const int sm_NaturalRegen1 = 21;        // When the vampire gets a natural +1 regen
const int sm_NaturalRegen2 = 26;        // When the vampire gets a natural +2 regen
const int sm_NaturalRegen3 = 32;        // When the vampire gets a natural +3 regen
const int sm_NaturalRegen4 = 35;        // When the vampire gets a natural +4 regen
// End of Natural Regen section.

// Sitrius - Added for new Epic Abilities.
// Set these to FALSE to disable the respective disiplines.
const int UseAuspex1 = TRUE;
const int UseAuspex2 = TRUE;
const int UseCelerity = TRUE;
const int UseChimestry1 = TRUE;
const int UseChimestry2 = TRUE;
const int UseDementation1 = TRUE;
const int UseDominate1 = TRUE;
const int UseDominate2 = TRUE;
const int UseFortitude1 = TRUE;
const int UseObfuscate1 = TRUE;
const int UseObfuscate2 = TRUE;
const int UsePotence = TRUE;
const int UseTGargoyle = FALSE;
const int UseTMinion = FALSE;
// Sitrius - End of new Epic Abilities.

/*Default Order
Improve by Level (Always Active):
  Strength Boost
  Charisma Boost
  Speed Increase
  Fire Weakness
  Divine Weakness
  Cold Resist
  Negative Resist
  Vampire Fangs
Level 1:
  Ultravision
  Sunstone
Level 2:
  +1 Bonus negative damage added to attacks
Level 3:
  Immunity to death spells
Level 4:
  Small vampire aura
Level 5:
  +2 Bonus negative damage added to attacks
Level 6:
  Immunity to negative levels
Level 7:
  Bat Ability
Level 8:
  +1d4 Bonus negative damage added to attacks
Level 9:
  Immunity to disease
Level 10:
  Wolf Ability
Level 11:
  +1d6 Bonus negative damage added to attacks
Level 12:
  Immunity to poison
Level 13:
  Dire Wolf Upgrade
Level 14:
  +1d8 Bonus negative damage added to attacks
Level 15:
  Immunity to sneak attacks
Level 16:
  Mist Ability
Level 17:
  +1d10 Bonus negative damage added to attacks
Level 18:
  Immunity to critical hits
Level 19:
  Large vampire aura
Level 20:
  Damage resist of 5/-
  +2d6 Bonus negative damage added to attacks

Epic Levels:
Level 21:
  Book of Advancement
  Can drain levels via vampire bite (Adds 1 to every statistic of the vampire
   and fills their health while leaving their victim alive). Since the victim
   will stay stunned, asleep, or paralyzed the vampire can then bite them again.
Level 25:
  +2d8 Bonus negative damage added to attacks
  Book of Advancement
Level 29:
  Book of Advancement
Level 30:
  +2d10 Bonus negative damage added to attacks
Level 33:
  Book of Advancement
Level 35:
  +2d12 Bonus negative damage added to attacks
Level 38:
  Book of Advancement
*/

