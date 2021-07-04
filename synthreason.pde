/* 
 Copyright (C) 2021 George Wagenknecht SynthReason, This program is free
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
PrintWriter debug;
String resource = "exp.txt";// knowledge
String rules = "reason.txt";// rules
String output = "";
String txt = "";
int comboSearchValue = 100000; // combo search value
int sortMax = 99999999;
int minimumSentenceLength = 30;
int precision = 3;
void setup()
{
  String[] res = split(eliminateGarbage(resource).replace(".", "").toLowerCase(), " ");
  String[] resfull = split(eliminateGarbage(resource).toLowerCase(), ".");
  int count = 0;
  String[]vocabproc;
  String vocabsyn = "";
  for (count = 0; count < 25; count++)
  {
    vocabproc = loadStrings(count + ".txt");
    if (vocabproc != null)
    {
      String voc = join(vocabproc, '\n');
      if (voc.length() > 0)
      {
        vocabsyn += voc + ":::::";// load vocabulary
      }
      if (voc.length() == 0)
      {
        break;
      }
    }
  }
  String[]enx = split(join(loadStrings(rules), ""), ".");
  String[]vocabprep = vocabsyn.split(":::::");
  for (int z = 0; z < enx.length; z++)
  {
    String[]enwords = split(enx[z], " ");
    for (int x = 0; x < enwords.length; x++)
    {
      for (int y = 0; y < vocabprep.length; y++)
      {
        if (vocabprep[y].indexOf("\n" + enwords[x] + "\n") > -1)
        {
          txt += y + ",";// load rules
          break;
        }
      }
    }
  }
  String[]cat = split(txt, ",");
  for (int catPos = 0; catPos < cat.length-1; )
  {
    int x = round(random(split(vocabprep[int (cat[catPos])], "\n").length-1));
    String alpha = split(words(split(words(split(vocabprep[int (cat[catPos])], "\n")[x], res), " ")[round(random(split(words(split(vocabprep[int (cat[catPos])], "\n")[x], res), " ").length-1))], res), " ")[round(random(split(words(split(words(split(vocabprep[int (cat[catPos])], "\n")[x], res), " ")[round(random(split(words(split(vocabprep[int (cat[catPos])], "\n")[x], res), " ").length-1))], res), " ").length-1))];

    for (int z = 0; z != precision+1; z++) {
      if (controlDivergence(split(output, " ")[round(random(split(output, " ").length-1))], split(alpha, " ")[round(random(split(alpha, " ").length-1))], resfull) == false) {
        break;
      }
      if (controlDivergence(split(output, " ")[round(random(split(output, " ").length-1))], split(alpha, " ")[round(random(split(alpha, " ").length-1))], resfull) == true) {
        if (z == precision) {
          output += alpha + " ";
          catPos++;
        }
      }
    }
  }
  String[] sort = split(output, ".");
  String sorted = "";
  int m = 0;
  for (int n = 0; n < sortMax; n++) {
    for (int x = 0; x < sort.length-1; x++) {
      if (sort[x].length() == n) {
        sorted += sort[x] + ".";
        m++;
      }
    }
    if (m == sort.length-1) {
      break;
    }
  }
  sort = split(sorted, ".");
  sorted = "";
  for (int x = 0; x < sort.length-1; x++) {
    if (split(sort[x], " ").length-1 >= minimumSentenceLength) {
      sorted += sort[x] + ".";
    }
  }
  outputx = createWriter("output.txt");
  outputx.println(sorted);
  outputx.close();
  exit();
}
String words(String input, String[] res) {
  String state = "";
  for (int x = 0; x != comboSearchValue+1; x++ ) {
    int rand = round(random(res.length-3))+1;
    if ( res[rand+round(random(2))-1].equals(input) == true) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1];
      break;
    }
    if (x == comboSearchValue) {
      state = res[rand-1] + " " +  res[rand] + " " + res[rand+1] + ".";
      break;
    }
  }
  return state;
}
String eliminateGarbage(String resource)
{
  String proc =  join(loadStrings(resource), "");
  String[] eliminate = {"-", "=", "[", "]", ";", ":", ",", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate.length; k++) {
    proc = proc.replace(eliminate[k], "");
  }
  return proc;
}
boolean controlDivergence(String object, String interaction, String[] resource) {
  boolean state = false;
  int objectCount = 0, objectReductionCount = 0;
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1 && resource[j].indexOf(" " + interaction + " ") > -1) {
      objectCount++;
    }
  }
  for (int j = 0; j < resource.length-1; j++) {
    if (resource[j].indexOf(" " + object + " ") > -1 && resource[j].indexOf(" " + interaction + " ") == -1) {
      objectReductionCount++;
    }
  }
  if ( objectCount < objectReductionCount) {
    state = true;
  }
  return state;
}
