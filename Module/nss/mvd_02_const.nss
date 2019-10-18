/*
 * Constants of the LRES
 *
 * MvDunkelfels 2004-12-3
 */

/*
 * The check hereafter refers to the check if XP points should be
 * distributed.
 * All correlating to adjustable values are the default used on startup
 * of the LRES. Runtime adjustments override.
 * You might want to adjust the OOC words, as most of them come from
 * english<->german translation. Your mileage of OOC words most
 * probably varies.
 */

/*
 * Name of the dialog counter variable on the PC
 * Stores the amount of dialog points.
 */
const string cMvD_02_sDiagCounter = "MvD_02_iDiagCounter";

/*
 * Name of the flag: stores if a player is blocked
 */
const string cMvD_02_sIsBlocked = "MvD_02_iIsBlocked";

/*
 * Name of the hour variable: stores the hour the PC last got XP
 */
const string cMvD_02_sHourLastGiven = "MvD_02_iHourLastGiven";

/*
 * Name of the minute variable: stores the minute the PC last got XP
 */
const string cMvD_02_sMinLastGiven = "MvD_02_iMinLastGiven";

/*
 * Name of the variable storing how long a PC must wait to
 * get another XP allocation
 */
const string cMvD_02_sPCTimeDiff = "MvD_02_iPCTimeDiff";

/*
 * Name of the variable storing the XP multiplier.
 */
const string cMvD_02_sXPMult = "MvD_02_fXPMult";

/*
 * Name of the variable storing if random time is activated.
 */
const string cMvD_02_sIsPCRandomTime = "MvD_02_iIsPCRandomTime";

/*
 * Name of the variable storing the minimal XP amount to give.
 */
const string cMvD_02_sMinXPToGive = "MvD_02_iMinXPToGive";

/*
 * Name of the variable storing the maximal amount of XP to give.
 */
const string cMvD_02_sMaxXPToGive = "MvD_02_iMaxXPToGive";

/*
 * Name of the variable storing the minimal time difference a PC
 * has to wait between to XP givings.
 */
const string cMvD_02_sMinTimeDiff = "MvD_02_iMinTimeDiff";

/*
 * Name of the variable storing the maximal time difference a PC
 * hast to wait between to Xp allotments.
 *
 */
const string cMvD_02_sMaxTimeDiff = "MvD_02_iMaxTimeDiff";

/*
 * Name of the variable storing the maximal amount of
 * dialog points that remain after a XP allotment.
 */
const string cMvD_02_sMaxResiduum = "MvD_02_iMaxResiduum";

/*
 * Name of the variable storing the number of minutes between
 * each check.
 */
const string cMvD_02_sHeartBeatTime = "MvD_02_iHeartBeatTime";

/*
 * Name of the variable storing the minute the check last run.
 */
const string cMvD_02_sMinuteLastRun = "MvD_02_iMinuteLastRun";

/*
 * Name of the variable storing the hour the check last run.
 */
const string cMvD_02_sHourLastRun = "MvD_02_iHourLastRun";

/*
 * Name of the variable storing the minimal amount of dialog
 * points a player needs to get XP.
 */
const string cMvD_02_sMinDialogCount = "MvD_02_iMinDialogCount";

/*
 * Name of the variable storing the amount the minimal dialog points
 * needed get raised by for each PC.
 */
const string cMvD_02_sCountPerPC = "MvD_02_iCountPerPC";

/*
 * Name of the variable storing the last user of the staff.
 */
const string cMvD_02_sTargetObject = "MvD_02_sTargetObject";

/*
 * Name of the variable storing if the staff is in use.
 */
const string cMvD_02_sStaffInUse = "MvD_02_iStaffInUse";

/*
 * Name of the variable storing if a linear factor to the XP
 * should be applied.
 */
const string cMvD_02_sLinearFactor = "MvD_02_iLinearFactor";

/*
 * Name of the variable storing if the LRES is aktive.
 */
const string cMvD_02_sLRESAktive = "MvD_02_iLRESAktive";

/*
 * Name of the variable that stores info if the object is a player
 */
const string cMvD_02_sIsPlayer = "MvD_02_iIsPlayer";

/*
 * The number of the listen pattern we set up.
 */
const int cMvD_02_iListenPatternNumber = 5000;

/*
 * The default value if random time fpr each PC is active or not.
 */
const int cMvD_02_iPCRandomTime = TRUE;

/*
 * The minimal length of a spoken text to be counted as a dialog.
 */
const int cMvD_02_iStrMinLength = 6;

/*
 * The default amount the minimal dialog points get raised for each PC.
 */
const int cMvD_02_iCountPerPC = 2;

/*
 * The minimal amount of dialog points a PC must have to be given XP
 * for 0 logged in PC. So for n PC IG the actual IG amount is
 * cMvD_02_iMinDialogCount + n * cMvD_02_iCountPerPC.
 */
const int cMvD_02_iMinDialogCount = 10;

/*
 * The number of minutes between each run of the check.
 */
const int cMvD_02_iHeartBeatTime = 2;

/*
 * The minimal amount of minutes a PC has to wait to get another
 * XP allotment if he has enough dialog points.
 */
const int cMvD_02_iMinTimeDiff = 3;

