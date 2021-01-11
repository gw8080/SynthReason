PrintWriter outputz; //<>// //<>// //<>//
PrintWriter outputp;
PrintWriter debug;
int probLimit = 128;
int tries = 64000;
int distanceParamA = 64;
int distanceParamB = 4;
int correlationClusterLocation = 0;
int chain = 0;
int chainLength = 1;
String[] turing = new String[0];
String[] prob = new String[0];
String text = "";
int actions = 2;
void setup()
{
  turing = initTuring("turing.txt");

  text = loadResources("text.txt");
  outputz = createWriter("output/output.txt");
  debug = createWriter("test.txt");

  while (true) {  
    prob = probability("prob.txt");
    String spectrumcheck = decide(turing, prob, actions);
    if (text.indexOf(spectrumcheck) > -1) {
      outputz.print(spectrumcheck);
      outputz.flush();
      outputp = createWriter("prob.txt");
      outputp.println(join(prob, ","));
      outputp.flush();
      outputp.close();
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
String loadResources(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  return str2;
}
String[] task_AC(String[] specOriginal, String[] spectrumA, String[] prob, int probheight, int searchlength) {
  String[] spec = new String[0];
  for (int count = 0; count < searchlength; count++) {
    float r = random(spectrumA.length-2);
    int xx = round(r);
    spec = split(spectrumA[xx], " ");
    correlationClusterLocation = xx;

    if (int(prob[xx]) < probheight && spec[0].equals(specOriginal[1]) == true) {
      if (chain == actions) {
        prob[xx] = str(int(prob[xx])+1);
        chain = 0;
      }
      if (chain > actions) {
        prob[xx] = str(int(prob[xx])-1);
        chain = 0;
      }
      chain++;
      break;
    }
  }
  return spec;
}
String decide(String[] spectrumA, String[] prob, int actions) {
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
  for (int count = 0; count < actions-1; count++) {
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
