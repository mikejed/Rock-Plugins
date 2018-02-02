![Icon](../Print%20blank%20labels%20Plugin/package-icon.png?raw=true "Project Icon")
## Pre-printing blank tags
Since you never know when your power or ISP will suddenly fail on Sunday morning, children's ministry workers often rightly feel better about check-in they've got a stack of blank labels pre-printed and ready for them to scribble names onto using markers. Sometimes, that's just the best solution.

But as much as possible, we don't want to compromise the security features that the check-in process allows us. So you'll want your pre-printed labels to have matching security codes on them ... and of course it would be nice if they looked like your regular tags.

To do this, you'll need two things: a slightly modified version of your .prn files, and this Windows .exe program.

### Prepare your labels
Start off by downloading copies of the .prn files you're using in Rock. Open them in Notepad, and then delete any lines with the normal merge fields. This is necessary to keep it from printing placeholder text where their names would usually go. Then, replace the placeholder for the security code with `???` - this is what this program will use to determine where to write the code it generates for this set of tags.

Do this for each of the labels you want to pre-print, and store them all together in a single directory. They're going to come out of the printer according to their file name, so you may want to prepend the file names with numbers.

If you'd like, you can also download the files we use at my church from this repository.

### Get the program
Once you've installed this plugin, you can download the program from `Admin Tools -> Power Tools -> External Applications`. But that just links you to the program in this repository, so you can download it right from here, too. Save it in the same directory as the .prn files you've prepared. Then run it.

## Use
Launch the program - you'll have to allow it to run because it's not digitally signed. A dialogue will open resembling the following:

![Icon](../Print%20blank%20labels%20Plugin/Screenshot.png?raw=true "Screenshot")
* Begin by selecting the method of locating the printer.
    * The easy way is to enter the IP address of the Zebra printer you want to print the blank labels on, using "Network Printer (IP address)" mode.
    * If your printer is installed locally, or on a print server, we'll have to use the UNC path. The printer will have to be shared for this to work, so if it's truly a local printer, open up your Printer Properties, go to the "Share" tab, and choose to share it. Take note of (and change if you wish!) the name, then you can access the printer in "Shared local printer" mode, using a path like `\\localhost\PrinterNameHere`.

* By default it will generate and print random alpha-numeric security codes. If you'd perfer sequential numeric codes however, you can check the "Print sequential numeric codes instead" and provide a starting number. This number will be padded with zeros to get it to the length you specify below. If you've previously run this program asking for sequential numeric codes, this will default to the "next" number that would have been printed in sequence.

* If you'd like all the security codes to start with a particular character, you can specify that prefix in the "Security code prefix" input

* You can specify how long the generated codes should be in the "Code Length" input - this does *NOT* include the prefix. So if you provide `M` as the prefix and ask for a security code length of 3 digits, you could get a code like `M6AB`.

* Specify how many labels you wish to have printed in this run using the "Number of labels to print" input. It's limited to 100 using the arrows but if you REALLY want to, you can type an arbitrary number in the input.

* The labels which are found and will be printed by the program are listed on the right side of the dialogue. If something looks wrong (the order, for instance), you'll have to exit the program, tweak the .prn files themselves, and run the program again.

## Troubleshooting
* I got an error on Line -1: `Error: Subscript used with non-Array variable.`*
This occurs when no .prn files are found in the same directory as the program. Make sure the program isn't in a .zip file and that your .prn files are in the same place as you've saved the program.

## Support
You can file a report here if you need help, but I encourage you to jump into the [Rock Slack channel](https://www.rockrms.com/slack) first. You can ping me by mentioning `@mikejed` in there.
