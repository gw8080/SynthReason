PrintWriter outputx;
PrintWriter outputz;
int block = 128;
int num = 100;
int sens = 100;
int searchlength = 10000;
void setup()
{
  outputz = createWriter("output/output.txt");

  for (int loop = 0; loop < num; loop++) {

    String[] spectrumA = initTuring("turing.txt");
    String[] prob = probability("prob.txt");
    String spectrum = decide(spectrumA, prob);
    //String[] knowledge = loadResources("text.txt");
    //String full = returnstr(knowledge);
    //String file = "f.txt";
    // spectrum = generate(spectrum, full, file, 0);
    outputz.println(spectrum);
    outputz.println();
    outputz.flush();
  }
  outputz.close();
  exit();
}
String returnstr(String[] KB)
{
  String str2 = "";
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  return str2;
}
String[] loadResources(String resource)
{
  String str2 = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  String[] knowledge = split(str2, ".");
  return knowledge;
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
String decide(String[] spectrumA, String[] prob) {
  String spectrumout = "";
  int exit1 = 0;
  float r2 = random(prob.length-1);
  int rem = round(r2);
  for (int count2 = 0; exit1 == 0 && count2 < searchlength; count2++) {
    String dis = "";
    for (int count = 0; count != prob.length-1; count++) {
      String[] spec = split(spectrumA[rem], " ");
      String[] spec2 = split(spectrumA[count], " ");
      if (spec[1].equals(spec2[0]) == true) {
        dis += str(count) + ",";
      }
    }
    int exit = 0;
    for (int e = 0; e < searchlength && exit == 0; e++) {
      String[] disA = split(dis, ","); 
      for (int x = 0; x < disA.length && exit == 0; x++ ) {
        float r = random(sens);
        int y = round(r);
        float r3 = random(disA.length-1);
        x = round(r3);
        if (y < int(prob[int(disA[x])])) {
          spectrumout += spectrumA[int(disA[x])] + " ";
          rem = int(disA[x]);
          if (spectrumout.length() > block) {
            exit1 = 1;
          }
          exit = 1;
        }
      }
    }
  }
  String[] check = split(spectrumout, " ");

  for (int z = 0; z < check.length; z++) {
    spectrumout = spectrumout.replace(check[z] + " " + check[z] + " ", check[z] + " ");
  }
  return spectrumout;
}
String generate(String spectrum, String full, String file, int mode) {
  String[] KB = loadStrings(file);
  String loop = join(KB, "");
  String[] loopA = split(loop, "\n");
  String[] eny = split(spectrum, " ");// guide
  for (int j = 0; j != eny.length - 1; j++) {
    for (int a = 0; a != loopA.length-1; a++) {
      float r = random(loopA.length-1);
      int x = round(r);
      if (loopA[x] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[x] + " " + eny[j+1]) > -1 && mode == 0) {
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
