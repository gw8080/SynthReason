PrintWriter outputz; //<>//
int num = 100;
int sens = 20;
int searchlengthInit = 64;
void setup()
{
  outputz = createWriter("output/output.txt");
  String spectrum = "";
  for (int loop = 0; loop < num; loop++) {  
    spectrum += decide(initTuring("turing.txt"), probability("prob.txt"));
    spectrum += " ";
  }
  spectrum = generate(spectrum, loadFilter("filter.txt"), loadResources("text.txt"));
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
String decide(String[] spectrumA, String[] prob) {
  String[] spec = new String[0], spec2 = new String[0];
  for (int count = 0; count < searchlengthInit; count++) {
    float r = random(spectrumA.length-1);
    int xx = round(r);
    spec = split(spectrumA[xx], " ");
    if (int(prob[xx]) > sens ) {
      break;
    }
  }
  String collocates = "";
  for (int count = 0; count < spectrumA.length-2; count++) {
    float r = random(spectrumA.length-2);
    int xx = round(r);
    spec2 = split(spectrumA[xx], " ");
    if (spec[0].equals(spec2[0]) == true) {
      collocates += spec2[0] + " " + spec2[1] + ",";
    }
  }
  String kernelsentence = join(spec, " ");
  String[] collocatesA = split(collocates, ",");
  String[] kernelsentenceA = split(kernelsentence, " ");
  String sentence1 = "", sentence2 = "";
  for (int count = 0; count < collocatesA.length-1; count++) {
    float r = random(collocatesA.length-1);
    int xx = round(r);
    spec2 = split(spectrumA[xx], " ");
    String[] spec3 = split(collocatesA[count], " ");
    if (spec3[0].equals(kernelsentenceA[0]) == true) {
      sentence1 += spec2[1] + ",";
    }
    if (spec3[0].equals(kernelsentenceA[1]) == true) {
      sentence2 += spec2[1] + ",";
    }
  }
  String[] sentence1A = split(sentence1, ",");
  String[] sentence2A = split(sentence2, ",");
  float r = random(sentence1A.length-1);
  int random = round(r);
  String spectrumout = kernelsentence + " " + sentence1A[random];
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
        if (full.indexOf(eny[j] + " " + loopA[x] + " ") > -1 && full.indexOf(" " + loopA[x] + " " + eny[j+1]) > -1 && loop.indexOf("\n" + eny[j] + "\n") == -1 && loop.indexOf("\n" + eny[j+1] + "\n") == -1 && full.indexOf(eny[j] + " " + eny[j+1]) == -1) {
          spectrum = spectrum.replace(eny[j] + " " + eny[j+1] + " ", eny[j] + " " + loopA[x] + " " + eny[j+1] + " ");
          break;
        }
      }
    }
  }
  spectrum = spectrum.replace("^^", " ");
  return spectrum;
}
