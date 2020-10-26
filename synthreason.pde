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
String output = "the ";
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
  int step = 0, go = 1;
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  outputx = createWriter("output.txt");
  float r2 = 0;
  int x = round(r2);
  String[] outputl = split(output, " ");
   String[] searchparam = outputl;
  for (int b = 0; b != cat.length - 10; b++)
  {
    float r = random(en.length-5);
    outputl = split(output, " ");
    searchparam = outputl;

    for (int i = round(r); i < en.length; i++)
    {


      if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1 && str.indexOf(outputl[outputl.length-1] + " " + en[i]) > -1 )
      {
        //inference rules
        r2 = random(searchparam.length-1);
        x = round(r2);
        if (go == 1 && step == 0) {
          output += searchparam[x] + " ";
          go = 0;
          step++;
        }   
        if (go == 1 && step == 1 && en[i-1].indexOf(searchparam[x]) > -1) {
          output += en[i] + " " + en[i+1] + " ";
          go = 0;
          b+=3;
          step++;
        }
        if (go == 1 && step == 2 && en[i-1].indexOf(searchparam[x]) > -1) {
          output += en[i] + " " + en[i+1] + " " + en[i+2] + " " + en[i+3] + " ";
          go = 0;
          b+=3;
          step++;
        }
        r = random(en.length-5);
        i = round(r);
        go = 1;
        if (step > 2) {
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
  output = output.replace(" in .", ".");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
