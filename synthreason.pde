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
String output = "mind ";
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
    for (int y = 0; y != vocabprep.length; y++)
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
  int step = 0;
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  outputx = createWriter("output.txt");
  for (int b = 0; b != cat.length - 10; b++)
  {
    float r = random(en.length-5);
    for (int i = round(r); i < en.length; i++)
    {
      String[] outputl = split(output, " ");
      if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1 && str.indexOf(outputl[outputl.length-1] + " " + en[i]) > -1 )
      {
        //inference rules
        if (step == 0) {
          output += "the ";
        }
        if (step == 1) {
          output += en[i] + " ";
        }
        if (step == 2) {
          output += "of ";
        }
        if (step == 3) {
          output += en[i] + " "+ en[i+1] + " ";
        }
        if (step == 4) {
          output += "is ";
        }
        if (step == 5) {
          output += en[i] + " "+ en[i+1] + " ";
        }

        if (step == 6) {
          output += "because ";
        }
        if (step == 7) {
          output += en[i] + " " + en[i+1] + " " + en[i+2] + " " + en[i+3] + " ";
        }
        if (step == 9) {
          output += "is ";
        }
        if (step == 10) {
          output += en[i] + " "+ en[i+1] + " " + en[i+2] + " ";
        }
        if (step == 11) {
          output += ". ";
        }
        r = random(en.length-5);
        i = round(r);
        step++;
        if (step > 11) {
          step = 0;
        }
        break;
      }
    }
  }

  output = output.replace(" and .", ".");
  output = output.replace(" than .", ".");
  output = output.replace(" any .", ".");
  output = output.replace(" the .", ".");
  output = output.replace(" has .", ".");
  output = output.replace(" a .", ".");
  output = output.replace(" to .", ".");
  output = output.replace(" only .", ".");
  output = output.replace(" they .", ".");
  output = output.replace(" of .", ".");
  output = output.replace(" is .", ".");
  output = output.replace(" which .", ".");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
