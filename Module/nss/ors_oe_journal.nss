////////////////////////////////////////////////////////////////////////////////
//  Player Journal Giver Through a Trigger
//  ors_oe_journal
//  By Don Anderson
//  dandersonru@msn.com
//
//  This is used for Adding Rules to the Player Journal
//
////////////////////////////////////////////////////////////////////////////////

void main()
{
    object oPC      = GetEnteringObject();
    object oTrigger = OBJECT_SELF;

    //Journals to Add
    string sJournal1 = "ClassRules";
    string sJournal2 = "GeneralRules";
    //string sJournal3 = "Updates";
    //string sJournal4 = "PvPRules";
    //string sJournal5 = "SpellRules";
    //string sJournal6 = "TroopRules";

    AddJournalQuestEntry(sJournal1,1,oPC,FALSE,FALSE,FALSE);
    AddJournalQuestEntry(sJournal2,1,oPC,FALSE,FALSE,FALSE);
    //AddJournalQuestEntry(sJournal3,1,oPC,FALSE,FALSE,FALSE);
    //AddJournalQuestEntry(sJournal4,1,oPC,FALSE,FALSE,FALSE);
    //AddJournalQuestEntry(sJournal5,1,oPC,FALSE,FALSE,FALSE);
    //AddJournalQuestEntry(sJournal6,1,oPC,FALSE,FALSE,FALSE);
}
