![Icon](../Print%20blank%20labels%20Plugin/package-icon.png?raw=true "Project Icon")
## Pre-printing blank tags
Since you never know when your power or ISP will suddenly fail on Sunday morning, children's ministry workers often rightly feel better about check-in they've got a stack of blank labels pre-printed and ready for them to scribble names onto using markers. Sometimes, that's just the best solution.

But as much as possible, we don't want to compromise the security features that the check-in process allows us. So you'll want your pre-printed labels to have matching security codes on them ... and of course it would be nice if they looked like your regular tags.

This program will not only let you choose which fields are hidden, shown as text, or act as a security code, but even let you edit the zpl or send commands to your printers.

You can either load labels from your file system, load labels securely from your Rock server, or start with a blank label.

### Former v2 user?
You no longer need to manually change your label files for this program to work.

### Get the program
Once you've installed this plugin, you can download the program from `Admin Tools -> Power Tools -> External Applications`. But that just links you to the program in this repository, so you since you're already here, you can browse the version folders at the top of this page to download the latest program directly and then run it.

## Use
Launch the program - you'll have to allow it to run because it's not digitally signed. A dialogue will open resembling the following:

![Icon](../Print%20blank%20labels%20Plugin/Screenshot.png?raw=true "Screenshot")
* Begin by loading one or more labels.
    * The easy way is to click "Load from Server" - this will prompt you for your server address, username, and password. If your login succeeds, it will allow you to choose which labels to download - just check the box next to any labels you want to load.
    * Alternatively, you can start from a blank label (you'll need to give it a name), or if you have the .prn files locally, you can browse for the files.

* Now click on each label - on the right side you'll be shown all of the merge fields available in the label. You'll probably want to hide any field that would usually be filled in with Lava, show text for any regular text, and choose "Security Code" for whatever field should get the random code.

* When you highlight a label, a preview of the label will be shown, assuming a standard 4x2 label size. It even shows graphics and icons from the normal Rock-provided font icon properly. (Note: you must be online for the preview to work).

* By default "Security Code" will generate and print random alpha-numeric security codes that match for an entire label set. If you'd perfer sequential numeric codes however, you can choose "Sequential numbers starting at" and provide a starting number in the top right section. This number will be padded with zeros to get it to the length you specify. If you've previously run this program asking for sequential numeric codes, this will default to the "next" number that would have been printed in sequence.

* If you'd like all the security codes to start with a particular character, you can specify that prefix in the "Security code prefix" input

* You can specify how long the generated codes should be in the "Code Length" input - this does *NOT* include the prefix. So if you provide `M` as the prefix and ask for a security code length of 3 digits, you could get a code like `M6AB`.

* If you want to make direct changes to the zpl, you can do so at the bottom left of the window when a label is highlighted- when you're done click "Update Code" and your changes will be saved (and the preview reloaded)

## Once you're ready to print

* Begin by selecting the method of locating the printer.
    * The easy way is to enter the IP address of the Zebra printer you want to print the blank labels on, using "Network Printer (IP address)" mode.
    * If your printer is installed locally, or on a print server, we'll have to use the UNC path. The printer will have to be shared for this to work, so if it's truly a local printer, open up your Printer Properties, go to the "Share" tab, and choose to share it. Take note of (and change if you wish!) the name, then you can access the printer in "Shared local printer" mode, using a path like `\\localhost\PrinterNameHere`.

* Specify how many labels you wish to have printed in this run using the "Sets of labels to print" input. It's limited to 100 using the arrows but if you REALLY want to, you can type an arbitrary number in the input.

## Autosave
Your settings will be saved and auto-selected the next time you run the app, and the labels you configured last time will be auto-loaded as well. If you want to reset to the defaults, simply delete the .ini and .bak files that get created in the same directory as this app (one of each).

## Troubleshooting
**I got an error when trying to load remote files: `The requested resource does not support http method 'GET'`**
* This occurs if your server's API isn't accessible to the program - I've seen this once on a system protected by Cloudflare, but have tried to add a friendlier error message in this case that explains that. But there may be other circumstances this occurs too. If you get this, you may need to download your labels manually and browse your computer to load them instead.
