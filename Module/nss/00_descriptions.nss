////////////////////////////////////////////////////////////////////////////////
//:: FILENAME: "00_descriptions"
//:: Description: Include file for setting randomized descriptions on preexisting
//::              npc citizens.
//:: Created By: Blasco-Yang
//:: Credit: ffbj: At least a third of the phrases used within the
//::         "SetRandomNPCDescription(object oNPC)" function  were provided
//::         by ffbj.
//:: Created On: October/2009
//////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

//:: FUNCTIONS:
////////////////////////////////////////////////////////////////////////////////
//:: GetIsVowel(string sLetter)
//:: returns TRUE if the specified letter is a vowel
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////
int GetIsVowel(string sLetter)
{
 if(sLetter == "a" || sLetter == "e" || sLetter == "i" || sLetter == "o" || sLetter == "u")
 return TRUE;
 return FALSE;
}
////////////////////////////////////////////////////////////////////////////////
//:: GetRandomLetter()
//:: returns a random letter of the 26 letters of the english alphabet
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////
string GetRandomLetter()
{
 string sLetter;
 int nRandomLetter = Random(25);
 if(nRandomLetter == 0)
 sLetter = "b";
 if(nRandomLetter == 1)
 sLetter = "c";
 if(nRandomLetter == 2)
 sLetter = "d";
 if(nRandomLetter == 3)
 sLetter = "f";
 if(nRandomLetter == 4)
 sLetter = "g";
 if(nRandomLetter == 5)
 sLetter = "h";
 if(nRandomLetter == 6)
 sLetter = "j";
 if(nRandomLetter == 7)
 sLetter = "k";
 if(nRandomLetter == 8)
 sLetter = "l";
 if(nRandomLetter == 9)
 sLetter = "m";
 if(nRandomLetter == 10)
 sLetter = "n";
 if(nRandomLetter == 11)
 sLetter = "p";
 if(nRandomLetter == 12)
 sLetter = "q";
 if(nRandomLetter == 13)
 sLetter = "r";
 if(nRandomLetter == 14)
 sLetter = "s";
 if(nRandomLetter == 15)
 sLetter = "t";
 if(nRandomLetter == 16)
 sLetter = "v";
 if(nRandomLetter == 17)
 sLetter = "w";
 if(nRandomLetter == 18)
 sLetter = "x";
 if(nRandomLetter == 19)
 sLetter = "y";
 if(nRandomLetter == 20)
 sLetter = "z";
 if(nRandomLetter == 21)
 sLetter = "a";
 if(nRandomLetter == 22)
 sLetter = "e";
 if(nRandomLetter == 23)
 sLetter = "i";
 if(nRandomLetter == 24)
 sLetter = "o";
 if(nRandomLetter == 25)
 sLetter = "u";
 return sLetter;
}
////////////////////////////////////////////////////////////////////////////////
//:: GetRandomConsonant()
//:: returns a random consonant of the english alphabet
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////
string GetRandomConsonant()
{
 string sConsonant;
 int nRandomLetter = Random(20);
 if(nRandomLetter == 0)
 sConsonant = "b";
 if(nRandomLetter == 1)
 sConsonant = "c";
 if(nRandomLetter == 2)
 sConsonant = "d";
 if(nRandomLetter == 3)
 sConsonant = "f";
 if(nRandomLetter == 4)
 sConsonant = "g";
 if(nRandomLetter == 5)
 sConsonant = "h";
 if(nRandomLetter == 6)
 sConsonant = "j";
 if(nRandomLetter == 7)
 sConsonant = "k";
 if(nRandomLetter == 8)
 sConsonant = "l";
 if(nRandomLetter == 9)
 sConsonant = "m";
 if(nRandomLetter == 10)
 sConsonant = "n";
 if(nRandomLetter == 11)
 sConsonant = "p";
 if(nRandomLetter == 12)
 sConsonant = "q";
 if(nRandomLetter == 13)
 sConsonant = "r";
 if(nRandomLetter == 14)
 sConsonant = "s";
 if(nRandomLetter == 15)
 sConsonant = "t";
 if(nRandomLetter == 16)
 sConsonant = "v";
 if(nRandomLetter == 17)
 sConsonant = "w";
 if(nRandomLetter == 18)
 sConsonant = "x";
 if(nRandomLetter == 19)
 sConsonant = "y";
 if(nRandomLetter == 20)
 sConsonant = "z";
 return sConsonant;

}
////////////////////////////////////////////////////////////////////////////////
//:: GetRandomVowel()
//:: returns a random vowel of the english alphabet (omits "y")
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////

