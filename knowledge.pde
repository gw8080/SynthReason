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
String output = "";
void setup()
{
  String[] resfull = split(eliminateGarbage(resource).toLowerCase(), ".");
  String res = eliminateGarbage(resource).toLowerCase();
  String noun = join(loadStrings("noun.txt"), "\n");
  for (int x = 0; x < 100; ) {
    String word = split(noun, "\n")[round(random(split(noun, "\n").length-1))];
    if (res.indexOf(word) > -1) {
      x++;
      String wordx = concept(word, resfull, noun);
      String wordy = concept(wordx, resfull, noun);
      if (word.equals(wordy) == false) {
        String wordz = concept(wordy, resfull, noun);
        output+= word + " has " + wordy + " and influences " + wordx + " because of " + wordz + "\n";
      }
    }
  }
  outputx = createWriter("output.txt");
  outputx.println(output);
  outputx.close();
  exit();
}
String concept(String word, String[] resfull, String noun) {
  String state = "";
  boolean exit = false;
  for (int x = 0; x < 100 && exit == false; x++) {
    int xx = round(random(resfull.length-1));
    for (int y = 0; y < 100 && exit == false; y++) {
      int rand = round(random(split(resfull[xx], " ").length-1));
      if (noun.indexOf( "\n" + word +  "\n") > -1 && noun.indexOf( "\n" +split(resfull[xx], " ")[rand] +  "\n") > -1) {
        state = split(resfull[xx], " ")[rand];
        exit = true;
      }
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
