PrintWriter outputx;
String resource = "reason.txt";
void setup()
{
  String voc = "";
  String[] KB = loadStrings(resource);
  String[] vocab = loadStrings("merge.txt");
  String str2 = join(KB, "");
  for (int i = 0; i != vocab.length; i++)
  {
    if (str2.indexOf(" " + vocab[i] + " ") > -1) {
      voc += vocab[i] + "\n";
    }
  }
  outputx = createWriter("output/vocab.txt");
  outputx.println(voc);
  outputx.close();
  exit();
}
