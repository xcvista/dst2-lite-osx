Subrip
======

Language Specification
----------------------

The format has no header, and no footer. Each subtitle has four parts:
* Line 1 is a sequential count of subtitles, starting with 1.
* Line 2 is the start timecode, followed by the string " --> ", followed by the end timecode. Timecodes are in the format HH:MM:SS,MIL (hours, minutes, seconds, milliseconds). The end timecode can optionally be followed by display coordinates (example " X1:100 X2:600 Y1:050 Y2:100"). Without coordinates displayed, each line of the subtitle will be centered and the block will appear at the bottom of the screen.
* Lines 3 onward are the text of the subtitle. New lines are indicated by new lines (i.e. there's no "\n" code). The only formatting accepted are the following:
 * &lt;b&gt;text&lt;/b&gt: put text in boldface
 * &lt;i&gttext&lt;/i&gt: put text in italics
 * &lt;u&gttext&lt;/u&gt: underline text
 * &lt;font color="#00ff00"&gttext&lt;/font&gt;: apply green color formatting to the text (you can use the font tag only to change color)

Tags can be combined (and should be nested properly). Note that the SubRip code appears to prefer whole-line formatting (no underlining just one word in the middle of a line).

Finally, successive subtitles are separated from each other by blank lines.

Parser design (in GDL)
----------------------

For info about GDL, check <https://github.com/xcvista/GraphKit>

Language as in scanf-like designation:

 srt = line | srt line;
 line = %u \n timetag [location] \n %s \n\n;
 timetag = time --> time;
 time = %u:%02u:%02u.%03u;
 location = X1:%u X2:%u Y1:%u Y2:%u;

Parser:

* 0 -%u\n-> 1
* 1 -timetag(lex)-> 2
* 2 -\n-> 4
* 2 -location(lex)-> 3
* 3 -\n-> 4
* 4 -%s\n-> 4
* 4 -\n\n-> 5
* 5 -%u\n-> 1
* 5 -%s\n-> 4

End case is 4 and 5.
