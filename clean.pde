PrintWriter outputx;
PrintWriter outputz;
PrintWriter outputy;
PrintWriter outputp;
String resource = "text.txt";
int buffer = 1024;
void setup()
{
  String[] spectrumA = initTuring();//4
  String[] prob = initProb();//4
  String[] distance = initDistance();//4
  String full = "", full2 = "", full3 = "";
  outputz = createWriter("output/turingclean.txt");
  outputx = createWriter("output/probclean.txt");
  outputy = createWriter("output/distanceclean.txt");
  for (int a = 0; a < spectrumA.length-1; a++) {
    if (int(prob[a]) > 0) {
      full += prob[a] + ",";
      full2 += spectrumA[a] + ",";
      full3 += distance[a] + ":";
    }
    String[] x = split(full, ",");
    if (x.length >= buffer) {  
      outputx.print(full);
      outputx.flush();
      outputz.print(full2);
      outputz.flush();   
      outputy.print(full3);
      outputy.flush();
      full = "";
      full2 = "";
      full3 = "";
      outputp = createWriter("output/progress.txt");
      outputp.println(a + "/" + spectrumA.length);
      outputp.close();
    }
  }
  outputx.print(full);
  outputz.print(full2);
  outputy.print(full3);

  outputz.close();
  outputx.close();
  outputy.close();
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

String[] initDistance() {
  String[] KB = loadStrings("distance.txt");
  String spectrumx = join(KB, "");
  String[] spectrumA = split(spectrumx, ":");
  return spectrumA;
}
String[] initProb() {
  String[] KB = loadStrings("prob.txt");
  String spectrumx = join(KB, "");
  String[] prob = split(spectrumx, ",");
  return prob;
}
