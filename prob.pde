PrintWriter outputx;
PrintWriter outputz;
String resource = "text.txt";
int buffer = 102400;
void setup()
{
  String[] knowledge = loadResources();//2
  String[] spectrumA = initTuring();//4
  String full = "";
  outputx = createWriter("output/prob.txt");
  for (int a = 0; a < spectrumA.length-1; a++) {
    int count = 0;
    String[] spec = split(spectrumA[a], " ");
    for (int b = 0; b < knowledge.length-1; b++) {
      if (knowledge[b].indexOf(spec[0]) < knowledge[b].indexOf(spec[1]) && knowledge[b].indexOf(spec[0]) > -1 && knowledge[b].indexOf(spec[1]) > -1) {
        count += 1;
      }
    }
    full += count + ",";
    if (full.length() >= buffer) {
      outputx.print(full);
      outputx.flush();
      outputz = createWriter("output/progress.txt");
      outputz.println(a + "/" + spectrumA.length);
      outputz.close();
      full = "";
    }
  }
  outputx.print(full);
  outputx.close();
  exit();
}
String[] loadResources()
{
  String str2 = "";
  String[] KB = loadStrings(resource);
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  String[] knowledge = split(str2, ".");
  return knowledge;
}
String[] initTuring() {
  String spectrumx = "";
  String[] KB = loadStrings("turing.txt");
  for (int i = 0; i != KB.length; i++)
  {
    spectrumx += KB[i];
  }
  String[] spectrumA = split(spectrumx, ",");
  return spectrumA;
}
