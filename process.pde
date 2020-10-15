PrintWriter output;
String[] resource;
String str = "";
String out = "";
void setup() {
  resource = loadStrings("n.txt");
  for (int i = 0; i < resource.length; i++) {
    str += resource[i];
  }
  String[] sentence = split(str, '.');
  str = "";
  String[] resource2 = loadStrings("noun.txt");
  for (int i = 0; i < resource2.length; i++) {
    str += resource2[i] + "\n";
  }
  String[] words = split(str, '\n');
  for (int x = 0; x != words.length-1; x++) {
    for (int i = 0; i != sentence.length-1; i++) {
      if (sentence[i].indexOf(words[x]) > -1) {
        out += sentence[i] + "\n";
      }
    }
    output = createWriter(x + ".txt");
    output.println(out);
    output.flush();
    output.close();
    out = "";
  }




  exit();
}
