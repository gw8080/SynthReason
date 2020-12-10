PrintWriter outputx;
PrintWriter outputz;
String resource = "text.txt";
void setup()
{
  String[] KB = loadStrings(resource);
  String output = join(KB, "");
  String[] eliminate2 = {"[", "]", ",", ".", "\"", "0", "1", "2", "3", "4", "5", "6", "7", "8", "9", "(", ")", "\'", "?"};
  for (int k = 0; k < eliminate2.length; k++) {
    outputz = createWriter("output/progress.txt");
    outputz.println(k + "/" + eliminate2.length);
    outputz.close();
    output = output.replace(eliminate2[k], "");
  }
  outputx = createWriter("output/textElim.txt");
  outputx.print(output);
  outputx.close();
  exit();
}