string GetRandomVowel()
{
 string sVowel;
 int nRandomLetter = Random(4);
 if(nRandomLetter == 0)
 sVowel = "a";
 if(nRandomLetter == 1)
 sVowel = "e";
 if(nRandomLetter == 2)
 sVowel = "i";
 if(nRandomLetter == 3)
 sVowel = "o";
 if(nRandomLetter == 4)
 sVowel = "u";
 return sVowel;
}
////////////////////////////////////////////////////////////////////////////////
//:: GetRandomWord()
//:: returns a random 4 to 10 letter word that can be used as character names/
//:: names of places in a fantasy world setting.  Includes a swear filter.
//:: (not for sensitive eyes)
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////
string GetRandomWord()
{
    string s4;
    string sWord;
    string s1 = GetStringUpperCase(GetRandomConsonant());
    string s2 = GetRandomVowel();
    string s3 = GetRandomLetter();
    if(GetIsVowel(s3))
    s4 = GetRandomConsonant();
    else
    s4 = GetRandomVowel();
    string s5 = GetRandomConsonant();
    string s6 = GetRandomVowel();
    string s7 = GetRandomConsonant();
    string s8 = GetRandomVowel();
    string s9 = GetRandomConsonant();
    string s10 = GetRandomVowel();

    int nWordLength = Random(6);

    if(nWordLength == 0)//4 leter word
    sWord = s1 + s2 + s3 + s4;
    if(nWordLength == 1)//5 letter word
    sWord = s1 + s2 + s3 + s4 + s5;
    if(nWordLength == 2) //6 letter word
    sWord = s1 + s2 + s3 + s4 + s5 + s6;
    if(nWordLength == 3)//7 letter word
    sWord = s1 + s2 + s3 + s4 + s5 + s6 + s7;
    if(nWordLength == 4)//8 letter word
    sWord = s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8;
    if(nWordLength == 5)//9 letter word
    sWord = s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 +s9;
    if(nWordLength == 6)//10 letter word
    sWord = s1 + s2 + s3 + s4 + s5 + s6 + s7 + s8 + s9 + s10;

    //SWEAR FILTER: (My apologies for the harsh language.  Better to see it here
    //than to see it in the game.)
    if(sWord == "Fuck" || sWord == "Shit" || sWord == "Shitty"
    || sWord == "Damn" || sWord == "Bitch" || sWord == "Bitchy"
    || sWord ==  "Bitcher" || sWord == "Cunt" || sWord == "Cunter"
    || sWord == "Fucker" || sWord == "Bastard" || sWord == "Rape"
    || sWord == "Rapist")

    sWord == "Blascoffbj";
    return sWord;
}
////////////////////////////////////////////////////////////////////////////////
//:: ReturnRandomHomeLand()
//:: returns a random string of descriptive text naming a place of interest.
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////
string ReturnRandomHomeLand()
{
    string sRandomWord = GetRandomWord();
    string sRandomAddition;
    int nRandomOther = Random(30);
    if(nRandomOther == 0)
    sRandomAddition = "Northern ";
    if(nRandomOther == 1)
    sRandomAddition = "Southern ";
    if(nRandomOther == 2)
    sRandomAddition = "Eastern ";
    if(nRandomOther == 3)
    sRandomAddition = "Western ";
    if(nRandomOther == 4)
    sRandomAddition = "The City of ";
    if(nRandomOther == 5)
    sRandomAddition = "The small village of western ";
    if(nRandomOther == 6)
    sRandomAddition = "The dark marshes of ";
    if(nRandomOther == 7)
    sRandomAddition = "The forbidden badlands of ";
    if(nRandomOther == 8)
    sRandomAddition = "The exotic city of ";
    if(nRandomOther == 9)
    sRandomAddition = "A small hamlet called ";
    if(nRandomOther == 10)
    sRandomAddition = "The dark and forboding lands of ";
    if(nRandomOther == 11)
    sRandomAddition = "The mysterious kingdom of ";
    if(nRandomOther == 12)
    sRandomAddition = "The war torn lands of ";
    if(nRandomOther == 13)
    sRandomAddition = "The deep forest lands of ";
    if(nRandomOther == 14)
    sRandomAddition = "The fishing village of ";
    if(nRandomOther == 15)
    sRandomAddition = "The sacred land of ";
    if(nRandomOther == 16)
    sRandomAddition = "The sinister kingdom of ";
    if(nRandomOther == 17)
    sRandomAddition = "The Black swamps of southern ";
    if(nRandomOther == 18)
    sRandomAddition = "The wide open prarie lands of eastern ";
    if(nRandomOther == 19)
    sRandomAddition = "The mountains of northern ";
    if(nRandomOther == 20)
    sRandomAddition = "The frozen wastelands of ";
    if(nRandomOther == 21)
    sRandomAddition = "The humid jungles of ";
    if(nRandomOther == 22)
    sRandomAddition = "The Valley of ";
    if(nRandomOther == 23)
    sRandomAddition = "The arctic region of  ";
    if(nRandomOther == 24)
    sRandomAddition = "The Great Salt Flats of ";
    if(nRandomOther == 25)
    sRandomAddition = "The windswept deserts of ";
    if(nRandomOther == 26)
    sRandomAddition = "The rugged frontier of  ";
    if(nRandomOther == 27)
    sRandomAddition = "The exotic islands of southern ";
    if(nRandomOther == 28)
    sRandomAddition = "The sandstone cliffs of ";
    if(nRandomOther == 29)
    sRandomAddition = "The rolling hills of western ";

    string sRandomHomelandSentence = sRandomAddition + sRandomWord+". ";
    return sRandomHomelandSentence;
}
////////////////////////////////////////////////////////////////////////////////
//:: SetRandomNPCDescription(object oNPC)
//:: Sets a randomized description on the NPC.
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Credit:  At least a third of the phrases used in this function were
//::          provided by the generosity and imagination of ffbj.
//::
//:: Created On: October/2009
////////////////////////////////////////////////////////////////////////////////
void SetRandomNPCDescription(object oNPC)
{
 object oArea = GetArea(oNPC);
 int nRace = GetRacialType(oNPC);
 int nGender = GetGender(oNPC);
 string sName = GetName(oNPC);

 string sFirstSentence;
 string sSecondSentence;
 string sThirdSentence;

 string sLower_He_She;
 string sLower_His_Her;
 string sLower_Him_Her;

 string sHe_She;
 string sHis_Her;
 string sHim_Her;

 if(nGender == GENDER_MALE)
   {
    sLower_He_She = "he";
    sLower_His_Her = "his";
    sLower_Him_Her = "him";
    sHe_She = "He";
    sHis_Her = "His";
    sHim_Her = "Him";
   }
 else if(nGender == GENDER_FEMALE)
   {
    sLower_He_She = "she";
    sLower_His_Her = "her";
    sLower_Him_Her = "her";
    sHe_She = "She";
    sHis_Her = "Her";
    sHim_Her = "Her";
   }

string sOrigin;
int nRandomOrigin = Random(11);
if(nRandomOrigin == 0)
sOrigin = " hails from ";
if(nRandomOrigin == 1)
sOrigin = " comes from ";
if(nRandomOrigin == 2)
sOrigin = " has travelled from ";
if(nRandomOrigin == 3)
sOrigin = " made the journey from ";
if(nRandomOrigin == 4)
sOrigin = " long ago made the perilous trek from ";
if(nRandomOrigin == 5)
sOrigin = " calls " + sLower_His_Her + " home ";
if(nRandomOrigin == 6)
sOrigin = " left " + sLower_His_Her + " home in ";
if(nRandomOrigin == 7)
sOrigin = " departed from ";
if(nRandomOrigin == 8)
sOrigin = " bade goobye to " + sLower_His_Her + " home in ";
if(nRandomOrigin == 9)
sOrigin = " said farewell to " + sLower_His_Her + " home in ";
if(nRandomOrigin == 10)
sOrigin = " shook " + sLower_His_Her + " fist at the sky and left "+sLower_His_Her+ " home in ";

string sEnemy;
int nRandomEnemy = Random(20);
if(nRandomEnemy == 0)
sEnemy = " a dark wizard named " + GetRandomWord();
if(nRandomEnemy == 1)
sEnemy = GetRandomWord() +" a black hearted noble of " + sLower_His_Her + " homeland";
if(nRandomEnemy == 2)
sEnemy = " a band of thieves and cutthroats from "+sLower_His_Her+ " hometown";
if(nRandomEnemy == 3)
sEnemy = " a pious religious leader of "+ sLower_His_Her + " country";
if(nRandomEnemy == 4)
sEnemy = " a demented cult leader who goes by the name of Almighty " + GetRandomWord();
if(nRandomEnemy == 5)
sEnemy = " a renegade traitor named "+GetRandomWord();
if(nRandomEnemy == 6)
sEnemy = " Lord "+GetRandomWord();
if(nRandomEnemy == 7)
sEnemy = " a two bit thug named "+GetRandomWord();
if(nRandomEnemy == 8)
sEnemy = " a gambler named "+GetRandomWord();
if(nRandomEnemy == 9)
sEnemy = " a shapeshifting mage who calls "+sLower_Him_Her+"self Arcanus "+GetRandomWord();
if(nRandomEnemy == 10)
sEnemy = " a Dark Knight of the court of King "+GetRandomWord();
if(nRandomEnemy == 11)
sEnemy = " a no good horse thief named "+GetRandomWord();
if(nRandomEnemy == 12)
sEnemy = " Captain "+GetRandomWord()+ " of the Imperial Army of "+GetRandomWord();
if(nRandomEnemy == 13)
sEnemy = " a blue eyed bard who goes by the self given title of '"+GetRandomWord()+ " of the Silver Tongue'";
if(nRandomEnemy == 14)
sEnemy = " an albino named  "+GetRandomWord();
if(nRandomEnemy == 15)
sEnemy = " a one armed man with a jagged scar on his cheek";
if(nRandomEnemy == 16)
sEnemy = " a fat merchant named "+GetRandomWord();
if(nRandomEnemy == 17)
sEnemy = " a self proclaimed messiah to the masses who goes by the title: Father "+GetRandomWord()+" of the holy order of Light";
if(nRandomEnemy == 18)
sEnemy = " a wild eyed barbarian from "+ReturnRandomHomeLand();
if(nRandomEnemy == 19)
sEnemy = " a high ranking official of the Kingdom of "+GetRandomWord();



//sHistory will call upon the sEnemy section above
string sHistory;
int nRandomHistory = Random(31);
if(nRandomHistory == 0)
sHistory = sHe_She +" was driven from home by a raging plague that swept the country. ";
if(nRandomHistory == 1)
sHistory = sHe_She +" has sworn vengance against " +sEnemy + ". ";
if(nRandomHistory == 2)
sHistory = sHe_She +" wanders the country side in search of  "+sEnemy+". " +sHe_She+ " will not rest until justice is served for the cold blooded murder of "+sLower_His_Her+ " father. ";
if(nRandomHistory == 3)
sHistory = sName +" seeks out " +sEnemy+ ". "+sHe_She+ " has an unquenchable desire to bring to justice those who left " +sLower_Him_Her+ " for dead in "+ReturnRandomHomeLand()+" " ;
if(nRandomHistory == 4)
sHistory = sHe_She+" managed to escape from the dungeon of King "+GetRandomWord()+". "+sHe_She+ " can never return under penalty of death. ";
if(nRandomHistory == 5)
sHistory = sHe_She+" was schooled in the art of combat by a battle hardened veteran named Captain "+GetRandomWord() +". ";
if(nRandomHistory == 6)
sHistory = sHe_She+" served in the military as a scout during the wars that plagued "+sLower_His_Her+ " homeland. ";
if(nRandomHistory == 7)
sHistory = sHe_She+" spent considerable time at sea as a merchant before turning to a life of piracy, but that was some time ago. ";
if(nRandomHistory == 8)
sHistory =  sHe_She+" left a home of poverty back in the old country and has since seen many strange lands and endured many hardships. ";
if(nRandomHistory == 9)
sHistory =  sHe_She+" left home in search of "+sLower_His_Her+ " brother who was forced into servitude to a dottering old wizard named "+GetRandomWord() +". ";
if(nRandomHistory == 10)
sHistory =  sHe_She+" tried "+sLower_His_Her+" luck in the gambling halls of the Great city of "+GetRandomWord() +", but to no avail. ";
if(nRandomHistory == 11)
sHistory = sHe_She+" swore an oath to "+sLower_His_Her+" dying mother that "+sLower_He_She+ " would leave thier pathetic farm in search of a better future. ";
if(nRandomHistory == 12)
sHistory = sHe_She +" woke up naked in a barrel, bereft of all possessions. ";
if(nRandomHistory == 13)
sHistory = sHe_She +" is known to have a vendetta against " +sEnemy + ". ";
if(nRandomHistory == 14)
sHistory = sHe_She +" escaped from the clutches of a cult of snake worshippers, and is now in search of  "+sEnemy+". " +sHe_She+ " will not rest until justice is served for the cold blooded murder of "+sLower_His_Her+ " father. ";
if(nRandomHistory == 15)
sHistory = sName +" seeks out " +sEnemy+ ", "+" and is on a quest to repay for deserting " +sLower_Him_Her+" in "+ReturnRandomHomeLand()+" " ;

if(nRandomHistory == 16)
sHistory = sHe_She+" has broken out of "+GetRandomWord()+" Prison and can never return under penalty of death. ";
if(nRandomHistory == 17)
sHistory = sHe_She+" was trained in the the lost art of " +GetRandomWord()+ " style combat by the ancient immortal Master "+GetRandomWord() +". ";
if(nRandomHistory == 18)
sHistory = sHe_She+" was a trained assassin during the conflict that errupted in "+sLower_His_Her+ " homeland. ";
if(nRandomHistory == 19)
sHistory = sHe_She+" wandered aimlessly in the desert of " +GetRandomWord()+ ", later becoming a Mercenary for the forces of "+sEnemy+". ";
if(nRandomHistory == 20)
sHistory =  sHe_She+" is concerned that so many adventurer's " +sLower_He_She+ " once knew, are now dead. ";
if(nRandomHistory == 21)
sHistory =  sHe_She+" was once considered a local hero during the great floods of the "+GetRandomWord()+" plains, wherein "+sLower_He_She+" was known to have saved many lives. ";
if(nRandomHistory == 22)
sHistory =  sHe_She+" worked as a blacksmith in the town of "+GetRandomWord()+" for a few years, turning out some extravagantly crafted long swords that were known far and wide.  That life is far behind "+sLower_Him_Her+" now. ";
if(nRandomHistory == 23)
sHistory =  sHe_She+" was married long ago, but a traitorous spouse was not one "+sLower_He_She+ " felt "+sLower_He_She+" could live with. So "+sLower_He_She+ " packed "+sLower_His_Her+" clothes, boots, and the spouse's head in a duffel and left home. ";
if(nRandomHistory == 24)
sHistory =  sHe_She+" was embroiled in the wars that shook the foundation of the kingdom of "+GetRandomWord()+ ", but once the monarchy was overthrown "+sLower_He_She+" found "+sLower_Him_Her+"self on the wrong side of the newly established fence and had to depart in a hurry. ";
if(nRandomHistory == 25)
sHistory =  sHe_She+" was a poet once upon a time, though you could not tell by looking at "+sLower_Him_Her+" now. Many of "+sLower_His_Her+" literary works can still be found in the Great Library of "+GetRandomWord()+". ";
if(nRandomHistory == 26)
sHistory =  "After "+IntToString(Random(3)+2)+" years in  a "+GetRandomWord()+"ian dungeon, suffering the endless days and nights of torture, "+sLower_He_She+" managed to escape and spent the next 2 years in a quiet monastery to gather "+sLower_His_Her+" wits. ";
if(nRandomHistory == 27)
sHistory =  sHe_She+" spent much of "+sLower_His_Her+ " youth working as an apprentice cobbler to "+sLower_His_Her+" father, but after his untimely death "+sLower_He_She+" moved on to other things. ";
if(nRandomHistory == 28)
sHistory =  "Stricken with fever at the young age of six, it was thought that "+sLower_He_She+ " would surely die, but young "+sName+ " proved them all wrong. ";
if(nRandomHistory == 29)
sHistory =  sHe_She+" was in love once upon a time, but love has a funny way of dying when you least expect it and all that is left is the empty shell of the person you used to be. ";
if(nRandomHistory == 30)
sHistory =  "They tried to send "+sLower_Him_Her+" to the finest schools, but "+sLower_He_She+" seemed to have a thirst for adventure that could not be quenched.  So "+sLower_His_Her+ " Uncle "+GetRandomWord()+ " took "+sLower_Him_Her+ " on board a merchant vessel for an overeas venture.  It's all been downhill from there. ";



string sPersonal;
int nRandomPersonal = Random(31);
if(nRandomPersonal == 0)
sPersonal = "What riches await in the future of "+sName+ " are unknown, but " +sLower_He_She+ " cares not for the future, only for the now.";
if(nRandomPersonal == 1)
sPersonal = sHe_She+ " was known in "+sLower_His_Her+ " home country as a decent sort, but has since taken a far different road.";
if(nRandomPersonal == 2)
sPersonal = sHe_She+ " cannot shake off the nightmares of "+sLower_His_Her+ " past. Some things are better left forgotten.";
if(nRandomPersonal == 3)
sPersonal = sHe_She+ " haunts the shadows of the wildlands in search of a better life than the one "+sLower_He_She+" left behind.";
if(nRandomPersonal == 4)
sPersonal = sHe_She+ " cannot shake off the horrible screams that plague "+sLower_His_Her+" dreams each night.  Some things are best left forgotten.";
if(nRandomPersonal == 5)
sPersonal = sHe_She+ " now travels about these forgeign shores seeking for an answer to the questions that broil within.";
if(nRandomPersonal == 6)
sPersonal = sHe_She+ " can find no rest for "+sLower_His_Her+ " weary head until "+sLower_His_Her+ " nightmares are finally laid to rest.";
if(nRandomPersonal == 7)
sPersonal = sHe_She+ " finds joy now in the simple things of life.";
if(nRandomPersonal == 8)
sPersonal = " There is a sadness in "+sLower_His_Her+ " eyes that penetrates to your very soul.";
if(nRandomPersonal == 9)
sPersonal = sHe_She+" does not seem to be one who is given to bragging, but the rumors that surround "+sLower_Him_Her+" are enough of a warning.";
if(nRandomPersonal == 10)
sPersonal = sHe_She+ " seems to be a quiet, soft spoken sort these days, but there is an uncanny movement about "+sLower_Him_Her+ " that speaks volumes.";
if(nRandomPersonal == 11)
sPersonal = sHe_She+" has a jovial way about "+sLower_Him_Her+" that endears "+sLower_Him_Her+" almost immediately to all whom "+sLower_He_She+" meets.";
if(nRandomPersonal == 12)
sPersonal = sHe_She+" moves with an easy grace that speaks of having lived a life full of constant danger.";
if(nRandomPersonal == 13)
sPersonal = " What tragedy awaits "+sName+ " is shrouded in mystery, but " +sLower_He_She+ " cares not. ";
if(nRandomPersonal == 14)
sPersonal = sHe_She+ " was known in "+sLower_His_Her+ " hamlet as a friendly sort of person, but has since taken an alternate path in "+sLower_His_Her+ " ongoing search for glory.";
if(nRandomPersonal == 15)
sPersonal = sHe_She+ " cannot forget  "+sLower_His_Her+ " past sins. What they are, who can say? ";

if(nRandomPersonal == 16)
sPersonal = sHe_She+ " skulks in the shadow world. It is a very different life from the one "+sLower_He_She+" left behind.";
if(nRandomPersonal == 17)
sPersonal = sHe_She+ " seems to be sizing you up with a battle hardened gaze.";
if(nRandomPersonal == 18)
sPersonal = sHe_She+ " wanders in strange dreams seeking for an answer to the questions that trouble mankind.";
if(nRandomPersonal == 19)
sPersonal = sHe_She+ " seems preoccupied with something in "+sLower_His_Her+ "  pocket until "+sLower_He_She+ "  notices you.";
if(nRandomPersonal == 20)
sPersonal = sHe_She+ " has an odd smile that seems to say something that is unspoken but real.";
if(nRandomPersonal == 21)
sPersonal = " There is a shimmering glint from "+sLower_His_Her+ " belt as if it is inset with precious stones.";
if(nRandomPersonal == 22)
sPersonal = sHe_She+" seems to mumble to "+sLower_Him_Her+ "self far too often, as if thinking out loud.";
if(nRandomPersonal == 23)
sPersonal = sHe_She+" seems to have an annoying habit of biting  "+sLower_His_Her+ "  nails.";
if(nRandomPersonal == 24)
sPersonal = sHe_She+" can't seem to stop twitching.  Most find "+sLower_Him_Her+ " to be somewhat strange, and aloof.";
if(nRandomPersonal == 25)
sPersonal = sHe_She+" doesn't seem to make freinds easily, but the few "+sLower_He_She+ " has are loyal to a fault.";
if(nRandomPersonal == 26)
sPersonal = sHis_Her+" left eye seems like a pale, glazed over, dead thing that neither moves nor blinks, but by the look in "+sLower_His_Her+ " one good eye, it doesn't seem to be a good idea to question "+sLower_Him_Her+" about it.";
if(nRandomPersonal == 27)
sPersonal = "A terrible scar blazes a trail across "+sLower_His_Her+ " face, ruining what would otherwise be handsome features.";
if(nRandomPersonal == 28)
sPersonal = sHe_She+" can't seem to stop smiling. It's a trait that can be somewhat unnerving when one witnesses it in combat.";
if(nRandomPersonal == 29)
sPersonal = sHe_She+" was once known as a prankster until the night "+sLower_He_She+ " slipped scorpions into a freind's boots while he slept. After the burial "+sLower_He_She+ " swore off jokes of any kind." ;
if(nRandomPersonal == 30)
sPersonal = sHe_She+" never seems quite at ease among a group of people.  Seeming to prefer solitude to company." ;

sFirstSentence = sName + sOrigin + ReturnRandomHomeLand();
sSecondSentence = sHistory;
sThirdSentence = sPersonal;
//Hopefully, the following will get a bit more randomness in the descriptions:
int nLastHistory = GetLocalInt(oArea,"PreviousHistory");
int nLastPersonal = GetLocalInt(oArea,"PreviousPersonal");
if(nRandomHistory == nLastHistory || nRandomPersonal == nLastPersonal)
  {
   SetRandomNPCDescription(oNPC);
   return;
  }

string sFinalDescription = sFirstSentence + " " + sSecondSentence+ ""+sThirdSentence;
SetDescription(oNPC,sFinalDescription);

SetLocalInt(oArea,"PrevousHistory",nRandomHistory);
SetLocalInt(oArea,"PrevousPersonal",nRandomPersonal);

}

