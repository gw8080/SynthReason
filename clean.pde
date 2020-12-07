PrintWriter outputx;
PrintWriter outputz;
PrintWriter outputp;
String resource = "text.txt";
int buffer = 1024;
void setup()
{
  String[] spectrumA = initTuring();//4
  String[] prob = initProb();//4
  String full = "", full2 = "";
  outputz = createWriter("output/turingclean.txt");
  outputx = createWriter("output/probclean.txt");

  for (int a = 0; a < spectrumA.length-1; a++) {
    if (int(prob[a]) > 0) {
      full += prob[a] + ",";
      full2 += spectrumA[a] + ",";
      String[] x = split(full, ",");
      if (x.length >= buffer) {  
        outputx.print(prob[a] + ",");
        outputx.flush();
        outputz.print(spectrumA[a] + ",");
        outputz.flush();        
        full = "";
        full2 = "";
        outputp = createWriter("output/progress.txt");
        outputp.println(a + "/" + spectrumA.length);
        outputp.close();
      }
    }
  }
  outputx.print(full);
  outputz.print(full2);

  outputz.close();
  outputx.close();
  exit();
}
String[] loadResources()
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] knowledge = split(str2, ".");
  return knowledge;
}
String[] initTuring() {
  String[] KB = loadStrings("turing.txt");
  String spectrumx = join(KB, "");
  String[] spectrumA = split(spectrumx, ",");
  return spectrumA;
}
String[] initProb() {
  String[] KB = loadStrings("prob.txt");
  String spectrumx = join(KB, "");
  String[] prob = split(spectrumx, ",");
  return prob;
}
