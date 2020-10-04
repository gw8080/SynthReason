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
String resource = "n.txt";
String rules = "reason.txt";
String output = "";
String txt = "";
void setup()
{
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
  str = "";
  KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  int br = 0;
  outputx = createWriter("output.txt");
  for (int b = 2; b != cat.length - 10; b++)
  {
    float r = random(en.length);
    for (int i = round(r); i < en.length; i++)
    {
      if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1)
      {
        //inference rules
        while (true) {
          if (int (cat[b]) == 4 && int (cat[b+1]) == 4) {
            output += enx[b] + " ";
            b++;
            br++;
          }
          if (int (cat[b]) == 1 && int (cat[b+1]) == 4) {
            output += enx[b] + " ";
            b++;
            br++;
          }
          if (int (cat[b]) == 4 && int (cat[b+1]) == 1) {
            output += enx[b] + " ";
            b++;
            br++;
          }
          if (int (cat[b]) == 1 && int (cat[b+1]) == 1) {
            output += enx[b] + " ";
            b++;
            br++;
          }
          if (int (cat[b]) == 0 && int (cat[b+1]) == 1) {
            output += enx[b] + " ";
            b++;
            br++;
          }
          if (int (cat[b]) == 1 && int (cat[b+1]) == 0) {
            output += enx[b] + " ";
            b++;
            br++;
          }
           if (int (cat[b]) == 1 && int (cat[b+1]) == 7) {
            output += enx[b] + " ";
            b++;
            br++;
          }
          if (br == 0) {
            break;
          }
          br = 0;
        }
        if (int (cat[b]) == 10) {//learn from internet trigger
          KB = loadStrings("https://en.wikipedia.org/wiki/" + en[i]);//Learn
          for (int j = 0; j < KB.length; j++)
          {
            str += KB[j];
          }
          en = str.split(" ");
        }
        output += en[i] + cat[b] + " ";
        r = random(en.length);
        i = round(r);
        break;
      }
    }
  }
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
