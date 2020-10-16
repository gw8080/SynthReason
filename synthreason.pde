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
  for (count = 0; count < 4000; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, ' ');
      if (voc.length() > 0)
      {
        vocabsyn += voc + ":::::";
      }
    }
  }
  //debug output
  outputx = createWriter("vocab.txt");
  outputx.println(vocabsyn);
  outputx.flush();
  outputx.close();
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
      if (vocabprep[y].indexOf(" " + enx[x] + " ") > -1)
      {
        txt += y + ",";
        break;
      }
    }
  }
  //debug output
  outputx = createWriter("rules.txt");
  outputx.println(txt);
  outputx.flush();
  outputx.close();
  //load resource
  str = "";
  KB = loadStrings(resource);
  for (int i = 0; i < KB.length; i++)
  {
    str += KB[i];
  }
  String[]en = str.split(" ");
  String[]cat = txt.split(",");
  for (int b = 0; b < cat.length-5; b++)
  {
    float r = random(en.length);
    //inference rules
    if (int (cat[b]) >= 0) {
      for (int i = round(r); i < en.length-5; i++)
      {
        if (vocabprep[int (cat[b])].indexOf(" " + en[i] + " ") > -1)
        {
          output += en[i] + " " + en[i+1] + " "+ en[i+2] + " ";
          b+=2;   
          break;
        }
      }
    }
  }
  output = output.replace("in are", "in");
  output = output.replace("and and", "and");
  output = output.replace("or the", "the");
  output = output.replace("the the", "the");
  output = output.replace("to as", "to");
  output = output.replace("to and", "to");
  output = output.replace("is and", "is");
  output = output.replace("to are", "are");
  output = output.replace("in or", "in");
  output = output.replace("the or", "the");
  output = output.replace("for to", "to");
  output = output.replace("of of", "of");
  output = output.replace("to can", "can");
  output = output.replace("the an", "the");
  output = output.replace("The to", "to");
  output = output.replace("for by", "for");
  output = output.replace("a the", "a");
  output = output.replace("to in", "in");
  output = output.replace("in is", "is");
  output = output.replace("the of", "the");
  output = output.replace("of and", "of");
  output = output.replace("in and", "in");
  output = output.replace("of to", "of");
  output = output.replace("by of", "of");
  output = output.replace("a of", "of");
  //Save to file
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.flush();
  outputx.close();
  exit();
}
