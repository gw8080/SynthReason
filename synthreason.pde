PrintWriter outputz; //<>// //<>// //<>//
PrintWriter outputp;
int actions = 2;
int tries = 6400;
int chain = 0;
String[] prob = new String[0];
String learnpath = "";
String[] learnpathA = new String[0];
void setup()
{
  String[] turing = initTuring("turing.txt");
  prob = probability("prob.txt");
  outputz = createWriter("output/output.txt");
  String text = loadResources("text.txt");
  String check = "";
  while (true) { 
    prob = probability("prob.txt");

    String spectrumcheck = decide(turing, prob, actions);

    if (text.indexOf(check+spectrumcheck) > -1 && chain == actions) {
      for (int xt = 0; xt != learnpathA.length; xt++) {
        prob[int(learnpathA[xt])] = str(int(prob[int(learnpathA[xt])])+1);
      }
      learnpath = "";
      chain = 0;
      check = spectrumcheck;
    }
    outputz.print(spectrumcheck);
    outputz.flush();
    outputp = createWriter("prob.txt");
    outputp.println(join(prob, ","));
    outputp.flush();
    outputp.close();
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
    float r = random(prob.length-2);
    int xx = round(r);
    spec = split(spectrumA[xx], " ");
    if (spec[0].equals(specOriginal[1]) == true) { 
      for (int v = 0; v < int(prob[xx]); v++) {
        pool += xx + ",";
      }
    }
  }
  String[] poolA = split(pool, ",");
  float r = random(poolA.length-1);
  int xx = round(r);
  spec = split(spectrumA[int(poolA[xx])], " ");
  learnpath += int(poolA[xx]) + ",";
  learnpathA = split(learnpath, ",");
  chain++;
  return spec;
}
String decide(String[] spectrumA, String[] prob, int actions) {
  String spectrumout = "";
  float r2 = random(spectrumA.length-2);
  int xx = round(r2)+1;
  String[] SpecOriginal = split(spectrumA[xx], " ");
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
