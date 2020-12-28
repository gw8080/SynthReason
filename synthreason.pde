PrintWriter outputz; //<>// //<>//
int num = 50000;
int limit = 64;
int actions = 4;
int tries = 64000;
String input = "mind mind";
void setup()
{
  String search = loadFilter("positive.txt");
  String search2 = loadFilter("filter.txt");
  outputz = createWriter("output/output.txt");
  String[] turing = initTuring("turing.txt");
  String[] prob = probability("prob.txt");
  for (int loop = 0; loop < num; loop++) {  
    String spectrumcheck = decide(turing, prob);
    String[] check = split(spectrumcheck, " ");
    if (search.indexOf("\n" + check[check.length-2] + "\n") > -1 && search2.indexOf("\n" + check[check.length-2] + "\n") == -1) {
      outputz.println(spectrumcheck);
      outputz.println();
      outputz.flush();
    }
  }
  outputz.flush();
  outputz.close();
  exit();
}
String loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
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
    if (int(prob[xx]) < probheight && spec[0].equals(specOriginal[1]) == true) {
      break;
    }
  }
  return spec;
}
String decide(String[] spectrumA, String[] prob) {
  String spectrumout = "";
  String[] SpecOriginal = split(input, " ");
  float r = random(limit);
  int chance = round(r);
  for (int count = 0; count < actions; count++) {
    String[] spec = task_AC(SpecOriginal, spectrumA, prob, chance, tries);
    r = random(limit);
    chance = round(r);
    spectrumout += join(spec, " ") + " ";
    SpecOriginal = spec;
  }
  String[] check = split(spectrumout, " ");
  for (int z = 0; z < check.length-1; z++) {
    spectrumout = spectrumout.replace(check[z] + " " + check[z] + " ", check[z] + " ");
  }

  return spectrumout;
}
