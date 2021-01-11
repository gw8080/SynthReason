PrintWriter outputz; //<>// //<>// //<>//
PrintWriter outputp;
int actions = 15;
int tries = 64000;
void setup()
{
  String[] turing = initTuring("turing.txt");
  String[] prob = probability("prob.txt");
  outputz = createWriter("output/output.txt");

  while (true) {  
    String spectrumcheck = decide(turing, prob, actions);
    outputz.println(spectrumcheck);
    outputz.println();
    outputz.flush();
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
String[] task_AC(String[] specOriginal, String[] spectrumA, String[] prob) {
  String pool = "";
  String[] spec = new String[0];
  for (int count = 0; count < tries; count++) {
    float r = random(spectrumA.length-1);
    int xx = round(r);


    spec = split(spectrumA[xx], " ");
    if (spec[0].equals(specOriginal[1]) == true) { 
      for (int v = 0; v < int(prob[xx]); v++) {
        pool += count + ",";
      }
    }
  }
  String[] poolA = split(pool, ",");
  float r = random(poolA.length-1);
  int xx = round(r);
  spec = split(spectrumA[int(poolA[xx])], " ");
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
  spectrumout += SpecOriginal[1] + " ";
  for (int count = 0; count < actions-1; count++) {
    String[] spec = task_AC(SpecOriginal, spectrumA, prob);
    spectrumout += join(spec, " ") + " ";
    SpecOriginal = spec;
  }
  String[] check = split(spectrumout, " ");
  for (int z = 0; z < check.length-1; z++) {
    spectrumout = spectrumout.replace(check[z] + " " + check[z] + " ", check[z] + " ");
  }
  return spectrumout;
}
