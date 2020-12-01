PrintWriter outputx;
String resource = "text.txt";
void setup()
{
  String str2 = "",voc = "";
  String[] KB = loadStrings(resource);
  String[] vocab = loadStrings("merge.txt");
  for (int i = 0; i != KB.length; i++)
  {
    str2 += KB[i];
  }
  for (int i = 0; i != vocab.length; i++)
  {
    if (str2.indexOf(" " + vocab[i] + " ") > -1){
    voc += vocab[i] + "\n";
    }
  }
  outputx = createWriter("output/vocab.txt");
  outputx.println(voc);
  outputx.close();
  exit();
}