/*
 * The maximal amount of minutes a PC has to wait to get another
 * XP allotment if he has enough dialog points. Is only used if
 * random PC time is on.
 */
const int cMvD_02_iMaxTimeDiff = 5;

/*
 * Number of dialog points a PC keeps after he got XP.
 */
const int cMvD_02_iMaxResiduum = 5;

/*
 * Minimal amount of XP to be given.
 */
const int cMvD_02_iMinXP = 250;

/*
 * Maximal amount of XP to be given.
 */
const int cMvD_02_iMaxXP = 500;

/*
 * If the multiplier should be used.
 */
const int cMvD_02_iIsXPMult = FALSE;

/*
 * Name of the hub object that does the checking.
 */
const string cMvD_02_sHubTag = "LRESMainHub";

/*
 * Nummer of the userdefined event the hub gets to initiate a check.
 */
const int cMvD_02_iUserEventNr = 5000;

/*
 * Case sensitife substring denoting an OOC Area
 */
const string cMvD_02_sOOCAreaName = "OOC";

/*
 * These OOC Substrings are case-sensitive. For case-insensitive matches
 * please use the "Word" constants. See MvD_02_OOCMatchCase and
 * MvD_02_OOCMatchNoCase
 */

/*
 * 1. OOC substring
 */
const string cMvD_02_sOOC1 = "((";

/*
 * 2. OOC substring
 */
const string cMvD_02_sOOC2 = "))";

/*
 * 3. OOC substring
 */
const string cMvD_02_sOOC3 = "^^";

/*
 * 4. OOC substring
 */
const string cMvD_02_sOOC4 = "oO";

/*
 * 5. OOC substring
 */
const string cMvD_02_sOOC5 = "Oo";

/*
 * 6. OOC substring
 */
const string cMvD_02_sOOC6 = ":)";

/*
 * 7. OOC substring
 */
const string cMvD_02_sOOC7 = ":(";

/*
 * 8. OOC substring
 */
const string cMvD_02_sOOC8 = ":=)";

/*
 * 9. OOC substring
 */
const string cMvD_02_sOOC9 = ":=(";

/*
 * 10. OOC substring
  */
const string cMvD_02_sOOC10 = "-_-";

/*
 * 11. OOC substring
 */
const string cMvD_02_sOOC11 = ";)";

/*
 * 12. OOC substring
 */
const string cMvD_02_sOOC12 = ";(";

/*
 * 12. OOC substring
 */
const string cMvD_02_sOOC13 = "EP";

/*
 * 14. OOC substring
 */
const string cMvD_02_sOOC14 = "XP";

/*
 * 15. OOC substring
 */
const string cMvD_02_sOOC15 = ":P";

/*
 * 16. OOC substring
 */
const string cMvD_02_sOOC16 = ";P";

/*
 * 17. OOC substring
 */
const string cMvD_02_sOOC17 = "o_O";

/*
 * 18. OOC substring
 */
const string cMvD_02_sOOC18 = "O_o";

/*
 * 19. OOC substring
 */
const string cMvD_02_sOOC19 = ":-D";

/*
 * 20. OOC substring
 */
const string cMvD_02_sOOC20 = "{";

/*
 * 20. OOC substring
 */
const string cMvD_02_sOOC21 = "}";

/*
 * These OOC Substrings will be compared to the lowercase string. So the
 * comparision is case insensitive. Therefore the strings must all be
 * lowercase.
 */

/*
 * 1. OOC word
 */
const string cMvD_02_sOOCWord1 = "*gg*";

/*
 * 2. OOC word
 */
const string cMvD_02_sOOCWord2 = "lol";

/*
 * 3. OOC word
 */
const string cMvD_02_sOOCWord3 = "lool";

/*
 * 4. OOC word
 */
const string cMvD_02_sOOCWord4 = "loool";

/*
 * 5. OOC word
 */
const string cMvD_02_sOOCWord5 = "looool";

/*
 * 6. OOC word
 */
const string cMvD_02_sOOCWord6 = "*g*";

/*
 * 7. OOC word
 */
const string cMvD_02_sOOCWord7 = "cool";

/*
 * 8 OOC word
 */
const string cMvD_02_sOOCWord8 = "*ggg*";

/*
 * 9. OOC word
 */
const string cMvD_02_sOOCWord9 = "hello";

/*
 * 10. OOC word
 */
const string cMvD_02_sOOCWord10 = "ok";

/*
 * 11. OOC word
 */
const string cMvD_02_sOOCWord11 = "*eg*";

/*
 * 12. OOC word
 */
const string cMvD_02_sOOCWord12 = "linux";

/*
 * 13. OOC word
 */
const string cMvD_02_sOOCWord13 = "movie";

/*
 * 14. OOC word
 */
const string cMvD_02_sOOCWord14 = "[party]";

/*
 * 15. OOC word
 */
const string cMvD_02_sOOCWord15 = "[ruf]";

/*
 * 16. OOC word
 */
const string cMvD_02_sOOCWord16 = "[dm]";

/*
 * 17. OOC word
 */
const string cMvD_02_sOOCWord17 = "loggt";

/*
 * 18. OOC word
 */
const string cMvD_02_sOOCWord18 = "nwn";
