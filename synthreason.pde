PrintWriter outputz; //<>// //<>//
int probLimit = 128;
int actions = 4;
int tries = 64000;
int distanceParamA = 64;
int distanceParamB = 4;
int correlationClusterLocation = 0;
void setup()
{
  String[] ResourceA = loadResourcesA("text.txt");

  String search2 = loadFilter("filter.txt");
  outputz = createWriter("output/output.txt");
  String[] turing = initTuring("turing.txt");
  String[] prob = probability("prob.txt");
  while (true) {  
    float r3 = random(ResourceA.length-1);
    int yy = round(r3);
    String search = ResourceA[yy];
    String spectrumcheck = decide(turing, prob);
    String[] check = split(spectrumcheck, " ");
    if (search.indexOf(" " + check[check.length-2] + " ") > -1 && search2.indexOf("\n" + check[check.length-2] + "\n") == -1) {
      outputz.println(spectrumcheck);
      outputz.println();
      outputz.flush();
    }
  }
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
String[] loadResourcesB(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ":");
  return str3;
}
String[] loadResourcesA(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ".");
  return str3;
}
int distanceSelect(String[] distanceA, int pos) {
  String[] arr = split(distanceA[pos], ",");
  int exit = 0;
  int selection = 0;
  for (int x = 0; x < distanceParamA && exit == 0; x++) {
    for (int z = 0; z < arr.length - 1 && exit == 0; z++) {
      if (int(arr[z]) == x) {
        selection = x;
        exit = 1;
      }
    }
  }
  return selection;
}
String[] task_AC(String[] specOriginal, String[] spectrumA, String[] prob, int probheight, int searchlength) {
  String[] spec = new String[0];
  String[] distanceA = loadResourcesB("distance.txt");
  for (int count = 0; count < searchlength; count++) {
    float r = random(spectrumA.length-2);
    int xx = round(r);
    spec = split(spectrumA[xx], " ");
    correlationClusterLocation = xx;
    int distance = distanceSelect(distanceA, correlationClusterLocation);
    if (distance <= distanceParamB) {
      if (int(prob[xx]) < probheight && spec[0].equals(specOriginal[1]) == true) {
        break;
      }
    }
  }
  return spec;
}
String decide(String[] spectrumA, String[] prob) {
  String spectrumout = "";
  String[] ResourceA = loadResourcesA("text.txt");
  float r3 = random(ResourceA.length-1);
  int yy = round(r3);
  String[] origin = split(ResourceA[yy], " ");
  float r2 = random(origin.length-1);
  int xx = round(r2);

  String[] SpecOriginal = split("null " + origin[xx], " ");
  float r = random(probLimit);
  int chance = round(r);
  spectrumout += SpecOriginal[1] + " ";
  for (int count = 0; count != actions; count++) {
    String[] spec = task_AC(SpecOriginal, spectrumA, prob, chance, tries);
    r = random(probLimit);
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
