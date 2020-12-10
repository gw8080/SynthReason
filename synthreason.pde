 //<>//


PrintWriter outputx;
PrintWriter outputz;
int block = 128;
int num = 100;
int sens = 50;
int searchlength = 10000;
int selectionSize = 1024;
void setup()
{
  outputz = createWriter("output/output.txt");
  for (int loop = 0; loop < num; loop++) {  
    String spectrum = decide(initTuring("turing.txt"), probability("prob.txt"), loadFilter("filter.txt"), loadResources("text.txt"));
    //spectrum = generate(spectrum ,loadFilter("filter.txt"), loadResources("text.txt"));
    //spectrum = bigram(spectrum, loadFilter("filter.txt"));
    outputz.println(spectrum);
    outputz.println();
    outputz.flush();
  }
  outputz.close();
  exit();
}

String bigram(String spectrum, String[] filter) {
  String[] proc = split(spectrum, " ");
  String filterstr = join(filter, "\n");
  String output = "";
  int count = 0;
  for (int a = 0; a < proc.length; a++) {
    if (filterstr.indexOf("\n" + proc[a] + "\n") > -1) {
      if (count == 0) {
        output += proc[a] + " ";
      }
      count++;
      if (count > 1) {
        count = 0;
      }
    }
    if (filterstr.indexOf("\n" + proc[a] + "\n") == -1) {
      output += proc[a] + " ";
    }
  }
  return output;
}

String[] loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  String[] str3 = split(str2, "\n");
  return str3;
}
String loadFilterstr(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  return str2;
}
String loadResources(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  return str2;
}
String[] initTuring(String file) {
  String[] KB = loadStrings(file);
  String spectrumx = join(KB, "");
  String[] spectrumA = split(spectrumx, ",");
  return spectrumA;
}
String[] probability(String file) {
  String[] KB = loadStrings(file);
  String list = join(KB, "");
  String[] prob = split(list, ",");
  return prob;
}
String decide(String[] spectrumA, String[] prob, String[] check2, String know) {
  String loop = join(check2, "");
  String spectrumout = "";
  int exit1 = 0;
  float r7 = random(spectrumA.length);
  int rem = round(r7);
  for (int count2 = 0; exit1 == 0 && count2 < searchlength; count2++) {
    String dis = "";
    for (int count = 0; count != prob.length-1; count++) {
      String[] spec = split(spectrumA[rem], " ");
      float r8 = random(spectrumA.length-1);
      int xx = round(r8);
      String[] spec2 = split(spectrumA[xx], " ");
      if (spec[1].equals(spec2[0]) == true) {
        dis += str(count) + ",";
      }
      String[] disA = split(dis, ","); 
      if (disA.length > selectionSize) {
        break;
      }
    }
    int exit = 0;
    for (int e = 0; e < searchlength && exit == 0; e++) {
      String[] disA = split(dis, ","); 
      String string = "";
      for (int x = 0; x < disA.length && exit == 0; x++ ) {
        float r = random(int(prob[int(disA[x])]));
        int y = round(r);
        string += y + ",";
      }
      String[] array = split(string, ",");
      for (int f = sens; f > 0 && exit == 0; f--) {
        for (int r = 0; r < array.length-1 && exit == 0; r++) {
          String[] spec = split(spectrumA[int(disA[r])], " ");
          if (int(array[r]) < sens && int(array[r]) >= f && spectrumout.indexOf(spec[1]) == -1)
          {
            spectrumout += spectrumA[int(disA[r])] + " ";
            rem = int(disA[r]);
            if (spectrumout.length() > block) {
              exit1 = 1;
            }
            exit = 1;
            break;
          }
        }
      }
    }
  }
  String[] check = split(spectrumout, " ");
  for (int z = 0; z < check.length; z++) {
    spectrumout = spectrumout.replace(check[z] + " " + check[z] + " ", check[z] + " ");
  }
  String[] check3 = loadFilter("filter.txt");
  for (int z = 0; z < check3.length; z++) {
    spectrumout = spectrumout.replace(" " + check[z] + " ", " ");
  }
  return spectrumout;
}
String generate(String spectrum, String[] loopA, String full) {
  String loop = join(loopA, "\n");
  String[] eny = split(spectrum, " ");// guide
  for (int j = 0; j != eny.length - 1; j++) {
    for (int a = 0; a != loopA.length-1; a++) {
      float r = random(loopA.length-1);
      int x = round(r);
      if (loopA[x] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[x] + " " + eny[j+1]) > -1 && loop.indexOf("\n" + eny[j] + "\n") == -1 && loop.indexOf("\n" + eny[j+1] + "\n") == -1 && full.indexOf(eny[j] + " " + eny[j+1]) == -1) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[x] + " " + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum += ".";
  spectrum = spectrum.replace(" .", ".");
  return spectrum;
}