////////////////////////////////////////////////////////////////////////////////
//:: SpeakRandomOneLiner(object oNPC)
//:: Causes the NPC to speak a random one liner.
//:: Should only be called from the OnConversation event of the npc.
//:://////////////////////////////////////////////
//:: Created By: Blasco-Yang
//:: Created On: November/9/2009
////////////////////////////////////////////////////////////////////////////////
void SpeakRandomOneLiner(object oNPC)
{
 int nIsAlreadyABounty = GetLocalInt(oNPC,"Bounty");
 if(nIsAlreadyABounty == 1)return;//if the npc is a bounty we don't want to be conversational:
 if(!GetIsPC(GetLastSpeaker()))return;
 string sRandomOneLiner;
 string sNoun1;

 int nRandomNoun = Random(8);
 if(nRandomNoun == 0)
 sNoun1 = "sword";
 if(nRandomNoun == 1)
 sNoun1 = "book";
 if(nRandomNoun == 2)
 sNoun1 = "pouch";
 if(nRandomNoun == 3)
 sNoun1 = "backpack";
 if(nRandomNoun == 4)
 sNoun1 = "horse";
 if(nRandomNoun == 5)
 sNoun1 = "pair of boots";
 if(nRandomNoun == 6)
 sNoun1 = "ring";
 if(nRandomNoun == 7)
 sNoun1 = "dagger";


 int nRandom = Random(21);
 if(nRandom == 0)
 sRandomOneLiner = "How far is it to the next town?";
 if(nRandom == 1)
 sRandomOneLiner = "You wouldn't happen to know the time would you? ";
 if(nRandom == 2)
 sRandomOneLiner = "I can smell a rat from a mile away.";
 if(nRandom == 3)
 sRandomOneLiner = "I'm feeling a bit under the weather.";
 if(nRandom == 4)
 sRandomOneLiner = "Just trying to break in my new boots. ";
 if(nRandom == 5)
 sRandomOneLiner = "Sorry.  I'm kind of in a hurry.";
 if(nRandom == 6)
 sRandomOneLiner = "Yea.  I just got back from "+ReturnRandomHomeLand()+" ";
 if(nRandom == 7)
 sRandomOneLiner = "I seem to have lost my "+sNoun1+".";
 if(nRandom == 8)
 sRandomOneLiner = "Have you ever been to "+ReturnRandomHomeLand()+"?";
 if(nRandom == 9)
 sRandomOneLiner = "I just bought a new "+sNoun1+".";
 if(nRandom == 10)
 sRandomOneLiner = "Do I know you?";

 if(nRandom == 11)
 sRandomOneLiner = "You can always tell the quality of a town by how clean the streets are.";
 if(nRandom == 12)
 sRandomOneLiner = "I'm exhausted.  Been walking for days.";
 if(nRandom == 13)
 sRandomOneLiner = "There's nothing I can do to help you freind.";
 if(nRandom == 14)
 sRandomOneLiner = "Don't make me angry.  You wouldn't like me when I'm angry.";
 if(nRandom == 15)
 sRandomOneLiner = "Sorry freind.  I didn't mean to get in your way.";
 if(nRandom == 16)
 sRandomOneLiner = "Keep your chin up freind. Things will get better in time.";
 if(nRandom == 17)
 sRandomOneLiner = "Dogs make good travelling companions.  Plus, if things get bad you can always eat em.";
 if(nRandom == 18)
 sRandomOneLiner = "Sometimes I feel like I've sold my soul to the devil.";
 if(nRandom == 19)
 sRandomOneLiner = "You look like you've had a rough time of it.";
 if(nRandom == 20)
 sRandomOneLiner = "I need a stiff drink.";

 AssignCommand(oNPC,SpeakString(sRandomOneLiner));
}

////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////
// Used only for compilation purposes:
/*
void main()
{}
