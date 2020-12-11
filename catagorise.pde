
PrintWriter outputx;
PrintWriter outputz;
int block = 128;
int num = 100;
int sens = 50;
int searchlength = 10000;
int selectionSize = 128;
void setup()
{

  String[] problem = loadFilter("problem.txt");
  String[] vocab = loadFilter("vocab.txt");
  String[] knowledge = loadResourcesA("text.txt");

  outputx = createWriter("output/properties.txt");
  String spectrum = "";
  for (int count3= 0; count3 < vocab.length; count3++) {
    spectrum += vocab[count3] + ":";
    outputz = createWriter("output/progress.txt");
    outputz.println(count3 + "/" + vocab.length);
    outputz.close();
    for (int count = 0; count < knowledge.length; count++) {
      for (int count2 = 0; count2 < problem.length; count2++) {
        if (knowledge[count].indexOf(problem[count2]) > -1 && knowledge[count].indexOf(vocab[count3]) > -1) {
          spectrum += problem[count2] + " ";
        }
      }
    }
    outputx.println(spectrum);
    outputx.flush();
    spectrum = "";
  }
  outputx.close();
  exit();
}

String[] loadFilter(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "\n");
  String[] str3 = split(str2, "\n");
  return str3;
}

String[] loadResourcesA(String resource)
{
  String[] KB = loadStrings(resource);
  String str2 = join(KB, "");
  String[] str3 = split(str2, ".");
  return str3;
}
