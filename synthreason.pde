/* 
 Copyright (C) 2020 George Wagenknecht SynthReason, This program is free
 software; you can redistribute it and/or modify it under the terms of the
 GNU General Public License as published by the Free Software Foundation;
 either version 2 of the License, or (at your option) any later version.
 This program is distributed in the hope that it will be useful, but WITHOUT 
 ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
 FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for
 more details. You should have received a copy of the GNU General Public
 License along with this program; if not, write to the Free Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA */

PrintWriter outputx;
String resource = "uber.txt";
String rules = "reason.txt";
String output = "";
String txt = "";
void setup()
{
  //Load vocabulary
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 20; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, '\n');
      if (voc.length() > 0)
      {
        vocabsyn += voc + ":::::";
      }
      if (voc.length() == 0)
      {
        break;
      }
    }
  }
  //Load rules
  String str = "";
  String[]KB = loadStrings(rules);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }
  String[]enx = split(str, " ");
  String[]vocabprep = vocabsyn.split(":::::");
  for (int x = 0; x < enx.length; x++)
  {
    for (int y = 0; y < vocabprep.length; y++)
    {
      if (vocabprep[y].indexOf("\n" + enx[x] + "\n") > -1)
      {
        txt += y + ",";
        break;
      }
    }
  }
  //load resource
  str = "";
  KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  int go = 0;
  for (int b = 0; b != cat.length-2; b++)
  {
    float r = random(en.length);
    //inference rules
    if (int (cat[b]) == 0) {
      for (int i = round(r); i < en.length-2; i++)
      {
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1)
        {
          int prob = 0;
          for (int x = 0; x != KB.length-1; x++) {
            if (KB[x].indexOf(" " + en[i] + " ") > -1 && KB[x].indexOf(" " + en[i+1] + " ") > -1 ) {
              prob++;
            }
          }
          if (prob < 50) {
            output += en[i] + " " + en[i+1] + " ";
            go++;
          }
          break;
        }
      }
    }

    if (int (cat[b]) == 2) {
      for (int i = round(r); i < en.length-2; i++)
      {
        if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1)
        {
          int prob = 0;
          for (int x = 0; x != KB.length-1; x++) {
            if (KB[x].indexOf(" " + en[i] + " ") > -1 && KB[x].indexOf(" " + en[i+1] + " ") > -1 ) {
              prob++;
            }
          }
          if (prob < 50) {
            output += en[i] + " " + en[i+1] + " ";
            go++;
          }
          break;
        }
      }
    }
    if (go > 1) {
      if (int (cat[b]) == 1 || int (cat[b]) == 3 ||int (cat[b]) == 4 || int (cat[b]) == 5||int (cat[b]) == 6 || int (cat[b]) == 7 || int (cat[b]) == 8) {
        for (int i = round(r); i < en.length-2; i++)
        {
          if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1)
          {
            output += en[i] + " ";
            go = 0;
            break;
          }
        }
      }
    }
  }
  //Save to file
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
