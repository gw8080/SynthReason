PrintWriter outputx; //<>// //<>// //<>// //<>//
PrintWriter outputy;
PrintWriter outputz;
int num = 5;
int limit = 64;
int actions = 64;
int tries = 64;
void setup()
{
  outputz = createWriter("output/output.txt");
  String spectrum = "";
  for (int loop = 0; loop < num; loop++) {  
    spectrum += decide(initTuring("turing.txt"), probability("prob.txt"));
  }
  //spectrum = generate(spectrum, loadFilter("filter.txt"), loadResources("text.txt"));
  outputz.println(spectrum);
  outputz.println();
  outputz.flush();
  outputz.close();
  exit();
}
String[] loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  String[] str3 = split(str2, "\n");
  return str3;
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

String[] task_AC(String[] specOriginal, String[] spectrumA, String[] prob, int probheight, int searchlength) {
  String[] spec = new String[0];
  for (int count = 0; count < searchlength; count++) {
    float r = random(spectrumA.length-1);
    int xx = round(r);
    spec = split(spectrumA[xx], " ");
    if (int(prob[xx]) > probheight && spec[0].equals(specOriginal[1]) == true) {
      break;
    }
  }
  return spec;
}

String decide(String[] spectrumA, String[] prob) {
  String input = "mind mind";
  String spectrumout = "";
  String[] SpecOriginal = split(input, " ");
  float r = random(limit);
  int chance = round(r), count = 0;
  for (String[] spec = task_AC(SpecOriginal, spectrumA, prob, chance, tries); count < actions; count++ ) {
    SpecOriginal = spec;
    r = random(limit);
    chance = round(r);
  }


  return spectrumout;
}
String generate(String spectrum, String[] loopA, String full) {
  String loop = join(loopA, "\n");
  String[] eny = split(spectrum, " ");// guide
  for (int j = 0; j < eny.length - 2; j++) {
    for (int a = 0; a != loopA.length-1; a++) {
      float r = random(loopA.length-1);
      int x = round(r);
      if (loopA[x] != null ) {
        if (full.indexOf(eny[j] + " " + loopA[x] + " ") > -1 && full.indexOf(" " + loopA[x] + " " + eny[j+1]) > -1 && loop.indexOf("\n" + eny[j] + "\n") == -1 && loop.indexOf("\n" + eny[j+1] + "\n") == -1) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[x] + "^^" + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum = spectrum.replace("^^", " ");
  return spectrum;
}
