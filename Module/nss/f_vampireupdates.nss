/* Vampire Update Notes: v2
Future Plans:
    window scripts
    put in door script for invitations
    option to require holy ground for resting

-Changed mist form to use the new cloud of bewilderment effect by default, looks
  a bit better and saves the grease for the undead slime =)
-Fixed undead slime spawn.
-Could not upload on Wednesday, kept getting an error when accessing nwnvault,
  university net probably clogged with that email virus that is going around.
  Will do some more bug checking.
-Note to confused module builders: The function that checks if a character is a
  pc vampire is located in 'f_vampire_spls_h', just include that and make a call
  to GetIsVampire(oPC) to find out if they are a vampire.
-Giygas brought up a good point, garlic should also protect people from vampires
  garlic will now make you immune to a vampiric aura and vampires cannot bite you
  while you are under the influence of garlic (This also affects the epic look of
  hunger). Module builders: if there are many vampires in your module it would
  be wise to bump the price up on garlic =)
-Missed the Tuesday I said I would have this done by...testing has taken alot
  longer than anticipated. As well as converting all the spells into the hook
  format. Should be able to get it out Wednesday after testing the new HotU
  spells, finishing up the example module and erfing it all up.
-Tested all epic abilities and made some minor tweaks.
-Fixed summons to use the proper associate ai...whoops!
-Added epic skill that will make the vampire un-turnable via turn undead.
-All spells and spellabilities that need to check for vampires are now using the
  current 1.61 HotU version scripts.
-All spells with spell hooks have been placed into f_vampirespell_h and are now
  accessed through the HotU spellhook system.
-Vampires used to get double the turn resistance of normal undead, they now get
  1/5 more turn resist than standard undead and have a possibility to be turned.
-A vampire may now choose to drain only what it needs to fill up it's health.
  Only if the target has more health than you need though.
-Once a vampire reaches level 21 (changable in f_vampire_defs) they can drain
  levels from those that they have disabled by using their fangs. The amount of
  levels drained and the resulting stat boosts on the vampire are random, but the
  range increases with your vampire level.
-'Dire' creatures now have a slightly higher chance of your aura effecting them
  as corrupt creatures are more alike to vampires than non-corrupt.
-You can no longer catch red slaad eggs from bad blood.
-The darkness spell will now prevent sun damage if you are within it's area of
  effect.
-A vampire may spread vampirism among friends now. When your fangs are used on a
  non-vampire PC that has marked you as a friend (and that you've marked as a
  friend) the non-vampire will be given a vampirism bite permission token. If they
  use the token they can be bitten by any vampire for 30 seconds allowing the
  vampire to drain their blood, turn them into a vampire, etc. A vampire can give
  out a token every 5 minutes (to prevent spamming), the token will disappear upon
  use or after a minute.
-Added a device in custom 1 that allows dm's to reset a pc vampires epic abilities
  and allow the pc to choose new epic abilities. Strangely enough it is called:
  "DM Device to Reset a PC Vampires Epic Abilities"...  =)
-Rolls for success on holy water take the user of the holy waters level into
  account as well now.
-With the inclusion of epic vampire levels the stat boosts now grow a little
  slower, but grow throughout the epic levels as well. (Level / 5 instead of
  Level / 4).
-Max vampire level now capped at 40
-The negative damage that is added to attacks as your vampire level grows will
  now grow at 25, 30, and 35 as well.
-Due to their power, thralls will self-destruct after 24 game hours. This also
  prevents the 'masterless thralls' syndrome that could effect persistant worlds.
-Epic vampire levels! You get an advancement book every at 21 and every 4 levels
  after that, you can use the book to activate epic vampire abilities from the
  following list:
        Improved Thrall - Not just a standard zombie anymore, this thrall will
                          retain all the abilities of it's original self with
                          boosted stats based upon your epic vampire level
        Unholy Thrall - The best thrall you can make, it not only retains it's
                        abilities, but will have boosted stats, an aura (or 2,
                        or 3...), special damage immunities, and even more as
                        your vampire level increases. You can take this feat a
                        second time to always maximize the abilities of the
                        thrall.
        Children of the Night - Summon a creature to assist you. This is a
                                prequisite for Children of the Damnned. It will
                                randomly summon a spider lord, plague rat, or
                                ancient bat.
        Kin of the Damned - Summon an unholy creature to assist you. This is
                            a prequisite for Children of the Abyss. It will
                            randomly summon Vengence, Hate or Pain
        Twin of the Abyss - Summon a kindred spirit from the depths of the abyss
                            to fight with you. It will randomly summon an Ancient
                            Shadow Dragon, an Undead Slime, or a Hand of Evil.
        Sunproof - You have aquired enough power to prevent sunlight from harming
                   you, this makes you rather noticable though as all light will
                   stay away from you...
        Blood of the Land - You will never need to worry about thirsting for
                            blood again, in fact you absorb the blood spilt in
                            ages past from the soil giving you a constant regen.
                            You may take this again to double the regen.
        Holy Vampire - If you have managed to work yourself back to good alignment
                       you may be healed by healing potions and spells again by
                       taking this ability. In fact you will get the best of
                       both worlds and can be healed by both negative and positive
                       energy.
        Look of Hunger - With a glance you can pull the blood of the wounded to
                         you. Healing yourself half of the damage that your
                         target has taken, as with using your fangs the extra
                         blood will be stored automatically. You may take
                         this ability a second time to double the uses per day.
        Refuge - You can be instantly teleported to your coffin once a day. The
                 teleport will leave behind a rather annoying going away present
                 for whomever was bothering you.
-Fixed a huge error in the create thrall script...pc's should not get set to
  the hostile faction...heh. =/
-Added switches to turn on/off effects of picking up silver, holy water and wild
  roses. Located in f_vampire_prefs with all the other options.
-Persistancy has been added, if you need to change it to use your custom system
  all persistancy commands are located in f_vampire_persis. Currently it is
  using the nwn Campaign system. The variables stored are as follows:
        FALLEN_SUBRACE - int - determines what subrace is applied, 1 for vampire (Yes I am developing others for my module =p )
        FALLEN_VAMPIRE_MARK - loc - location that can be flown to in bat form
        FALLEN_VAMPIRE_LEVEL - int - level of vampirism (1 to 40)
        FALLEN_VAMPIRE_COFFIN_VALID - int - TRUE if they have a valid coffin
        FALLEN_VAMPIRE_BLOOD_SYSTEM - int - primary blood system timer
        FALLEN_VAMPIRE_BLOOD_PENALTY - int - penalty, in levels, of blood hunger
        FALLEN_VAMPIRE_BLOOD_PENALTY_TIMER - int - penalty timer for additional hunger
        FALLEN_VAMPIRE_COFFIN_LOC - loc - location where coffin was/is
        FALLEN_VAMPIRE_COFFIN_GARLIC - int - is garlic applied to the coffin?
        FALLEN_VAMPIRE_COFFIN_HWATER - int - is holy water applied to the coffin?
        FALLEN_VAMPIRE_COFFIN_ROSE - int - is a roseward applied to the coffin?
        FALLEN_VAMPIRE_EPIC - int - keeps track of chosen epic abilities
      Note: there may be a couple more I did not list that were left in for my
            personal use or future expansion. All except the 'FALLEN_SUBRACE'
            begin with 'FALLEN_VAMPIRE_' though so there should not be any
            conflicts.
-Both vampire shops have special DM conversations for fast free vampire items...
  as well as getting Etna to bow down to someone ;-)
-Added new divine champion class as a 'holy' class that has better effects vs
  vampires
-Simplified how wild roses are handled, was unnecissarily complex before
-Fixed drown pulse attack to no longer affect pc vampires.
-Added new HotU spells: Stone Bones, Healing Sting, Undeath to Death and Drown.
-No more heartbeats!!! Woohoo!
-Added hook for module onrest event...how did I forget that =/
-Added vampirism check to the Holy Pulse attack
-Holy traps now check for vampirism, Bioware coded them to do rather unholy
  amounts of damage to the undead. Vampires beware!
-Circle of Doom now heals vampires as it should
-Added the option to created labeled blood types so PC's know exactly what is
  in those bottles. Vampire's blood is always labeled. Non-labeled blood types
  are all exactly identical in looks now and can be identified by either type of
  blood merchant in the demo module.
-Added a vial of preservation system where you have to use special vials of
  preservation to store blood in. One demonstration vampire shop uses these
  extensively.




*/
/* Vampire Update Notes: v1.1
-Fixed problem with false positives for contaminated coffins
-Removed vampire heartbeat aura for biting and replaced with an activatable item
 (Allows for a description so newbie vampires know how fangs work)
-Put in option for an item that controls vampire auras (allows vampires to hide
 the most visible sign of their heritage at will from other players in a PW)
-Added virgin (fast regen) and child blood (long term regen).
  Note: you can now mark someone to give certain types of blood:
        Bad blood = SetLocalInt(oNPC, "FALLEN_VAMPIRE_HASBLOOD", 1); //or is diseased or poisoned
        Virgin    = SetLocalInt(oNPC, "FALLEN_VAMPIRE_HASBLOOD", 2);
        Child     = SetLocalInt(oNPC, "FALLEN_VAMPIRE_HASBLOOD", 3); //or is using one of the 2 child models or Age < 13
-Fixed touch attack problem when a vampire drinks a healing potion
-Added support for weather, the module creator can choose to have no sun damage
  when the weather is raining or snowing.
-Added vampire support to Horrid Wilting, by default it hurts pc vampires since
  it dries out their blood supply, but it can be set to not hurt them in the defs
-Vampire bite scripts are a little smarter now and are PW friendly. Also note that
  anyone that sees you take a bite will become your enemy...even 'friends' The
  undead are not really team players. On the other hand, you can now drain the
  blood of any disabled playable race, even those that consider you to be a friend.
-Fixed a multitude of inconsistencies in vampire level determination
-Consolidated all vampire level gets into a single function (Determine_Vampire_Level)
-Fixed an animation bug when polymorphing to a wolf
-Fixed a problem with mist form fading when the area changed with patch 1.32
-Added blood hunger system, fully configurable in f_vampire_defs
-Added client enter script for blood system and applying stats
-Fixed a couple small issues that bothered me in the vampire death scripts
-Added option to change what mist the mist form uses (still like grease the best)
-Fixed the vampire aura to take into account the 'both' gender and to balance out
  the fear/paralyze ratio (fear is much more possible now).
-Fixed an error where PC vampires were too easy to turn, they now are viewed as a
  pure undead to the turn undead function
-Change: Now both the small and large auras are activated at once so there is no
         need to use a heartbeat and take up system resources.
-Added ability to turn off some of the bite options or to even level limit them.
-Added: Vampires are now immune to vampiric touch like all other undead (whoops,
  guess I had missed one)
-Fixed: self inflicted heals or cures (via potion or spell) cannot miss or be
  resisted
*/

void main()
{

}
