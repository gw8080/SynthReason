PrintWriter outputx;
PrintWriter outputz;
String resource = "text.txt";
void setup()
{
  String voc = "";
  String[] KB = loadStrings(resource);
  String[] vocab = loadStrings("words.txt");
  String str2 = join(KB, "");
  for (int i = 0; i != vocab.length; i++)
  {
    float r8 = random(5000);
    int xx = round(r8);
    if (xx == 1) {
      outputz = createWriter("output/progress.txt");
      outputz.println(i + "/" + vocab.length);
      outputz.close();
    }
    if (str2.indexOf(" " + vocab[i] + " ") > -1) {
      voc += vocab[i] + "\n";
    }
  }
  outputx = createWriter("output/vocab.txt");
  outputx.println(voc);
  outputx.close();
  exit();
}
