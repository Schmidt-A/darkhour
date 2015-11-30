//::///////////////////////////////////////////////
//:: Name: Book writing include file
//:: FileName: td_quill_inc
//:://////////////////////////////////////////////
/*
    using the quill pen a player can write in and rename a blank book,
    or write on and title a sheet of parchment. Instruction on how to use the
    quill pen are in its description, then a pc first aquires a quill pen it
    opens the examine window for the pen, also using the activate item power
    on the pc will also fire the examine feature. To name a book or title a
    sheet of parchment the player must speak in talk volume "name-"
    (without the quotation marks) plus what he or she wishes the title of the
    book to be. Then use the quill's activate item power on the book or sheet
    of parchment. To write in or on a book or parchment the process is the
    same with the exception of "name-" changing to "write-" (again without
    the quotation marks). Books and parchments can be written in multiple
    times, each new entry being added to what was written before.
    Once a book (not parchment) has been written the pc can make a "published"
    copy of that book by placeing it in the printers desk and chosing make copy
    from the dialogue. A book so coppied can no longer be written in and will
    have the default bioware book apearance.
*/
//:://////////////////////////////////////////////
//:: Created By: Thales Darkshine (Russ Henson)
//:: Created On: 07-20-2008
//:://////////////////////////////////////////////

//* constants
string NOT_BOOK = "you can not write on this with this pen";
string NAME_BOOK = "you write the name of the book on the cover";
string WRITE_BOOK = "you write in the book";
string WRITE_NOTE = "you write on the sheet of parcment";
string BOOK_DONE = "this book is already full you must write in a blank book";
string NAME_NOTE = "you write a title on the top of this sheet of parchment";
//* Prototypes

// Set the Name of the book
// changes books current name to value of sName
void  SetBookName(object oBook, string sName);

// Put at title on the note
// keeps original name first, adds characters title after
void  SetNoteName(object oNote, string sName);

// Set the Description of the book
// keep original descritpion only if it is not the defaut
// new descritpion is value of sNewText
void WriteBook(object obook, string sNewText);

// Set the Description of the Note
// keep original descritpion only if it is not the defaut
// new descritpion is value of sNewText
void WriteNote(object oNote, string sNewText);

//::///////////////////////////////////////////////
//:: Name SetBookName
//:://////////////////////////////////////////////
/*
   changes name of book to what the player
   says as a chat message.
*/
//:://////////////////////////////////////////////
void  SetBookName(object oBook, string sName)
{
    SetName(oBook,sName);
    return;
}
//::///////////////////////////////////////////////
//:: Name SetNoteName
//:://////////////////////////////////////////////
/*
   changes name of book to what the player
   says as a chat message.
*/
//:://////////////////////////////////////////////
void  SetNoteName(object oNote, string sName)
{
    SetName(oNote,"sheet of parchment titled "+sName);
    return;
}

//::///////////////////////////////////////////////
//:: Name WriteBook
//:://////////////////////////////////////////////
/*
    updated books descritpion with last player chat
*/
//:://////////////////////////////////////////////
void WriteBook(object oBook, string sNewText)
{
    // check for original destricpion of book.
    string sOldText = GetDescription(oBook,FALSE,TRUE);
    // if book has not been written in yet it should have the
    // following description
    if (sOldText == "A simple leather bound book with blank pages")
    {
        SetDescription(oBook, sNewText, TRUE);
        return;
    }
    else
    SetDescription(oBook, GetDescription(oBook,FALSE,TRUE)+ sNewText, TRUE);
}
//::///////////////////////////////////////////////
//:: Name WriteNote
//:://////////////////////////////////////////////
/*
    updated books descritpion with last player chat
*/
//:://////////////////////////////////////////////
void WriteNote(object oNote, string sNewText)
{
    // check for original destricpion of book.
    string sOldText = GetDescription(oNote,FALSE,TRUE);
    // if book has not been written in yet it should have the
    // following description
    if (sOldText == "a blank sheet of parchment")
    {
        SetDescription(oNote, sNewText, TRUE);
        return;
    }
    else
    SetDescription(oNote, GetDescription(oNote,FALSE,TRUE)+ sNewText, TRUE);
}
