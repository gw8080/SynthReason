PrintWriter outputx;
PrintWriter outputz;
int block = 512;
int num = 100;
int sens = 100;
int searchlength = 10000;
void setup()
{
  outputz = createWriter("output/output.txt");

  for (int loop = 0; loop < num; loop++) {

    String[] spectrumA = initTuring("turing.txt");
    String[] prob = probability("prob.txt");
    String spectrum = decide(spectrumA, prob, loadResources("problem.txt"), loadResources("solve.txt"), loadResources("3.txt"));
    outputz.println(spectrum);
    outputz.println();
    outputz.flush();
  }
  outputz.close();
  exit();
}
String loadResources(String resource)
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
String decide(String[] spectrumA, String[] prob, String problem, String solve, String info) {
  String spectrumout = "";
  int exit1 = 0;
  float r2 = random(prob.length-1);
  int rem = round(r2);
  int step = 0;
  for (int count2 = 0; exit1 == 0 && count2 < searchlength; count2++) {
    String dis = "";
    for (int count = 0; count != prob.length-1; count++) {
      String[] spec = split(spectrumA[rem], " ");
      String[] spec2 = split(spectrumA[count], " ");
      if (spec[1].equals(spec2[0]) == true && spectrumout.indexOf(spec2[1]) == -1) {
        if (step == 0 && problem.indexOf("\n" + spec2[1] + "\n") > -1) {
          dis += str(count) + ",";
        }
        if (step == 1 && solve.indexOf("\n" + spec2[1] + "\n") > -1) {
          dis += str(count) + ",";
        }
        if (step == 2 && info.indexOf("\n" + spec2[1] + "\n") > -1) {
          dis += str(count) + ",";
          step = 0;
        }
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
    step++;
  }
  String[] check = split(spectrumout, " ");

  for (int z = 0; z < check.length; z++) {
    spectrumout = spectrumout.replace(check[z] + " " + check[z] + " ", check[z] + " ");
  }
  return spectrumout;
}
