PrintWriter outputx;
PrintWriter outputz;
String resource = "n.txt";
void setup()
{
  String[] knowledge = loadResources();//2
  String[] spectrumA = initTuring();//4
  int[] prob = probability(spectrumA, knowledge);//5
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
  outputx = createWriter("output/4.txt");
  outputx.println(spectrumx);
  outputx.close();
  return spectrumA;
}
int[] probability(String[] spectrumA, String[] knowledge) {
  int[] prob;
  prob = new int[spectrumA.length];
  for (int i = 0; i != spectrumA.length; i++)
  {
    prob[i] = 0;
  }
  for (int a = 0; a < spectrumA.length-1; a++) {
    String[] spec = split(spectrumA[a], " ");
    for (int b = 0; b < knowledge.length-1; b++) {
      if (knowledge[b].indexOf(spec[0]) < knowledge[b].indexOf(spec[1]) && knowledge[b].indexOf(spec[0]) > -1 && knowledge[b].indexOf(spec[1]) > -1) {
        prob[a] += 1;
      }
    }
  }
  String str4 = "";
  for (int x = 0; x != prob.length; x++)
  {
    str4 += prob[x] + ",";
  }
  outputx = createWriter("output/prob.txt");
  outputx.println(str4);
  outputx.close();
  return prob;
}
