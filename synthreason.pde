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
  // Load vocabulary
  String[]vocabproc;
  String vocabsyn = "";
  for (int count = 0; count < 20; count++)
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
  str = "";
  //Load knowledgebase
  KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  String output2 = "";
  for (int b = 0; b != cat.length; b++)//Execute rules
  {
    float r = random(en.length);
    for (int i = round(r); i < en.length; i++)//Continuum
    {
      if (vocabprep[int (cat[b])].indexOf("\n" + en[i] + "\n") > -1)
      {
        output += en[i] + " "; 
        if (int (cat[b]) == 2)
        {
          String[]outputl = output.split(" ");
          if (outputl.length > 10 && outputl.length < 20) {//Sentence sizer
            String ss = output.substring(0, output.length() -1);
            output2 += ss + ".\n\n";
            outputx = createWriter("output.txt");
            outputx.println(output2);
            outputx.flush();
            outputx.close();
            KB = loadStrings("https://en.wikipedia.org/wiki/" + en[i]);//Learn
            for (int j = 0; j < KB.length; j++)
            {
              str += KB[j];
            }
            en = str.split(" ");
          }
          output = "";
        }
        r = random(en.length);
        i = round(r);
        break;
      }
    }
  }
  outputx.println(output2);//Save to file
  outputx.flush();
  outputx.close();
  exit();
}
